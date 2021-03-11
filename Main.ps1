Add-Type -AssemblyName PresentationCore, PresentationFramework

$AddAutomation = {
    if ($script:Automationxml) {
        $xml =  @"
    
    <artifact>
        <targets>$($txtAdHocTargets.Lines -join ", ")</targets>
        <action>$($cbxAction.SelectedItem.ToString())</action>   
"@
        switch ($cbxAction.SelectedItem.ToString()) {
            'Generic Process Execution' {  
                $xml += @"

        <parameter name='Principal'>$($cbxAdHoc2.SelectedItem.ToString())</parameter>
        <parameter name='Runlocation'>$($cbxAdHoc1.SelectedItem.ToString())</parameter>
        <parameter name='ProcessName'>$($txtAdHoc1.Text)</parameter>
"@
            } #generic process execution
        } #switch
        $xml += '</artifact>'
        $autonode = $script:Automationxml | 
            Select-Xml -XPath '//automation' | 
                Select-Object -ExpandProperty node
        $autonode.innerxml += $xml
        $script:Automationxml.automation.outerxml | Set-Content -Path $Script:Automationfile -Force
        $updatedgvAutomation.invoke()
    } #if
} #AddAutomation script block

$NewAutomation = {
    $saveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
    $saveFileDialog.Filter = "xml files (*.xml)|*.xml"
    $saveFileDialog.FilterIndex = 2
    $saveFileDialog.ValidateNames = $true
    if ($saveFileDialog.ShowDialog() -eq [System.windows.forms.dialogresult]::OK) {
        $Script:Automationfile     = $saveFileDialog.FileName
        $lblFileLoaded.text        = "File Loaded: '$Script:Automationfile'"
        $lblFileLoaded.Forecolor   = [System.Drawing.Color]::Green
        "<automation></automation>" | Set-Content -Path $Script:Automationfile
        [xml]$script:Automationxml = Get-Content -Path $Script:Automationfile
    } #if
} #NewAutomation script block

$LoadAutomation = {
    $openFileDialog = New-Object System.windows.forms.openFileDialog
    $openFileDialog.Filter = "xml files (*.xml)|*.xml"
    $openFileDialog.FilterIndex = 2
    if ($openFileDialog.ShowDialog() -eq [system.windows.forms.dialogresult]::OK) {
        $Script:Automationfile       = $openFileDialog.FileName
        $lblFileLoaded.text          = $Script:Automationfile
        $lblFileLoaded.Forecolor      = [System.Drawing.Color]::Green 
        [xml]$script:Automationxml   = Get-Content -Path $Script:Automationfile
        $updatedgvAutomation.invoke()
    } #if
} #LoadAutomation script block

$LoadCredentials = {
    $script:credential = Get-Credential -Message 'Enter Credentials for Remote Host Access'
    $lblCredentials.text = "Credentials Loaded For {0}" -f $credential.UserName
    $lblCredentials.ForeColor = [System.Drawing.Color]::Green
    $btnLoadCredentials.Text = "Re-Load Credentials"
    $DropDown.Principal += $script:credential.UserName
} #LoadCredential script block

