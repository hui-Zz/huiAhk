F1:: ;<--颜色神偷
	MouseGetPos,mouseX,mouseY
	PixelGetColor,color,%mouseX%,%mouseY%,RGB
	StringRight,color,color,6
	clipboard=%color%
	FileAppend,%color%(%mouseX%`,%mouseY%)`n,Z:\color.txt
	ToolTip,%color%`n%mouseX% %mouseY%
	SetTimer,RemoveToolTip,3000
	MouseMove,0,0
	PixelGetColor,co,%mouseX%,%mouseY%,RGB
	FileAppend,%co%`n`n,Z:\color.txt
	MouseMove,%mouseX%,%mouseY%
	Run,% "F:\Users\Windows\Notepad2.exe /o /p 1066,234,300,300 Z:\color.txt"
	return
	
F2:: ;<--取当前鼠标下颜色
	MouseGetPos,mouseX,mouseY
	PixelGetColor,color,%mouseX%,%mouseY%,RGB
	StringRight,color,color,6
	clipboard=%color%
	FileAppend,%color%(%mouseX%`,%mouseY%)`n,Z:\color.txt
	ToolTip,%color%`n%mouseX% %mouseY%
	SetTimer,RemoveToolTip,3000
	return
	
F3:: ;<--取鼠标移开后颜色
	PixelGetColor,co,%mouseX%,%mouseY%,RGB
	FileAppend,%co%`n`n,Z:\color.txt
	return
	
RemoveToolTip:
	SetTimer,RemoveToolTip,Off
	ToolTip
	return
