SetTitleMatchMode 2
Run,cmd
WinWait, ahk_class ConsoleWindowClass,
IfWinNotActive, ahk_class ConsoleWindowClass, , WinActivate, ahk_class ConsoleWindowClass,
WinWaitActive, ahk_class ConsoleWindowClass,
ControlSend, , lsnrctl stop {Enter}, cmd.exe
ControlSend, , sqlplus /nolog {Enter}, cmd.exe
ControlSend, , conn sys /as sysdba {Enter} {Enter}, cmd.exe
ControlSend, , shutdow immediate; {Enter}, cmd.exe
ControlSend, , startup; {Enter}, cmd.exe
ControlSend, , exit; {Enter}, cmd.exe
ControlSend, , lsnrctl start {Enter}, cmd.exe
WinWaitClose, ahk_class ConsoleWindowClass,