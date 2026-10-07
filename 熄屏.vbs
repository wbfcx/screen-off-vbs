Set sh = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

' 等待3秒，避免双击鼠标后马上重新唤醒

ps = sh.ExpandEnvironmentStrings("%TEMP%") & "\screen_off_temp.ps1"

Set f = fso.CreateTextFile(ps, True)

f.WriteLine "Add-Type -TypeDefinition @'"
f.WriteLine "using System;"
f.WriteLine "using System.Runtime.InteropServices;"
f.WriteLine "public static class MonitorPower {"
f.WriteLine "    [DllImport(""user32.dll"")]"
f.WriteLine "    public static extern IntPtr SendMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);"
f.WriteLine "}"
f.WriteLine "'@"
f.WriteLine "[MonitorPower]::SendMessage([IntPtr]0xffff, 0x0112, [IntPtr]0xF170, [IntPtr]2) | Out-Null"

f.Close

sh.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File " & Chr(34) & ps & Chr(34), 0, True

On Error Resume Next
fso.DeleteFile ps, True