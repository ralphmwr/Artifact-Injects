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

    [Parameter(Mandatory=$true, Position = 1)]
    [ValidateScript({
        if((Get-Item "env:\$_" -ErrorAction Ignore).value | Test-Path -ErrorAction Ignore) {
            $true
        }
        else {
            Throw "$_ is an invalid run location on $env:COMPUTERNAME"
        }
    })]
    [string]
    $Runlocation,

    [Parameter(Mandatory=$true, Position = 2)]
    [ValidateScript({
        #check for invalid characters, words or combination of characters
        if(($_.IndexOfAny([System.IO.Path]::GetInvalidFileNameChars()) -eq -1) -and 
           ($_ -notmatch "^COM[0-9]|CON|LPT[0-9]|NUL|PRN|AUX|\.{2,}|\s{2,}|.*\.$|.*\s$")) {
            $true
        }
        else {
            Throw "$_ is an invalid filename."
        }
    })]
    [string]
    $ProcessName
) #param block

#store error action preface to return at the end of script
Write-Verbose "Setting error action preference to 'Stop' for error handling purposes"
$startpref = $ErrorActionPreference
$ErrorActionPreference = "Stop"

#nested in try, catch, finally main for overall success determination
try {
    $success = $true
    
    try {
        $copyargs = @{
            Path = where.exe cmd.exe
            Destination = Join-Path -Path (Get-Item -Path "env:\$Runlocation").Value -ChildPath "$ProcessName.exe"
        } #copyargs hashtable
    
        if (Test-Path -Path $copyargs.Destination) {
            Write-Verbose "$($copyargs.Destination) already exists on $env:COMPUTERNAME."
        } #if test-path
        else {
            Write-Verbose "Copying cmd.exe to $($copyargs.Destination) on $env:COMPUTERNAME"
            Copy-Item @copyargs -Force  
        } #else   
    } #try
    catch {
        $message = "Unable to create executable program on $env:COMPUTERNAME. Path: {0}, Destination: {1}" -f $copyargs.Path, $copyargs.Destination
        Throw $_
    } #catch
    
    try {
        Write-Verbose "Creating scheduled task arguments"
        $userid = (Get-CimInstance -ClassName Win32_Account -Filter "Name = '$Principal'").SID
        $taskargs = @{
            Action    = New-ScheduledTaskAction -Execute $copyargs.Destination
            Settings  = New-ScheduledTaskSettingsSet -Hidden
            Principal = New-ScheduledTaskPrincipal -UserId $userid -LogonType ServiceAccount
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
            Register-ScheduledTask -TaskName $taskname | 
                Start-ScheduledTask
    } #try
    catch {
        $message = "Unable to start process from scheduled task - $taskname on $env:COMPUTERNAME"
        Throw $_
    } #catch

    try {
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
        Unregister-ScheduledTask -Confirm:$false
    }

    [PSCustomObject]@{
        success = $success
        message = $message
    } #pscustomobject returned from script
} #Main finally


