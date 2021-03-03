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

$DropDown = [PSCustomObject]@{
    RunFrom     = 'AllUsersProfile','AppData','ProgramFiles','Temp'
    Principal   = 'SYSTEM','Credentialed User'
    Persistance = 'None','Registry-HKU','Registry-HKLM','Registry-HKCU'
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