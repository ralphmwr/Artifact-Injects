function Invoke-Process {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true)]
        [string]
        $path,
        [Parameter(ParameterSetName="CN", Mandatory=$true)]
        [string]
        $ComputerName,
        [Parameter(ParameterSetName="CN", Mandatory=$true)]
        [pscredential]
        $Credential,
        [Parameter(ParameterSetName="Session", Mandatory=$true)]
        [PSSession]
        $Session
    )
    
    begin {
        
    }
    
    process {
        $splat = @{
            ScriptBlock = {
                if (Test-Path -Path $path) {
                    Start-Process -FilePath $path
                }
            }
        }
        if ($PSCmdlet.ParameterSetName -eq "CN") {
            $splat.ComputerName = $ComputerName
            $splat.Credential   = $Credential
        }
        else {
            $splat.Session = $Session
        }
    }
    
    end {
        
    }
}