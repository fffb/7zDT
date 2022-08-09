# 7zDT
## Intro 简介
For a long time, 7-Zip lacks the ability to add date/time to the archive's filename. We can only rename it after the archive is generated. This script will generate a window on the right side of 7-Zip's "Add to Archive" window, containing 6 buttons corresponding to 6 date/time naming methods. Archive files named with date/time will be automatically generated when the button is clicked.

长久以来，7-Zip 自身缺乏给压缩包文件名添加日期/时间的功能，只能在生成压缩包之后再重命名。本脚本会在 7-Zip 的“添加到压缩包”窗口右侧生成一个窗口，包含6个按钮，对应6种日期/时间命名方式，点击按钮后自动生成压缩包。

### History 更新记录
>2022-08-09 v6.3.4
>1. Add support for 7-Zip 22.00 & 22.01. Cause the ClassNN for "OK" Button has changed to "Button10" instead of "Button14" since 7-Zip 22.00.\
支持7-Zip 22.00 和 22.01。因为从7-Zip 22.00 开始，"OK "按钮的 ClassNN 变成了 "Button10 "而不是 "Button14"。
>2. Bugfix for Mode 1 and 2. 7zDT now works well on Windows 7.\
模式 1、2 错误修复，7zDT 现在在 Windows 7 上运行良好。

>2022-08-08 v6.3.2
>1. Imporved window detection method to prevent pop up on "Benchmark & compressing" window.\
改进窗口检测办法，防止在“基准测试”和"正在压缩"界面出现
>2. Improved sample text, showing the current date/time (sorry for not showing the real filename, as the length is not controllable).\
改进示例文字显示，显示当前日期时间（抱歉不显示真正文件名，因为长度不可控）

>2022-08-06 v6.3.0
>1. Changed window detection method, now fits any language version of 7-Zip. 改变了窗口检测办法，现在适合任何语言版本的 7-Zip。
>2. Multi-Language Support: Chinese & English. 多语言支持：中文、英语。

## Screenshot 截图
![image](https://github.com/fffb/7zDT/blob/main/screenshot.png)
