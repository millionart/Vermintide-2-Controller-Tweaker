
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SetBatchLines -1
ListLines Off
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, force

#Include, Initialization.ahk
ResolutionAdaptation("screenWidth","screenHeight")

Menu, tray, NoStandard
Menu, tray, add, 重置 | Reload, ReloadScrit
Menu, tray, add, 暂停 | Pause, PauseScrit
Menu, tray, add
Menu, tray, add, 帮助 | Help, Help
Menu, tray, add, 更新 | Ver %ver%, UpdateScrit
Menu, tray, add, 退出 | Exit, ExitScrit

Gui, +ToolWindow -Caption +AlwaysOnTop -DPIScale
Gui, Color, %bGColor%
gui, font, s12 cffffff
Gui, Color, ,000000
Gui, Add, Edit, x0 y0 w%chatboxW% h25 vchatBox Limit140
gui, font

SetTimer, battleModeCheck, 200

Return

battleModeCheck:
	If WinExist("ChatBoxTitle") && !WinActive("ChatBoxTitle")
	{
		WinActive("ChatBoxTitle")
		Gui Cancel
	}

	If !WinActive("ahk_exe vermintide2.exe") && (rDown=1)
	{
		Send, {RButton Up}
		rDown=0
	}
Return

#Include, Handle.ahk