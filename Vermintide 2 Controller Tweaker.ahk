
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetBatchLines -1
ListLines Off
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

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

SetTimer, battleModeCheck, 200

Hotkey, IfWinActive, ahk_exe vermintide2.exe
	Hotkey, %skillKey%, CustSkill
Hotkey, IfWinActive

Return

#IfWinActive, ahk_exe vermintide2.exe
    ~Shift::
        forwardKeyDown:=GetKeyState("w" , "P")
        If (forwardKeyDown=1)
        {
            Send, {RButton Up}
            rDown=0
            ;inBattle=0
            KeyWait, Shift
            inBattle=1
        }
    Return

    +Tab::
        Send, {Shift Down}{Tab Down}
        Sleep, 100
        Send, {Shift Up}{Tab Up}
        consoleMode:=consoleMode=1?0:1
    Return

    1::
        item=0
        weapon=1
        inBattle=1
        Send, {1}
    Return

    2::
        send, {RButton Up}
        rDown=0
        item=0
        weapon=2
        inBattle=1
        Send, {2}
    Return

    3::
        item=1
        normalButton("3")
    Return

    4::
        item=1
        normalButton("4")
    Return

    5::
        item=1
        normalButton("5")
    Return

    LButton::
    If (inBattle=1) && (weapon=1)
    {
        send, {LButton}
        sleep,150
        lButton:=GetKeyState("LButton" , "P")
        If (lButton=1)
        {
            send, {RButton Up}
            rDown=0
            Loop,
            {
                send, {LButton}
                Random, clickIntervals , 100, 150
                sleep, %clickIntervals%
                lButton:=GetKeyState("LButton" , "P")
            }Until lButton=0
        }

        Send, {RButton Down}
        rDown=1
    }
    Else
    If (inBattle=1) && (weapon=2)
    {
        SetTimer, checkRButton,200
        rButton:=GetKeyState("rButton" , "P")
        If (rButton=0)
        {
            send, {RButton Down}
            rDown=1
            KeyWait, LButton
            send, {LButton}
            send, {RButton Up}
            rDown=0
        }
    }
    Else
        normalButton("LButton")
    Return

    RButton::
    If (inBattle=1) && (weapon=1)
    {
        Send, {LButton}
        Sleep, 200
        rButton:=GetKeyState("RButton" , "P")
        If (rButton=1)
        {
            Send, {RButton Up}
            rDown=0
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
    If (inBattle=1) && (weapon=2)
    {
        lButton:=GetKeyState("LButton" , "P")
        If (lButton=0)
        {
            Loop
            {
                Send, {LButton}
                Random, clickIntervals , 100, 150
                sleep, %clickIntervals%
                rButton:=GetKeyState("RButton" , "P")
            }Until rButton=0
        }
        Else
        {
            send, {RButton Up}
            rDown=0
        }
    }
    Else
    {
        normalButton("RButton")
        rDown=0
    }
    Return

    WheelUp::
    If (inBattle=1) || (item=1)
		WeaponSwitch()
    Else
        Send, {WheelUp}
    Return

    WheelDown::
    If (inBattle=1) || (item=1)
		WeaponSwitch()
    Else
        Send, {WheelDown}
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
        If (tabUI=1)
        {
            Send, {Tab Up}
            tabUI=0
        }
        
        If (tabUI=0) || (tabUI="")
        {
            inBattle=0
            Send, {Tab Down}{RButton}
            tabUI=1
        }
    }
    Return

    i::
    normalButton("i")
    Return

    h::
    normalButton("h")
    Return

    m::
    If (inBattle=1)
    {
        Send, {F10}
        Sleep, 100
        Send, {m Down}
        KeyWait, m
        Send, {m Up}
    }
    Else
        normalButton("m")
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

        PixelGetColor, sightTopLeft, A_ScreenWidth/2/dpiRatio, A_ScreenHeight/2/dpiRatio, RGB Slow
        StartingPos=3
        Loop, 3
        {
            sightTopLeft%A_Index%:= SubStr(sightTopLeft, StartingPos, 2)
            sightTopLeft%A_Index%:=Format("{1:u}", "0x" . sightTopLeft%A_Index%)
            StartingPos:=StartingPos+2
        }
        sightTopLeftLight:=Round(sightTopLeft1*0.30+sightTopLeft2*0.59+sightTopLeft3*0.11, 0)
        

        If (sightTopLeftLight>165) && (item=0)
        {
            inBattle=1
            If (weapon=0)
                weapon:=preWeapon
        }
        
        If (sightTopLeft=0)
        {
            inBattle=0
            weapon=1
        }

        If (inBattle=1) && (weapon=1)
        {
            lButton:=GetKeyState("LButton" , "P")
            rButton:=GetKeyState("RButton" , "P")
            shiftKeyDown:=GetKeyState("Shift" , "P")
            forwardKeyDown:=GetKeyState("w" , "P")
            If (lButton=0) && (rButton=0) && (shiftKeyDown=0) && (forwardKeyDown=0)
            {
                Send, {RButton Down}
                rDown=1
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
        ;ToolTip,%sightTopLeftLight% %screenCenterX% %screenCenterY% %A_ScreenWidth% %A_ScreenHeight%, 0, 0, 1
    }

	If !WinActive("ahk_exe vermintide2.exe")
	{
        If (rDown=1)
        {
            Send, {RButton Up}
            rDown=0
        }
        ToolTip,,,,20
	}

	If WinExist("ChatBoxTitle") && !WinActive("ChatBoxTitle")
	{
		WinActive("ChatBoxTitle")
		Gui Cancel
	}

Return

CustSkill:
    normalButton(skillKey)
	inBattle=1
    weapon:=preWeapon
Return

checkRButton:
    rButton:=GetKeyState("rButton" , "P")
    If (rButton=1)
    {
        SetTimer, checkRButton,Off
        send, {RButton Down}{LButton Down}
        rDown=1
        KeyWait,LButton
        send, {RButton up}{LButton up}
        rDown=0
    }
Return

WeaponSwitch()
{
	global
    item=0
	If (weapon=1)
	{
		send, {RButton Up}
		rDown=0
		Send, {2}
		weapon=2
	}
	else
	{
		Send, {1}
		weapon=1
	}
}

#Include, Handle.ahk