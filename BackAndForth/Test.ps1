#powershell -windowstyle minimized
#region modules
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[void] [System.Windows.Forms.Application]::EnableVisualStyles()
$ScriptPath = $PSScriptRoot
Set-Location -Path $ScriptPath
Import-Module .\Get-Planet.ps1
#Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
#endregion
<#Region progressbar
$ProgressBar = New-ProgressBar -MaterialDesign -Type Circle -Theme Dark
Write-ProgressBar -ProgressBar $Progressbar 
-Activity "Prettyin up Powershell" `
-PercentComplete 50 `
-Status "Prettyin" `
-SecondsRemaining 100 `
-CurrentOperation "Progressifyin"
#>#endregion
#region form specs
$objForm = New-Object System.Windows.Forms.Form
$objForm.Text = "Q-linea Release Test Interface"
#$objForm.Size = New-Object System.Drawing.Size(750,400)
$objForm.StartPosition = "CenterScreen"
$objForm.KeyPreview = $True
$objForm.topmost = $true
#endregion
#region icon and background
$objIcon = New-Object system.drawing.icon (".\Q-logo-0.ico")
$objForm.Icon = $objIcon
$objImage = [system.drawing.image]::FromFile(".\ASTAR.png")
$objForm.BackgroundImage = $objImage
$objForm.BackgroundImageLayout = "3"
$Newsizefactor= ($objImage.Height/$objImage.Width)*1.2
$objForm.Width = $newsizefactor*$objImage.Width
$objForm.Height = $Newsizefactor*$objImage.Height
#$objForm.Size = New-Object System.Drawing.Size($objForm.Width,$objForm.Height)
$objForm.MaximumSize = $objForm.Size
$objForm.MinimumSize = $objForm.Size
#endregion
<# label
$objLabel = New-Object System.Windows.Forms.label
$objLabel.Location = New-Object System.Drawing.Size(7,10)
$objLabel.Size = New-Object System.Drawing.Size(130,15)
$objLabel.BackColor = "Transparent"
$objLabel.ForeColor = "yellow"
$objLabel.Text = "Enter test"
$objForm.Controls.Add($objLabel)
#>
#region text box
$objTextbox = New-Object System.Windows.Forms.TextBox
$objTextbox.Location = New-Object System.Drawing.Size(10,10)
$objTextbox.Size = New-Object System.Drawing.Size(200,100)
$objTextbox.Multiline = $true
#$objTextbox.Height = 400
$objTextbox.Text = "Inte ett skit"
$objForm.Controls.Add($objTextbox)
#endregion
#region Test button
$objButton = New-Object System.Windows.Forms.Button
$objButton.Size = New-Object System.Drawing.Size(100,100)
$setwidth = $objForm.Width/2-$objButton.Width/2
$setheight = $objForm.Height/2-$objbutton.Height
$objButton.Location = New-Object System.Drawing.Size($setwidth,$setheight)
$objButton.Text = "RUN GET-PLANET"
$objForm.Controls.Add($objButton)
#endregion
$objButton.add_click({
$result = Invoke-pester .\Get-planet.tests.ps1 -PassThru
$passed = $result.PassedCount 
$objTextbox.Text = "Passed tests: "+ $passed 
$objTextbox.AppendText("`r`nFailed tests: "+ $result.FailedCount)
$objTextbox.AppendText("`r`nSkipped tests: "+ $result.SkippedCount)
$objTextbox.AppendText("`r`nInconclusive tests: "+ $result.InconclusiveCount)
$objTextbox.AppendText("`r`nPending tests: "+ $result.PendingCount)    
$objTextbox.AppendText("`r`n"+ $result.testresult.name) 
})
#region exit button
$cancelbutton = New-Object System.Windows.Forms.Button
$cancelbutton.Size = New-Object System.Drawing.Size(50,20)
$cancelbutton.Location = New-Object System.Drawing.Size(($objForm.Width-[int]100),($objform.Height-[int]100))
$cancelbutton.Text = "Exit"
$objForm.Controls.Add($cancelbutton)
$cancelbutton.add_click({$objForm.close()})
#endregion


[system.windows.forms.application]::run($objForm)

