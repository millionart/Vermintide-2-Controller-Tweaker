# Vermintide 2 Controller Tweaker

Controller Tweaker like Overwatch for Steam game Warhammer: Vermintide 2

仿守望先锋控制器，针对 Steam 游戏《战锤：末日鼠疫2》

----

## Asian text chat | 亚洲文字聊天

- Automatic split long sentence sending | 自动拆分长句发送
- Automatically replace missing text | 自动替换缺失文字
- Set game to DX11 and window full mode | 必须设置游戏为 DX11 窗口全屏模式
- Basic chat only script | 仅有基本聊天功能的脚本 Vermintide 2 Chatbox.ahk

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

- Teammate control will cancel battle mode
- 队友控制功能，会取消战斗模式

### other | 其他

- Selecting the weapon (button 1 2) will switch to battle mode
- 选择武器（按键 1 2），会进入战斗模式

----

## Install | 安装说明

1. Install [Autohotkey](https://www.autohotkey.com/download/ahk-install.exe) and run this script.

    安装 [Autohotkey](https://www.autohotkey.com/download/ahk-install.exe) 然后双击脚本运行。

    - Script |  脚本名:

        Vermintide 2 Controller Tweaker.ahk

2. After entering the level | 进入关卡后

    - press 1 to enter battle mode, __you will see that the Normal mode in the upper right corner disappears__
    - press esc back to normal mode

    - 按一下 1 进入战斗模式，__你会看到右上角的 Normal mode 消失了__
    - 按一下 esc 回到普通模式

3. (Recommend) Change Game input in Game | (推荐) 更改默认控制按键

    Item 项目|Default 默认值|Setto 设置为|说明
    ----:|:----:|:----:|:----
    Dodge only <br />仅闪避||**shift**|'Dodge only' set to Shift will trun on 'automatically dodge' mode<br />“仅闪避”设置为 Shift 将开启自动闪避模式

## Note | 注意

- The default skill key is F. If you need to change it, edit Initialization.ahk change the letter after the skillKey= in the 1st line to the game corresponding key and save it in UTF-8 with BOM format (then run script again).

    默认技能键为 F，如需更改，请编辑 Initialization.ahk 第 1 行 skillKey= 后面的字母改为游戏对应按键，并保存为 UTF-8 with BOM 格式（然后重新执行脚本）


----