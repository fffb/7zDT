;2023-10-15 v1.2.0
;https://github.com/fffb/7zDT

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
    md7 := "原始文件名"
    dp := "日期在前"
    ds := "日期在后"
    dts := "日期 && 时间在后"
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
    md7 := "Original`nFilename"
    dp := "Date Prefix"
    ds := "Date Suffix"
    dts := "Date Time Suffix"
}
;;;;;;;;;;;;;;;;;;;;;;;自定义系统托盘图标及菜单
TraySetIcon("7zDT.ico")
A_IconTip := "7zDT"
tray := A_TrayMenu
tray.delete    ; 删除系统托盘标准菜单
tray.add traymenu_st, AutoStart
tray.add traymenu_rl, Rld
tray.add traymenu_tc, TC

If FileExist(A_Startup "\7zDT.lnk")
{
    Tray.Check(traymenu_st)
}
else
{
    Tray.Uncheck(traymenu_st)
}

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
        global ATA := WinGetTitle("ahk_exe 7zG.exe")
        try if ControlGetEnabled("Edit1", ATA) = 1    ;检测窗口是否包含 Edit1 控件，防止在“基准测试”等窗口也弹出
        {
            WinGetPos &Xpos, &Ypos, &W7z    ;获取7z压缩界面的屏幕位置和窗口宽度
            global XposOld := Xpos
            global YposOld := Ypos
            Xpos2 := Xpos + W7z    ;横坐标设为7z压缩界面的最右边

            global MyGui := Gui("-SysMenu + ToolWindow", slct)    ;删除窗口左上角系统菜单和图标，及标题栏上的最小化最大化和关闭按钮，让窗口显示细标题栏, 同时去除任务栏按钮
            MyGui.Show("x" Xpos2 "y" Ypos "h490 w190")
            MyGui.SetFont("c0066cc")

            MyGui.Add("GroupBox", "x20 w150 h125", dp)
            BTN1 := MyGui.AddButton("x45 y25 w96 h30", md1)
            MyGui.AddText("xp-15 yp+35 w150 h30", A_YYYY "-" A_MM "-" A_DD "_filename.7z")
            BTN1.OnEvent("Click", Mode1)

            BTN2 := MyGui.AddButton("x45 yp+15 w96 h30", md2)
            MyGui.AddText("xp-15 yp+35 w150 h30", A_YYYY A_MM A_DD "_filename.7z")
            BTN2.OnEvent("Click", Mode2)

            MyGui.Add("GroupBox", "x20 yp+35 w150 h125", ds)
            BTN3 := MyGui.AddButton("x45 yp+20 w96 h30", md3)
            MyGui.AddText("xp-15 yp+35 w150 h30", "filename_" A_YYYY "-" A_MM "-" A_DD ".7z")
            BTN3.OnEvent("Click", Mode3)

            BTN4 := MyGui.AddButton("x45 yp+15 w96 h30", md4)
            MyGui.AddText("xp-15 yp+35 w150 h30", "filename_" A_YYYY A_MM A_DD ".7z")
            BTN4.OnEvent("Click", Mode4)

            MyGui.Add("GroupBox", "x20 yp+35 w150 h125", dts)
            BTN5 := MyGui.AddButton("x45 yp+20 w96 h30", md5)
            MyGui.AddText("xp-15 yp+35 w180 h30", "fn_" A_YYYY "-" A_MM "-" A_DD "_" A_Hour A_Min A_Sec ".7z")
            BTN5.OnEvent("Click", Mode5)

            BTN6 := MyGui.AddButton("x45 yp+15 w96 h30", md6)
            MyGui.AddText("xp-15 yp+35 w170 h30", "fn_" A_YYYY A_MM A_DD "_" A_Hour A_Min A_Sec ".7z")
            BTN6.OnEvent("Click", Mode6)

            BTN7 := MyGui.AddButton("x45 yp+35 w96 h30", md7)
            BTN7.OnEvent("Click", Mode7)

            global OriginalFileName := ControlGetText("Edit1", ATA)
            SetTimer main, 0    ;禁用计时器，防止7z界面刷新导致的无法点击
            WindowStatusChanged
        }
    }
}

WindowStatusChanged()
{
    SetTimer WindowStatusChanged, 700
    if WinExist(ATA)
    {
        WinGetPos &XposNew, &YposNew, , , ATA
        if XposOld != XposNew or YposOld != YposNew
        {
            Back2Main
        }
    }
    else
    {
        Back2Main
    }
}

Back2Main()
{
    MyGui.Destroy()
    SetTimer WindowStatusChanged, 0
    SetTimer main
}

GetFilename()
{
    ControlFocus "Edit1", ATA
    global FullFileName, Ext, NameNoExt
    FullFileName := ControlGetText("Edit1", ATA)
    SplitPath FullFileName, , , &Ext, &NameNoExt
}

Mode1(*)
{
    GetFilename
    Send A_YYYY "-" A_MM "-" A_DD "_" FullFileName
}

Mode2(*)
{
    GetFilename
    Send A_YYYY A_MM A_DD "_" FullFileName
}

Mode3(*)
{
    GetFilename
    Send NameNoExt "_" A_YYYY "-" A_MM "-" A_DD "." Ext
}

Mode4(*)
{
    GetFilename
    Send NameNoExt "_" A_YYYY A_MM A_DD "." Ext
}

Mode5(*)
{
    GetFilename
    Send NameNoExt "_" A_YYYY "-" A_MM "-" A_DD "_" A_Hour A_Min A_Sec "." Ext
}

Mode6(*)
{
    GetFilename
    Send NameNoExt "_" A_YYYY A_MM A_DD "_" A_Hour A_Min A_Sec "." Ext
}

Mode7(*)
{
    ControlFocus "Edit1", ATA
    Send OriginalFileName
}