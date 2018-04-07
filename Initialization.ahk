
screenWidth=1680
screenHeight=1050

/*
- The default skill key is F. 
If you need to change it, 
change the letter after the skillKey= to the game corresponding key (then run script again).

    默认技能键为 F，如需更改，
    请编辑 skillKey= 后面的字母改为游戏对应按键（然后重新执行脚本）
*/
skillKey=f

/* 
- The default switch weapon key is Q. 
If you need to change it, 
change the letter after the switchWeaponKey= to the game corresponding key (then run script again).

    默认切换武器键为 Q，如需更改，
    请编辑 switchWeaponKey= 后面的字母改为游戏对应按键（然后重新执行脚本）
*/
switchWeaponKey=q

/* 
- Some Long-range weapons are not suitable for this script, 
such as 
Drakegun, 
Beam Staff, 
Flamestorm Staff, 
etc. 
To use these weapons, 
change the letter after the secondWeaponController= to 0 (then run script again).

    部分远程武器并不适合此脚本，比如 
    铁龙炮、
    光束法杖、
    烈火风暴法杖 
    等，如需使用此类武器，
    请编辑 secondWeaponController= 后面的数字改为 0（然后重新执行脚本）
*/
secondWeaponController=1


/*
- Windows 10 with high DPI display mast get the value of 'Change the size of text, apps, and other items', you can find it in above:
    1. Right-click anywhere on the Desktop
    2. Select __Display Settings__ from the menu, You will see it
    3. Edit Initialization.ahk to change the value after TAOsize= to the corresponding number (without the % sign)

    拥有高 DPI 显示设备的 Windows 10 系统需要获得 “更改文本、应用和其他项目的大小” 的值，你可以在这里找到它：
    1. 在桌面空白地方点击桌面
    2. 从菜单中选择"显示设置“，你会在界面中看到这个选项
    3. 编辑 Initialization.ahk，将 TAOsize= 后面的值改为对应数字（不带 % 号）
*/
TAOsize=100

/*
    Do not change the following
    不要改变以下内容
*/

; Chat word limit 聊天字数限制
chatboxMaxLength=10

Gosub, SetDefaultState

