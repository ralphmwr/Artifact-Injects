[CmdletBinding()]
param (
    [Parameter(Mandatory=$true, Position = 0)]
    [ValidateScript({
        if (Get-CimInstance -ClassName Win32_Account -Filter "Name = '$_'" -ErrorAction Ignore) {
            $true
        }
        else {
            Throw "$_ does not exist on $env:COMPUTERNAME"
        }
    })]
    [string]
    $Principal,

    [Parameter(Mandatory=$true, Position=1)]
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

    [Parameter(Mandatory=$true, Position = 2)]
    [ValidateScript({
        $ValidGroups = (Get-CimInstance -ClassName win32_group).name
        foreach ($group in @($_)) {
            if ($group -notin $ValidGroups) {
                Throw "$group does not exist on $env:COMPUTERNAME"
            }
        }
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

#nested in try, catch, finally main for overall success determination
try {
    $success = $true
      
    try {
        Write-Verbose "Creating scheduled task arguments"
        $userid = (Get-CimInstance -ClassName Win32_Account -Filter "Name = '$Principal'").SID
        if ($userid.SIDType -eq 1) {
            $PrincipalArg = @{LogonType = "Password"}
            $RegisterArg  = @{Password  = $Credential.GetNetworkCredential().Password}
        }
        else {
            $PrincipalArg = @{LogonType = "ServiceAccount"}
            $RegisterArg  = @{}
        }
        $script = {
            New-LocalUser -Name $AccountName -NoPassword | Out-Null
            foreach ($group in $GroupMembership) {
                ([ADSI]("WinNT://$env:COMPUTERNAME/$group,group").add("WinNT://$AccountName,user"))
            } #foreach            
        } #script

        $taskargs = @{
            Action    = New-ScheduledTaskAction -Execute "powershell.exe -script $script"
            Settings  = New-ScheduledTaskSettingsSet -Hidden
            Principal = New-ScheduledTaskPrincipal -UserId $userid @PrincipalArg
        } #taskargs hashtable
    } #try
    catch {
        $message = "Unable to create scheduled task arguments on $env:COMPUTERNAME"
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
                Start-ScheduledTask
    } #try
    catch {
        $message = "Unable to start process from scheduled task - $taskname on $env:COMPUTERNAME"
        Throw $_
    } #catch

    try {
        $ProcessName = (Split-Path -Path $Path -Leaf -Resolve) -replace "\.exe"
        Write-Verbose "Validating $ProcessName is running on $env:COMPUTERNAME"
        Get-Process -Name $ProcessName | Out-Null
        $message = "Validated process: $ProcessName on $env:COMPUTERNAME"
        Write-Verbose $message
    } #try
    catch {
        $message = "$ProcessName is NOT running on $env:COMPUTERNAME"
        Throw $_
    } #catch

} #Main Try

catch {
    $success = $false
    $message += "`nError Msg: $($_.Tostring())"
} #Main catch

finally {
    Write-Verbose "Setting error action preface back to $startpref on $env:COMPUTERNAME"
    $ErrorActionPreference = $startpref  

    Write-Verbose "Attempting to remove scheduled task: $taskname on $env:COMPUTERNAME"
    if ($taskname) {
        Get-ScheduledTask -TaskName $taskname -ErrorAction Ignore | 
        Unregister-ScheduledTask -Confirm:$false -ErrorAction Ignore
    }

    [PSCustomObject]@{
        success = $success
        message = $message
    } #pscustomobject returned from script
} #Main finally


