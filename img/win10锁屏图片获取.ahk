SourcePath := A_AppData . "\..\Local\Packages\Microsoft.Windows.ContentDeliveryManager_cw5n1h2txyewy\LocalState\Assets\"
SavePath := A_MyDocuments . "\..\Pictures\lockimg\"
IfNotExist, % SavePath
    FileCreateDir, % SavePath
pToken := Gdip_Startup()

Loop, Files, % SourcePath . "*"
{
    img := Gdip_CreateBitmapFromFile(A_LoopFileFullPath)
    w := Gdip_GetImageWidth(img)
    if ( w > 800 )
        h := Gdip_GetImageHeight(img)
    else
        Continue
    if ( w > h )
        FileCopy, % A_LoopFileFullPath, % SavePath . A_LoopFileName . ".jpg"
        
}

Gdip_Shutdown(pToken)

; º¯ÊýÁÐ±í
Gdip_Startup()
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	if !DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("LoadLibrary", "str", "gdiplus")
	VarSetCapacity(si, A_PtrSize = 8 ? 24 : 16, 0), si := Chr(1)
	DllCall("gdiplus\GdiplusStartup", A_PtrSize ? "UPtr*" : "uint*", pToken, Ptr, &si, Ptr, 0)
	return pToken
}

Gdip_Shutdown(pToken)
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	
	DllCall("gdiplus\GdiplusShutdown", Ptr, pToken)
	if hModule := DllCall("GetModuleHandle", "str", "gdiplus", Ptr)
		DllCall("FreeLibrary", Ptr, hModule)
	return 0
}

Gdip_CreateBitmapFromFile(sFile, IconNumber=1, IconSize="")
{
	Ptr := A_PtrSize ? "UPtr" : "UInt"
	PtrA := A_PtrSize ? "UPtr*" : "UInt*"
        DllCall("gdiplus\GdipCreateBitmapFromFile", Ptr, &sFile, PtrA, pBitmap)
	return pBitmap
}

Gdip_GetImageWidth(pBitmap)
{
   DllCall("gdiplus\GdipGetImageWidth", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Width)
   return Width
}

Gdip_GetImageHeight(pBitmap)
{
   DllCall("gdiplus\GdipGetImageHeight", A_PtrSize ? "UPtr" : "UInt", pBitmap, "uint*", Height)
   return Height
}
