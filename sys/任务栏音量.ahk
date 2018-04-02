#If (MouseIsOveRControl("MSTaskListWClass1"))
	Wheelup::SoundSet,+10
	WheelDown::SoundSet,-10
MouseIsOveRControl(ControlClass){
	MouseGetPos,,,,thisControl
	IfEqual,thisControl,%Controlclass%
		return true
}
#If