[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]
    $Principal,

    [Parameter(Mandatory=$true)]
    [ValidateScript({
        $valid = @(Get-ChildItem -Path "Env:\").Name
        if ($_ -in $valid) { 
            $true 
        } #if
        else { 
            Throw ("'$_' is not a valid run location. Valid locations are {0}" -f ($valid -join ", "))  
        } #else
    })] #ValidateScript
    [string]
    $Runlocation,

    [Parameter(Mandatory=$true)]
    [string]
    $ProcessName
) #param block

Write-Verbose "Setting error action preference to 'Stop' for error handling purposes"
$startpref = $ErrorActionPreference
$ErrorActionPreference = "Stop"

#nested in try, catch, finally for overall success determination
try {
    try {
        Write-Verbose "Searching for $Principal SID on $env:COMPUTERNAME"
        if (! ($userid = Get-CimInstance -ClassName Win32_Account -Filter "Name like '$Principal'" |
            Select-Object -ExpandProperty SID)) { Throw }
    } #try
    catch {
        $results = "Unable to find $Principal on $env:COMPUTERNAME"
        Throw         
    } #catch
    
    try {
        $copyargs = @{
            Path = where.exe cmd.exe
            Destination = Join-Path -Path (Get-Item -Path "env:\$Runlocation").Value -ChildPath "$ProcessName.exe"
        } #copyargs hashtable
    
        if (Test-Path -Path $copyargs.Destination) {
            Write-Verbose "$($copyargs.Destination) already exists."
        } #if test-path
        else {
            Write-Verbose "Copying cmd.exe to $($copyargs.Destination)"
            Copy-Item @copyargs -Force  
        } #else     
    } #try
    catch {
        $results = "Unable to create executable program. Path: {0}, Destination: {1}" -f $copyargs.Path, $copyargs.Destination
        Throw 
    } #catch
    
    try {
        Write-Verbose "Creating scheduled task arguments"
        $taskargs = @{
            Action    = New-ScheduledTaskAction -Execute $copyargs.Destination
            Settings  = New-ScheduledTaskSettingsSet -Hidden
            Principal = New-ScheduledTaskPrincipal -UserId $userid -LogonType ServiceAccount
        } #taskargs hashtable
    } #try
    catch {
        $results = "Unable to create scheduled task arguments"
        Throw
    } #catch
    
    Write-Verbose "Coming up with random task name that doesn't already exist."
    do {
        $taskname = -join ((65..90) + (97..122) | Get-Random -Count 5 | ForEach-Object {[char]$_})
    } while (Get-ScheduledTask -TaskName $taskname -ErrorAction Ignore)
    
    try {
        Write-Verbose "Creating/Registering/Starting scheduled task $taskname"
        New-ScheduledTask @taskargs | 
            Register-ScheduledTask -TaskName $taskname | 
                Start-ScheduledTask
    } #try
    catch {
        $results = "Unable to start process from scheduled task - $taskname on $env:COMPUTERNAME"
        Unregister-ScheduledTask -TaskName $taskname -Confirm:$false
        Throw
    } #catch

    try {
        Write-Verbose "Unregistering $taskname, process should still be running."
        Unregister-ScheduledTask -TaskName $taskname -Confirm:$false
    } #try
    catch {
        $results = "Unable to unregister $taskname from registered scheduled tasks."
        Throw
    } #catch

    try {
        Write-Verbose "Validating $ProcessName is running"
        Get-Process -Name $ProcessName | Out-Null
        Write-Verbose "Confirmed $ProcessName process is running"
        [PSCustomObject]@{
            success = $true
            message = "Validated $ProcessName on $env:COMPUTERNAME"
        } #pscustomobject
    } #try
    catch {
        $results = "$ProcessName is NOT running on $env:COMPUTERNAME"
        Throw
    } #catch

} #try
catch {
    [PSCustomObject]@{
        success = $false
        message = $results
    } #pscustomobject
} #catch
finally {
    Write-Verbose "Setting error action preface back to $startpref"
    $ErrorActionPreference = $startpref     
} #finally


