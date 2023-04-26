	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$form1 = New-Object 'System.Windows.Forms.Form'
	$label3 = New-Object 'System.Windows.Forms.Label'
	$button2 = New-Object 'System.Windows.Forms.Button'
	$combobox1 = New-Object 'System.Windows.Forms.ComboBox'
	$label2 = New-Object 'System.Windows.Forms.Label'
	$label1 = New-Object 'System.Windows.Forms.Label'
	$textbox2 = New-Object 'System.Windows.Forms.TextBox'
	$button1 = New-Object 'System.Windows.Forms.Button'
	$textbox1 = New-Object 'System.Windows.Forms.TextBox'
	$openfiledialog1 = New-Object 'System.Windows.Forms.OpenFileDialog'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	
	$form1_Load={
		$form1.Text = "Подсчёт контрольной суммы файла"
		$label1.Text = "Введите путь до файла включая расширение:"
		$label2.Text = "Выберите вид контрольной суммы:"
		$label3.Text = "Контрольная сумма:"
		$button1.Text = "Обзор"
		$button2.Text = "Рассчитать"
		$combobox1.Items.Add("MD5")
		$combobox1.Items.Add("SHA1")
		$combobox1.Items.Add("SHA256")
		$combobox1.Items.Add("SHA384")
		$combobox1.Items.Add("SHA512")
		$combobox1.Text = $combobox1.Items[0]
	}
	
	$button1_Click = {
		$openfiledialog1.InitialDirectory = [Environment]::GetFolderPath([Environment+SpecialFolder]::MyDocuments)
		$openfiledialog1.ShowDialog()
		$textbox1.Text = $openfiledialog1.FileName
	}
	$button2_Click = {
		if ($textbox1.Text -eq "")
		{
			[System.Windows.Forms.MessageBox]::Show("Вы ввели неверный путь к файлу или поле пустое")
		}
		else
		{
			$textbox2.Text = ""
			$Hash = Get-FileHash $textbox1.Text -Algorithm $combobox1.Text | % { $_.Hash }
			$textbox2.Text = $Hash
		}
		
	}
	
	$Form_StateCorrection_Load=
	{
		$form1.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		try
		{
			$button2.remove_Click($button2_Click)
			$button1.remove_Click($button1_Click)
			$form1.remove_Load($form1_Load)
			$form1.remove_Load($Form_StateCorrection_Load)
			$form1.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null }
	}

	$form1.SuspendLayout()

	$form1.Controls.Add($label3)
	$form1.Controls.Add($button2)
	$form1.Controls.Add($combobox1)
	$form1.Controls.Add($label2)
	$form1.Controls.Add($label1)
	$form1.Controls.Add($textbox2)
	$form1.Controls.Add($button1)
	$form1.Controls.Add($textbox1)
	$form1.AutoScaleDimensions = '6, 13'
	$form1.AutoScaleMode = 'Font'
	$form1.ClientSize = '648, 151'
	$form1.FormBorderStyle = 'FixedSingle'
	$form1.Name = 'form1'
	$form1.StartPosition = 'CenterScreen'
	$form1.Text = 'Form'
	$form1.add_Load($form1_Load)

	$label3.AutoSize = $True
	$label3.Location = '12, 101'
	$label3.Name = 'label3'
	$label3.Size = '35, 17'
	$label3.TabIndex = 7
	$label3.Text = 'label3'
	$label3.UseCompatibleTextRendering = $True

	$button2.Location = '564, 118'
	$button2.Name = 'button2'
	$button2.Size = '75, 23'
	$button2.TabIndex = 6
	$button2.Text = 'button2'
	$button2.UseCompatibleTextRendering = $True
	$button2.UseVisualStyleBackColor = $True
	$button2.add_Click($button2_Click)

	$combobox1.FormattingEnabled = $True
	$combobox1.Location = '200, 65'
	$combobox1.Name = 'combobox1'
	$combobox1.Size = '83, 21'
	$combobox1.TabIndex = 5

	$label2.AutoSize = $True
	$label2.Location = '12, 68'
	$label2.Name = 'label2'
	$label2.Size = '35, 17'
	$label2.TabIndex = 4
	$label2.Text = 'label2'
	$label2.UseCompatibleTextRendering = $True

	$label1.AutoSize = $True
	$label1.Location = '12, 12'
	$label1.Name = 'label1'
	$label1.Size = '35, 17'
	$label1.TabIndex = 3
	$label1.Text = 'label1'
	$label1.UseCompatibleTextRendering = $True

	$textbox2.Font = 'Consolas, 8.25pt, style=Bold'
	$textbox2.Location = '12, 121'
	$textbox2.Name = 'textbox2'
	$textbox2.Size = '546, 20'
	$textbox2.TabIndex = 2

	$button1.Location = '564, 30'
	$button1.Name = 'button1'
	$button1.Size = '75, 23'
	$button1.TabIndex = 1
	$button1.Text = 'button1'
	$button1.UseCompatibleTextRendering = $True
	$button1.UseVisualStyleBackColor = $True
	$button1.add_Click($button1_Click)

	$textbox1.Location = '12, 32'
	$textbox1.Name = 'textbox1'
	$textbox1.Size = '546, 20'
	$textbox1.TabIndex = 0

	$openfiledialog1.FileName = 'openfiledialog1'
	$form1.ResumeLayout()

	$InitialFormWindowState = $form1.WindowState

	$form1.add_Load($Form_StateCorrection_Load)

	$form1.add_FormClosed($Form_Cleanup_FormClosed)

	return $form1.ShowDialog()