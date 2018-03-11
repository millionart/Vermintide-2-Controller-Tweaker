#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetBatchLines -1
ListLines Off
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force
;#NoTrayIcon
inBattle=0
inputState=0
bGColor=FF00FF
transparency=200
title=ChatBoxTitle
chatboxY:=A_ScreenHeight*0.89
chatboxW:=A_ScreenWidth/A_ScreenDPI*16

Menu, tray, NoStandard
Menu, tray, add, 重置 | Reload, ReloadScrit
Menu, tray, add, 暂停 | Pause, PauseScrit
Menu, tray, add
Menu, tray, add, 帮助 | Help, Help
Menu, tray, add, 更新 | Ver 0.1, UpdateScrit
Menu, tray, add, 退出 | Exit, ExitScrit


Gui, +ToolWindow -Caption +AlwaysOnTop
Gui, Color, %bGColor%
gui, font, s12 cffffff
Gui, Color, ,000000
Gui, Add, Edit, x0 y0 w%chatboxW% h25 vChatBox Limit140
gui, font



#IfWinActive, ahk_exe vermintide2.exe
    SetTimer, autoBlock, 500

    Enter::
        inputState:=inputState=0?1:0

        If (inputState=1)
        {
            Send, {Enter}
            Gui, Show, w%chatboxW% h25 x0 y%chatboxY%, %title%
            WinSet, TransColor, %bGColor% %transparency%, %title%
        }
        Else
            normalButton("Enter")
    Return


    f::
        inBattle:=inBattle=1?0:1

        If (inBattle=1)
        {
            Send, {1}
            weapon=1
            Sleep, 200
            send, {RButton Down}
        }

        If (inBattle=0)
            normalButton("f")
    Return

    Esc::
        normalButton("Esc")
        inputState=0
    Return
    
    1::
        weapon=1
        Send, {1}
    Return

    2::
        weapon=2
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
            KeyWait,LButton
            send, {RButton up}{LButton up}
        }
    Return

    LButton::
    If (inBattle=1)
    {
        If (weapon=1)
        {
            send, {LButton}
            sleep,150
            lButton:=GetKeyState("LButton" , "P")
            If (lButton=1)
            {
                send, {RButton Up}
                Loop,
                {
                    send, {LButton}
                    Random, clickIntervals , 100, 300
                    sleep, %clickIntervals%
                    lButton:=GetKeyState("LButton" , "P")
                }Until lButton=0
            }

            Send, {RButton Down}
        }

        If (weapon=2)
        {
            SetTimer, checkRButton,200
            rButton:=GetKeyState("rButton" , "P")
            If (rButton=0)
            {
                send, {RButton Down}
                KeyWait, LButton
                send, {LButton}
                send, {RButton Up}
            }
        }
    }
    Else
    {
        Send, {LButton Down}
        KeyWait, LButton
        Send, {LButton Up}
    }
    Return

    RButton::
    If (inBattle=1)
    {
        If (weapon=1)
        {
            Send, {LButton}
            Sleep, 200
            rButton:=GetKeyState("RButton" , "P")
            If (rButton=1)
            {
                Send, {RButton Up}
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

        If (weapon=2)
        {
            lButton:=GetKeyState("LButton" , "P")
            If (lButton=0)
            {
                Loop
                {
                    Send, {LButton}
                    Random, clickIntervals , 100, 300
                    sleep, %clickIntervals%
                    rButton:=GetKeyState("RButton" , "P")
                }Until rButton=0
            }
            Else
                send, {RButton Up}
        }

    }
    Else
    {
        Send, {RButton Down}
        KeyWait, RButton
        Send, {RButton Up}
    }
    Return

    WheelUp::
    If (inBattle=1)
    {

        If (weapon=1)
        {
            send, {RButton Up}
            weapon=2
            Send, {2}
        }
        else
        {
            weapon=1
            Send, {1}
            Sleep, 500
            send, {RButton Down}
        }
    }
    Else
        Send, {WheelUp}
    Return

    WheelDown::
    If (inBattle=1)
    {

        If (weapon=1)
        {
            send, {RButton Up}
            weapon=2
            Send, {2}
        }
        else
        {
            weapon=1
            Send, {1}
            Sleep, 500
            send, {RButton Down}
        }
    }
    Else
        Send, {WheelDown}
    Return

    p::
    If (inputState!=1)
    {
        If (tabUI=1)
        {
            Send, {Tab Up}
            tabUI=0
        }
        else (tabUI=0)
        {
            inBattle=0
            Send, {Tab Down}
            Sleep, 500
            send, {RButton}
            tabUI=1
        }
    }
    Else
        Send, {p}
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

    /*
    a::
    If (inBattle=1)
    {
        Send, {a Down}{Shift}
        KeyWait, a
        Send, {a Up}
    }
    Else
    {
        Send, {a Down}
        KeyWait, a
        Send, {a Up}
    }

    s::
    If (inBattle=1)
    {
        Send, {s Down}{Shift}
        KeyWait, s
        Send, {s Up}
    }
    Else
    {
        Send, {s Down}
        KeyWait, s
        Send, {s Up}
    }

    d::
    If (inBattle=1)
    {
        Send, {d Down}{Shift}
        KeyWait, d
        Send, {d Up}
    }
    Else
    {
        Send, {d Down}
        KeyWait, d
        Send, {d Up}
    }
*/
    Return
#IfWinActive

#IfWinActive, ChatBoxTitle
    Enter::
    Gui Submit
    ;Gui, Show, Hide
    WinActive("ahk_exe vermintide2.exe")
    WinWaitActive, ahk_exe vermintide2.exe
    If (ChatBox!="")
    {
        Send, %ChatBox%
        Sleep, 100
    }
    Send, {Enter}
    GuiControl, Text, ChatBox,
    inputState=0
    Return

    Esc::
    Gui Cancel
    WinActive("ahk_exe vermintide2.exe")
    WinWaitActive, ahk_exe vermintide2.exe

    Send, {Enter}
    ;GuiControl, Text, ChatBox,
    inputState=0
    Return
#IfWinActive

normalButton(key)
{
    inBattle=0
    send, {RButton Up}
    Send, {%key%}
}

ReloadScrit:
Reload
Return

autoBlock:
If (inBattle=1) && (weapon=1)
{
    lButton:=GetKeyState("LButton" , "P")
    rButton:=GetKeyState("RButton" , "P")
    If (lButton=0) && (rButton=0)
        Send, {RButton Down}
}
Return

PauseScrit:
Pause, Toggle, 1
Return

UpdateScrit:
Run, https://github.com/millionart/Vermintide-2-Controller-Tweaker/releases
Return

Help:
Run, https://github.com/millionart/Vermintide-2-Controller-Tweaker
Return

ExitScrit:
ExitApp
Return