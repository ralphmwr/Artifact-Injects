$frmMain = New-Object -TypeName System.Windows.Forms.Form
[System.Windows.Forms.GroupBox]$gbxAutomation = $null
[System.Windows.Forms.Button]$btnAutoRemove = $null
[System.Windows.Forms.Button]$btnValidate = $null
[System.Windows.Forms.Button]$btnAutoRun = $null
[System.Windows.Forms.Label]$lblAutoValidation = $null
[System.Windows.Forms.Button]$btnLoadAutomation = $null
[System.Windows.Forms.Label]$lblAutomationName = $null
[System.Windows.Forms.DataGridView]$dgvAutomation = $null
[System.Windows.Forms.Label]$lblFileLoaded = $null
[System.Windows.Forms.Button]$btnLoadCredentials = $null
[System.Windows.Forms.Label]$lblCredentials = $null
[System.Windows.Forms.GroupBox]$gbxAdHoc = $null
[System.Windows.Forms.CheckBox]$cbVerbose = $null
[System.Windows.Forms.Button]$btnAddAutomation = $null
[System.Windows.Forms.Button]$btnAdHocRemove = $null
[System.Windows.Forms.Label]$lbltxtAdHocStatus = $null
[System.Windows.Forms.TextBox]$txtAdHocStatus = $null
[System.Windows.Forms.Button]$btnAdHocValidate = $null
[System.Windows.Forms.Button]$btnAdHocRun = $null
[System.Windows.Forms.Label]$lbltxtAdHocTargets = $null
[System.Windows.Forms.TextBox]$txtAdHocTargets = $null
[System.Windows.Forms.Label]$lbltxtAdHoc3 = $null
[System.Windows.Forms.TextBox]$txtAdHoc3 = $null
[System.Windows.Forms.Label]$lbltxtAdHoc2 = $null
[System.Windows.Forms.TextBox]$txtAdHoc2 = $null
[System.Windows.Forms.Label]$lblcbxAdHoc3 = $null
[System.Windows.Forms.ComboBox]$cbxAdHoc3 = $null
[System.Windows.Forms.Label]$lblcbxAdHoc2 = $null
[System.Windows.Forms.ComboBox]$cbxAdHoc2 = $null
[System.Windows.Forms.Label]$lblcbxAdHoc1 = $null
[System.Windows.Forms.ComboBox]$cbxAdHoc1 = $null
[System.Windows.Forms.Label]$lbltxtAdHoc1 = $null
[System.Windows.Forms.TextBox]$txtAdHoc1 = $null
[System.Windows.Forms.Label]$lblAction = $null
[System.Windows.Forms.ComboBox]$cbxAction = $null
function InitializeComponent
{
$gbxAutomation = (New-Object -TypeName System.Windows.Forms.GroupBox)
$btnAutoRemove = (New-Object -TypeName System.Windows.Forms.Button)
$btnValidate = (New-Object -TypeName System.Windows.Forms.Button)
$btnAutoRun = (New-Object -TypeName System.Windows.Forms.Button)
$lblAutoValidation = (New-Object -TypeName System.Windows.Forms.Label)
$btnLoadAutomation = (New-Object -TypeName System.Windows.Forms.Button)
$lblAutomationName = (New-Object -TypeName System.Windows.Forms.Label)
$dgvAutomation = (New-Object -TypeName System.Windows.Forms.DataGridView)
$lblFileLoaded = (New-Object -TypeName System.Windows.Forms.Label)
$btnLoadCredentials = (New-Object -TypeName System.Windows.Forms.Button)
$lblCredentials = (New-Object -TypeName System.Windows.Forms.Label)
$gbxAdHoc = (New-Object -TypeName System.Windows.Forms.GroupBox)
$btnAddAutomation = (New-Object -TypeName System.Windows.Forms.Button)
$btnAdHocRemove = (New-Object -TypeName System.Windows.Forms.Button)
$lbltxtAdHocStatus = (New-Object -TypeName System.Windows.Forms.Label)
$txtAdHocStatus = (New-Object -TypeName System.Windows.Forms.TextBox)
$btnAdHocValidate = (New-Object -TypeName System.Windows.Forms.Button)
$btnAdHocRun = (New-Object -TypeName System.Windows.Forms.Button)
$lbltxtAdHocTargets = (New-Object -TypeName System.Windows.Forms.Label)
$txtAdHocTargets = (New-Object -TypeName System.Windows.Forms.TextBox)
$lbltxtAdHoc3 = (New-Object -TypeName System.Windows.Forms.Label)
$txtAdHoc3 = (New-Object -TypeName System.Windows.Forms.TextBox)
$lbltxtAdHoc2 = (New-Object -TypeName System.Windows.Forms.Label)
$txtAdHoc2 = (New-Object -TypeName System.Windows.Forms.TextBox)
$lblcbxAdHoc3 = (New-Object -TypeName System.Windows.Forms.Label)
$cbxAdHoc3 = (New-Object -TypeName System.Windows.Forms.ComboBox)
$lblcbxAdHoc2 = (New-Object -TypeName System.Windows.Forms.Label)
$cbxAdHoc2 = (New-Object -TypeName System.Windows.Forms.ComboBox)
$lblcbxAdHoc1 = (New-Object -TypeName System.Windows.Forms.Label)
$cbxAdHoc1 = (New-Object -TypeName System.Windows.Forms.ComboBox)
$lbltxtAdHoc1 = (New-Object -TypeName System.Windows.Forms.Label)
$txtAdHoc1 = (New-Object -TypeName System.Windows.Forms.TextBox)
$lblAction = (New-Object -TypeName System.Windows.Forms.Label)
$cbxAction = (New-Object -TypeName System.Windows.Forms.ComboBox)
$cbVerbose = (New-Object -TypeName System.Windows.Forms.CheckBox)
$gbxAutomation.SuspendLayout()
([System.ComponentModel.ISupportInitialize]$dgvAutomation).BeginInit()
$gbxAdHoc.SuspendLayout()
$frmMain.SuspendLayout()
#
#gbxAutomation
#
$gbxAutomation.Controls.Add($btnAutoRemove)
$gbxAutomation.Controls.Add($btnValidate)
$gbxAutomation.Controls.Add($btnAutoRun)
$gbxAutomation.Controls.Add($lblAutoValidation)
$gbxAutomation.Controls.Add($btnLoadAutomation)
$gbxAutomation.Controls.Add($lblAutomationName)
$gbxAutomation.Controls.Add($dgvAutomation)
$gbxAutomation.Controls.Add($lblFileLoaded)
$gbxAutomation.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]38))
$gbxAutomation.Name = [System.String]'gbxAutomation'
$gbxAutomation.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]934,[System.Int32]314))
$gbxAutomation.TabIndex = [System.Int32]1
$gbxAutomation.TabStop = $false
$gbxAutomation.Text = [System.String]'Automation'
$gbxAutomation.UseCompatibleTextRendering = $true
#
#btnAutoRemove
#
$btnAutoRemove.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]153,[System.Int32]17))
$btnAutoRemove.Name = [System.String]'btnAutoRemove'
$btnAutoRemove.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]128,[System.Int32]23))
$btnAutoRemove.TabIndex = [System.Int32]9
$btnAutoRemove.Text = [System.String]'Remove Artifacts'
$btnAutoRemove.UseCompatibleTextRendering = $true
$btnAutoRemove.UseVisualStyleBackColor = $true
#
#btnValidate
#
$btnValidate.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]153,[System.Int32]49))
$btnValidate.Name = [System.String]'btnValidate'
$btnValidate.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]128,[System.Int32]23))
$btnValidate.TabIndex = [System.Int32]8
$btnValidate.Text = [System.String]'Validate'
$btnValidate.UseCompatibleTextRendering = $true
$btnValidate.UseVisualStyleBackColor = $true
#
#btnAutoRun
#
$btnAutoRun.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]49))
$btnAutoRun.Name = [System.String]'btnAutoRun'
$btnAutoRun.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]141,[System.Int32]23))
$btnAutoRun.TabIndex = [System.Int32]7
$btnAutoRun.Text = [System.String]'Run + Validate'
$btnAutoRun.UseCompatibleTextRendering = $true
$btnAutoRun.UseVisualStyleBackColor = $true
#
#lblAutoValidation
#
$lblAutoValidation.ForeColor = [System.Drawing.Color]::Red
$lblAutoValidation.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]287,[System.Int32]49))
$lblAutoValidation.Name = [System.String]'lblAutoValidation'
$lblAutoValidation.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]641,[System.Int32]19))
$lblAutoValidation.TabIndex = [System.Int32]6
$lblAutoValidation.Text = [System.String]'Not Validated'
$lblAutoValidation.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$lblAutoValidation.UseCompatibleTextRendering = $true
#
#btnLoadAutomation
#
$btnLoadAutomation.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]20))
$btnLoadAutomation.Name = [System.String]'btnLoadAutomation'
$btnLoadAutomation.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]141,[System.Int32]23))
$btnLoadAutomation.TabIndex = [System.Int32]0
$btnLoadAutomation.Text = [System.String]'Load-Automation-File'
$btnLoadAutomation.UseCompatibleTextRendering = $true
$btnLoadAutomation.UseVisualStyleBackColor = $true
#
#lblAutomationName
#
$lblAutomationName.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]84))
$lblAutomationName.Name = [System.String]'lblAutomationName'
$lblAutomationName.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]922,[System.Int32]23))
$lblAutomationName.TabIndex = [System.Int32]5
$lblAutomationName.Text = [System.String]'Automation Name: NONE'
$lblAutomationName.TextAlign = [System.Drawing.ContentAlignment]::MiddleLeft
$lblAutomationName.UseCompatibleTextRendering = $true
#
#dgvAutomation
#
$dgvAutomation.AllowDrop = $true
$dgvAutomation.AllowUserToAddRows = $false
$dgvAutomation.AllowUserToDeleteRows = $false
$dgvAutomation.ColumnHeadersHeightSizeMode = [System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode]::AutoSize
$dgvAutomation.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]107))
$dgvAutomation.Name = [System.String]'dgvAutomation'
$dgvAutomation.ReadOnly = $true
$dgvAutomation.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]922,[System.Int32]201))
$dgvAutomation.TabIndex = [System.Int32]2
$dgvAutomation.Visible = $false
#
#lblFileLoaded
#
$lblFileLoaded.ForeColor = [System.Drawing.Color]::Red
$lblFileLoaded.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]380,[System.Int32]17))
$lblFileLoaded.Name = [System.String]'lblFileLoaded'
$lblFileLoaded.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]548,[System.Int32]23))
$lblFileLoaded.TabIndex = [System.Int32]1
$lblFileLoaded.Text = [System.String]'File Loaded: NONE'
$lblFileLoaded.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$lblFileLoaded.UseCompatibleTextRendering = $true
#
#btnLoadCredentials
#
$btnLoadCredentials.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]8.25,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$btnLoadCredentials.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]18,[System.Int32]9))
$btnLoadCredentials.Name = [System.String]'btnLoadCredentials'
$btnLoadCredentials.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]141,[System.Int32]23))
$btnLoadCredentials.TabIndex = [System.Int32]3
$btnLoadCredentials.Text = [System.String]'Load Credentials'
$btnLoadCredentials.UseCompatibleTextRendering = $true
$btnLoadCredentials.UseVisualStyleBackColor = $true
$btnLoadCredentials.add_Click($LoadCredentials)
#
#lblCredentials
#
$lblCredentials.Font = (New-Object -TypeName System.Drawing.Font -ArgumentList @([System.String]'Tahoma',[System.Single]8.25,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point,([System.Byte][System.Byte]0)))
$lblCredentials.ForeColor = [System.Drawing.Color]::Red
$lblCredentials.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]165,[System.Int32]9))
$lblCredentials.Name = [System.String]'lblCredentials'
$lblCredentials.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]775,[System.Int32]23))
$lblCredentials.TabIndex = [System.Int32]4
$lblCredentials.Text = [System.String]'No Credentials Loaded'
$lblCredentials.TextAlign = [System.Drawing.ContentAlignment]::MiddleRight
$lblCredentials.UseCompatibleTextRendering = $true
#
#gbxAdHoc
#
$gbxAdHoc.Controls.Add($cbVerbose)
$gbxAdHoc.Controls.Add($btnAddAutomation)
$gbxAdHoc.Controls.Add($btnAdHocRemove)
$gbxAdHoc.Controls.Add($lbltxtAdHocStatus)
$gbxAdHoc.Controls.Add($txtAdHocStatus)
$gbxAdHoc.Controls.Add($btnAdHocValidate)
$gbxAdHoc.Controls.Add($btnAdHocRun)
$gbxAdHoc.Controls.Add($lbltxtAdHocTargets)
$gbxAdHoc.Controls.Add($txtAdHocTargets)
$gbxAdHoc.Controls.Add($lbltxtAdHoc3)
$gbxAdHoc.Controls.Add($txtAdHoc3)
$gbxAdHoc.Controls.Add($lbltxtAdHoc2)
$gbxAdHoc.Controls.Add($txtAdHoc2)
$gbxAdHoc.Controls.Add($lblcbxAdHoc3)
$gbxAdHoc.Controls.Add($cbxAdHoc3)
$gbxAdHoc.Controls.Add($lblcbxAdHoc2)
$gbxAdHoc.Controls.Add($cbxAdHoc2)
$gbxAdHoc.Controls.Add($lblcbxAdHoc1)
$gbxAdHoc.Controls.Add($cbxAdHoc1)
$gbxAdHoc.Controls.Add($lbltxtAdHoc1)
$gbxAdHoc.Controls.Add($txtAdHoc1)
$gbxAdHoc.Controls.Add($lblAction)
$gbxAdHoc.Controls.Add($cbxAction)
$gbxAdHoc.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]12,[System.Int32]369))
$gbxAdHoc.Name = [System.String]'gbxAdHoc'
$gbxAdHoc.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]934,[System.Int32]273))
$gbxAdHoc.TabIndex = [System.Int32]2
$gbxAdHoc.TabStop = $false
$gbxAdHoc.Text = [System.String]'Ad-Hoc'
$gbxAdHoc.UseCompatibleTextRendering = $true
#
#btnAddAutomation
#
$btnAddAutomation.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]230,[System.Int32]234))
$btnAddAutomation.Name = [System.String]'btnAddAutomation'
$btnAddAutomation.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]128,[System.Int32]23))
$btnAddAutomation.TabIndex = [System.Int32]20
$btnAddAutomation.Text = [System.String]'Add to Automation'
$btnAddAutomation.UseCompatibleTextRendering = $true
$btnAddAutomation.UseVisualStyleBackColor = $true
#
#btnAdHocRemove
#
$btnAdHocRemove.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]230,[System.Int32]205))
$btnAdHocRemove.Name = [System.String]'btnAdHocRemove'
$btnAdHocRemove.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]128,[System.Int32]23))
$btnAdHocRemove.TabIndex = [System.Int32]19
$btnAdHocRemove.Text = [System.String]'Remove Artifact'
$btnAdHocRemove.UseCompatibleTextRendering = $true
$btnAdHocRemove.UseVisualStyleBackColor = $true
#
#lbltxtAdHocStatus
#
$lbltxtAdHocStatus.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]364,[System.Int32]121))
$lbltxtAdHocStatus.Name = [System.String]'lbltxtAdHocStatus'
$lbltxtAdHocStatus.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]196,[System.Int32]23))
$lbltxtAdHocStatus.TabIndex = [System.Int32]18
$lbltxtAdHocStatus.Text = [System.String]'Status'
$lbltxtAdHocStatus.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
$lbltxtAdHocStatus.UseCompatibleTextRendering = $true
#
#txtAdHocStatus
#
$txtAdHocStatus.Enabled = $false
$txtAdHocStatus.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]364,[System.Int32]147))
$txtAdHocStatus.Multiline = $true
$txtAdHocStatus.Name = [System.String]'txtAdHocStatus'
$txtAdHocStatus.ReadOnly = $true
$txtAdHocStatus.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]564,[System.Int32]118))
$txtAdHocStatus.TabIndex = [System.Int32]17
#
#btnAdHocValidate
#
$btnAdHocValidate.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]230,[System.Int32]176))
$btnAdHocValidate.Name = [System.String]'btnAdHocValidate'
$btnAdHocValidate.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]128,[System.Int32]23))
$btnAdHocValidate.TabIndex = [System.Int32]16
$btnAdHocValidate.Text = [System.String]'Validate'
$btnAdHocValidate.UseCompatibleTextRendering = $true
$btnAdHocValidate.UseVisualStyleBackColor = $true
#
#btnAdHocRun
#
$btnAdHocRun.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]230,[System.Int32]147))
$btnAdHocRun.Name = [System.String]'btnAdHocRun'
$btnAdHocRun.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]128,[System.Int32]23))
$btnAdHocRun.TabIndex = [System.Int32]14
$btnAdHocRun.Text = [System.String]'Run + Validate'
$btnAdHocRun.UseCompatibleTextRendering = $true
$btnAdHocRun.UseVisualStyleBackColor = $true
$btnAdHocRun.add_Click($AdHocRun)
#
#lbltxtAdHocTargets
#
$lbltxtAdHocTargets.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]121))
$lbltxtAdHocTargets.Name = [System.String]'lbltxtAdHocTargets'
$lbltxtAdHocTargets.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]23))
$lbltxtAdHocTargets.TabIndex = [System.Int32]15
$lbltxtAdHocTargets.Text = [System.String]'Targets (One Per Line)'
$lbltxtAdHocTargets.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
$lbltxtAdHocTargets.UseCompatibleTextRendering = $true
#
#txtAdHocTargets
#
$txtAdHocTargets.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]147))
$txtAdHocTargets.Multiline = $true
$txtAdHocTargets.Name = [System.String]'txtAdHocTargets'
$txtAdHocTargets.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]118))
$txtAdHocTargets.TabIndex = [System.Int32]9
#
#lbltxtAdHoc3
#
$lbltxtAdHoc3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]678,[System.Int32]22))
$lbltxtAdHoc3.Name = [System.String]'lbltxtAdHoc3'
$lbltxtAdHoc3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]23))
$lbltxtAdHoc3.TabIndex = [System.Int32]13
$lbltxtAdHoc3.Text = [System.String]'lbltxtAdHoc3'
$lbltxtAdHoc3.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
$lbltxtAdHoc3.UseCompatibleTextRendering = $true
$lbltxtAdHoc3.Visible = $false
#
#txtAdHoc3
#
$txtAdHoc3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]678,[System.Int32]48))
$txtAdHoc3.Name = [System.String]'txtAdHoc3'
$txtAdHoc3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]21))
$txtAdHoc3.TabIndex = [System.Int32]12
$txtAdHoc3.Visible = $false
#
#lbltxtAdHoc2
#
$lbltxtAdHoc2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]454,[System.Int32]22))
$lbltxtAdHoc2.Name = [System.String]'lbltxtAdHoc2'
$lbltxtAdHoc2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]23))
$lbltxtAdHoc2.TabIndex = [System.Int32]11
$lbltxtAdHoc2.Text = [System.String]'lbltxtAdHoc2'
$lbltxtAdHoc2.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
$lbltxtAdHoc2.UseCompatibleTextRendering = $true
$lbltxtAdHoc2.Visible = $false
#
#txtAdHoc2
#
$txtAdHoc2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]454,[System.Int32]48))
$txtAdHoc2.Name = [System.String]'txtAdHoc2'
$txtAdHoc2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]21))
$txtAdHoc2.TabIndex = [System.Int32]10
$txtAdHoc2.Visible = $false
#
#lblcbxAdHoc3
#
$lblcbxAdHoc3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]454,[System.Int32]72))
$lblcbxAdHoc3.Name = [System.String]'lblcbxAdHoc3'
$lblcbxAdHoc3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]23))
$lblcbxAdHoc3.TabIndex = [System.Int32]9
$lblcbxAdHoc3.Text = [System.String]'lblcbxAdHoc3'
$lblcbxAdHoc3.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
$lblcbxAdHoc3.UseCompatibleTextRendering = $true
$lblcbxAdHoc3.Visible = $false
#
#cbxAdHoc3
#
$cbxAdHoc3.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cbxAdHoc3.FormattingEnabled = $true
$cbxAdHoc3.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]454,[System.Int32]97))
$cbxAdHoc3.Name = [System.String]'cbxAdHoc3'
$cbxAdHoc3.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]21))
$cbxAdHoc3.TabIndex = [System.Int32]8
$cbxAdHoc3.Visible = $false
#
#lblcbxAdHoc2
#
$lblcbxAdHoc2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]230,[System.Int32]71))
$lblcbxAdHoc2.Name = [System.String]'lblcbxAdHoc2'
$lblcbxAdHoc2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]23))
$lblcbxAdHoc2.TabIndex = [System.Int32]7
$lblcbxAdHoc2.Text = [System.String]'lblcbxAdHoc2'
$lblcbxAdHoc2.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
$lblcbxAdHoc2.UseCompatibleTextRendering = $true
$lblcbxAdHoc2.Visible = $false
#
#cbxAdHoc2
#
$cbxAdHoc2.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cbxAdHoc2.FormattingEnabled = $true
$cbxAdHoc2.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]230,[System.Int32]97))
$cbxAdHoc2.Name = [System.String]'cbxAdHoc2'
$cbxAdHoc2.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]21))
$cbxAdHoc2.TabIndex = [System.Int32]6
$cbxAdHoc2.Visible = $false
#
#lblcbxAdHoc1
#
$lblcbxAdHoc1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]72))
$lblcbxAdHoc1.Name = [System.String]'lblcbxAdHoc1'
$lblcbxAdHoc1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]23))
$lblcbxAdHoc1.TabIndex = [System.Int32]5
$lblcbxAdHoc1.Text = [System.String]'lblcbxAdHoc1'
$lblcbxAdHoc1.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
$lblcbxAdHoc1.UseCompatibleTextRendering = $true
$lblcbxAdHoc1.Visible = $false
#
#cbxAdHoc1
#
$cbxAdHoc1.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cbxAdHoc1.FormattingEnabled = $true
$cbxAdHoc1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]97))
$cbxAdHoc1.Name = [System.String]'cbxAdHoc1'
$cbxAdHoc1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]21))
$cbxAdHoc1.TabIndex = [System.Int32]4
$cbxAdHoc1.Visible = $false
#
#lbltxtAdHoc1
#
$lbltxtAdHoc1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]230,[System.Int32]22))
$lbltxtAdHoc1.Name = [System.String]'lbltxtAdHoc1'
$lbltxtAdHoc1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]23))
$lbltxtAdHoc1.TabIndex = [System.Int32]3
$lbltxtAdHoc1.Text = [System.String]'lbltxtAdHoc1'
$lbltxtAdHoc1.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
$lbltxtAdHoc1.UseCompatibleTextRendering = $true
$lbltxtAdHoc1.Visible = $false
#
#txtAdHoc1
#
$txtAdHoc1.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]230,[System.Int32]48))
$txtAdHoc1.Name = [System.String]'txtAdHoc1'
$txtAdHoc1.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]21))
$txtAdHoc1.TabIndex = [System.Int32]2
$txtAdHoc1.Visible = $false
#
#lblAction
#
$lblAction.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]22))
$lblAction.Name = [System.String]'lblAction'
$lblAction.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]23))
$lblAction.TabIndex = [System.Int32]1
$lblAction.Text = [System.String]'Action'
$lblAction.TextAlign = [System.Drawing.ContentAlignment]::BottomLeft
$lblAction.UseCompatibleTextRendering = $true
#
#cbxAction
#
$cbxAction.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
$cbxAction.FormattingEnabled = $true
$cbxAction.Items.AddRange([System.Object[]]@([System.String]'Generic Process Execution',[System.String]'Start Process',[System.String]'New Local Account',[System.String]'Startup Folder Persistence',[System.String]'Registry Persistence',[System.String]'WMI Subscription Persistence',[System.String]'Scheduled Task Persistence',[System.String]'Remove Firewall Rule',[System.String]'Add Firewall Rule'))
$cbxAction.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]6,[System.Int32]48))
$cbxAction.Name = [System.String]'cbxAction'
$cbxAction.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]218,[System.Int32]21))
$cbxAction.TabIndex = [System.Int32]0
$cbxAction.add_SelectedIndexChanged($UpdateAdHocForm)
#
#cbVerbose
#
$cbVerbose.Location = (New-Object -TypeName System.Drawing.Point -ArgumentList @([System.Int32]730,[System.Int32]94))
$cbVerbose.Name = [System.String]'cbVerbose'
$cbVerbose.Size = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]166,[System.Int32]24))
$cbVerbose.TabIndex = [System.Int32]21
$cbVerbose.Text = [System.String]'Include Verbose Messages'
$cbVerbose.UseCompatibleTextRendering = $true
$cbVerbose.UseVisualStyleBackColor = $true
#
#frmMain
#
$frmMain.ClientSize = (New-Object -TypeName System.Drawing.Size -ArgumentList @([System.Int32]958,[System.Int32]654))
$frmMain.Controls.Add($gbxAdHoc)
$frmMain.Controls.Add($gbxAutomation)
$frmMain.Controls.Add($lblCredentials)
$frmMain.Controls.Add($btnLoadCredentials)
$frmMain.Text = [System.String]'Host Artifact-Injector'
$gbxAutomation.ResumeLayout($false)
([System.ComponentModel.ISupportInitialize]$dgvAutomation).EndInit()
$gbxAdHoc.ResumeLayout($false)
$gbxAdHoc.PerformLayout()
$frmMain.ResumeLayout($false)
Add-Member -InputObject $frmMain -Name base -Value $base -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxAutomation -Value $gbxAutomation -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnAutoRemove -Value $btnAutoRemove -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnValidate -Value $btnValidate -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnAutoRun -Value $btnAutoRun -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblAutoValidation -Value $lblAutoValidation -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnLoadAutomation -Value $btnLoadAutomation -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblAutomationName -Value $lblAutomationName -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name dgvAutomation -Value $dgvAutomation -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblFileLoaded -Value $lblFileLoaded -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnLoadCredentials -Value $btnLoadCredentials -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblCredentials -Value $lblCredentials -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name gbxAdHoc -Value $gbxAdHoc -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name cbVerbose -Value $cbVerbose -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnAddAutomation -Value $btnAddAutomation -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnAdHocRemove -Value $btnAdHocRemove -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lbltxtAdHocStatus -Value $lbltxtAdHocStatus -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name txtAdHocStatus -Value $txtAdHocStatus -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnAdHocValidate -Value $btnAdHocValidate -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name btnAdHocRun -Value $btnAdHocRun -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lbltxtAdHocTargets -Value $lbltxtAdHocTargets -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name txtAdHocTargets -Value $txtAdHocTargets -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lbltxtAdHoc3 -Value $lbltxtAdHoc3 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name txtAdHoc3 -Value $txtAdHoc3 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lbltxtAdHoc2 -Value $lbltxtAdHoc2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name txtAdHoc2 -Value $txtAdHoc2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblcbxAdHoc3 -Value $lblcbxAdHoc3 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name cbxAdHoc3 -Value $cbxAdHoc3 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblcbxAdHoc2 -Value $lblcbxAdHoc2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name cbxAdHoc2 -Value $cbxAdHoc2 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblcbxAdHoc1 -Value $lblcbxAdHoc1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name cbxAdHoc1 -Value $cbxAdHoc1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lbltxtAdHoc1 -Value $lbltxtAdHoc1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name txtAdHoc1 -Value $txtAdHoc1 -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name lblAction -Value $lblAction -MemberType NoteProperty
Add-Member -InputObject $frmMain -Name cbxAction -Value $cbxAction -MemberType NoteProperty
}
. InitializeComponent
