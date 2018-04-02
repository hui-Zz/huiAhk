#SingleInstance,Force ;~运行替换旧实例
F12::
	Run,regsvr32 dm.dll	;~ /s无声
	return
F1::	;~ 找图
	dm:=ComObjCreate("dm.dmsoft")	;~ 调用大漠
	;~ MsgBox,% dm.Ver()
	dmSetPath:=dm.GetBasePath()		;~ dm.dll路径
	dm_ret:=dm.SetPath(dmSetPath)	;~ 设置默认路径
	hwnd:=dm.GetForegroundWindow()	;~ 绑定窗口句柄
	;~ hwnd:=dm.GetMousePointWindow()
	;~ 设置后台操作模式
	dm_ret:=dm.BindWindow(hwnd,"dx2","normal","windows",0)
	;~ dm_ret:=dm.BindWindow(hwnd,"gdi","normal","normal",0)
	;~ dm_ret:=dm.BindWindow(hwnd, "dx2", "windows3", "windows", 0)
	If dm_ret=0
		MsgBox,"绑定失败"
	SetTimer,t,800
return

F2::	;~ 截图
	dm := ComObjCreate("dm.dmsoft")
	dm_ret := dm.SetPath("z:")
	hwnd := dm.GetMousePointWindow()
	dm_ret := dm.BindWindow(hwnd,"normal","normal","windows",0)
	dm_ret := dm.Capture(0,0,1366,768,"screen.bmp")
	dm_ret := dm.UnBindWindow()
	return

t:
	dm_ret:=dm.FindPic(0,0,1366,768,"z.bmp","000000",0.8,0,intx,inty)	;~ 找图
	;~ MouseMove, %intx%, %inty%	;~ 移动到图片坐标
	ToolTip,% dm_ret
return
