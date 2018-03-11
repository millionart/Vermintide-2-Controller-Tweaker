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
Menu, tray, add, 更新 | Ver 0.3, UpdateScrit
Menu, tray, add, 退出 | Exit, ExitScrit


Gui, +ToolWindow -Caption +AlwaysOnTop
Gui, Color, %bGColor%
gui, font, s12 cffffff
Gui, Color, ,000000
Gui, Add, Edit, x0 y0 w%chatboxW% h25 vChatBox Limit140
gui, font

#IfWinActive, ahk_exe vermintide2.exe
    Enter::
        inputState:=inputState=0?1:0
        inBattle=0
        If (inputState=1)
        {
            Send, {Enter}
            Gui, Show, w%chatboxW% h25 x0 y%chatboxY%, %title%
            WinSet, TransColor, %bGColor% %transparency%, %title%
        }
        Else
            normalButton("Enter")
    Return

    Esc::
        normalButton("Esc")
        inputState=0
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
#IfWinActive
Return

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

normalButton(key)
{
    global
    inBattle=0
    weapon=0
    send, {RButton Up}
    Send, {%key%}
}