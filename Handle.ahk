
#IfWinActive, ahk_exe vermintide2.exe
    Enter::
        inputState:=inputState=1?0:1
        inBattle=0
        Send, {Enter}
        If (inputState=1)
        {
            Gui, Show, w%chatBoxW% h25 x0 y%chatBoxY%, %title%
            WinSet, TransColor, %bGColor% %transparency%, %title%
        }
    Return

    Esc::
        normalButton("Esc")
        inputState=0
    Return

    f1::
    FastWord("f1","救救我_(:з」/_")
    Return

    f2::
    FastWord("f2","233")
    Return

    f3::
    FastWord("f3","谢谢 (*^з^*)")
    Return

    f4::
    FastWord("f4","你们看我屌吗-_,-")
    Return

    f5::
    FastWord("f5","膨胀了膨胀了，快回来")
    Return

    f6::
    FastWord("f6","老哥666")
    Return

    f11::
        normalButton("f2")
        inputState=1
    Return
#IfWinActive

#IfWinActive, ChatBoxTitle
    Enter::
    Gui Submit
    ;Gui, Show, Hide
    WinWaitActive, ahk_exe vermintide2.exe

    If (chatBox!="")
    {
        ReplaceMissingText("chatBox")
        chatBoxLength:= StrLen(chatBox)
        chatBoxCutOff:=chatBoxLength/chatboxMaxLength
        If (chatBoxCutOff>1)
        {
            chatBoxCutOff:= Ceil(chatBoxCutOff)
            
            chatBoxStartPos=1
            Loop, %chatBoxCutOff%
            {
                chatBox%A_Index%:= SubStr(chatBox, chatBoxStartPos, chatboxMaxLength)
                chatBoxStartPos:=chatBoxStartPos+chatboxMaxLength
                chatText=% chatBox%A_Index%
                WinWaitActive, ahk_exe vermintide2.exe
                Send, {Text}%chatText%
                Sleep, 50
                Send, {Enter}
                If (A_Index<chatBoxCutOff)
                {
                    Sleep, 50
                    Send, {Enter}
                }
            }
        }
        Else
        {
            Send, {Text}%chatBox%
            Sleep, 50
            Send, {Enter}
        }
    }
    Else
        Send, {Enter}
    GuiControl, Text, chatBox,
    inputState=0
    Return

    Esc::
        Gui Cancel
        WinWaitActive, ahk_exe vermintide2.exe

        Send, {Enter}
        ;GuiControl, Text, chatBox,
        inputState=0
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

normalButton(key)
{
    global
    inBattle=0
    preWeapon:=weapon
    weapon=0
    send, {RButton Up}
    rDown=0
    Send, {%key% Down}
    KeyWait, %key%
    Send, {%key% Up}
}

ReplaceMissingText(vName)
{
	%vName%:=StrReplace(%vName%, "," , "`,")
	%vName%:=StrReplace(%vName%, ";" , "`;")
    %vName%:=StrReplace(%vName%, "霞" , "xiá")
    %vName%:=StrReplace(%vName%, "贤" , "xián")
    %vName%:=StrReplace(%vName%, "腼" , "勉")
    %vName%:=StrReplace(%vName%, "棉" , "绵")
    %vName%:=StrReplace(%vName%, "腆" , "填")
	%vName%:=StrReplace(%vName%, "屌" , "吊")
}

FastWord(keyName,String)
{
	global fastWordStr
    if (A_PriorHotkey <> keyName or A_TimeSincePriorHotkey > 1000)
    {
		fastWordStr=%String%
		ReplaceMissingText("fastWordStr")
        Send, {Enter}
        Sleep, 100
        Send, {Text}%fastWordStr%
        Sleep, 100
        Send, {Enter}
    }
}

