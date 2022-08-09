#Persistent
#SingleInstance Force
gosub, MultiLanguage
SetTimer, 7z

;Menu, Tray, Icon, 7zDT.ico, 1
Menu, Tray, NoStandard ; 不显示 ahk 自己的菜单
Menu, Tray, Tip, 7zDT ; 托盘提示信息
Menu, Tray, Add, %m_rl%, RL
Menu, Tray, Add, %m_tc%, TC
Return

RL:
    Reload

TC:
ExitApp

7z: 
    if WinExist("ahk_exe 7zG.exe")
    {
        WinGet, 7zPath, ProcessPath , ahk_exe 7zG.exe ;检测 7zG 的版本，根据版本确定点击的按钮，因为22.0之后按钮名称变了
        FileGetVersion, 7zVersion , %7zPath%
        if 7zVersion in 22.0.0.0,22.1.0.0
            BTN := "Button10"
        else
            BTN := "Button14"

        WinGetTitle, ATA, ahk_exe 7zG.exe
        ControlGet, OutputVar, Enabled ,, Edit1, %ATA% ;检测窗口是否包含 Edit1 控件，防止在“基准测试”等窗口也弹出
        if OutputVar = 1
        {
            WinGetPos, Xpos, Ypos, W7z ;获取7z压缩界面的屏幕位置和窗口宽度
            Xpos2 := Xpos+W7z ;横坐标设为7z压缩界面的最右边

            Gui, Show, x%Xpos2% y%Ypos% h430 w190, %slct%
            Gui, Font, c0066cc

            Gui, Add, Button, x40 y10 w110 h40 gMode1, %md1%
            Gui, Add, Text, xp-10 y55 w150 h30, %A_YYYY%-%A_MM%-%A_DD%_filename.7z

            Gui, Add, Button, x40 yp+25 w110 h40 gMode2, %md2%
            Gui, Add, Text, xp-5 yp+45 w150 h30, %A_YYYY%%A_MM%%A_DD%_filename.7z

            Gui, Add, Button, x40 yp+25 w110 h40 gMode3, %md3%
            Gui, Add, Text, xp-10 yp+45 w150 h30, filename_%A_YYYY%-%A_MM%-%A_DD%.7z

            Gui, Add, Button, x40 yp+25 w110 h40 gMode4, %md4%
            Gui, Add, Text, xp-5 yp+45 w150 h30, filename_%A_YYYY%%A_MM%%A_DD%.7z

            Gui, Add, Button, x40 yp+25 w110 h40 gMode5, %md5%
            Gui, Add, Text, x8 yp+45 w180 h30, filename_%A_YYYY%-%A_MM%-%A_DD%_%A_Hour%%A_Min%%A_Sec%.7z

            Gui, Add, Button, x40 yp+25 w110 h40 gMode6, %md6% 
            Gui, Add, Text, x12 yp+45 w170 h40, filename_%A_YYYY%%A_MM%%A_DD%_%A_Hour%%A_Min%%A_Sec%.7z

            Gui -SysMenu +ToolWindow ;删除点击窗口左上角时弹出的系统菜单和图标，同时也删除标题栏上的最小化, 最大化和关闭按钮，让窗口显示细标题栏, 同时去除任务栏按钮
            WinActivate, %ATA%
            SetTimer, 7z, Off ;禁用计时器，防止7z界面刷新导致的无法点击
            Gosub, 7zexit
        }
        Return
    } 
Return

7zexit: ;检测到 7z 窗口关闭后同步关闭
    SetTimer, 7zexit
    if not WinExist(ATA)
    {
        Gui Destroy
        SetTimer, 7zexit, Off
        SetTimer, 7z
    }
Return

Mode1:
    WinActivate, %ATA%
    ControlFocus, Edit1, %ATA%
    ControlGetText, filename, Edit1, %ATA%
    Send %A_YYYY%-%A_MM%-%A_DD%_%filename%
    SetControlDelay -1 ;在 ControlClick 期间用户同时在使用鼠标时提高稳定性，不加本行下一行运行会出错
    ControlClick, %BTN%, %ATA%
    Gui Destroy
    SetTimer, 7z
Return

Mode2:
    WinActivate, %ATA%
    ControlFocus, Edit1, %ATA%
    ControlGetText, filename, Edit1, %ATA%
    Send %A_YYYY%%A_MM%%A_DD%_%filename%
    SetControlDelay -1
    ControlClick, %BTN%, %ATA%
    Gui Destroy
    SetTimer, 7z
Return

Mode3:
    WinActivate, %ATA%
    ControlFocus, Edit1, %ATA%
    ControlGetText, filename, Edit1, %ATA%
    SplitPath, filename,,, ext, name_no_ext
    Send %name_no_ext%_%A_YYYY%-%A_MM%-%A_DD%.%ext%
    Sleep 500
    SetControlDelay -1
    ControlClick, %BTN%, %ATA%
    Gui Destroy
    SetTimer, 7z
Return

Mode4:
    WinActivate, %ATA%
    ControlFocus, Edit1, %ATA%
    ControlGetText, filename, Edit1, %ATA%
    SplitPath, filename,,, ext, name_no_ext
    Send %name_no_ext%_%A_YYYY%%A_MM%%A_DD%.%ext%
    Sleep 500
    SetControlDelay -1
    ControlClick, %BTN%, %ATA%
    Gui Destroy
    SetTimer, 7z
Return

Mode5:
    WinActivate, %ATA%
    ControlFocus, Edit1, %ATA%
    ControlGetText, filename, Edit1, %ATA%
    SplitPath, filename,,, ext, name_no_ext
    Send %name_no_ext%_%A_YYYY%-%A_MM%-%A_DD%_%A_Hour%%A_Min%%A_Sec%.%ext%
    Sleep 500
    SetControlDelay -1
    ControlClick, %BTN%, %ATA%
    Gui Destroy
    SetTimer, 7z
Return

Mode6:
    WinActivate, %ATA%
    ControlFocus, Edit1, %ATA%
    ControlGetText, filename, Edit1, %ATA%
    SplitPath, filename,,, ext, name_no_ext
    Send %name_no_ext%_%A_YYYY%%A_MM%%A_DD%_%A_Hour%%A_Min%%A_Sec%.%ext%
    Sleep 500
    SetControlDelay -1
    ControlClick, %BTN%, %ATA%
    Gui Destroy
    SetTimer, 7z
Return

MultiLanguage:
    if (A_Language="0804")
    {
        m_rl := "重载(&R)"
        m_tc := "退出(&X)"
        slct := "选择模式"
        md1 := "← 日期在前 1"
        md2 := "← 日期在前 2"
        md3 := "日期在后 1 →"
        md4 := "日期在后 2 →"
        md5 := "日期时间在后 1"
        md6 := "日期时间在后 2"
    }
    Else
    {
        m_rl := "&Reload"
        m_tc := "E&xit"
        slct := "Select Mode"
        md1 := "Mode 1"
        md2 := "Mode 2"
        md3 := "Mode 3"
        md4 := "Mode 4"
        md5 := "Mode 5"
        md6 := "Mode 6"
    }
Return