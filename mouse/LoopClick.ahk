;********************
;  LWin+鼠标双击连点
;********************
RCtrl & LButton::
	KeyWait,LButton
	KeyWait,LButton,d,t0.1
	if Errorlevel
		SetTimer,zClick,1
	else
		SetTimer,zClick,Off
	return
zClick:
	Click
	return