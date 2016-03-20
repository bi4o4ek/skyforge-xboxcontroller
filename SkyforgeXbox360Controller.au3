#include "_IsPressed360.au3"
HotKeySet('^m', '_Exit')
Global Const $hDll = DllOpen("xinput9_1_0.dll")
Global $iLeftTdown = 0, $iRightTdown = 0
Global $iLeftBdown = 0, $iRightBdown = 0
Global $iAdown = 0, $iBdown = 0, $iXDown = 0, $iYDown = 0
Global $iStartDown = 0, $iBackDown = 0
Global $iLeftJoyDown = 0, $iRightJoyDown = 0
Global $iLeftDown = 0, $iRightDown = 0, $iUpDown = 0, $iDownDown = 0
Global $iRightJoyRightDown = 0, $iRightJoyLeftDown = 0, $iRightJoyDown = 0, $iRightJoyUpDown = 0, $iRightJoyDownDown = 0
Global $iLBraceDown = 0, $iRBraceDown = 0

While 1
    #_MouseUpDown(32768, 'primary', $iLeftTdown, $hDll) ;LT button
    #_MouseUpDown(65536, 'secondary', $iRightTdown, $hDll) ;RT button
    #_KeyUpDown(256, '{LSHIFT down}', $iLeftBdown, $hDll) ;LB pressed
    #If _IsPressed360(256, $hDll) Then Send('{LSHIFT}') ;LB pressed

    _KeyUpDown(512, '{SPACE down}', $iRightBdown, $hDll) ;RB pressed

    _KeyUpDown(16384, '{1 down}', $iXDown, $hDll) ;X pressed
    _KeyUpDown(-32768, '{2 down}', $iYDown, $hDll) ;Y pressed
    _KeyUpDown(4096, '{3 down}', $iADown, $hDll) ;A pressed
    _KeyUpDown(8192, '{4 down}', $iBDown, $hDll) ;B pressed

    _KeyUpDown(1, '{e down}', $iUpDown, $hDll) ;D-Pad Up button
    _KeyUpDown(2, '{x down}', $iDownDown, $hDll) ;D-Pad Down button
    _KeyUpDown(4, '{z down}', $iLeftDown, $hDll) ;D-Pad Left button
    _KeyUpDown(8, '{c down}', $iRightDown, $hDll) ;D-Pad Right button

    _KeyUpDown(16, '{r down}', $iStartDown, $hDll) ;Start button
    _KeyUpDown(32, '{ESC down}', $iBackDown, $hDll) ;Back button

    _KeyUpDown(128, '{v down}', $iRightJoyDown, $hDll) ;RightJoyStickt button
    _KeyUpDown(64, '{f down}', $iLeftJoyDown, $hDll) ;LeftJoyStick button

    If _IsPressed360(256, $hDll) And _IsPressed360(131072, $hDll)  And @extended < 0 Then Send('+a') ;LB and LS-left pressed
    If _IsPressed360(256, $hDll) And _IsPressed360(131072, $hDll)  And @extended > 0 Then Send('+d') ;LB and LS-right pressed
    If _IsPressed360(256, $hDll) And _IsPressed360(262144, $hDll)  And @extended < 0 Then Send('+s') ;LB and LS-down pressed
    If _IsPressed360(256, $hDll) And _IsPressed360(262144, $hDll)  And @extended > 0 Then Send('+w') ;LB and LS-up pressed

    _KeyUpDown(32768, '{[ down}', $iLBraceDown, $hDll) ;Left brace button
    _KeyUpDown(65536, '{] down}', $iRBraceDown, $hDll) ;Right brace button

    Sleep(10)
WEnd

Func _MouseUpDown($iKey360, $sPressKey, ByRef $iVar, $vDll = "xinput9_1_0.dll")
    If _IsPressed360($iKey360, $vDll) And $iVar = 0 Then
        MouseDown($sPressKey)
        $iVar = 1
    ElseIf Not _IsPressed360($iKey360, $vDll) And $iVar = 1 Then
        MouseUp($sPressKey)
        $iVar = 0
    EndIf
EndFunc   ;==>_MouseUpDown

Func _KeyUpDown($iKey360, $sPressKey, ByRef $iVar, $vDll = "xinput9_1_0.dll")
    If _IsPressed360($iKey360, $vDll) And $iVar = 0 Then
        Send($sPressKey)
        $iVar = 1
    ElseIf Not _IsPressed360($iKey360, $vDll) And $iVar = 1 Then
        Send(StringRegExpReplace($sPressKey, '(\ down\})', ' up}'))
        $iVar = 0
    EndIf
EndFunc   ;==>_KeyUpDown

Func _Exit()
    DllClose($hDll)
    Exit
EndFunc   ;==>_Exit

