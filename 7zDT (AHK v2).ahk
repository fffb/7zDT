; v1.0.0
;2023-01-30 准备转换到 AHK v2
;2023-02-03 完成主体部分重写
;2023-02-04 完成多语言支持，自定义托盘菜单及图标，加入开机自启功能

#SingleInstance Force
;;;;;;;;;;;;;;;;;;;;;;;;;多语言支持
if (A_Language = "0804")
{
    traymenu_st := "开机自启(&A)"
    traymenu_rl := "重新载入(&R)"
    traymenu_tc := "退出(&X)"
    slct := "选择模式"
    md1 := "模式 1"
    md2 := "模式 2"
    md3 := "模式 3"
    md4 := "模式 4"
    md5 := "模式 5"
    md6 := "模式 6"
}
Else
{
    traymenu_st := "&AutoStart"
    traymenu_rl := "&Reload"
    traymenu_tc := "E&xit"
    slct := "Select Mode"
    md1 := "Mode 1"
    md2 := "Mode 2"
    md3 := "Mode 3"
    md4 := "Mode 4"
    md5 := "Mode 5"
    md6 := "Mode 6"
}
;;;;;;;;;;;;;;;;;;;;;;;自定义系统托盘图标及菜单
TraySetIcon("7zDT.ico")
tray := A_TrayMenu
tray.delete    ; 删除系统托盘标准菜单
tray.add traymenu_st, AutoStart
tray.add traymenu_rl, Rld
tray.add traymenu_tc, TC

AutoStart(*)
{
    If FileExist(A_Startup "\7zDT.lnk")
    {
        FileDelete A_Startup "\7zDT.lnk"
        Tray.Uncheck(traymenu_st)
    }
    else
    {
        FileCreateShortcut A_ScriptFullPath, A_Startup "\7zDT.lnk", A_ScriptDir
        Tray.Check(traymenu_st)
    }
}

Rld(*)
{
    Reload
}

TC(*)
{
    ExitApp
}
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
SetTimer main

main()
{
    if WinExist("ahk_exe 7zG.exe")
    {
        try if ControlGetEnabled("Edit1", WinGetTitle("ahk_exe 7zG.exe")) = 1    ;检测窗口是否包含 Edit1 控件，防止在“基准测试”等窗口也弹出
            {
                WinGetPos &Xpos, &Ypos, &W7z    ;获取7z压缩界面的屏幕位置和窗口宽度
                Xpos2 := Xpos + W7z    ;横坐标设为7z压缩界面的最右边

                global MyGui := Gui("-SysMenu + ToolWindow", slct)    ;删除窗口左上角系统菜单和图标，及标题栏上的最小化最大化和关闭按钮，让窗口显示细标题栏, 同时去除任务栏按钮
                MyGui.Show("x" Xpos2 "y" Ypos "h430 w190")
                MyGui.SetFont("c0066cc")

                BTN1 := MyGui.AddButton("x40 y10 w110 h40", md1)
                MyGui.AddText("xp-10 y55 w150 h30", A_YYYY "-" A_MM "-" A_DD "_filename.7z")
                BTN1.OnEvent("Click", Mode1)

                BTN2 := MyGui.AddButton("x40 yp+25 w110 h40", md2)
                MyGui.AddText("xp-5 yp+45 w150 h30", A_YYYY A_MM A_DD "_filename.7z")
                BTN2.OnEvent("Click", Mode2)

                BTN3 := MyGui.AddButton("x40 yp+25 w110 h40", md3)
                MyGui.AddText("xp-10 yp+45 w150 h30", "filename_" A_YYYY "-" A_MM "-" A_DD ".7z")
                BTN3.OnEvent("Click", Mode3)

                BTN4 := MyGui.AddButton("x40 yp+25 w110 h40", md4)
                MyGui.AddText("xp-5 yp+45 w150 h30", "filename_" A_YYYY A_MM A_DD ".7z")
                BTN4.OnEvent("Click", Mode4)

                BTN5 := MyGui.AddButton("x40 yp+25 w110 h40", md5)
                MyGui.AddText("x8 yp+45 w180 h30", "filename_" A_YYYY "-" A_MM "-" A_DD "_" A_Hour A_Min A_Sec ".7z")
                BTN5.OnEvent("Click", Mode5)

                BTN6 := MyGui.AddButton("x40 yp+25 w110 h40", md6)
                MyGui.AddText("x12 yp+45 w170 h40", "filename_" A_YYYY A_MM A_DD "_" A_Hour A_Min A_Sec ".7z")
                BTN6.OnEvent("Click", Mode6)

                SetTimer main, 0    ;禁用计时器，防止7z界面刷新导致的无法点击
                exit7z
            }
    }
}

exit7z()
{
    SetTimer exit7z
    if not WinExist("ahk_exe 7zG.exe")
    {
        MyGui.Destroy()
        SetTimer exit7z, 0
        SetTimer main
    }
}

GetFilename()
{
    WinActivate "ahk_exe 7zG.exe"
    ControlFocus "Edit1", "ahk_exe 7zG.exe"
    global FullFileName, Ext, NameNoExt
    FullFileName := ControlGetText("Edit1", "ahk_exe 7zG.exe")
    SplitPath FullFileName, , , &Ext, &NameNoExt
    Return
}

Mode1(*)
{
    GetFilename
    Send A_YYYY "-" A_MM "-" A_DD "_" FullFileName
    return
}

Mode2(*)
{
    GetFilename
    Send A_YYYY A_MM A_DD "_" FullFileName
    return
}

Mode3(*)
{
    GetFilename
    Send NameNoExt "_" A_YYYY "-" A_MM "-" A_DD "." Ext
    return
}

Mode4(*)
{
    GetFilename
    Send NameNoExt "_" A_YYYY A_MM A_DD "." Ext
    return
}

Mode5(*)
{
    GetFilename
    Send NameNoExt "_" A_YYYY "-" A_MM "-" A_DD "_" A_Hour A_Min A_Sec "." Ext
    return
}

Mode6(*)
{
    GetFilename
    Send NameNoExt "_" A_YYYY A_MM A_DD "_" A_Hour A_Min A_Sec "." Ext
    return
}