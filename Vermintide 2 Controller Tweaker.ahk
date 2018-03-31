
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetBatchLines -1
ListLines Off
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force
SetKeyDelay -1
Process, Priority,, High

#Include, Initialization.ahk
ResolutionAdaptation(screenWidth,screenHeight)

If (A_IsUnicode!=1)
{
    MsgBox, "Error, file is not Unicode!"
    ExitApp
}

Menu, tray, NoStandard
Menu, tray, add, 重置 | Reload, ReloadScrit
Menu, tray, add, 暂停 | Pause, PauseScrit
Menu, tray, add
Menu, tray, add, 帮助 | Help, Help
Menu, tray, add, 更新 | Ver %ver%, UpdateScrit
Menu, tray, add, 退出 | Exit, ExitScrit

Gui, +ToolWindow -Caption +AlwaysOnTop
Gui, Color, %bGColor%
gui, font, s12 cffffff
Gui, Color, ,000000
Gui, Add, Edit, x0 y0 w%chatboxW% h25 vchatBox Limit140
gui, font

Hotkey, IfWinActive, ahk_exe vermintide2.exe
    Hotkey, %switchWeaponKey%, WeaponSwitchKeyEqualsCustom
    Hotkey, WheelUp, WeaponSwitchKeyEqualsWheelUp
    Hotkey, WheelDown, WeaponSwitchKeyEqualsWheelDown
Hotkey, IfWinActive

SetTimer, battleModeCheck, 200

Return

#IfWinActive, ahk_exe vermintide2.exe
    ~Shift::
        forwardKeyDown:=GetKeyState("w" , "P")
        If (forwardKeyDown=1)
        {
            Send, {RButton Up}
            rDown:=0
            ;inBattle:=0
            KeyWait, Shift
            inBattle:=1
        }
    Return

    +Tab::
        Send, {Shift Down}{Tab Down}
        Sleep, 100
        Send, {Shift Up}{Tab Up}
        consoleMode:=consoleMode=1?0:1
    Return

    1::
    If (gameUI!=1)
    {
        item:=0
        weapon:=1
        inBattle:=1
        Send, {1}
    }
    Return

    2::
    If (gameUI!=1)
    {
        send, {RButton Up}
        rDown:=0
        item:=0
        weapon:=2
        inBattle:=1
        Send, {2}
    }
    Return

    3::
        If (gameUI!=1)
            item:=1
        normalButton("3")
    Return

    4::
        If (gameUI!=1)
            item:=1
        normalButton("4")
    Return

    5::
        If (gameUI!=1)
            item:=1
        normalButton("5")
    Return

    LButton::
    If (inBattle=1) && (weapon=1) && (gameUI=0) && (item=0)
    {
        send, {LButton}
        sleep,150
        lButton:=GetKeyState("LButton" , "P")
        If (lButton=1)
        {
            send, {RButton Up}
            rDown:=0
            Loop,
            {
                send, {LButton}
                Random, clickIntervals , 100, 150
                sleep, %clickIntervals%
                lButton:=GetKeyState("LButton" , "P")
            }Until lButton=0
        }

        Send, {RButton Down}
        rDown:=1
    }
    Else
    If (inBattle=1) && (weapon=2) && (gameUI=0) && (item=0)
    {
        SetTimer, checkRButton,200
        rButton:=GetKeyState("rButton" , "P")
        If (rButton=0)
        {
            send, {RButton Down}
            rDown:=1
            KeyWait, LButton
            send, {LButton}
            send, {RButton Up}
            rDown:=0
        }
    }
    Else
    If (item=1) && (gameUI=0)
    {
        inBattle:=0
        weapon:=0
        send, {RButton Up}
        rDown:=0
        Send, {LButton Down}
        KeyWait, LButton
        Send, {LButton Up}
        inBattle:=1
        weapon:=preWeapon
        item:=0
    }
    Else
        normalButton("LButton")
    Return

    RButton::
    If (inBattle=1) && (weapon=1) && (gameUI=0) && (item=0)
    {
        Send, {LButton}
        Sleep, 200
        rButton:=GetKeyState("RButton" , "P")
        If (rButton=1)
        {
            Send, {RButton Up}
            rDown:=0
            loop,
            {
            Send, {LButton Down}
            sleep,1500
            Send, {LButton Up}
            sleep,200
            rButton:=GetKeyState("RButton" , "P")
            }Until (rButton=0)
        }
    }
    Else
    If (inBattle=1) && (weapon=2) && (gameUI=0) && (item=0)
    {
        lButton:=GetKeyState("LButton" , "P")
        If (lButton=0)
        {
            send, {RButton Up}
            rDown:=0
            Loop
            {
                Send, {LButton}
                Random, clickIntervals , 47, 50
                sleep, %clickIntervals%
                rButton:=GetKeyState("RButton" , "P")
            } Until rButton=0
        }
        Else
        {
            send, {RButton Up}
            rDown:=0
        }
    }
    Else
    If (item=1) && (gameUI=0)
    {
        inBattle:=0
        weapon:=0
        send, {RButton Up}
        rDown:=0
        Send, {RButton Down}
        KeyWait, RButton
        Send, {RButton Up}
        inBattle:=1
        weapon:=preWeapon
        item:=0
    }
    Else
    {
        normalButton("RButton")
        rDown:=0
    }
    Return

    t::
    If (inputState=1) || (consoleMode=1) 
        normalButton("t")
    Else
    {
        Loop, 
        {
            Send, {t}
            Sleep, 200
            tKeyDown:=GetKeyState("t", "P")
        }Until (tKeyDown=0)
    }
    Return

    p::
    If (inputState=1)
        normalButton("p")
    Else
    {
        If (gameUI=1)
        {
            Send, {Tab Up}
            gameUI:=0
        }
        
        If (gameUI=0) || (gameUI="")
        {
            inBattle:=0
            Send, {Tab Down}{RButton}
            gameUI:=1
            Send, {Tab Up}
        }
    }
    Return

    i::
        If (heroUI=1) || (mapsUI=1) && (itemUI=0)
        {
            Send, {Esc}
            Sleep, 200
            gameUI:=0
        }
        normalButton("i")
        If (inputState!=1)
        {
            gameUI:=gameUI=1?0:1
            itemUI:=itemUI=1?0:1
            heroUI:=0
            mapsUI:=0
        }

    Return

    h::
        If (mapsUI=1) || (itemUI=1) && (heroUI=0)
        {
            Send, {Esc}
            Sleep, 200
            gameUI:=0
        }
        normalButton("h")
        If (inputState!=1)
        {
            itemUI:=0
            heroUI:=heroUI=1?0:1
            mapsUI:=0
        }
    Return

    m::
    If (inputState=1)
        normalButton("m")
    Else
    {
        If (itemUI=1) || (heroUI=1) && (mapsUI=0)
        {
            Send, {Esc}
            Sleep, 200
            gameUI:=0
        }
        Send, {F10}
        Sleep, 100
        Send, {m Down}
        KeyWait, m
        Send, {m Up}
        gameUI:=gameUI=1?0:1
        itemUI:=0
        heroUI:=0
        mapsUI:=mapsUI=1?0:1
    }
    Return

    ~s::
    If (inBattle=1)
    {
        Send, {s Down}{Shift}
        KeyWait, s
        Send, {s Up}
    }
    Else
        normalButton("s")
    Return
