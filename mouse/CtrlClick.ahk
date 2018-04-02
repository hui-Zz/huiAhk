~^LButton::
	Hotkey,LButton,CtrlLButton
	KeyWait,LButton
	Keywait,LButton,d,t0.2
	if Errorlevel {
		Hotkey,LButton,Off
	}else{
		Hotkey,LButton,On
		ToolTip,后台打开
		SetTimer,RemoveToolTip,1000
	}
	return
CtrlLButton:
	Send,^{LButton}
	return