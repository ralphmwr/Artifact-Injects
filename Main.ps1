$UpdateAdHocForm = {
    switch ($cbxAction.SelectedItem.ToString()) {
        'Generic Process Execution' {
            $ActiveControls   = @(
                $lbltxtAdHoc1,
                $lblcbxAdHoc1,
                $lblcbxAdHoc2,
                $lblcbxAdHoc3,
                $txtAdHoc1,
                $cbxAdHoc1,
                $cbxAdHoc2,
                $cbxAdHoc3
            ) #ActiveControls
            $InactiveControls = @(
                $lbltxtAdHoc2,
                $lbltxtAdHoc3,
                $txtAdHoc2,
                $txtAdHoc3
            ) #InactiveControls
            #
            # Configuring Controls
            $lbltxtAdHoc1.text = 'Process Name'
            $lblcbxAdHoc1.text = 'Run Location'
            $lblcbxAdHoc2.text = 'Principal'
            $lblcbxAdHoc3.text = 'Persistance'
            $cbxAdHoc1.items.clear()
            $cbxAdHoc1.items.AddRange($DropDown.RunFrom)
            $cbxAdHoc2.items.Clear()
            $cbxAdHoc2.items.AddRange($DropDown.Principal)
            $cbxAdHoc3.items.Clear()
            $cbxAdHoc3.items.AddRange($DropDown.Persistance)
            $ActiveControls | ForEach-Object {$_.Visible = $true}
            $InactiveControls | ForEach-Object {$_.Visible = $false}

        } #Generic Process Execution

        'Start Process' {
            $ActiveControls   = @(
                $lbltxtAdHoc1,
                $lblcbxAdHoc1,
                $lblcbxAdHoc2,
                $txtAdHoc1,
                $cbxAdHoc1,
                $cbxAdHoc2
            ) #ActiveControls
            $InactiveControls = @(
                $lbltxtAdHoc2,
                $lbltxtAdHoc3,
                $lblcbxAdHoc3,
                $txtAdHoc2,
                $txtAdHoc3,
                $cbxAdHoc3
            ) #InactiveControls

            # Configuring Controls
            $lbltxtAdHoc1.text = 'Executable Path:'
            $lblcbxAdHoc1.text = 'Principal'
            $lblcbxAdHoc2.text = 'Persistance'
            $cbxAdHoc1.items.clear()
            $cbxAdHoc1.items.AddRange($DropDown.Principal)
            $cbxAdHoc2.items.Clear()
            $cbxAdHoc2.items.AddRange($DropDown.Persistance)
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
            $InactiveControls = @(
                $lbltxtAdHoc3,
                $lblcbxAdHoc2,
                $lblcbxAdHoc3,
                $txtAdHoc3,
                $cbxAdHoc2,
                $cbxAdHoc3
            ) #InactiveControls

            # Configuring Controls
            $lbltxtAdHoc1.text = 'Account Name:'
            $lbltxtAdHoc2.text = 'Group Membership (comma delimit)'
            $lblcbxAdHoc1.text = 'Principal'
            $cbxAdHoc1.items.clear()
            $cbxAdHoc1.items.AddRange($DropDown.Principal)
            $ActiveControls | ForEach-Object {$_.Visible = $true}
            $InactiveControls | ForEach-Object {$_.Visible = $false}

        } # New Local Account

        'Startup Folder Persistence' {}
        'Registry Persistence' {}
        'WMI Subscription Persistence' {}
        'Scheduled Task Persistence' {}
        'Remove Firewall Rule' {}
        'Add Firewall Rule' {}
    } #Switch cbxAction.selectitem.tostring()
} #UpdateAdHocForm scriptblock

$DropDown = [PSCustomObject]@{
    RunFrom     = 'AllUsersProfile','AppData','ProgramFiles','Temp'
    Principal   = 'SYSTEM','Credentialed User'
    Persistance = 'None','Registry-HKU','Registry-HKLM','Registry-HKCU'
    Direction   = 'Inbound','Outbound','Both'
} #DropDown definition

Add-Type -AssemblyName System.Windows.Forms
. (Join-Path $PSScriptRoot 'main.designer.ps1')
$frmMain.ShowDialog()