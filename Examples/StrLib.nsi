
Name "StrLib.nsh Examples"
OutFile "StrLib.exe"
ShowInstDetails show
RequestExecutionLevel user
Unicode true

!include "StrLib.nsh"

Page instfiles

; =====================================================================
;  Logical operators
; =====================================================================

Section "StartsWith / StartsWithS"

  ${If} "Hello World" ${StartsWith} "Hello"
    DetailPrint '"Hello World" starts with "Hello"'
  ${EndIf}

  ; Case-insensitive
  ${If} "Hello World" ${StartsWith} "hello"
    DetailPrint '"Hello World" starts with "hello" (case-insensitive)'
  ${EndIf}

  ; Case-sensitive variant
  ${IfNot} "Hello World" ${StartsWithS} "hello"
    DetailPrint '"Hello World" does not start with "hello" (case-sensitive)'
  ${EndIf}

SectionEnd

Section "EndsWith / EndsWithS"

  ${If} "setup.exe" ${EndsWith} ".exe"
    DetailPrint '"setup.exe" ends with ".exe"'
  ${EndIf}

  ; Case-insensitive
  ${If} "setup.exe" ${EndsWith} ".EXE"
    DetailPrint '"setup.exe" ends with ".EXE" (case-insensitive)'
  ${EndIf}

  ; Case-sensitive variant
  ${IfNot} "setup.exe" ${EndsWithS} ".EXE"
    DetailPrint '"setup.exe" does not end with ".EXE" (case-sensitive)'
  ${EndIf}

SectionEnd

Section "Contains / ContainsS"

  ${If} "Hello World" ${Contains} "lo Wo"
    DetailPrint '"Hello World" contains "lo Wo"'
  ${EndIf}

  ; Case-sensitive variant
  ${IfNot} "Hello World" ${ContainsS} "hello"
    DetailPrint '"Hello World" does not contain "hello" (case-sensitive)'
  ${EndIf}

SectionEnd

Section "IsLowerCase / IsUpperCase"

  ${If} ${IsLowerCase} "hello"
    DetailPrint '"hello" is all lowercase'
  ${EndIf}

  ${If} ${IsUpperCase} "HELLO"
    DetailPrint '"HELLO" is all uppercase'
  ${EndIf}

SectionEnd

; =====================================================================
;  Transforms
; =====================================================================

Section "TrimLeft / TrimRight / Trim"

  ${TrimLeft} "  hello  " $R0
  DetailPrint 'TrimLeft "  hello  " => "$R0"'
  ; Output: "hello  "

  ${TrimRight} "  hello  " $R0
  DetailPrint 'TrimRight "  hello  " => "$R0"'
  ; Output: "  hello"

  ${Trim} "  hello  " $R0
  DetailPrint 'Trim "  hello  " => "$R0"'
  ; Output: "hello"

SectionEnd

Section "PadLeft / PadRight"

  ${PadLeft} "42" 5 "0" $R0
  DetailPrint 'PadLeft "42" 5 "0" => "$R0"'
  ; Output: "00042"

  ${PadRight} "hi" 5 "." $R0
  DetailPrint 'PadRight "hi" 5 "." => "$R0"'
  ; Output: "hi..."

SectionEnd

Section "ToLowerCase / ToUpperCase"

  ${ToLowerCase} "Hello World" $R0
  DetailPrint 'ToLowerCase "Hello World" => "$R0"'
  ; Output: "hello world"

  ${ToUpperCase} "Hello World" $R0
  DetailPrint 'ToUpperCase "Hello World" => "$R0"'
  ; Output: "HELLO WORLD"

SectionEnd

Section "Reverse"

  ${Reverse} "Hello" $R0
  DetailPrint 'Reverse "Hello" => "$R0"'
  ; Output: "olleH"

SectionEnd

Section "ToPascalCase"

  ${ToPascalCase} "hello_world" $R0
  DetailPrint 'ToPascalCase "hello_world" => "$R0"'
  ; Output: "HelloWorld"

SectionEnd

Section "ToCamelCase"

  ${ToCamelCase} "hello_world" $R0
  DetailPrint 'ToCamelCase "hello_world" => "$R0"'
  ; Output: "helloWorld"

SectionEnd

Section "ToSnakeCase"

  ${ToSnakeCase} "helloWorld" $R0
  DetailPrint 'ToSnakeCase "helloWorld" => "$R0"'
  ; Output: "hello_world"

SectionEnd

Section "ToConstantCase"

  ${ToConstantCase} "helloWorld" $R0
  DetailPrint 'ToConstantCase "helloWorld" => "$R0"'
  ; Output: "HELLO_WORLD"

SectionEnd

Section "ToCapitalCase"

  ${ToCapitalCase} "hello_world" $R0
  DetailPrint 'ToCapitalCase "hello_world" => "$R0"'
  ; Output: "Hello World"

SectionEnd

Section "ToKebabCase"

  ${ToKebabCase} "helloWorld" $R0
  DetailPrint 'ToKebabCase "helloWorld" => "$R0"'
  ; Output: "hello-world"

SectionEnd

Section "Slugify"

  ${Slugify} "Hello World 123" $R0
  DetailPrint 'Slugify "Hello World 123" => "$R0"'
  ; Output: "hello-world-123"

SectionEnd
