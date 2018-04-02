SetTitleMatchMode 2
Run,cmd
WinWait, ahk_class ConsoleWindowClass,
IfWinNotActive, ahk_class ConsoleWindowClass, , WinActivate, ahk_class ConsoleWindowClass,
WinWaitActive, ahk_class ConsoleWindowClass,
ControlSend, , ping baidu.com -t {Enter}, cmd.exe
