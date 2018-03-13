
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetBatchLines -1
ListLines Off
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

#Include, Initialization.ahk

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

    1::
        weapon=1
        inBattle=1
        Send, {1}
    Return

    2::
        send, {RButton Up}
        rDown=0
        weapon=2
        inBattle=1
        Send, {2}
    Return

    3::
        normalButton("3")
    Return

    4::
        normalButton("4")
    Return

    5::
        normalButton("5")
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
    If (inBattle=1)
		WeaponSwitch()
    Else
        Send, {WheelUp}
    Return

    WheelDown::
    If (inBattle=1)
		WeaponSwitch()
    Else
        Send, {WheelDown}
    Return

    e::
    If (inputState=1)
        normalButton("e")
    Else
    {
    Send, {e Down}
    KeyWait, e
    Send, {e Up}
    send, {t}
    }
    Return

    t::
    If (inputState=1)
        normalButton("e")
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
    normalButton("m")
    Return

    s::
    If (inBattle=1)
    {
        Send, {s Down}{Shift}
        KeyWait, s
        ;SetTimer,Dodge,Off
        Send, {s Up}
    }
    Else
        normalButton("s")
    Return
/*
    a::
    If (inBattle=1)
    {
        Send, {a Down}{Shift}
        dodgekey=a
        SetTimer,Dodge,500
        KeyWait, a
        ;SetTimer,Dodge,Off
        Send, {a Up}
    }
    Else
        normalButton("a")
    Return
    d::
    If (inBattle=1)
    {
        Send, {d Down}{Shift}
        dodgekey=d
        SetTimer,Dodge,500
        KeyWait, d
        ;SetTimer,Dodge,Off
        Send, {d Up}
    }
    Else
        normalButton("d")
    Return
    */
#IfWinActive

battleModeCheck:
	If WinExist("ChatBoxTitle") && !WinActive("ChatBoxTitle")
	{
		WinActive("ChatBoxTitle")
		Gui Cancel
	}

	If WinActive("ahk_exe vermintide2.exe")
    {
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

        If (inputState=0) && (inBattle=1)
            Send, {t}
    }

	If !WinActive("ahk_exe vermintide2.exe") && (rDown=1)
	{
		Send, {RButton Up}
		rDown=0
	}
Return

CustSkill:
    normalButton(skillKey)
    Sleep, 200
	inBattle=1
    weapon:=preWeapon
Return

WeaponSwitch()
{
	global
	If (weapon=1)
	{
		send, {RButton Up}
		rDown=0
		weapon=2
		Send, {2}
	}
	else
	{
		weapon=1
		Send, {1}
		Sleep, 300
		send, {RButton Down}
		rDown=1
	}
}

#Include, Handle.ahk