$AdHocRun = {
    $txtAdHocStatus.Lines = "Running..."
    try {
        $Parameters = @{
            ErrorAction  = 'Stop'
        } #Parameters

        $AdhocOptions = New-PSSessionOption @Parameters -ApplicationArguments @{verbose=$cbVerbose.checked}
        
        $Parameters += @{            
            Credential    = $script:credential
            SessionOption = $AdhocOptions
            ComputerName = $txtAdHocTargets.Lines
        } #Parameters
        $AdHocSession = New-PSSession @Parameters

        $Parameters = @{
            Session     = $AdHocSession
            ErrorAction = 'Stop'
        }
        switch ($cbxAction.SelectedItem.ToString()) {
            'Generic Process Execution' {  
                $Parameters.FilePath = Join-Path -Path $PSScriptRoot -ChildPath 'SRC_Scripts\Invoke-GenericProcess.ps1'
                $Parameters.argumentlist = $cbxAdHoc2.SelectedItem.ToString(),
                                           $cbxAdHoc1.SelectedItem.ToString(),
                                           $txtAdHoc1.Text
    
                if ($Parameters.argumentlist[0] -ne 'SYSTEM') {
                    $msgTitle = "Use {0} as Principal?" -f $Parameters.argumentlist[0]
                    $msgBody  = "{0} must be logged in for this process to start. Are you sure you want to use this Principal?" -f $Parameters.argumentlist[0]
                    $msgBtns  = [system.Windows.messageboxbutton]::YesNo
                    $msgIcon  = [system.Windows.messageboximage]::Warning
                    if([system.Windows.messagebox]::Show($msgBody,$msgTitle,$msgBtns,$msgIcon) -eq 'Yes') {
                        $Parameters.argumentlist += $credential
                    } #if are you sure?
                    else {Break}
                } #if not SYSTEM as principal
                
                try {
                    Invoke-Command @Parameters |
                    ForEach-Object {$txtAdHocStatus.Lines += ("{0} - {1}" -f $_.pscomputername, $_.message)}  
                } #try
                catch {
                    $txtAdHocStatus.Lines += "Invoke-Command error : "
                    Throw $_
                } #catch
            } #Generic Process Execution
            
            'Start Process' {
                $Parameters.FilePath = Join-Path -Path $PSScriptRoot -ChildPath 'SRC_Scripts\Invoke-Process.ps1'
                $Parameters.argumentlist = $cbxAdHoc1.SelectedItem.ToString(),
                                           $txtAdHoc1.Text
    
                if ($Parameters.argumentlist[0] -ne 'SYSTEM') {
                    $msgTitle = "Use {0} as Principal?" -f $Parameters.argumentlist[0]
                    $msgBody  = "{0} must be logged in for this process to start. Are you sure you want to use this Principal?" -f $Parameters.argumentlist[0]
                    $msgBtns  = [system.Windows.messageboxbutton]::YesNo
                    $msgIcon  = [system.Windows.messageboximage]::Warning
                    if([system.Windows.messagebox]::Show($msgBody,$msgTitle,$msgBtns,$msgIcon) -eq 'Yes') {
                        $Parameters.argumentlist += $credential
                    } #if are you sure?
                    else {Break}
                } #if not SYSTEM as principal
                
                try {
                    Invoke-Command @Parameters |
                    ForEach-Object {$txtAdHocStatus.Lines += ("{0} - {1}" -f $_.pscomputername, $_.message)}  
                } #try
                catch {
                    $txtAdHocStatus.Lines += "Invoke-Command error : "
                    Throw $_
                } #catch
            } #Start Process
            'New Local Account' {
    
            } #New Local Account
            'Startup Folder Persistence' {
    
            } #Startup Folder Persistence
            'Registry Persistence' {
    
            } #Registry Persistence
            'WMI Subscription Persistence' {
    
            } #WMI Subscription Persistence
            'Remove Firewall Rule' {
    
            } #Remove Firewall Rule
            'Add Firewall Rule' {
    
            } #Add Firewall Rule
            Default {
                [system.Windows.messagebox]::Show('Select an Action!')
            } #default
        } #switch
    }
    catch {
        $txtAdHocStatus.Lines += ("Error Msg: {0} : {1}" -f $_.Tostring(), $_.InvocationInfo.Line.trim())
    }
    finally {
        $AdHocSession | Remove-PSSession -ErrorAction Ignore
    }   
} #AdHoc Run+Validate

