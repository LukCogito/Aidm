$gif = [System.Drawing.Image]::Fromfile("D:\USERS\lukpa_adm\Desktop\splash\splash.gif")
[void][Reflection.Assembly]::LoadWithPartialName('system.windows.forms')
$screen = New-Object System.Windows.Forms.Form
$screen.Text = 'Aidm loading'
$pictureBox = New-Object System.Windows.Forms.PictureBox
$pictureBox.Width = $gif.Size.width
$pictureBox.Height = $gif.size.height
$pictureBox.Top = ($screen.ClientRectangle.Height - $pictureBox.Height)/2
$pictureBox.Left = ($screen.ClientRectangle.Width - $pictureBox.Width)/2
$pictureBox.Image = $gif
$timer = New-object system.timers.Timer
$timer.Interval = 80 # Adjust interval based on desired frame rate
Register-ObjectEvent -InputObject $timer -event Elapsed -sourceIdentifier TimerEvt -action {
    try{
        $pictureBox.Invalidate();
     } catch {}
}
$timer.Enabled=$true
$timer.AutoReset=$false
$screen.Controls.Add($pictureBox);
$screen.ShowDialog() | Out-Null
Unregister-Event -Force -SourceIdentifier TimerEvt
Remove-Variable timer