$data=@()
for ( $index = 0; $index -le 100; $index+10)
{
  $data += $index
}
write-host $data
$ProgressBar = New-ProgressBar -MaterialDesign -Type Circle -Theme Dark
Write-ProgressBar -ProgressBar $Progressbar `
-Activity "Prettyin up Powershell" `
-PercentComplete 50 `
-Status "Prettyin" `
-SecondsRemaining 100 `
-CurrentOperation "Progressifyin"
write-host kor
start-sleep 10
Write-ProgressBar -ProgressBar $Progressbar `
-Activity "Prettyin up Powershell" `
-PercentComplete 75 `
-Status "Prettyin" `
-SecondsRemaining 100 `
-CurrentOperation "Progressifyin"
#Close-ProgressBar $ProgressBar
