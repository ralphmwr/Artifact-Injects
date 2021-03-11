[CmdletBinding()]
param (
    [Parameter(Mandatory=$true, Position=0)]
    [ValidateSet("Generic Process",
                 "Start Process",
                 "Local Account",
                 "Startup Folder Persistence",
                 "Registry Persistence",
                 "WMI Subscription Persistence",
                 "Scheduled Task Persistence",
                 "Remove Firewall Rule",
                 "Add Firewall Rule")]
    [string]
    $Action,

    [Parameter(Mandatory=$true, Position=1)]
    [string]
    $Principal,

    [Parameter(Mandatory=$true)]
    [string[]]
    $targets,

    # Parameter help description
    [Parameter(ParameterSetName='Generic Process', Mandatory=$true)]
    [ValidateSet('AllUsersProfile','AppData','ProgramFiles','Temp')]
    [String]
    $RunFrom,

    [Parameter(ParameterSetName='Generic Process', Mandatory=$true)]
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
    $ProcessName,

    [Parameter(ParameterSetName='Generic Process')]
    [pscredential]
    $Credential,

    [Parameter(ParameterSetName='Start Process',Mandatory=$true)]
    [ValidateScript({
        if($_.EndsWith(".exe")) {
            $true
        }
        else {
            Throw "$_ must end in .exe"
        }
    })]
    [string]
    $Path,

    [Parameter(ParameterSetName='Local Account', Mandatory=$true)]
    [ValidateScript({
        if (($_ -notmatch '^[a-zA-Z0-9]+([._]?[a-zA-Z0-9]+)*$') -or ($_.length -notin 8..20)) {
            Throw "$_ is not a valid user name"
        }
        else {
            $true
        }
    })]
    [String]
    $AccountName,

    [Parameter(ParameterSetName='Local Account')]
    [string[]]
    $GroupMembership
)
[xml]$xml = "<artifact><action>$Action</action></artifact>"
foreach ($target in $targets) {
    $xml.artifact.innerxml += "<target>$target</target>"
}
foreach ($parameter in $PSBoundParameters.Keys) {
    foreach ($arg in $parameter.'#text') {
        $xml.artifact.innerxml += "<parameter name='$parameter'>$arg</parameter>"        
    }
}
$xml.OuterXml
