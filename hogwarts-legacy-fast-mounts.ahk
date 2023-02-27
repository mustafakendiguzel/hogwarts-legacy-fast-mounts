#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
SendMode Input
SetKeyDelay, 100


#IFWinActive, ahk_exe HogwartsLegacy.exe

LoadSettings(_SourcePath = "settings.ini", _ValueDelim = "=", _VarPrefixDelim = "_")
{
  Global
  if !FileExist(_SourcePath){
    MsgBox, 16, % "Error", % "The file " . _SourcePath . " does not esxist"
  } else {    
    Local FileContent, CurrentPrefix, CurrentVarName, CurrentVarContent, DelimPos
    FileRead, FileContent, %_SourcePath%
    If ErrorLevel = 0
    {
      Loop, Parse, FileContent, `n, `r%A_Tab%%A_Space%
      {
        If A_LoopField Is Not Space
        {
          If (SubStr(A_LoopField, 1, 1) = "[")
          {
            RegExMatch(A_LoopField, "\[(.*)\]", ini_Section)
            CurrentPrefix := ini_Section1
          }
          Else
          {
            DelimPos := InStr(A_LoopField, _ValueDelim)
            CurrentVarName := SubStr(A_LoopField, 1, DelimPos - 1)
            CurrentVarContent := SubStr(A_LoopField, DelimPos + 1)
            %CurrentPrefix%%_VarPrefixDelim%%CurrentVarName% = %CurrentVarContent%
          }
          
        }
      }
    }
  }
}
LoadSettings()

HotKey, %TransportVehicles_MagicStick%, MagicStickHandler
HotKey, %TransportVehicles_Hippogriff%, HippogriffHandler
HotKey, %TransportVehicles_Graphorns%, GraphornsHandler


MagicStickHandler:
{
  Send "{Tab Down}{3 up}" ;hold a
  Sleep 300 ;10 seconds
  Send "{3 down}{Tab up}"
}

HippogriffHandler:
{
  Send "{Tab Down}{2 up}" ;hold a
  Sleep 300 ;10 seconds
  Send "{2 down}{Tab up}"
}

GraphornsHandler:
{
  Send "{Tab Down}{1 up}" ;hold a
  Sleep 300 ;10 seconds
  Send "{1 down}{Tab up}"
}
