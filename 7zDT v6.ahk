#Persistent
#SingleInstance Force
SetBatchLines, -1
SetTimer, 7z, 250

Menu, Tray, Icon, 7zDT.ico, 1
Menu, Tray, NoStandard ; 不显示 ahk 自己的菜单
Menu, Tray, Tip, 7zDT ; 托盘提示信息
Menu, Tray, Add, 退出, MenuHandler ;自定义系统托盘右键菜单

7z: ;构建 GUI
    if WinExist("添加到压缩包")
    {
        WinGetPos, Xpos, Ypos ;获取7z压缩界面的屏幕位置
        Xpos2 := Xpos+625 ;横坐标设为7z压缩界面的最右边
        Gui, Show, x%Xpos2% y%Ypos% h270 w170, 选择插入模式
        Gui, Add, Button, x30 y10 w110 h40 gDateBefore, ← 日期在前
        Gui, Font, c0066cc
        Gui, Add, Text, x30 y55 w150 h30, YYYY-MM-DD 文件名
        Gui, Add, Button, x30 y75 w110 h40 gDTB, ← 日期时间在前
        Gui, Add, Text, x12 y120 w150 h30, YYYY-MM-DD_HHMMSS 文件名
        Gui, Add, Button, x30 y140 w110 h40 gDateAfter, 日期在后 →
        Gui, Add, Text, x30 y185 w150 h30, 文件名_YYYY-MM-DD
        Gui, Add, Button, x30 y205 w110 h40 gDTA, 日期时间在后 → 
        Gui, Add, Text, x12 y250 w150 h30, 文件名_YYYY-MM-DD_HHMMSS
        Gui -SysMenu +ToolWindow ;删除点击窗口左上角时弹出的系统菜单和图标，同时也删除标题栏上的最小化, 最大化和关闭按钮，让窗口显示细标题栏, 同时去除任务栏按钮
        WinActivate, 添加到压缩包
        SetTimer, 7z, Off ;禁用计时器，防止7z界面刷新导致的无法点击
        Gosub, 7zexit
    } 
Return

7zexit: ;检测到 7z 窗口关闭后同步关闭
    SetTimer, 7zexit, 250
    if not WinExist("添加到压缩包")
    {
        Gui Destroy
        SetTimer, 7zexit, Off
        SetTimer, 7z, 250
    }
Return

DateBefore:
    WinActivate, 添加到压缩包
    ControlFocus, Edit1, 添加到压缩包
    Send {left}%A_YYYY%-%A_MM%-%A_DD%{space}
    SetControlDelay -1 ;在 ControlClick 期间用户同时在使用鼠标时提高稳定性，不加本行下一行运行会出错
    ControlClick, Button14, 添加到压缩包
    Gui Destroy
    SetTimer, 7z, 250
Return

DateAfter:
    WinActivate, 添加到压缩包
    ControlFocus, Edit1, 添加到压缩包
    ControlGetText, filename, Edit1, 添加到压缩包
    SplitPath, filename,,, ext, name_no_ext
    Send %name_no_ext%_%A_YYYY%-%A_MM%-%A_DD%.%ext%
    Sleep 500
    SetControlDelay -1
    ControlClick, Button14, 添加到压缩包
    Gui Destroy
    SetTimer, 7z, 250
Return

DTA:
    WinActivate, 添加到压缩包
    ControlFocus, Edit1, 添加到压缩包
    ControlGetText, filename, Edit1, 添加到压缩包
    SplitPath, filename,,, ext, name_no_ext
    Send %name_no_ext%_%A_YYYY%-%A_MM%-%A_DD%_%A_Hour%%A_Min%%A_Sec%.%ext%
    Sleep 500
    SetControlDelay -1
    ControlClick, Button14, 添加到压缩包
    Gui Destroy
    SetTimer, 7z, 250
Return

DTB:
    WinActivate, 添加到压缩包
    ControlFocus, Edit1, 添加到压缩包
    Send {left}%A_YYYY%-%A_MM%-%A_DD%_%A_Hour%%A_Min%%A_Sec%{space}
    SetControlDelay -1
    ControlClick, Button14, 添加到压缩包
    Gui Destroy
    SetTimer, 7z, 250
Return

MenuHandler:
    if (A_ThisMenuItem = "退出")
        ExitApp
Return