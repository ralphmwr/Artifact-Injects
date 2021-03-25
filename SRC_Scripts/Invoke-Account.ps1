[CmdletBinding()]
param (
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateScript({
        $Para = @{
            ClassName = 'Win32_Account'
            ErrorAction = 'Ignore'
        }
        $caption = $_ -replace '\\','\\'
        if ((Get-CimInstance @Para -Filter "Caption = '$caption'") -or (Get-CimInstance @Para -Filter "Name = '$caption'")) {
            $true
        }
        else {
            Throw "$_ does not exist on $env:COMPUTERNAME"
        }
    })]
    [string]
    $Principal,

    [Parameter(Mandatory=$true, Position = 1)]
    [ValidateScript({
        if (Get-CimInstance -ClassName Win32_Account -Filter "Name = '$_'" -ErrorAction Ignore) {
            Throw "$_ already exists on $env:COMPUTERNAME"
        }
        elseif (($_ -notmatch '^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$') -or ($_.length -notin 8..20)) {
            Throw "$_ is not a valid user name"
        }
        else {
            $true
        }
    })]
    [String]
    $AccountName,

    [Parameter(Position = 2)]
    [ValidateScript({
        if ($_) {
            $ValidGroups = (Get-CimInstance -ClassName win32_group).name
            foreach ($group in @($_)) {
                if ($group -notin $ValidGroups) {
                    Throw "$group does not exist on $env:COMPUTERNAME"
                } #if notin $validGroups
            } #foreach
        } #if
        $true
    })]
    [string[]]
    $GroupMembership
) #param block

#store error action preface to return at the end of script
Write-Verbose "Setting error action preference to 'Stop' for error handling purposes"
$startpref = $ErrorActionPreference
$ErrorActionPreference = "Stop"

#to add verbose messaging (Invoked remotely), add an application argument with key of verbose and value of $true
if ($PSSenderInfo.applicationarguments.verbose) {$VerbosePreference = 'Continue'}

$message = @()
#nested in try, catch, finally main for overall success determination
try {
    $success = $true
      
    try {
        Write-Verbose "Creating scheduled task arguments"
        $userid = (Get-CimInstance -ClassName Win32_Account -Filter "Caption = '$($Principal -replace '\\','\\')'").SID
        if (!$userid) {
            $userid = (Get-CimInstance -ClassName Win32_Account -Filter "Name = '$Principal'").SID
        }
        if ($userid.SIDType -eq 1) {
            $PrincipalArg = @{LogonType = "Password"}
            $RegisterArg  = @{Password  = $Credential.GetNetworkCredential().Password}
        }
        else {
            $PrincipalArg = @{LogonType = "ServiceAccount"}
            $RegisterArg  = @{}
        }

        $script = "`"New-LocalUser -Name '$AccountName' -NoPassword; "
        $script += foreach ($group in $GroupMembership) {
                "([ADSI]('WinNT://$env:COMPUTERNAME/$group,group')).add('WinNT://$AccountName,user'); "
            }
        $script += '"'

        $taskargs = @{
            Action    = New-ScheduledTaskAction -Execute "powershell" -Argument "-command $script"
            Settings  = New-ScheduledTaskSettingsSet -Hidden
            Principal = New-ScheduledTaskPrincipal -UserId $userid @PrincipalArg
        } #taskargs hashtable
    } #try
    catch {
        $message += "Unable to create scheduled task arguments on $env:COMPUTERNAME"
        Throw $_
    } #catch
    
    Write-Verbose "Coming up with random task name that doesn't already exist."
    do {
        $taskname = -join ((65..90) + (97..122) | Get-Random -Count 5 | ForEach-Object {[char]$_})
    } while (Get-ScheduledTask -TaskName $taskname -ErrorAction Ignore)
    
    try {
        Write-Verbose "Creating/Registering/Starting scheduled task $taskname on $env:COMPUTERNAME"
        New-ScheduledTask @taskargs | 
            Register-ScheduledTask -TaskName $taskname @RegisterArg | 
                Start-ScheduledTask -Verbose
        
        $timeout = 0
        while ((Get-ScheduledTask -TaskName $taskname).state -eq "Running") {
            Write-Verbose "Task $taskname is running...."
            Start-Sleep -Seconds 3
            $timeout += 1
            if ($timeout -gt 5) {
                Throw "Task timed out!"
            } #if
        } #while
    } #try
    catch {
        $message += "Unable to create account $AccountName on $env:COMPUTERNAME"
        Throw $_
    } #catch

    try {
        Write-Verbose "Validating $AccountName is on $env:COMPUTERNAME"
        Get-LocalUser -Name $AccountName | Out-Null
        $message += "Validated account: $AccountName on $env:COMPUTERNAME"
    } #try
    catch {
        $message += "$AccountName is NOT on $env:COMPUTERNAME"
        Throw $_
    } #catch
    try {
        if ($GroupMembership) {
            foreach ($group in $GroupMembership) {
                Write-Verbose "Validating $AccountName is in $group"
                if ($AccountName -notin (Get-CimInstance win32_group -Filter "Name = '$group'" |
                    Get-CimAssociatedInstance -Association win32_groupuser).Name) {
                    $message += "$AccountName is NOT in $group"
                    $success = $false
                } #if
                else {
                    $message += "Validated account: $AccountName in $group"
                } #esle
            } #foreach  
        } #if
    } #try
    catch {
        Throw $_
    } #catch
} #Main Try

catch {
    $success = $false
    $message += " - Error Msg: $($_.Tostring())"
} #Main catch

finally {
    Write-Verbose "Setting error action preface back to $startpref on $env:COMPUTERNAME"
    $ErrorActionPreference = $startpref  

    Write-Verbose "Attempting to remove scheduled task: $taskname on $env:COMPUTERNAME"
    if ($taskname) {
        Get-ScheduledTask -TaskName $taskname -ErrorAction Ignore | 
        Unregister-ScheduledTask -Confirm:$false -ErrorAction Ignore
        if ($?) {Write-Verbose "Removed $taskname from scheduled tasks"}
        else {Write-Verbose "Unable to remove $taskname from scheduled tasks"}
    } #if

    [PSCustomObject]@{
        success = $success
        message = $message
    } #pscustomobject returned from script
} #Main finally