$UpdateAdHocForm = {
    switch ($cbxAction.SelectedItem.ToString()) {
        'Generic Process Execution' {
            $ActiveControls   = @(
                $lbltxtAdHoc1,
                $lblcbxAdHoc1,
                $lblcbxAdHoc2,
                $txtAdHoc1,
                $cbxAdHoc1,
                $cbxAdHoc2
            ) #ActiveControls
            $InactiveControls = $AdHocControls | Where-Object {$_ -notin $ActiveControls}

            # Configuring Controls
            $lbltxtAdHoc1.text = 'Process Name'
            $lblcbxAdHoc1.text = 'Run Location'
            $lblcbxAdHoc2.text = 'Principal'
            $cbxAdHoc1.items.clear()
            $cbxAdHoc1.items.AddRange($DropDown.RunFrom)
            $cbxAdHoc2.items.Clear()
            $cbxAdHoc2.items.AddRange($DropDown.Principal)
            $ActiveControls | ForEach-Object {$_.Visible = $true}
            $InactiveControls | ForEach-Object {$_.Visible = $false}

        } #Generic Process Execution

        'Start Process' {
            $ActiveControls   = @(
                $lbltxtAdHoc1,
                $lblcbxAdHoc1,
                $txtAdHoc1,
                $cbxAdHoc1
            ) #ActiveControls
            $InactiveControls = $AdHocControls | Where-Object {$_ -notin $ActiveControls}

            # Configuring Controls
            $lbltxtAdHoc1.text = 'Executable Path:'
            $lblcbxAdHoc1.text = 'Principal:'
            $cbxAdHoc1.items.clear()
            $cbxAdHoc1.items.AddRange($DropDown.Principal)
            $ActiveControls | ForEach-Object {$_.Visible = $true}
            $InactiveControls | ForEach-Object {$_.Visible = $false}

        } #Start Process

        'New Local Account' {
            $ActiveControls   = @(
                $lbltxtAdHoc1,
                $lbltxtAdHoc2,
                $lblcbxAdHoc1,
                $txtAdHoc1,
                $txtAdHoc2,
                $cbxAdHoc1
            ) #ActiveControls
            $InactiveControls = $AdHocControls | Where-Object {$_ -notin $ActiveControls}

            # Configuring Controls
            $lbltxtAdHoc1.text = 'Account Name:'
            $lbltxtAdHoc2.text = 'Group Membership (comma delimit)'
            $lblcbxAdHoc1.text = 'Principal'
            $cbxAdHoc1.items.clear()
            $cbxAdHoc1.items.AddRange($DropDown.Principal)
            $ActiveControls | ForEach-Object {$_.Visible = $true}
            $InactiveControls | ForEach-Object {$_.Visible = $false}

        } # New Local Account

        'Startup Folder Persistence' {
            $ActiveControls   = @(
                $lbltxtAdHoc1,
                $lblcbxAdHoc1,
                $txtAdHoc1,
                $cbxAdHoc1
            ) #ActiveControls
            $InactiveControls = $AdHocControls | Where-Object {$_ -notin $ActiveControls}

            # Configuring Controls
            $lbltxtAdHoc1.text = 'File Name:'
            $lblcbxAdHoc1.text = 'Principal'
            $cbxAdHoc1.items.clear()
            $cbxAdHoc1.items.AddRange($DropDown.Principal)
            $ActiveControls | ForEach-Object {$_.Visible = $true}
            $InactiveControls | ForEach-Object {$_.Visible = $false}

        } #Startup Folder Persistence

        'Registry Persistence' {
            $ActiveControls   = @(
                $lbltxtAdHoc1,
                $lbltxtAdHoc2,
                $lblcbxAdHoc1,
                $lblcbxAdHoc2,
                $txtAdHoc1,
                $txtAdHoc2,
                $cbxAdHoc1,
                $cbxAdHoc2
            ) #ActiveControls
            $InactiveControls = $AdHocControls | Where-Object {$_ -notin $ActiveControls}

            # Configuring Controls
            $lbltxtAdHoc1.text = 'Key Name:'
            $lbltxtAdHoc2.text = 'Value:'
            $lblcbxAdHoc1.text = 'Principal:'
            $lblcbxAdHoc2.text = 'Hive:'
            $cbxAdHoc1.items.clear()
            $cbxAdHoc1.items.AddRange($DropDown.Principal)
            $cbxAdHoc2.items.clear()
            $cbxAdHoc2.items.AddRange($DropDown.Hive)
            $ActiveControls | ForEach-Object {$_.Visible = $true}
            $InactiveControls | ForEach-Object {$_.Visible = $false}
        } #Registry Persistence
        'WMI Subscription Persistence' {}
        'Scheduled Task Persistence' {}
        'Remove Firewall Rule' {}
        'Add Firewall Rule' {}
    } #Switch cbxAction.selectitem.tostring()
} #UpdateAdHocForm scriptblock

$updatedgvAutomation = {
    if ($Script:Automationfile){
        $dgvAutomation.Visible = $true
        $dgvAutomation.ColumnCount = 4
        $dgvAutomation.Columns[0].Name = "Targets"
        $dgvAutomation.Columns[1].Name = "Action"
        $dgvAutomation.Columns[2].Name = "Parameters"
        $dgvAutomation.Columns[3].Name = "Status"

        foreach ($artifact in $Script:Automationxml.automation.artifact) {
            $row = @($artifact.Targets)
            $row += $artifact.Action
            $row += ($artifact.parameter | 
                Group-Object -Property name |
                    Select-Object @{n='param';e={"$($_.name)=$($_.group.'#text' -join ', ')"}}).param -join "; "
            $row += "Not Validated"
            $dgvAutomation.rows.add($row)
        }
        
    } #if
} #updatedgvAutomation

$DropDown = [PSCustomObject]@{
    RunFrom     = 'AllUsersProfile','AppData','ProgramFiles','Temp'
    Principal   = @('SYSTEM')
    Persistance = 'Registry-HKU','Registry-HKLM','Registry-HKCU'
    Direction   = 'Inbound','Outbound','Both'
    Hive        = 'HKLM','HKU','HKCU'
} #DropDown definition

Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'main.designer.ps1')
$AdHocControls = @(
    $lbltxtAdHoc1,
    $lbltxtAdHoc2,
    $lbltxtAdHoc3,
    $lblcbxAdHoc1,
    $lblcbxAdHoc2,
    $lblcbxAdHoc3,
    $txtAdHoc1,
    $txtAdHoc2,
    $txtAdHoc3,
    $cbxAdHoc1,
    $cbxAdHoc2,
    $cbxAdHoc3
)
$frmMain.ShowDialog()