#IfWinActive

battleModeCheck:
	If WinActive("ahk_exe vermintide2.exe")
    {
        DllCall("SendMessage", "UInt", (WinActive("ahk_exe vermintide2.exe")), "UInt", "80", "UInt", "1", "UInt", (DllCall("LoadKeyboardLayout", "Str", "00000804", "UInt", "257")))

        PixelGetColor, sightBottomRight, A_ScreenWidth/2/dpiRatio, A_ScreenHeight/2/dpiRatio, RGB Slow
        StartingPos=3
        Loop, 3
        {
            sightBottomRight%A_Index%:= SubStr(sightBottomRight, StartingPos, 2)
            sightBottomRight%A_Index%:=Format("{1:u}", "0x" . sightBottomRight%A_Index%)
            StartingPos:=StartingPos+2
        }
        sightBottomRightLight:=Round(sightBottomRight1*0.30+sightBottomRight2*0.59+sightBottomRight3*0.11, 0)
        

        If (sightBottomRightLight>165) && (item=0) && (itemUI=0)
        {
            inBattle:=1
            If (weapon=0)
                weapon:=preWeapon
            voteUI:=0
            gameUI:=0
        }
        Else
        If (sightBottomRightLight<15)
        {
            voteUI:=1
            inBattle:=0
        }


        If (sightBottomRight=0)
        {
            inBattle:=0
            weapon:=1
            item:=0
            gameUI:=0
            itemUI:=0
            heroUI:=0
            mapsUI:=0
        }
        If (inBattle=1) && (weapon=1)
        {
            lButton:=GetKeyState("LButton" , "P")
            rButton:=GetKeyState("RButton" , "P")
            shiftKeyDown:=GetKeyState("Shift" , "P")
            forwardKeyDown:=GetKeyState("w" , "P")
            skillKeyDown:=GetKeyState(skillKey , "P")
            If (lButton=0) && (rButton=0) && (shiftKeyDown=0) && (forwardKeyDown=0) && (skillKeyDown=0) && (gameUI=0) && (item!=1)
            {
                Send, {RButton Down}
                rDown:=1
            }
        }

        If (inputState=0) && (inBattle=1) && (consoleMode=0)
            Send, {t}

        If (inBattle=0)
        {
            ToolTip, Normal mode | %A_Hour%:%A_Min%, A_ScreenWidth, A_ScreenHeight,20
        }
        Else
        {
            ToolTip, %A_Hour%:%A_Min%, A_ScreenWidth, A_ScreenHeight,20
            hwnd := WinExist("ahk_class tooltips_class32")
            WinSet, Trans, 90, % "ahk_id" hwnd
        }
    }

	If !WinActive("ahk_exe vermintide2.exe")
	{
        If (rDown=1)
        {
            Send, {RButton Up}
            rDown:=0
        }
        ToolTip,,,,20
	}

	If WinExist("ChatBoxTitle") && !WinActive("ChatBoxTitle")
	{
		WinActive("ChatBoxTitle")
		Gui Cancel
	}

Return

checkRButton:
    rButton:=GetKeyState("rButton" , "P")
    If (rButton=1)
    {
        SetTimer, checkRButton,Off
        send, {RButton Down}{LButton Down}
        rDown:=1
        KeyWait,LButton
        send, {RButton up}{LButton up}
        rDown:=0
    }
Return

WeaponSwitchKeyEqualsCustom:
    WeaponSwitchKey(switchWeaponKey)
Return

WeaponSwitchKeyEqualsWheelUp:
    WeaponSwitchKey("WheelUp")
Return

WeaponSwitchKeyEqualsWheelDown:
    WeaponSwitchKey("WheelDown")
Return

WeaponSwitchKey(hotkey)
{
    global
    If (inBattle=1) || (item=1)
    {
        item:=0
        If (weapon=1)
        {
            send, {RButton Up}
            rDown:=0
            Send, {2}
            weapon:=2
        }
        else
        {
            Send, {1}
            weapon:=1
        }
    }
    Else
        Send, {%hotkey%}
}

#Include, Handle.ahk