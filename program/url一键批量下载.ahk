/*
╔══════════════════════════════════════════════════
║【url一键批量下载】 @2017.09.28 https://github.com/hui-Zz
╚══════════════════════════════════════════════════
*/
Gui,Destroy
Gui,+Resize
Gui,Font,,Microsoft YaHei
Gui,Margin,10,10
Gui,Add,Button,xm-5 yp+5 w35 h40 GSetDownPath,保存目录
Gui,Add,Edit,xm+35 yp+10 w600 r1 vvDownPath,%DownPath%
Gui,Add,Button,xm-3 yp+35 w28 h120 GSetUrlPath,url地址文件
Gui,Add,Edit,xm+35 yp w600 r30 -Wrap HScroll vvUrlPath,%UrlPath%
Gui,Font,Bold,Microsoft YaHei
Gui,Add,Button,xm-3 yp+130 w28 h150 GDownUrl,开始批量下载！
Gui,Add,Progress,xm+35 w600 cGreen vMyProgress
GuiControl, Hide, MyProgress
Gui, Show, , 【url一键批量下载】github.com/hui-Zz
return
GuiSize:
	if A_EventInfo = 1
		return
	GuiControl, Move, vDownPath, % " W" . (A_GuiWidth - 50)
	GuiControl, Move, vMyProgress, % " W" . (A_GuiWidth - 50)
	GuiControl, Move, vUrlPath, % "H" . (A_GuiHeight-70) . " W" . (A_GuiWidth - 50)
return
SetDownPath:
	FileSelectFolder, saveFolder, , 3
	GuiControl,, vDownPath, %saveFolder%
return
SetUrlPath:
	FileSelectFile, Urltxt, , , 选择要导入的url下载地址存储文件
	;~;[读取url下载地址存储文件]
	FileRead, OutputVar, %Urltxt%
	GuiControl,, vUrlPath, %OutputVar%
return
DownUrl:
	Gui,Submit,NoHide
	StringReplace, OutReplace, vUrlPath, `n, `n, UseErrorLevel
	lineNum := ErrorLevel + !(OutReplace = "")
	MsgBox,33,批量下载文件,确定批量下载%lineNum%个文件？
	IfMsgBox Ok
	{
		;~ 每次增加进度 := 向上取整(100%进度条/文件数)
		progressNum := Ceil(100 / lineNum)
		GuiControl, Show, MyProgress
		GuiControl,, MyProgress, 0
		Loop,parse,vUrlPath,`n
		{
			if(A_LoopField){
				SplitPath, A_LoopField, name
				;~ URLDownloadToFile,%A_LoopField%,%vDownPath%\%name%
				URLDownloadToFile(A_LoopField,vDownPath . "\" . name)
				if(ErrorLevel=1){
					MsgBox,%vDownPath%\%name%
				}
				GuiControl,, MyProgress, +%progressNum%
			}
		}
		TrayTip,,url一键批量下载完成,3,17
	}
return
UrlDownloadToFile(URL,FilePath,Proxy="",ProxyBypassList="",Cookie="",Referer="",UserAgent="",EnableRedirects="",Timeout=-1)
{
	ComObjError(0)  ;禁用 COM 错误通告。禁用后，检查 A_LastError 的值，脚本可以实现自己的错误处理
	WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	if (EnableRedirects<>"")
		WebRequest.Option(6):=EnableRedirects
	if (Proxy<>"")  ;设置代理服务器。微软的代码 SetProxy() 是放在 Open() 之前的，所以我也放前面设置，以免无效
		WebRequest.SetProxy(2,Proxy,ProxyBypassList)
	WebRequest.Open("GET", URL, true)   ;true为异步获取，默认是false。龟速的根源！！！卡顿的根源！！！
	if (Cookie<>"") ;设置Cookie。SetRequestHeader() 必须 Open() 之后才有效
	{
		WebRequest.SetRequestHeader("Cookie","tuzi")    ;先设置一个cookie，防止出错，见官方文档
		WebRequest.SetRequestHeader("Cookie",Cookie)
	}
	if (Referer<>"")    ;设置Referer
		WebRequest.SetRequestHeader("Referer",Referer)
	if (UserAgent<>"")  ;设置User-Agent
		WebRequest.SetRequestHeader("User-Agent",UserAgent)
	WebRequest.Send()
	WebRequest.WaitForResponse(Timeout) ;WaitForResponse方法确保获取的是完整的响应
	ADO:=ComObjCreate("adodb.stream")   ;使用 adodb.stream 编码返回值。参考 http://bbs.howtoadmin.com/ThRead-814-1-1.html
	ADO.Type:=1 ;以二进制方式操作
	ADO.Mode:=3 ;可同时进行读写
	ADO.Open()  ;开启物件
	ADO.Write(WebRequest.ResponseBody())    ;写入物件。注意没法将 WebRequest.ResponseBody() 存入一个变量，所以必须用这种方式写文件
	ADO.SaveToFile(FilePath,2)    ;文件存在则覆盖
	ADO.Close()
	return, 1
}