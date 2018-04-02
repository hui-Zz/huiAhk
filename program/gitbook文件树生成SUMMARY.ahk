;****************************
;* gitbook文件树生成SUMMARY *
;*                by hui-Zz *
;****************************
;~ InputBox, UserInput, 生成SUMMARY, 请输入gitbook的书库所在路径`n(不加引号,末尾不带\)
;~ if !ErrorLevel
;~ {

;~ }

UserInput=C:\Users\%A_UserName%\GitBook\Library\hui-zz\huinote
ignoreList:=["SUMMARY.md",".gitignore","README.md","_book"]
SummaryPath=%UserInput%\SUMMARY.md
FileDelete,%SummaryPath%
SummaryStr:="# Summary`n`n* [Introduction简介](README.md)"
FileAppend,%SummaryStr%`n,%SummaryPath%,UTF-8
dirREADME:=""	;用于让README.md文件排序到目录第一
Loop Files, %UserInput%\*.*, R  ; 递归子文件夹.
{
	ignoreFlag:=false
	For igk, igv in ignoreList
	{
		if(InStr(A_LoopFileFullPath,UserInput "\" igv))
			ignoreFlag:=true
	}
	if(ignoreFlag)
		continue
	SummaryStr:=SummarySpace:=""
    SplitPath, A_LoopFileFullPath, name, dir, ext, name_no_ext, drive
	if(InStr(dir,UserInput "\.git") || InStr(dir,UserInput "\assets"))
		continue
	pathStr:=StrReplace(A_LoopFileFullPath,UserInput "\")	;去掉书库路径
	pathStr:=StrReplace(StrReplace(pathStr,name),"\","/")	;替换正反斜杠
	pathArray:=StrSplit(pathStr, "/")	;用分隔符计算目录层级
	Loop, % pathArray.MaxIndex() - 2
	{
		SummarySpace.=A_Space A_Space
	}
	if(pathStr="") {				;如果是根目录文件，直接添加
		SummaryStr.=SummarySpace "* [" name_no_ext "](" pathStr name ")"
	}else if(name!="README.md") {
		if(dirREADME!=pathStr){		;优先添加README.md在顶部，作标记用于后续比较
			dirREADME:=pathStr
			lastSecond:=RegExReplace(A_LoopFileFullPath,"iS).*\\(.*?)\\.*?$","$1")
			SummaryStr.=SummarySpace "* [" lastSecond "]("  pathStr "README.md)`n"
		}
		SummarySpace.=A_Space A_Space	;父目录下的非README.md多缩进两空格
		SummaryStr.=SummarySpace "* [" name_no_ext "](" pathStr name ")"
	} else if(dirREADME!=pathStr){		;第一个是README.md就添加，之前已经添加过README.md就不用重复添加
		dirREADME:=pathStr
		lastSecond:=RegExReplace(A_LoopFileFullPath,"iS).*\\(.*?)\\.*?$","$1")
		SummaryStr:=SummarySpace "* [" lastSecond "]("  pathStr "README.md)"
	}
	if(SummaryStr)
		FileAppend,%SummaryStr%`n,%SummaryPath%,UTF-8
}

