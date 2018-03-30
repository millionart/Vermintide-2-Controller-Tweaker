# Vermintide 2 Controller Tweaker

Control optimization tool for Steam game Warhammer: Vermintide 2

针对 Steam 游戏《战锤：末日鼠疫2》的操作优化工具

----

## Asian text chat | 亚洲文字聊天

- Automatic split long sentence sending | 自动拆分长句发送
- Automatically replace missing text | 自动替换缺失文字
- Set game to DX11 and window full mode | 必须设置游戏为 DX11 窗口全屏模式
- Quick phrase function (F1~F6) | 快捷短语功能

----

## New control method | 全新控制方式

## Melee weapon status | 近战武器状态

### Left button | 左键

- Click to Fight back | 单击反击
- Hold to attack continuously | 按住连续轻击

### Right button | 右键

- Click to Fight back | 单击反击
- Hold to force attack | 按住连续重击

## Long-range weapon status | 远程武器状态

### Left button | 左键

- Hold to aim/accumulate and release to fire | 按住瞄准/蓄力，松开射击

### Right button | 右键

- Hold to continue firing | 按住持续射击

----

## All status | 任何状态

### Shift

- Click Shift to run while move to forward with main weapon
- 装备主武器并移动时点击 Shift 切换为跑步

### Wheel Down and Up | 鼠标滚轮

- Switch main and sub-weapons | 切换主副武器

### P

- Teammate control interface, will cancel battle mode
- 队友控制界面，会取消战斗模式

### other | 其他

- Selecting the weapon (button 1 2) will switch to battle mode
- 选择武器（按键 1 2），会进入战斗模式

----

## Usage | 使用说明

1. Install [Autohotkey](https://www.autohotkey.com/download/ahk-install.exe) and run this script.

    安装 [Autohotkey](https://www.autohotkey.com/download/ahk-install.exe) 然后双击脚本运行。

    - **Full functionality script | 完整功能的脚本:**

        **Vermintide 2 Controller Tweaker.ahk**

    - Basic chat only script | 仅有基本聊天功能的脚本：

        Vermintide 2 Chatbox.ahk

2. After entering the level | 进入关卡后

    - press 1 to enter battle mode, __you will see that the Normal mode in the upper right corner disappears__.
    - press esc restore to the default state.

    - 按一下 1 进入战斗模式，__你会看到右上角的 Normal mode 消失了__。
    - 按一下 esc 恢复默认状态。

3. The Chatbox defaults to 1680x1050. If you need to change it, please edit the ScreenWidth and screenHeight values of Initialization.ahk to the corresponding resolution width and height.

    聊天对话框默认适配 1680x1050 分辨率，如果需要更改，请编辑 Initialization.ahk 文件，将 screenWidth 和 screenHeight 改为对应分辨率宽高。

----

## Recommend | 推荐

- Change Game input in Game | 更改默认控制按键

    Item 项目|Default 默认值|Setto 设置为|说明
    ----:|:----:|:----:|:----
    Dodge only <br />仅闪避||**shift**|'Dodge only' set to Shift will trun on 'automatically dodge' mode<br />“仅闪避”设置为 Shift 将开启自动闪避模式
    Vote Yes<br />投票赞成|F5|**Y**|The quick phrase function occupies F5<br />快捷短语功能占用了 F5
    Vote No<br />投票反对|F6|**N**|The quick phrase function occupies F6<br />快捷短语功能占用了 F6

----

## Note | 注意

- The default skill key is F. If you need to change it, edit Initialization.ahk change the letter after the skillKey= in the 2nd line to the game corresponding key and save it (then run script again).

    默认技能键为 F，如需更改，请编辑 Initialization.ahk 第 2 行 skillKey= 后面的字母改为游戏对应按键，并保存（然后重新执行脚本）。

- The console key has been automatically changed from F2 to F11

    控制台按键已经自动由 F2 更换为 F11

- 在 Windows 10 1709 系统上有可能出现发送文字是问号的问题

    解决方法：

    - **运行脚本和游戏后：**

        1. 游戏界面中按回车进入输入状态
        2. 用鼠标点一下游戏界面，会发现输入工具界面消失了
        3. win + 空格 切换到中文输入法
        4. 按回车，发现游戏输入界面消失了
        5. 再次按回车，现在输入工具可以正常发送中文了

    正在寻找办法自动来处理这个步骤

- Windows 10 with high DPI display mast get the value of 'Change the size of text, apps, and other items', you can find it in above:
    1. Right-click anywhere on the Desktop
    1. Select __Display Settings__ from the menu, You will see it
    1. Edit Initialization.ahk to change the value after TAOsize= to the corresponding number (without the % sign)

    拥有高 DPI 显示设备的 Windows 10 系统需要获得 “更改文本、应用和其他项目的大小” 的值，你可以在这里找到它：
    1. 在桌面空白地方点击桌面
    1. 从菜单中选择"显示设置“，你会在界面中看到这个选项
    1. 编辑 Initialization.ahk，将 TAOsize= 后面的值改为对应数字（不带 % 号）

----