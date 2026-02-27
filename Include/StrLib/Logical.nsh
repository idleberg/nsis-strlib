; ---------------------
;  StrLib\Logical.nsh
; ---------------------
;
; The MIT License - Feel free to use, modify, and distribute this code.
; Copyright (c) 2026 Jan T: Sott
; https://github.com/idleberg/nsis-strlib
;
; LogicLib extensions for string prefix, suffix and substring tests.
;
; Usage:
;
;   All standard LogicLib flow operators work automatically:
;     If, IfNot, Unless, ElseIf, ElseIfNot, ElseUnless,
;     AndIf, AndIfNot, OrIf, OrIfNot, etc.
;
;   Case-insensitive tests:
;
;     ${If} $Haystack ${StartsWith} $Needle
;       DetailPrint "Haystack starts with Needle"
;     ${EndIf}
;
;     ${IfNot} $FileName ${EndsWith} ".tmp"
;       DetailPrint "Not a temp file"
;     ${EndIf}
;
;     ${If} $Path ${Contains} "temp"
;       DetailPrint "Path contains temp"
;     ${ElseIf} $Path ${Contains} "cache"
;       DetailPrint "Path contains cache"
;     ${EndIf}
;
;   Case-sensitive tests (S suffix, like StrCmpS):
;
;     ${If} $Haystack ${StartsWithS} "HTTP"
;     ${If} $FileName ${EndsWithS} ".DLL"
;     ${If} $Path ${ContainsS} "Temp"

!include "LogicLib.nsh"

!ifndef STRLIB_TESTS_INCLUDED
  !define STRLIB_TESTS_INCLUDED

  ; --- StartsWith (case-insensitive) ---

  !macro _StartsWith _a _b _t _f
    !insertmacro _LOGICLIB_TEMP
    StrLen $_LOGICLIB_TEMP `${_b}`
    StrCpy $_LOGICLIB_TEMP `${_a}` $_LOGICLIB_TEMP
    StrCmp $_LOGICLIB_TEMP `${_b}` `${_t}` `${_f}`
  !macroend
  !define StartsWith `StartsWith`

  ; --- StartsWith (case-sensitive) ---

  !macro _StartsWithS _a _b _t _f
    !insertmacro _LOGICLIB_TEMP
    StrLen $_LOGICLIB_TEMP `${_b}`
    StrCpy $_LOGICLIB_TEMP `${_a}` $_LOGICLIB_TEMP
    StrCmpS $_LOGICLIB_TEMP `${_b}` `${_t}` `${_f}`
  !macroend
  !define StartsWithS `StartsWithS`

  ; --- EndsWith (case-insensitive) ---

  !macro _EndsWith _a _b _t _f
    !insertmacro _LOGICLIB_TEMP
    StrLen $_LOGICLIB_TEMP `${_b}`
    IntOp $_LOGICLIB_TEMP 0 - $_LOGICLIB_TEMP
    StrCpy $_LOGICLIB_TEMP `${_a}` "" $_LOGICLIB_TEMP
    StrCmp $_LOGICLIB_TEMP `${_b}` `${_t}` `${_f}`
  !macroend
  !define EndsWith `EndsWith`

  ; --- EndsWith (case-sensitive) ---

  !macro _EndsWithS _a _b _t _f
    !insertmacro _LOGICLIB_TEMP
    StrLen $_LOGICLIB_TEMP `${_b}`
    IntOp $_LOGICLIB_TEMP 0 - $_LOGICLIB_TEMP
    StrCpy $_LOGICLIB_TEMP `${_a}` "" $_LOGICLIB_TEMP
    StrCmpS $_LOGICLIB_TEMP `${_b}` `${_t}` `${_f}`
  !macroend
  !define EndsWithS `EndsWithS`

  ; --- Contains (case-insensitive) ---
  ; Note: Internally saves and restores $0 and $1 via the stack.

  !macro _Contains _a _b _t _f
    !insertmacro _LOGICLIB_TEMP
    Push $0
    Push $1
    StrCpy $0 `${_a}`
    StrLen $1 `${_b}`
    _LogicLib_ContainsLoop_${LOGICLIB_COUNTER}:
      StrCpy $_LOGICLIB_TEMP $0 $1
      StrCmp $_LOGICLIB_TEMP `${_b}` _LogicLib_ContainsF_${LOGICLIB_COUNTER}
      StrCmp $_LOGICLIB_TEMP "" _LogicLib_ContainsNF_${LOGICLIB_COUNTER}
      StrCpy $0 $0 "" 1
      Goto _LogicLib_ContainsLoop_${LOGICLIB_COUNTER}
    _LogicLib_ContainsF_${LOGICLIB_COUNTER}:
      StrCpy $_LOGICLIB_TEMP 1
      Goto _LogicLib_ContainsD_${LOGICLIB_COUNTER}
    _LogicLib_ContainsNF_${LOGICLIB_COUNTER}:
      StrCpy $_LOGICLIB_TEMP 0
    _LogicLib_ContainsD_${LOGICLIB_COUNTER}:
      Pop $1
      Pop $0
      !insertmacro _IncreaseCounter
      IntCmp $_LOGICLIB_TEMP 1 `${_t}` `${_f}` `${_f}`
  !macroend
  !define Contains `Contains`

  ; --- Contains (case-sensitive) ---
  ; Note: Internally saves and restores $0 and $1 via the stack.

  !macro _ContainsS _a _b _t _f
    !insertmacro _LOGICLIB_TEMP
    Push $0
    Push $1
    StrCpy $0 `${_a}`
    StrLen $1 `${_b}`
    _LogicLib_ContainsSLoop_${LOGICLIB_COUNTER}:
      StrCpy $_LOGICLIB_TEMP $0 $1
      StrCmpS $_LOGICLIB_TEMP `${_b}` _LogicLib_ContainsSF_${LOGICLIB_COUNTER}
      StrCmp $_LOGICLIB_TEMP "" _LogicLib_ContainsSNF_${LOGICLIB_COUNTER}
      StrCpy $0 $0 "" 1
      Goto _LogicLib_ContainsSLoop_${LOGICLIB_COUNTER}
    _LogicLib_ContainsSF_${LOGICLIB_COUNTER}:
      StrCpy $_LOGICLIB_TEMP 1
      Goto _LogicLib_ContainsSD_${LOGICLIB_COUNTER}
    _LogicLib_ContainsSNF_${LOGICLIB_COUNTER}:
      StrCpy $_LOGICLIB_TEMP 0
    _LogicLib_ContainsSD_${LOGICLIB_COUNTER}:
      Pop $1
      Pop $0
      !insertmacro _IncreaseCounter
      IntCmp $_LOGICLIB_TEMP 1 `${_t}` `${_f}` `${_f}`
  !macroend
  !define ContainsS `ContainsS`

!endif ; STRLIB_TESTS_INCLUDED
