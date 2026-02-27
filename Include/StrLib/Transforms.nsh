; ----------------------
;  StrLib\Transforms.nsh
; ----------------------
;
; String transformation macros for NSIS.
;
; Usage:
;   ${Trim}           "  hello  "        $R0   ; "hello"
;   ${TrimLeft}       "  hello  "        $R0   ; "hello  "
;   ${TrimRight}      "  hello  "        $R0   ; "  hello"
;   ${PadLeft}        "hi" 5 "0"         $R0   ; "000hi"
;   ${PadRight}       "hi" 5 "."         $R0   ; "hi..."
;   ${Reverse}        "Hello"            $R0   ; "olleH"
;   ${ToLowerCase}    "Hello World"      $R0   ; "hello world"
;   ${ToUpperCase}    "Hello World"      $R0   ; "HELLO WORLD"
;   ${ToPascalCase}   "hello_world"      $R0   ; "HelloWorld"
;   ${ToCamelCase}    "hello_world"      $R0   ; "helloWorld"
;   ${ToSnakeCase}    "helloWorld"       $R0   ; "hello_world"
;   ${ToConstantCase} "helloWorld"       $R0   ; "HELLO_WORLD"
;   ${ToCapitalCase}  "hello_world"      $R0   ; "Hello World"
;   ${ToKebabCase}    "helloWorld"       $R0   ; "hello-world"
;   ${Slugify}        "Ärger über Öl"    $R0   ; "arger-uber-ol"
;
; All transforms support Unicode Latin characters (ö, é, ø, etc.).
; Slugify transliterates accented characters to ASCII equivalents.

!include "LogicLib.nsh"
!include "Util.nsh"

