#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetBatchLines -1
ListLines Off
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#SingleInstance, force
;#NoTrayIcon

Menu, tray, NoStandard
Menu, tray, add, Reload, ReloadScrit
Menu, tray, add, Pause, PauseScrit
Menu, tray, add
Menu, tray, add, Help, Help
Menu, tray, add, Update, UpdateScrit
Menu, tray, add, Exit, ExitScrit

#IfWinActive, ahk_exe vermintide2.exe
    P::
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
      send,{p}
    Return

    f::
        inBattle:=inBattle=1?0:1

        If (inBattle=1)
        {
            weapon=1
            Send, {1}
            Sleep, 500
            send, {RButton Down}
        }

        If (inBattle=0)
        {
            send,{RButton Up}
            send,{f}
        }
        Return

        Esc::
            inBattle=0
            send,{RButton Up}
            send,{Esc}
    Return
    
    Enter::
        inputState:=inputState=0?1:0
        inBattle=0
        send,{RButton Up}
        send,{Enter}
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
    inBattle=0
    send,{RButton Up}
    send,{3}
    Return

    4::
    inBattle=0
    send,{RButton Up}
    send,{4}
    Return

    5::
    inBattle=0
    send,{RButton Up}
    send,{5}
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
            send, {RButton Up}
            send, {LButton}
            Loop,
            {
                send, {LButton}
                Random, clickIntervals , 300, 500
                sleep, %clickIntervals%
                lButton:=GetKeyState("LButton" , "P")
            }Until lButton=0
            send,{RButton Down}
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
            send,{RButton Down}
            Sleep, 200
            rButton:=GetKeyState("RButton" , "P")
            If (rButton=1)
            {
                send,{RButton Up}
                Send, {LButton Down}
                KeyWait, RButton
                Send, {LButton Up}
            }
        }

        If (weapon=2)
        {
            lButton:=GetKeyState("LButton" , "P")
            If (lButton=0)
            {
                Loop
                {
                    send,{LButton}
                    Random, clickIntervals , 300, 500
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
    /*
    a::
    If (inBattle=1)
    {
        send,{a Down}{Shift}
        KeyWait, a
        send,{a Up}
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
        send,{s Down}{Shift}
        KeyWait, s
        send,{s Up}
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
        send,{d Down}{Shift}
        KeyWait, d
        send,{d Up}
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

ReloadScrit:
Reload
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