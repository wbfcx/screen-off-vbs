# screen-off-vbs
# 杂货铺 #001
# Windows 立即熄屏

一个非常简单的 Windows 熄屏小工具。

双击 `立即熄屏.vbs`，即可立即关闭显示器，无需等待。

## 使用方法

1. 下载 `立即熄屏.vbs`
2. 双击运行
3. 显示器立即熄灭
4. 移动鼠标或按键即可重新唤醒屏幕

## 特点

- 无需安装
- 双击直接运行
- 不弹出黑色命令行窗口
- 文件体积非常小
- 不需要安装 Python 或其他运行环境

## 支持系统

- Windows 10
- Windows 11

## 源码
```vbscript
Set sh = CreateObject("WScript.Shell")
Set fso = CreateObject("Scripting.FileSystemObject")

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
```
## 下载

直接下载仓库中的 `熄屏.vbs` 即可使用。
