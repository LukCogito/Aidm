/*
=============================================================================
# Powered by AutoHotkey 1.1.37.02                      
# Software License: GNU General Public License         
# https://www.autohotkey.com/docs/v1/license.htm       
                                                       
# Thanks to tic (Tariq Porter) for his GDI+ Library

; Gdip standard library v1.45 by tic (Tariq Porter) 07/09/11
; Modifed by Rseding91 using fincs 64 bit compatible Gdip library 5/1/2013
; Supports: Basic, _L ANSi, _L Unicode x86 and _L Unicode x64
=============================================================================
*/

#NoEnv
#Include %A_ScriptDir%\Lib\Gdip_All.ahk
SetBatchLines, -1

; CESTA K SOUBORU GIF
filePath = %a_scriptdir%\splash.gif

pToken := Gdip_Startup()
OnExit, Exit
exStyles := (WS_EX_COMPOSITED := 0x02000000) | (WS_EX_LAYERED := 0x80000)

Gui, New, +E%exStyles%
Gui, Add, Picture, y10 hwndhwndGif1, % filePath
Gui, +Disabled -SysMenu +Owner -caption
gif1 := new Gif(filePath, hwndGif1)
Gui, +LastFound
Gui, Show, x10 y10 AutoSize
gif1.Play()
WinID := WinExist()

; Automatické ukonèení 2 minuty
; sleep, 120000
; goto GuiClose

Return


GuiClose:
ExitApp

PlayPause:
isPlaying := gif1.isPlaying
GuiControl,, % hwndPlayPause, % (isPlaying) ? "Play" : "Pause"
if (!isPlaying) {
    gif1.Play()
} else {
    gif1.Pause()
}
return

Exit:
Gdip_ShutDown(pToken)
ExitApp
return

class Gif
{   
    __New(file, hwnd, cycle := true)
    {
        this.file := file
        this.hwnd := hwnd
        this.cycle := cycle
        this.pBitmap := Gdip_CreateBitmapFromFile(this.file)
        Gdip_GetImageDimensions(this.pBitmap, width, height)
        this.width := width, this.height := height
        this.isPlaying := false
        
        DllCall("Gdiplus\GdipImageGetFrameDimensionsCount", "ptr", this.pBitmap, "uptr*", frameDimensions)
        this.SetCapacity("dimensionIDs", 16*frameDimensions)
        DllCall("Gdiplus\GdipImageGetFrameDimensionsList", "ptr", this.pBitmap, "uptr", this.GetAddress("dimensionIDs"), "int", frameDimensions)
        DllCall("Gdiplus\GdipImageGetFrameCount", "ptr", this.pBitmap, "uptr", this.GetAddress("dimensionIDs"), "int*", count)
        this.frameCount := count
        this.frameCurrent := -1
        this.frameDelay := this.GetFrameDelay(this.pBitmap)
        this._Play("")
    }

    GetFrameDelay(pImage) {
        static PropertyTagFrameDelay := 0x5100

        DllCall("Gdiplus\GdipGetPropertyItemSize", "Ptr", pImage, "UInt", PropertyTagFrameDelay, "UInt*", ItemSize)
        VarSetCapacity(Item, ItemSize, 0)
        DllCall("Gdiplus\GdipGetPropertyItem"    , "Ptr", pImage, "UInt", PropertyTagFrameDelay, "UInt", ItemSize, "Ptr", &Item)

        PropLen := NumGet(Item, 4, "UInt")
        PropVal := NumGet(Item, 8 + A_PtrSize, "UPtr")

        outArray := []
        Loop, % PropLen//4 {
            if !n := NumGet(PropVal+0, (A_Index-1)*4, "UInt")
                n := 10
            outArray[A_Index-1] := n * 10
        }
        return outArray
    }
    
    Play()
    {
        this.isPlaying := true
        fn := this._Play.Bind(this)
        this._fn := fn
        SetTimer, % fn, -1
    }
    
    Pause()
    {
        this.isPlaying := false
        fn := this._fn
        SetTimer, % fn, Delete
    }
    
    _Play(mode := "set")
    {
        this.frameCurrent := mod(++this.frameCurrent, this.frameCount)
        DllCall("Gdiplus\GdipImageSelectActiveFrame", "ptr", this.pBitmap, "uptr", this.GetAddress("dimensionIDs"), "int", this.frameCurrent)
        hBitmap := Gdip_CreateHBITMAPFromBitmap(this.pBitmap)
        SetImage(this.hwnd, hBitmap)
        DeleteObject(hBitmap)
        if (mode = "set" && this.frameCurrent < (this.cycle ? 0xFFFFFFFF : this.frameCount - 1)) {
            fn := this._fn
            SetTimer, % fn, % -1 * this.frameDelay[this.frameCurrent]
        }
    }
    
    __Delete()
    {
        Gdip_DisposeImage(this.pBitmap)
        Object.Delete("dimensionIDs")
    }
}


; Detekce kliknutí levým tlaèítkem myši na aktivní GUI tohoto skriptu
~LButton::
    MouseGetPos, , , id, control
    ;sleep, 400

    if (winid = id) ; Kontrola, zda je GUI vytvoøené tímto skriptem aktivní okno
    {
        ExitApp
    }
return