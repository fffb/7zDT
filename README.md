# 7zDT
## Intro 简介
For a long time, 7-Zip lacks the ability to add date/time to the archive's filename. We can only rename it after the archive is generated. This script will generate a window on the right side of 7-Zip's "Add to Archive" window, containing 6 buttons corresponding to 6 date/time naming methods. The corresponding file name is automatically generated when the button is clicked.

长久以来，7-Zip 自身缺乏给压缩包文件名添加日期/时间的功能，只能在生成压缩包之后再重命名。本脚本会在 7-Zip 的“添加到压缩包”窗口右侧生成一个窗口，包含6个按钮，对应6种日期/时间命名方式，点击按钮后自动生成对应文件名。

## Screenshot 截图
![image](https://github.com/fffb/7zDT/blob/main/screenshot.jpg)

## Changelog 更新记录  
2023-10-15 v1.2.0  (AHK v2)
> - 7zDT will now move along with the 7-Zip "Add to Archive" window.   
> 如果 7-Zip “添加到压缩包”窗口发生位移，7zDT 也会自动跟随移动位置  

2023-10-14 v1.1.2  (AHK v2)
> - Interface Optimization.   
> 界面优化  

2023-02-15 v1.1.1  (AHK v2)
> - Fixed: 7zDT will no longer be displayed together with the "Compressing" window.   
> 修复了 7zDT 在“正在压缩”界面也显示的问题  
  
2023-02-05 v1.1.0  (AHK v2)  
>1. A new button has been added to help you revert to the original file name.  
增加了一个按钮，以便恢复原文件名。  
>2. Fix:  The "AutoStart" checkmark will now display correctly.  
修复：退出后再次打开，托盘右键菜单“开机自启”框选显示不准确的问题。  
>3. Code optimazation  
代码优化：删除不影响运行结果的冗余代码。

2023-02-04 v1.0.0  (AHK v2)
>["AutoHotkey v2 has been released and will be considered the default/main version."](https://www.autohotkey.com/boards/viewtopic.php?f=24&t=112989)  
>So 7zDT has been rewritten in AHK v2. Only 7zDT (AHK v2) will be updated in the future.  
AutoHotkey v2 已发布，并将被视为默认/主版本。因此用 AHK v2 重写了 7zDT。未来只有 7zDT (AHK v2) 会继续更新。
>>1. Add: New tray menu "AutoStart" which allows you to start 7zDT on system startup.  
>>系统托盘菜单添加“开机自启”，以便在系统启动后自动运行 7zDT。
>>2. Remove: Archive files will no longer be created automatically. You should click the OK button manually.  
>>压缩文件将不再被自动创建。你需要手动点击 "确定 "按钮。


2022-08-09 v6.3.4
>1. Add support for 7-Zip 22.00 & 22.01. Cause the ClassNN for "OK" Button has changed to "Button10" instead of "Button14" since 7-Zip 22.00.\
支持7-Zip 22.00 和 22.01。因为从7-Zip 22.00 开始，"OK "按钮的 ClassNN 变成了 "Button10 "而不是 "Button14"。
>2. Bugfix for Mode 1 and 2. 7zDT now works well on Windows 7.\
模式 1、2 错误修复，7zDT 现在在 Windows 7 上运行良好。

2022-08-08 v6.3.2
>1. Imporved window detection method to prevent pop up on "Benchmark & compressing" window.\
改进窗口检测办法，防止在“基准测试”和"正在压缩"界面出现
>2. Improved sample text, showing the current date/time (sorry for not showing the real filename, as the length is not controllable).\
改进示例文字显示，显示当前日期时间（抱歉不显示真正文件名，因为长度不可控）

2022-08-06 v6.3.0
>1. Changed window detection method, now fits any language version of 7-Zip.  
改变了窗口检测办法，现在适合任何语言版本的 7-Zip。
>2. Multi-Language Support: Chinese & English.  
多语言支持：中文、英语。