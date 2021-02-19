[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]
    $Principal,

    [Parameter(Mandatory=$true)]
    [ValidateScript({$_ -in @(Get-ChildItem -Path "Env:\" | Select-Object -ExpandProperty Name)})]
    [string]
    $Runlocation,

    [Parameter(Mandatory=$true)]
    [string]
    $ProcessName
) #param block

Write-Verbose "Setting error action preference to 'Stop' for error handling purposes"
$startpref = $ErrorActionPreference
$ErrorActionPreference = "Stop"

try {
    Write-Verbose "Searching for $Principal SID on $env:COMPUTERNAME"
    $userid = Get-CimInstance -ClassName Win32_Account -Filter "Name like '$Principal'" |
        Select-Object -ExpandProperty SID
} #try
catch {
    Write-Error "Unable to find $principal on $env:COMPUTERNAME"
    Exit
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
    Write-Error  ("Unable to create executable program. Path: {0}, Destination: {1}" -f $copyargs.Path, $copyargs.Destination)
    Exit
} #catch

Write-Verbose "Creating scheduled task arguments"
$taskargs = @{
    Action    = New-ScheduledTaskAction -Execute $copyargs.Destination
    Settings  = New-ScheduledTaskSettingsSet -Hidden
    Principal = New-ScheduledTaskPrincipal -UserId $userid -LogonType ServiceAccount
} #taskargs hashtable

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
    Write-Error "Unable to start process"
} #catch
finally {
    Write-Verbose "Unregistering $taskname, process should still be running."
    Unregister-ScheduledTask -TaskName $taskname -Confirm:$false -ErrorAction Ignore

    if (Get-Process -Name $ProcessName -ErrorAction Ignore) {
        Write-Verbose "Confirmed $ProcessName process is running"
    } #if   
    else { 
        Write-Error "Cannot find $ProcessName process! Something went wrong. Check error messages!"
    } #else
    Write-Verbose "Setting error action preface back to $startpref"
    $ErrorActionPreference = $startpref
} #finally