!ifndef STRLIB_TRANSFORMS_INCLUDED
  !define STRLIB_TRANSFORMS_INCLUDED

  ; ============================================================
  ;  Trim family
  ; ============================================================

  ; --- TrimLeft ---
  ; Removes leading whitespace (space, tab, CR, LF).

  !macro _StrLib_TrimLeft
    Exch $0 ; input
    Push $1 ; length
    Push $2 ; current char

    StrLen $1 $0
    ${If} $1 = 0
      Goto _StrLib_TrimLeft_Done
    ${EndIf}

    _StrLib_TrimLeft_Loop:
      StrCpy $2 $0 1
      ${If}   $2 == " "
      ${OrIf} $2 == "$\t"
      ${OrIf} $2 == "$\r"
      ${OrIf} $2 == "$\n"
        StrCpy $0 $0 "" 1
        StrLen $1 $0
        ${If} $1 > 0
          Goto _StrLib_TrimLeft_Loop
        ${EndIf}
      ${EndIf}

    _StrLib_TrimLeft_Done:
    Pop $2
    Pop $1
    Exch $0
  !macroend

  !macro TrimLeft INPUT OUTPUT
    Push `${INPUT}`
    ${CallArtificialFunction} _StrLib_TrimLeft
    Pop ${OUTPUT}
  !macroend
  !define TrimLeft `!insertmacro TrimLeft`

  ; --- TrimRight ---
  ; Removes trailing whitespace (space, tab, CR, LF).

  !macro _StrLib_TrimRight
    Exch $0 ; input
    Push $1 ; offset (negative)
    Push $2 ; current char

    StrLen $1 $0
    ${If} $1 = 0
      Goto _StrLib_TrimRight_Done
    ${EndIf}

    _StrLib_TrimRight_Loop:
      StrCpy $2 $0 1 -1
      ${If}   $2 == " "
      ${OrIf} $2 == "$\t"
      ${OrIf} $2 == "$\r"
      ${OrIf} $2 == "$\n"
        StrCpy $0 $0 -1
        StrLen $1 $0
        ${If} $1 > 0
          Goto _StrLib_TrimRight_Loop
        ${EndIf}
      ${EndIf}

    _StrLib_TrimRight_Done:
    Pop $2
    Pop $1
    Exch $0
  !macroend

  !macro TrimRight INPUT OUTPUT
    Push `${INPUT}`
    ${CallArtificialFunction} _StrLib_TrimRight
    Pop ${OUTPUT}
  !macroend
  !define TrimRight `!insertmacro TrimRight`

  ; --- Trim ---
  ; Removes leading and trailing whitespace.

  !macro Trim INPUT OUTPUT
    ${TrimLeft} `${INPUT}` ${OUTPUT}
    ${TrimRight} ${OUTPUT} ${OUTPUT}
  !macroend
  !define Trim `!insertmacro Trim`

  ; ============================================================
  ;  Pad family
  ; ============================================================

  ; --- PadLeft ---
  ; Pads the input string on the left to reach TargetLength.
  ; The pad string is repeated as needed and trimmed to fit exactly.
  ; If the input is already >= TargetLength, it is returned unchanged.

  !macro _StrLib_PadLeft
    Exch $2     ; pad string
    Exch 2
    Exch $0     ; input
    Exch
    Exch $1     ; target length
    Push $3     ; current length
    Push $4     ; needed padding
    Push $5     ; pad accumulator

    StrLen $3 $0
    ${If} $3 >= $1
      Goto _StrLib_PadLeft_Done
    ${EndIf}

    ; Guard against empty pad string (would loop forever)
    StrCmp $2 "" _StrLib_PadLeft_Done

    IntOp $4 $1 - $3  ; chars of padding needed
    StrCpy $5 ""

    _StrLib_PadLeft_Loop:
      StrCpy $5 "$5$2"
      StrLen $3 $5
      ${If} $3 < $4
        Goto _StrLib_PadLeft_Loop
      ${EndIf}

    ; Trim to exact length and prepend
    StrCpy $5 $5 $4
    StrCpy $0 "$5$0"

    _StrLib_PadLeft_Done:
    Pop $5
    Pop $4
    Pop $3
    Pop $1
    Exch
    Pop $2
    Exch $0
  !macroend

  !macro PadLeft INPUT TARGET PAD OUTPUT
    Push `${INPUT}`
    Push `${TARGET}`
    Push `${PAD}`
    ${CallArtificialFunction} _StrLib_PadLeft
    Pop ${OUTPUT}
  !macroend
  !define PadLeft `!insertmacro PadLeft`

  ; --- PadRight ---
  ; Pads the input string on the right to reach TargetLength.
  ; The pad string is repeated as needed and trimmed to fit exactly.
  ; If the input is already >= TargetLength, it is returned unchanged.

  !macro _StrLib_PadRight
    Exch $2     ; pad string
    Exch 2
    Exch $0     ; input
    Exch
    Exch $1     ; target length
    Push $3     ; current length
    Push $4     ; needed padding
    Push $5     ; pad accumulator

    StrLen $3 $0
    ${If} $3 >= $1
      Goto _StrLib_PadRight_Done
    ${EndIf}

    ; Guard against empty pad string (would loop forever)
    StrCmp $2 "" _StrLib_PadRight_Done

    IntOp $4 $1 - $3  ; chars of padding needed
    StrCpy $5 ""

    _StrLib_PadRight_Loop:
      StrCpy $5 "$5$2"
      StrLen $3 $5
      ${If} $3 < $4
        Goto _StrLib_PadRight_Loop
      ${EndIf}

    ; Trim to exact length and append
    StrCpy $5 $5 $4
    StrCpy $0 "$0$5"

    _StrLib_PadRight_Done:
    Pop $5
    Pop $4
    Pop $3
    Pop $1
    Exch
    Pop $2
    Exch $0
  !macroend

  !macro PadRight INPUT TARGET PAD OUTPUT
    Push `${INPUT}`
    Push `${TARGET}`
    Push `${PAD}`
    ${CallArtificialFunction} _StrLib_PadRight
    Pop ${OUTPUT}
  !macroend
  !define PadRight `!insertmacro PadRight`

  ; ============================================================
  ;  ToLowerCase / ToUpperCase
  ; ============================================================

  ; --- ToLowerCase ---
  ; Converts the entire string to lowercase via User32::CharLower.

  !macro _StrLib_ToLowerCase
    Exch $0
    System::Call "User32::CharLower(t r0 r0)i"
    Exch $0
  !macroend

  !macro ToLowerCase INPUT OUTPUT
    Push `${INPUT}`
    ${CallArtificialFunction} _StrLib_ToLowerCase
    Pop ${OUTPUT}
  !macroend
  !define ToLowerCase `!insertmacro ToLowerCase`

  ; --- ToUpperCase ---
  ; Converts the entire string to uppercase via User32::CharUpper.

  !macro _StrLib_ToUpperCase
    Exch $0
    System::Call "User32::CharUpper(t r0 r0)i"
    Exch $0
  !macroend

  !macro ToUpperCase INPUT OUTPUT
    Push `${INPUT}`
    ${CallArtificialFunction} _StrLib_ToUpperCase
    Pop ${OUTPUT}
  !macroend
  !define ToUpperCase `!insertmacro ToUpperCase`

  ; ============================================================
  ;  Reverse
  ; ============================================================

  ; --- Reverse ---
  ; Reverses the characters in the string.

  !macro _StrLib_Reverse
    Exch $0 ; input
    Push $1 ; result
    Push $2 ; index (counts down)
    Push $3 ; current char

    StrCpy $1 ""
    StrLen $2 $0
    ${If} $2 = 0
      Goto _StrLib_Reverse_Done
    ${EndIf}

    IntOp $2 $2 - 1

    _StrLib_Reverse_Loop:
      StrCpy $3 $0 1 $2
      StrCpy $1 "$1$3"
      IntOp $2 $2 - 1
      ${If} $2 >= 0
        Goto _StrLib_Reverse_Loop
      ${EndIf}

    _StrLib_Reverse_Done:
    StrCpy $0 $1
    Pop $3
    Pop $2
    Pop $1
    Exch $0
  !macroend

  !macro Reverse INPUT OUTPUT
    Push `${INPUT}`
    ${CallArtificialFunction} _StrLib_Reverse
    Pop ${OUTPUT}
  !macroend
  !define Reverse `!insertmacro Reverse`

  ; ============================================================
  ;  Word-aware transformations — shared core
  ; ============================================================
  ;
  ; All word-aware macros share _StrLib_WordTransform.
  ;
  ; Stack input (top to bottom): mode, input string
  ;   mode: P=PascalCase, C=CamelCase, S=SnakeCase, O=ConstantCase,
  ;         A=CapitalCase, K=KebabCase, G=Slugify
  ;
  ; Stack output: result string
  ;
  ; Registers used (all saved/restored):
  ;   $0 = input string
  ;   $1 = mode
  ;   $2 = result accumulator
  ;   $3 = current word accumulator
  ;   $4 = current char
  ;   $5 = char code (integer) for System::Call
  ;   $6 = temp for System::Call results
  ;   $7 = word counter
  ;   $8 = string length / loop index
  ;   $9 = prev-char-was-upper flag

  !macro _StrLib_WordTransform
    Exch $1 ; mode
    Exch
    Exch $0 ; input
    Push $2
    Push $3
    Push $4
    Push $5
    Push $6
    Push $7
    Push $8
    Push $9

    ; --- Slugify: transliterate accented chars via FoldString ---
    ${If} $1 == "G"
      System::Call "kernel32::FoldString(i 0x40, t r0, i -1, t .r2, i ${NSIS_MAX_STRLEN}) i"
      ${If} $2 != ""
        StrCpy $0 $2
      ${EndIf}
    ${EndIf}

    StrCpy $2 "" ; result
    StrCpy $3 "" ; current word
    StrCpy $7 0  ; word counter
    StrCpy $9 0  ; prev-was-upper

    StrLen $8 $0
    ${If} $8 = 0
      Goto _StrLib_WT_Done
    ${EndIf}

    Push $R0 ; loop index
    StrCpy $R0 0

    _StrLib_WT_CharLoop:
      ; Extract character at position $R0
      StrCpy $4 $0 1 $R0

      ; Get character code for classification
      System::Call "*(&t1 r4) p .r6"
      System::Call "*$6(&i${NSIS_CHAR_SIZE} .r5)"
      System::Free $6

      ; Check if alpha
      System::Call "user32::IsCharAlpha(i r5) i .r6"

      ${If} $6 = 0
        ; Non-alpha character — check if digit
        System::Call "user32::IsCharAlphaNumeric(i r5) i .r6"
        ${If} $6 <> 0
          ; It's a digit — add to current word as-is
          StrCpy $3 "$3$4"
          StrCpy $9 0
          Goto _StrLib_WT_NextChar
        ${EndIf}

        ; Non-alphanumeric: flush current word
        ${If} $3 != ""
          Push $R0
          !insertmacro _StrLib_FlushWord
          Pop $R0
        ${EndIf}
        StrCpy $9 0
        Goto _StrLib_WT_NextChar
      ${EndIf}

      ; Alpha character — detect word boundaries
      ; Check if uppercase
      System::Call "user32::IsCharUpper(i r5) i .r6"

      ${If} $6 <> 0
        ; Current char is uppercase
        ${If} $3 != ""
          ${If} $9 = 0
            ; lower→upper transition: flush word
            Push $R0
            !insertmacro _StrLib_FlushWord
            Pop $R0
            ; Re-extract current char (flush clobbered $4)
            StrCpy $4 $0 1 $R0
          ${Else}
            ; upper→upper: check if next char is lower (acronym end)
            IntOp $6 $R0 + 1
            ${If} $6 < $8
              StrCpy $6 $0 1 $6
              System::Call "*(&t1 r6) p .r6"
              System::Call "*$6(&i${NSIS_CHAR_SIZE} .r5)"
              System::Free $6
              System::Call "user32::IsCharAlpha(i r5) i .r6"
              ${If} $6 <> 0
                System::Call "user32::IsCharUpper(i r5) i .r6"
                ${If} $6 = 0
                  ; Next is alpha+lower: acronym boundary (e.g. "HTML|Parser")
                  Push $R0
                  !insertmacro _StrLib_FlushWord
                  Pop $R0
                ${EndIf}
              ${EndIf}
              ; Re-extract current char code (we clobbered $5)
              StrCpy $4 $0 1 $R0
              System::Call "*(&t1 r4) p .r6"
              System::Call "*$6(&i${NSIS_CHAR_SIZE} .r5)"
              System::Free $6
            ${EndIf}
          ${EndIf}
        ${EndIf}
        StrCpy $3 "$3$4"
        StrCpy $9 1
      ${Else}
        ; Current char is lowercase (or non-cased alpha)
        StrCpy $3 "$3$4"
        StrCpy $9 0
      ${EndIf}

    _StrLib_WT_NextChar:
      IntOp $R0 $R0 + 1
      ${If} $R0 < $8
        Goto _StrLib_WT_CharLoop
      ${EndIf}

    ; Flush final word
    ${If} $3 != ""
      Push $R0
      !insertmacro _StrLib_FlushWord
      Pop $R0
    ${EndIf}

    Pop $R0

    _StrLib_WT_Done:
    StrCpy $0 $2

    Pop $9
    Pop $8
    Pop $7
    Pop $6
    Pop $5
    Pop $4
    Pop $3
    Pop $2
    Exch
    Pop $1
    Exch $0
  !macroend

  ; --- Flush accumulated word: process casing and append to result ---
  ; Expects $1=mode, $2=result, $3=word, $7=word counter
  ; Modifies $2, $3, $7, uses $4-$6 as temps

  !macro _StrLib_FlushWord
    ; Determine separator
    ${If} $1 == "S"
    ${OrIf} $1 == "O"
      StrCpy $4 "_"
    ${ElseIf} $1 == "K"
    ${OrIf} $1 == "G"
      StrCpy $4 "-"
    ${ElseIf} $1 == "A"
      StrCpy $4 " "
    ${Else}
      StrCpy $4 "" ; P and C: no separator
    ${EndIf}

    ; Apply casing to the word
    ${If} $1 == "O"
      ; All uppercase
      System::Call "User32::CharUpper(t r3 r3)i"
    ${ElseIf} $1 == "S"
    ${OrIf} $1 == "K"
    ${OrIf} $1 == "G"
      ; All lowercase
      System::Call "User32::CharLower(t r3 r3)i"
    ${ElseIf} $1 == "C"
      ${If} $7 = 0
        ; First word in camelCase: all lowercase
        System::Call "User32::CharLower(t r3 r3)i"
      ${Else}
        ; Subsequent words: capitalize first, lower rest
        StrCpy $5 $3 1
        StrCpy $6 $3 "" 1
        System::Call "User32::CharUpper(t r5 r5)i"
        System::Call "User32::CharLower(t r6 r6)i"
        StrCpy $3 "$5$6"
      ${EndIf}
    ${Else}
      ; P and A: capitalize first, lower rest
      StrCpy $5 $3 1
      StrCpy $6 $3 "" 1
      System::Call "User32::CharUpper(t r5 r5)i"
      System::Call "User32::CharLower(t r6 r6)i"
      StrCpy $3 "$5$6"
    ${EndIf}

    ; Append separator + word to result
    ${If} $7 > 0
      StrCpy $2 "$2$4$3"
    ${Else}
      StrCpy $2 $3
    ${EndIf}
    IntOp $7 $7 + 1
    StrCpy $3 "" ; reset word
  !macroend

  ; ============================================================
  ;  Public macros — word-aware transforms
  ; ============================================================

  !macro ToPascalCase INPUT OUTPUT
    Push `${INPUT}`
    Push "P"
    ${CallArtificialFunction} _StrLib_WordTransform
    Pop ${OUTPUT}
  !macroend
  !define ToPascalCase `!insertmacro ToPascalCase`

  !macro ToCamelCase INPUT OUTPUT
    Push `${INPUT}`
    Push "C"
    ${CallArtificialFunction} _StrLib_WordTransform
    Pop ${OUTPUT}
  !macroend
  !define ToCamelCase `!insertmacro ToCamelCase`

  !macro ToSnakeCase INPUT OUTPUT
    Push `${INPUT}`
    Push "S"
    ${CallArtificialFunction} _StrLib_WordTransform
    Pop ${OUTPUT}
  !macroend
  !define ToSnakeCase `!insertmacro ToSnakeCase`

  !macro ToConstantCase INPUT OUTPUT
    Push `${INPUT}`
    Push "O"
    ${CallArtificialFunction} _StrLib_WordTransform
    Pop ${OUTPUT}
  !macroend
  !define ToConstantCase `!insertmacro ToConstantCase`

  !macro ToCapitalCase INPUT OUTPUT
    Push `${INPUT}`
    Push "A"
    ${CallArtificialFunction} _StrLib_WordTransform
    Pop ${OUTPUT}
  !macroend
  !define ToCapitalCase `!insertmacro ToCapitalCase`

  !macro ToKebabCase INPUT OUTPUT
    Push `${INPUT}`
    Push "K"
    ${CallArtificialFunction} _StrLib_WordTransform
    Pop ${OUTPUT}
  !macroend
  !define ToKebabCase `!insertmacro ToKebabCase`

  !macro Slugify INPUT OUTPUT
    Push `${INPUT}`
    Push "G"
    ${CallArtificialFunction} _StrLib_WordTransform
    Pop ${OUTPUT}
  !macroend
  !define Slugify `!insertmacro Slugify`

!endif ; STRLIB_TRANSFORMS_INCLUDED
