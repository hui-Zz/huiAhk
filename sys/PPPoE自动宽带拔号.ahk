SetBatchLines,-1 ;~脚本全速执行
SetTitleMatchMode,2 ;~窗口标题模糊匹配
Run,rasphone -a "宽带连接",,Min
WinWait,ahk_class NativeHWNDHost
ControlClick,Button4,ahk_class NativeHWNDHost
Sleep,500
ControlSetText,Edit1,宽带用户名,ahk_class NativeHWNDHost
ControlSetText,Edit2,宽带密码,ahk_class NativeHWNDHost
ControlClick,Button8,ahk_class NativeHWNDHost
ControlClick,Button1,ahk_class NativeHWNDHost
Loop
{
	IfExist,%A_AppData%\Microsoft\Network\Connections\Pbk\rasphone.pbk
		break
	Sleep,20
}
Run,rasphone -d "宽带连接",,Min
WinWait,连接 宽带连接
ControlClick,Button4,连接 宽带连接
