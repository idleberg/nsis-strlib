; ---------------------
;  StrLib\Logical.nsh
; ---------------------
;
; The MIT License - Feel free to use, modify, and distribute this code.
; Copyright (c) 2026 Jan T. Sott
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
;
;   Case checks (unary conditions):
;
;     ${If} ${IsLowerCase} $String
;     ${If} ${IsUpperCase} $String

!include "LogicLib.nsh"

!ifndef STRLIB_LOGICAL_INCLUDED
  !define STRLIB_LOGICAL_INCLUDED

  ; LogicLib (NSIS 3.12+) has "sherlocked" these operators; only define them on
  ; older NSIS where they are missing.
  !ifndef StartsWith

    ; --- StartsWith ---

    !macro _StrLib_StartsWith _op _a _b _t _f
      !insertmacro _LOGICLIB_TEMP
      StrLen $_LOGICLIB_TEMP `${_b}`
      StrCpy $_LOGICLIB_TEMP `${_a}` $_LOGICLIB_TEMP
      ${_op} $_LOGICLIB_TEMP `${_b}` `${_t}` `${_f}`
    !macroend
    !define StartsWith  `"StrLib_StartsWith StrCmp"`
    !define StartsWithS `"StrLib_StartsWith StrCmpS"`

    ; --- EndsWith ---

    !macro _StrLib_EndsWith _op _a _b _t _f
      !insertmacro _LOGICLIB_TEMP
      StrLen $_LOGICLIB_TEMP `${_b}`
      IntOp $_LOGICLIB_TEMP 0 - $_LOGICLIB_TEMP
      StrCpy $_LOGICLIB_TEMP `${_a}` "" $_LOGICLIB_TEMP
      ${_op} $_LOGICLIB_TEMP `${_b}` `${_t}` `${_f}`
    !macroend
    !define EndsWith  `"StrLib_EndsWith StrCmp"`
    !define EndsWithS `"StrLib_EndsWith StrCmpS"`

    ; --- Contains ---
    ; Note: Internally saves and restores $0 and $1 via the stack.

    !macro _StrLib_Contains _op _a _b _t _f
      !insertmacro _LOGICLIB_TEMP
      Push $0
      Push $1
      StrCpy $0 `${_a}`
      StrLen $1 `${_b}`
      _StrLib_ContainsLoop_${LOGICLIB_COUNTER}:
        StrCpy $_LOGICLIB_TEMP $0 $1
        ${_op} $_LOGICLIB_TEMP `${_b}` _StrLib_ContainsF_${LOGICLIB_COUNTER}
        StrCmp $_LOGICLIB_TEMP "" _StrLib_ContainsNF_${LOGICLIB_COUNTER}
        StrCpy $0 $0 "" 1
        Goto _StrLib_ContainsLoop_${LOGICLIB_COUNTER}
      _StrLib_ContainsF_${LOGICLIB_COUNTER}:
        StrCpy $_LOGICLIB_TEMP 1
        Goto _StrLib_ContainsD_${LOGICLIB_COUNTER}
      _StrLib_ContainsNF_${LOGICLIB_COUNTER}:
        StrCpy $_LOGICLIB_TEMP 0
      _StrLib_ContainsD_${LOGICLIB_COUNTER}:
        Pop $1
        Pop $0
        !insertmacro _IncreaseCounter
        IntCmp $_LOGICLIB_TEMP 1 `${_t}` `${_f}` `${_f}`
    !macroend
    !define Contains  `"StrLib_Contains StrCmp"`
    !define ContainsS `"StrLib_Contains StrCmpS"`

    ; --- IsLowerCase / IsUpperCase ---
    ; Note: Internally saves and restores $0 via the stack.

    !macro _StrLib_IsCase _func _a _b _t _f
      !insertmacro _LOGICLIB_TEMP
      Push $0
      StrCpy $0 `${_b}`
      System::Call "User32::${_func}(t r0 r0)i"
      StrCmpS $0 `${_b}` _StrLib_IsCaseY_${LOGICLIB_COUNTER}
      StrCpy $_LOGICLIB_TEMP 0
      Goto _StrLib_IsCaseD_${LOGICLIB_COUNTER}
      _StrLib_IsCaseY_${LOGICLIB_COUNTER}:
        StrCpy $_LOGICLIB_TEMP 1
      _StrLib_IsCaseD_${LOGICLIB_COUNTER}:
        Pop $0
        !insertmacro _IncreaseCounter
        IntCmp $_LOGICLIB_TEMP 1 `${_t}` `${_f}` `${_f}`
    !macroend
    !define IsLowerCase `"" "StrLib_IsCase CharLower"`
    !define IsUpperCase `"" "StrLib_IsCase CharUpper"`

  !endif ; StartsWith
!endif ; STRLIB_LOGICAL_INCLUDED
