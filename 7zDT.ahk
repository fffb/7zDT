#Persistent
#SingleInstance Force
SetTimer, 7z

Menu, Tray, Icon, 7zDT.ico, 1
Menu, Tray, NoStandard ; 不显示 ahk 自己的菜单
Menu, Tray, Tip, 7zDT ; 托盘提示信息
Menu, Tray, Add, 重载, RL
Menu, Tray, Add, 退出, Exit7zDT
Return

RL:
    Reload

Exit7zDT:
ExitApp

7z: 
    if WinExist("添加到压缩包")
    {
        WinGetPos, Xpos, Ypos, W7z ;获取7z压缩界面的屏幕位置和窗口宽度
        Xpos2 := Xpos+W7z ;横坐标设为7z压缩界面的最右边
        Gui, Show, x%Xpos2% y%Ypos% h430 w170, 选择插入模式
        Gui, Font, c0066cc
        Gui, Add, Button, x30 y10 w110 h40 gMode1, ← 日期在前 1
        Gui, Add, Text, xp y55 w150 h30, YYYY-MM-DD_name.7z

        Gui, Add, Button, xp yp+25 w110 h40 gMode2, ← 日期在前 2
        Gui, Add, Text, xp yp+45 w150 h30, YYYYMMDD_name.7z

        Gui, Add, Button, xp yp+25 w110 h40 gMode3, 日期在后 1 →
        Gui, Add, Text, xp yp+45 w150 h30, name_YYYY-MM-DD.7z

        Gui, Add, Button, xp yp+25 w110 h40 gMode4, 日期在后 2→
        Gui, Add, Text, xp yp+45 w150 h30, name_YYYYMMDD.7z

        Gui, Add, Button, xp yp+25 w110 h40 gMode5, 日期时间在后 1 →
        Gui, Add, Text, x12 yp+45 w150 h30, name_YYYY-MM-DD_HHMMSS.7z

        Gui, Add, Button, x30 yp+25 w110 h40 gMode6, 日期时间在后 2 → 
        Gui, Add, Text, x12 yp+45 w150 h30, name_YYYYMMDD_HHMMSS.7z
        Gui -SysMenu +ToolWindow ;删除点击窗口左上角时弹出的系统菜单和图标，同时也删除标题栏上的最小化, 最大化和关闭按钮，让窗口显示细标题栏, 同时去除任务栏按钮
        WinActivate, 添加到压缩包
        SetTimer, 7z, Off ;禁用计时器，防止7z界面刷新导致的无法点击
        Gosub, 7zexit
    } 
Return

7zexit: ;检测到 7z 窗口关闭后同步关闭
    SetTimer, 7zexit
    if not WinExist("添加到压缩包")
    {
        Gui Destroy
        SetTimer, 7zexit, Off
        SetTimer, 7z
    }
Return

Mode1:
    WinActivate, 添加到压缩包
    ControlFocus, Edit1, 添加到压缩包
    Send {left}%A_YYYY%-%A_MM%-%A_DD%_
    SetControlDelay -1 ;在 ControlClick 期间用户同时在使用鼠标时提高稳定性，不加本行下一行运行会出错
    ControlClick, Button14, 添加到压缩包
    Gui Destroy
    SetTimer, 7z
Return

Mode2:
    WinActivate, 添加到压缩包
    ControlFocus, Edit1, 添加到压缩包
    Send {left}%A_YYYY%%A_MM%%A_DD%_
    SetControlDelay -1 ;在 ControlClick 期间用户同时在使用鼠标时提高稳定性，不加本行下一行运行会出错
    ControlClick, Button14, 添加到压缩包
    Gui Destroy
    SetTimer, 7z
Return

Mode3:
    WinActivate, 添加到压缩包
    ControlFocus, Edit1, 添加到压缩包
    ControlGetText, filename, Edit1, 添加到压缩包
    SplitPath, filename,,, ext, name_no_ext
    Send %name_no_ext%_%A_YYYY%-%A_MM%-%A_DD%.%ext%
    Sleep 500
    SetControlDelay -1
    ControlClick, Button14, 添加到压缩包
    Gui Destroy
    SetTimer, 7z
Return

Mode4:
    WinActivate, 添加到压缩包
    ControlFocus, Edit1, 添加到压缩包
    ControlGetText, filename, Edit1, 添加到压缩包
    SplitPath, filename,,, ext, name_no_ext
    Send %name_no_ext%_%A_YYYY%%A_MM%%A_DD%.%ext%
    Sleep 500
    SetControlDelay -1
    ControlClick, Button14, 添加到压缩包
    Gui Destroy
    SetTimer, 7z
Return

Mode5:
    WinActivate, 添加到压缩包
    ControlFocus, Edit1, 添加到压缩包
    ControlGetText, filename, Edit1, 添加到压缩包
    SplitPath, filename,,, ext, name_no_ext
    Send %name_no_ext%_%A_YYYY%-%A_MM%-%A_DD%_%A_Hour%%A_Min%%A_Sec%.%ext%
    Sleep 500
    SetControlDelay -1
    ControlClick, Button14, 添加到压缩包
    Gui Destroy
    SetTimer, 7z
Return

Mode6:
    WinActivate, 添加到压缩包
    ControlFocus, Edit1, 添加到压缩包
    ControlGetText, filename, Edit1, 添加到压缩包
    SplitPath, filename,,, ext, name_no_ext
    Send %name_no_ext%_%A_YYYY%%A_MM%%A_DD%_%A_Hour%%A_Min%%A_Sec%.%ext%
    Sleep 500
    SetControlDelay -1
    ControlClick, Button14, 添加到压缩包
    Gui Destroy
    SetTimer, 7z
Return