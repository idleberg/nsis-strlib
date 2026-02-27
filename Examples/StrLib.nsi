
Name "StrLibTests Example"
OutFile "StrLib_Example.exe"
ShowInstDetails show
RequestExecutionLevel user
Unicode true

!include "StrLib.nsh"

Page instfiles

Section "Run tests"

  ; ===== StartsWith (case-insensitive) =====

  ${If} "Hello World" ${StartsWith} "Hello"
    DetailPrint 'PASSED: "Hello World" StartsWith "Hello"'
  ${Else}
    DetailPrint 'FAILED: "Hello World" StartsWith "Hello"'
  ${EndIf}

  ${If} "Hello World" ${StartsWith} "World"
    DetailPrint 'FAILED: "Hello World" should not StartsWith "World"'
  ${Else}
    DetailPrint 'PASSED: "Hello World" does not StartsWith "World"'
  ${EndIf}

  ${IfNot} "Hello World" ${StartsWith} "Bye"
    DetailPrint 'PASSED: "Hello World" does not StartsWith "Bye"'
  ${Else}
    DetailPrint 'FAILED: "Hello World" should not StartsWith "Bye"'
  ${EndIf}

  ; Case-insensitive: "hello" should match "Hello"
  ${If} "Hello World" ${StartsWith} "hello"
    DetailPrint 'PASSED: "Hello World" StartsWith "hello" (case-insensitive)'
  ${Else}
    DetailPrint 'FAILED: "Hello World" StartsWith "hello" (case-insensitive)'
  ${EndIf}

  ; Empty needle
  ${If} "Hello" ${StartsWith} ""
    DetailPrint 'PASSED: "Hello" StartsWith "" (empty needle)'
  ${Else}
    DetailPrint 'FAILED: "Hello" StartsWith "" (empty needle)'
  ${EndIf}

  ; ===== StartsWithS (case-sensitive) =====

  ${If} "Hello World" ${StartsWithS} "Hello"
    DetailPrint 'PASSED: "Hello World" StartsWithS "Hello"'
  ${Else}
    DetailPrint 'FAILED: "Hello World" StartsWithS "Hello"'
  ${EndIf}

  ; Case-sensitive: "hello" should NOT match "Hello"
  ${If} "Hello World" ${StartsWithS} "hello"
    DetailPrint 'FAILED: "Hello World" should not StartsWithS "hello"'
  ${Else}
    DetailPrint 'PASSED: "Hello World" does not StartsWithS "hello"'
  ${EndIf}

  ; ===== EndsWith (case-insensitive) =====

  ${If} "Hello World" ${EndsWith} "World"
    DetailPrint 'PASSED: "Hello World" EndsWith "World"'
  ${Else}
    DetailPrint 'FAILED: "Hello World" EndsWith "World"'
  ${EndIf}

  ${If} "Hello World" ${EndsWith} "Hello"
    DetailPrint 'FAILED: "Hello World" should not EndsWith "Hello"'
  ${Else}
    DetailPrint 'PASSED: "Hello World" does not EndsWith "Hello"'
  ${EndIf}

  ${IfNot} "Hello World" ${EndsWith} "Bye"
    DetailPrint 'PASSED: "Hello World" does not EndsWith "Bye"'
  ${Else}
    DetailPrint 'FAILED: "Hello World" should not EndsWith "Bye"'
  ${EndIf}

  ; Case-insensitive: "world" should match "World"
  ${If} "Hello World" ${EndsWith} "world"
    DetailPrint 'PASSED: "Hello World" EndsWith "world" (case-insensitive)'
  ${Else}
    DetailPrint 'FAILED: "Hello World" EndsWith "world" (case-insensitive)'
  ${EndIf}

  ${If} "setup.exe" ${EndsWith} ".exe"
    DetailPrint 'PASSED: "setup.exe" EndsWith ".exe"'
  ${Else}
    DetailPrint 'FAILED: "setup.exe" EndsWith ".exe"'
  ${EndIf}

  ${If} "setup.exe" ${EndsWith} ".EXE"
    DetailPrint 'PASSED: "setup.exe" EndsWith ".EXE" (case-insensitive)'
  ${Else}
    DetailPrint 'FAILED: "setup.exe" EndsWith ".EXE" (case-insensitive)'
  ${EndIf}

  ; ===== EndsWithS (case-sensitive) =====

  ${If} "setup.exe" ${EndsWithS} ".exe"
    DetailPrint 'PASSED: "setup.exe" EndsWithS ".exe"'
  ${Else}
    DetailPrint 'FAILED: "setup.exe" EndsWithS ".exe"'
  ${EndIf}

  ; Case-sensitive: ".EXE" should NOT match ".exe"
  ${If} "setup.exe" ${EndsWithS} ".EXE"
    DetailPrint 'FAILED: "setup.exe" should not EndsWithS ".EXE"'
  ${Else}
    DetailPrint 'PASSED: "setup.exe" does not EndsWithS ".EXE"'
  ${EndIf}

  ; ===== Contains (case-insensitive) =====

  ${If} "Hello World" ${Contains} "lo Wo"
    DetailPrint 'PASSED: "Hello World" Contains "lo Wo"'
  ${Else}
    DetailPrint 'FAILED: "Hello World" Contains "lo Wo"'
  ${EndIf}

  ${If} "Hello World" ${Contains} "xyz"
    DetailPrint 'FAILED: "Hello World" should not Contains "xyz"'
  ${Else}
    DetailPrint 'PASSED: "Hello World" does not Contains "xyz"'
  ${EndIf}

  ${IfNot} "Hello World" ${Contains} "xyz"
    DetailPrint 'PASSED: IfNot "Hello World" Contains "xyz"'
  ${Else}
    DetailPrint 'FAILED: IfNot "Hello World" Contains "xyz"'
  ${EndIf}

  ; Case-insensitive: "hello" should match
  ${If} "Hello World" ${Contains} "hello"
    DetailPrint 'PASSED: "Hello World" Contains "hello" (case-insensitive)'
  ${Else}
    DetailPrint 'FAILED: "Hello World" Contains "hello" (case-insensitive)'
  ${EndIf}

  ; Needle at start
  ${If} "Hello World" ${Contains} "Hello"
    DetailPrint 'PASSED: "Hello World" Contains "Hello" (at start)'
  ${Else}
    DetailPrint 'FAILED: "Hello World" Contains "Hello" (at start)'
  ${EndIf}

  ; Needle at end
  ${If} "Hello World" ${Contains} "World"
    DetailPrint 'PASSED: "Hello World" Contains "World" (at end)'
  ${Else}
    DetailPrint 'FAILED: "Hello World" Contains "World" (at end)'
  ${EndIf}

  ; Needle equals haystack
  ${If} "Hello" ${Contains} "Hello"
    DetailPrint 'PASSED: "Hello" Contains "Hello" (exact match)'
  ${Else}
    DetailPrint 'FAILED: "Hello" Contains "Hello" (exact match)'
  ${EndIf}

  ; Needle longer than haystack
  ${If} "Hi" ${Contains} "Hello World"
    DetailPrint 'FAILED: "Hi" should not Contains "Hello World"'
  ${Else}
    DetailPrint 'PASSED: "Hi" does not Contains "Hello World" (needle longer)'
  ${EndIf}

  ; Empty haystack with non-empty needle
  ${If} "" ${Contains} "x"
    DetailPrint 'FAILED: "" should not Contains "x"'
  ${Else}
    DetailPrint 'PASSED: "" does not Contains "x" (empty haystack)'
  ${EndIf}

  ; ===== ContainsS (case-sensitive) =====

  ${If} "Hello World" ${ContainsS} "lo Wo"
    DetailPrint 'PASSED: "Hello World" ContainsS "lo Wo"'
  ${Else}
    DetailPrint 'FAILED: "Hello World" ContainsS "lo Wo"'
  ${EndIf}

  ; Case-sensitive: "hello" should NOT match "Hello"
  ${If} "Hello World" ${ContainsS} "hello"
    DetailPrint 'FAILED: "Hello World" should not ContainsS "hello"'
  ${Else}
    DetailPrint 'PASSED: "Hello World" does not ContainsS "hello"'
  ${EndIf}

  ${If} "Hello World" ${ContainsS} "Hello"
    DetailPrint 'PASSED: "Hello World" ContainsS "Hello"'
  ${Else}
    DetailPrint 'FAILED: "Hello World" ContainsS "Hello"'
  ${EndIf}

  ; ===== ElseIf integration =====

  StrCpy $R1 "C:\Program Files\MyApp\setup.exe"
  ${If} $R1 ${EndsWith} ".msi"
    DetailPrint "FAILED: ElseIf should not match .msi"
  ${ElseIf} $R1 ${EndsWith} ".exe"
    DetailPrint "PASSED: ElseIf matched .exe"
  ${Else}
    DetailPrint "FAILED: ElseIf should have matched .exe"
  ${EndIf}

  ; ===== AndIf / OrIf integration =====

  StrCpy $R1 "C:\Temp\logfile.txt"
  ${If} $R1 ${StartsWith} "C:\Temp"
  ${AndIf} $R1 ${EndsWith} ".txt"
    DetailPrint "PASSED: AndIf StartsWith + EndsWith"
  ${Else}
    DetailPrint "FAILED: AndIf StartsWith + EndsWith"
  ${EndIf}

  ${If} $R1 ${StartsWith} "D:\"
  ${OrIf} $R1 ${Contains} "log"
    DetailPrint "PASSED: OrIf (first false, second true)"
  ${Else}
    DetailPrint "FAILED: OrIf (first false, second true)"
  ${EndIf}

  ; ===== Register preservation test =====
  ; Verify that Contains restores $0 and $1

  StrCpy $0 "preserved0"
  StrCpy $1 "preserved1"
  ${If} "test string" ${Contains} "str"
    Nop
  ${EndIf}
  ${If} $0 == "preserved0"
  ${AndIf} $1 == "preserved1"
    DetailPrint "PASSED: $$0 and $$1 preserved after Contains"
  ${Else}
    DetailPrint "FAILED: $$0=$0 $$1=$1 (expected preserved0, preserved1)"
  ${EndIf}

  ; =============================================================
  ;  Transformer tests
  ; =============================================================

  ; ===== TrimLeft =====

  ${TrimLeft} "  hello  " $R0
  StrCmp $R0 "hello  " 0 +3
    DetailPrint 'PASSED: TrimLeft "  hello  " = "hello  "'
    Goto +2
    DetailPrint 'FAILED: TrimLeft "  hello  " = "$R0"'

  ; Tab and newline
  ${TrimLeft} "$\t$\nhello" $R0
  StrCmp $R0 "hello" 0 +3
    DetailPrint 'PASSED: TrimLeft tab+newline prefix'
    Goto +2
    DetailPrint 'FAILED: TrimLeft tab+newline = "$R0"'

  ; Nothing to trim
  ${TrimLeft} "hello" $R0
  StrCmp $R0 "hello" 0 +3
    DetailPrint 'PASSED: TrimLeft no-op'
    Goto +2
    DetailPrint 'FAILED: TrimLeft no-op = "$R0"'

  ; Empty string
  ${TrimLeft} "" $R0
  StrCmp $R0 "" 0 +3
    DetailPrint 'PASSED: TrimLeft empty string'
    Goto +2
    DetailPrint 'FAILED: TrimLeft empty = "$R0"'

  ; ===== TrimRight =====

  ${TrimRight} "  hello  " $R0
  StrCmp $R0 "  hello" 0 +3
    DetailPrint 'PASSED: TrimRight "  hello  " = "  hello"'
    Goto +2
    DetailPrint 'FAILED: TrimRight "  hello  " = "$R0"'

  ; Tab and newline
  ${TrimRight} "hello$\t$\n" $R0
  StrCmp $R0 "hello" 0 +3
    DetailPrint 'PASSED: TrimRight tab+newline suffix'
    Goto +2
    DetailPrint 'FAILED: TrimRight tab+newline = "$R0"'

  ; ===== Trim =====

  ${Trim} "  hello  " $R0
  StrCmp $R0 "hello" 0 +3
    DetailPrint 'PASSED: Trim "  hello  " = "hello"'
    Goto +2
    DetailPrint 'FAILED: Trim "  hello  " = "$R0"'

  ${Trim} "hello" $R0
  StrCmp $R0 "hello" 0 +3
    DetailPrint 'PASSED: Trim no-op'
    Goto +2
    DetailPrint 'FAILED: Trim no-op = "$R0"'

  ${Trim} "   " $R0
  StrCmp $R0 "" 0 +3
    DetailPrint 'PASSED: Trim all-whitespace = ""'
    Goto +2
    DetailPrint 'FAILED: Trim all-whitespace = "$R0"'

  ; ===== PadLeft =====

  ${PadLeft} "hi" 5 "0" $R0
  StrCmp $R0 "000hi" 0 +3
    DetailPrint 'PASSED: PadLeft "hi" 5 "0" = "000hi"'
    Goto +2
    DetailPrint 'FAILED: PadLeft "hi" 5 "0" = "$R0"'

  ; Already long enough
  ${PadLeft} "hello" 3 "0" $R0
  StrCmp $R0 "hello" 0 +3
    DetailPrint 'PASSED: PadLeft no-op (already >= target)'
    Goto +2
    DetailPrint 'FAILED: PadLeft no-op = "$R0"'

  ; Multi-char pad string
  ${PadLeft} "x" 5 "ab" $R0
  StrCmp $R0 "ababx" 0 +3
    DetailPrint 'PASSED: PadLeft multi-char pad = "ababx"'
    Goto +2
    DetailPrint 'FAILED: PadLeft multi-char pad = "$R0"'

  ; Empty pad string (should return input unchanged)
  ${PadLeft} "hi" 5 "" $R0
  StrCmp $R0 "hi" 0 +3
    DetailPrint 'PASSED: PadLeft empty pad = no-op'
    Goto +2
    DetailPrint 'FAILED: PadLeft empty pad = "$R0"'

  ; ===== PadRight =====

  ${PadRight} "hi" 5 "." $R0
  StrCmp $R0 "hi..." 0 +3
    DetailPrint 'PASSED: PadRight "hi" 5 "." = "hi..."'
    Goto +2
    DetailPrint 'FAILED: PadRight "hi" 5 "." = "$R0"'

  ; Already long enough
  ${PadRight} "hello" 3 "." $R0
  StrCmp $R0 "hello" 0 +3
    DetailPrint 'PASSED: PadRight no-op (already >= target)'
    Goto +2
    DetailPrint 'FAILED: PadRight no-op = "$R0"'

  ; ===== ToLowerCase =====

  ${ToLowerCase} "Hello World" $R0
  StrCmp $R0 "hello world" 0 +3
    DetailPrint 'PASSED: ToLowerCase "Hello World" = "hello world"'
    Goto +2
    DetailPrint 'FAILED: ToLowerCase "Hello World" = "$R0"'

  ${ToLowerCase} "ALLCAPS" $R0
  StrCmp $R0 "allcaps" 0 +3
    DetailPrint 'PASSED: ToLowerCase "ALLCAPS" = "allcaps"'
    Goto +2
    DetailPrint 'FAILED: ToLowerCase "ALLCAPS" = "$R0"'

  ${ToLowerCase} "already" $R0
  StrCmp $R0 "already" 0 +3
    DetailPrint 'PASSED: ToLowerCase no-op'
    Goto +2
    DetailPrint 'FAILED: ToLowerCase no-op = "$R0"'

  ; ===== ToUpperCase =====

  ${ToUpperCase} "Hello World" $R0
  StrCmp $R0 "HELLO WORLD" 0 +3
    DetailPrint 'PASSED: ToUpperCase "Hello World" = "HELLO WORLD"'
    Goto +2
    DetailPrint 'FAILED: ToUpperCase "Hello World" = "$R0"'

  ${ToUpperCase} "alllower" $R0
  StrCmp $R0 "ALLLOWER" 0 +3
    DetailPrint 'PASSED: ToUpperCase "alllower" = "ALLLOWER"'
    Goto +2
    DetailPrint 'FAILED: ToUpperCase "alllower" = "$R0"'

  ${ToUpperCase} "ALREADY" $R0
  StrCmp $R0 "ALREADY" 0 +3
    DetailPrint 'PASSED: ToUpperCase no-op'
    Goto +2
    DetailPrint 'FAILED: ToUpperCase no-op = "$R0"'

  ; ===== ToPascalCase =====

  ${ToPascalCase} "hello_world" $R0
  StrCmp $R0 "HelloWorld" 0 +3
    DetailPrint 'PASSED: ToPascalCase "hello_world" = "HelloWorld"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "hello_world" = "$R0"'

  ${ToPascalCase} "hello world" $R0
  StrCmp $R0 "HelloWorld" 0 +3
    DetailPrint 'PASSED: ToPascalCase "hello world" = "HelloWorld"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "hello world" = "$R0"'

  ${ToPascalCase} "hello-world" $R0
  StrCmp $R0 "HelloWorld" 0 +3
    DetailPrint 'PASSED: ToPascalCase "hello-world" = "HelloWorld"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "hello-world" = "$R0"'

  ${ToPascalCase} "helloWorld" $R0
  StrCmp $R0 "HelloWorld" 0 +3
    DetailPrint 'PASSED: ToPascalCase "helloWorld" = "HelloWorld"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "helloWorld" = "$R0"'

  ${ToPascalCase} "HTMLParser" $R0
  StrCmp $R0 "HtmlParser" 0 +3
    DetailPrint 'PASSED: ToPascalCase "HTMLParser" = "HtmlParser"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "HTMLParser" = "$R0"'

  ; ===== ToCamelCase =====

  ${ToCamelCase} "hello_world" $R0
  StrCmp $R0 "helloWorld" 0 +3
    DetailPrint 'PASSED: ToCamelCase "hello_world" = "helloWorld"'
    Goto +2
    DetailPrint 'FAILED: ToCamelCase "hello_world" = "$R0"'

  ${ToCamelCase} "hello world" $R0
  StrCmp $R0 "helloWorld" 0 +3
    DetailPrint 'PASSED: ToCamelCase "hello world" = "helloWorld"'
    Goto +2
    DetailPrint 'FAILED: ToCamelCase "hello world" = "$R0"'

  ${ToCamelCase} "HelloWorld" $R0
  StrCmp $R0 "helloWorld" 0 +3
    DetailPrint 'PASSED: ToCamelCase "HelloWorld" = "helloWorld"'
    Goto +2
    DetailPrint 'FAILED: ToCamelCase "HelloWorld" = "$R0"'

  ${ToCamelCase} "HTML_parser" $R0
  StrCmp $R0 "htmlParser" 0 +3
    DetailPrint 'PASSED: ToCamelCase "HTML_parser" = "htmlParser"'
    Goto +2
    DetailPrint 'FAILED: ToCamelCase "HTML_parser" = "$R0"'

  ; ===== ToSnakeCase =====

  ${ToSnakeCase} "helloWorld" $R0
  StrCmp $R0 "hello_world" 0 +3
    DetailPrint 'PASSED: ToSnakeCase "helloWorld" = "hello_world"'
    Goto +2
    DetailPrint 'FAILED: ToSnakeCase "helloWorld" = "$R0"'

  ${ToSnakeCase} "HelloWorld" $R0
  StrCmp $R0 "hello_world" 0 +3
    DetailPrint 'PASSED: ToSnakeCase "HelloWorld" = "hello_world"'
    Goto +2
    DetailPrint 'FAILED: ToSnakeCase "HelloWorld" = "$R0"'

  ${ToSnakeCase} "hello-world" $R0
  StrCmp $R0 "hello_world" 0 +3
    DetailPrint 'PASSED: ToSnakeCase "hello-world" = "hello_world"'
    Goto +2
    DetailPrint 'FAILED: ToSnakeCase "hello-world" = "$R0"'

  ${ToSnakeCase} "HTMLParser" $R0
  StrCmp $R0 "html_parser" 0 +3
    DetailPrint 'PASSED: ToSnakeCase "HTMLParser" = "html_parser"'
    Goto +2
    DetailPrint 'FAILED: ToSnakeCase "HTMLParser" = "$R0"'

  ; ===== ToConstantCase =====

  ${ToConstantCase} "helloWorld" $R0
  StrCmp $R0 "HELLO_WORLD" 0 +3
    DetailPrint 'PASSED: ToConstantCase "helloWorld" = "HELLO_WORLD"'
    Goto +2
    DetailPrint 'FAILED: ToConstantCase "helloWorld" = "$R0"'

  ${ToConstantCase} "HelloWorld" $R0
  StrCmp $R0 "HELLO_WORLD" 0 +3
    DetailPrint 'PASSED: ToConstantCase "HelloWorld" = "HELLO_WORLD"'
    Goto +2
    DetailPrint 'FAILED: ToConstantCase "HelloWorld" = "$R0"'

  ${ToConstantCase} "hello_world" $R0
  StrCmp $R0 "HELLO_WORLD" 0 +3
    DetailPrint 'PASSED: ToConstantCase "hello_world" = "HELLO_WORLD"'
    Goto +2
    DetailPrint 'FAILED: ToConstantCase "hello_world" = "$R0"'

  ${ToConstantCase} "HTMLParser" $R0
  StrCmp $R0 "HTML_PARSER" 0 +3
    DetailPrint 'PASSED: ToConstantCase "HTMLParser" = "HTML_PARSER"'
    Goto +2
    DetailPrint 'FAILED: ToConstantCase "HTMLParser" = "$R0"'

  ; ===== ToCapitalCase =====

  ${ToCapitalCase} "hello_world" $R0
  StrCmp $R0 "Hello World" 0 +3
    DetailPrint 'PASSED: ToCapitalCase "hello_world" = "Hello World"'
    Goto +2
    DetailPrint 'FAILED: ToCapitalCase "hello_world" = "$R0"'

  ${ToCapitalCase} "helloWorld" $R0
  StrCmp $R0 "Hello World" 0 +3
    DetailPrint 'PASSED: ToCapitalCase "helloWorld" = "Hello World"'
    Goto +2
    DetailPrint 'FAILED: ToCapitalCase "helloWorld" = "$R0"'

  ${ToCapitalCase} "hello-world" $R0
  StrCmp $R0 "Hello World" 0 +3
    DetailPrint 'PASSED: ToCapitalCase "hello-world" = "Hello World"'
    Goto +2
    DetailPrint 'FAILED: ToCapitalCase "hello-world" = "$R0"'

  ; ===== ToKebabCase =====

  ${ToKebabCase} "helloWorld" $R0
  StrCmp $R0 "hello-world" 0 +3
    DetailPrint 'PASSED: ToKebabCase "helloWorld" = "hello-world"'
    Goto +2
    DetailPrint 'FAILED: ToKebabCase "helloWorld" = "$R0"'

  ${ToKebabCase} "HelloWorld" $R0
  StrCmp $R0 "hello-world" 0 +3
    DetailPrint 'PASSED: ToKebabCase "HelloWorld" = "hello-world"'
    Goto +2
    DetailPrint 'FAILED: ToKebabCase "HelloWorld" = "$R0"'

  ${ToKebabCase} "hello_world" $R0
  StrCmp $R0 "hello-world" 0 +3
    DetailPrint 'PASSED: ToKebabCase "hello_world" = "hello-world"'
    Goto +2
    DetailPrint 'FAILED: ToKebabCase "hello_world" = "$R0"'

  ; ===== Slugify =====

  ${Slugify} "Hello World" $R0
  StrCmp $R0 "hello-world" 0 +3
    DetailPrint 'PASSED: Slugify "Hello World" = "hello-world"'
    Goto +2
    DetailPrint 'FAILED: Slugify "Hello World" = "$R0"'

  ${Slugify} "Hello World 123" $R0
  StrCmp $R0 "hello-world-123" 0 +3
    DetailPrint 'PASSED: Slugify "Hello World 123" = "hello-world-123"'
    Goto +2
    DetailPrint 'FAILED: Slugify "Hello World 123" = "$R0"'

  ${Slugify} "  --Multiple   Spaces--  " $R0
  StrCmp $R0 "multiple-spaces" 0 +3
    DetailPrint 'PASSED: Slugify strips leading/trailing/consecutive separators'
    Goto +2
    DetailPrint 'FAILED: Slugify multiple spaces = "$R0"'

  ; =============================================================
  ;  Edge cases
  ; =============================================================

  ; ===== Empty string =====

  ${ToPascalCase} "" $R0
  StrCmp $R0 "" 0 +3
    DetailPrint 'PASSED: ToPascalCase "" = ""'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "" = "$R0"'

  ${ToSnakeCase} "" $R0
  StrCmp $R0 "" 0 +3
    DetailPrint 'PASSED: ToSnakeCase "" = ""'
    Goto +2
    DetailPrint 'FAILED: ToSnakeCase "" = "$R0"'

  ; ===== Single character =====

  ${ToPascalCase} "a" $R0
  StrCmp $R0 "A" 0 +3
    DetailPrint 'PASSED: ToPascalCase "a" = "A"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "a" = "$R0"'

  ${ToCamelCase} "A" $R0
  StrCmp $R0 "a" 0 +3
    DetailPrint 'PASSED: ToCamelCase "A" = "a"'
    Goto +2
    DetailPrint 'FAILED: ToCamelCase "A" = "$R0"'

  ; ===== Digits preserved =====

  ${ToPascalCase} "hello2World" $R0
  StrCmp $R0 "Hello2world" 0 +3
    DetailPrint 'PASSED: ToPascalCase "hello2World" = "Hello2world"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "hello2World" = "$R0"'

  ${ToSnakeCase} "hello2World" $R0
  StrCmp $R0 "hello2_world" 0 +3
    DetailPrint 'PASSED: ToSnakeCase "hello2World" = "hello2_world"'
    Goto +2
    DetailPrint 'FAILED: ToSnakeCase "hello2World" = "$R0"'

  ${ToCamelCase} "version2" $R0
  StrCmp $R0 "version2" 0 +3
    DetailPrint 'PASSED: ToCamelCase "version2" = "version2"'
    Goto +2
    DetailPrint 'FAILED: ToCamelCase "version2" = "$R0"'

  ${ToKebabCase} "version2" $R0
  StrCmp $R0 "version2" 0 +3
    DetailPrint 'PASSED: ToKebabCase "version2" = "version2"'
    Goto +2
    DetailPrint 'FAILED: ToKebabCase "version2" = "$R0"'

  ${ToConstantCase} "hello2World" $R0
  StrCmp $R0 "HELLO2_WORLD" 0 +3
    DetailPrint 'PASSED: ToConstantCase "hello2World" = "HELLO2_WORLD"'
    Goto +2
    DetailPrint 'FAILED: ToConstantCase "hello2World" = "$R0"'

  ${ToPascalCase} "123abc" $R0
  StrCmp $R0 "123abc" 0 +3
    DetailPrint 'PASSED: ToPascalCase "123abc" = "123abc"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "123abc" = "$R0"'

  ; ===== Consecutive / leading / trailing separators =====

  ${ToPascalCase} "__hello__world__" $R0
  StrCmp $R0 "HelloWorld" 0 +3
    DetailPrint 'PASSED: ToPascalCase "__hello__world__" = "HelloWorld"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "__hello__world__" = "$R0"'

  ${ToSnakeCase} "--hello--world--" $R0
  StrCmp $R0 "hello_world" 0 +3
    DetailPrint 'PASSED: ToSnakeCase "--hello--world--" = "hello_world"'
    Goto +2
    DetailPrint 'FAILED: ToSnakeCase "--hello--world--" = "$R0"'

  ${ToKebabCase} "  hello  world  " $R0
  StrCmp $R0 "hello-world" 0 +3
    DetailPrint 'PASSED: ToKebabCase "  hello  world  " = "hello-world"'
    Goto +2
    DetailPrint 'FAILED: ToKebabCase "  hello  world  " = "$R0"'

  ; ===== All-uppercase =====

  ${ToPascalCase} "HELLO" $R0
  StrCmp $R0 "Hello" 0 +3
    DetailPrint 'PASSED: ToPascalCase "HELLO" = "Hello"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "HELLO" = "$R0"'

  ${ToSnakeCase} "HELLOWORLD" $R0
  StrCmp $R0 "helloworld" 0 +3
    DetailPrint 'PASSED: ToSnakeCase "HELLOWORLD" = "helloworld" (no boundary)'
    Goto +2
    DetailPrint 'FAILED: ToSnakeCase "HELLOWORLD" = "$R0"'

  ; ===== Acronym chains =====

  ${ToPascalCase} "XMLToJSON" $R0
  StrCmp $R0 "XmlToJson" 0 +3
    DetailPrint 'PASSED: ToPascalCase "XMLToJSON" = "XmlToJson"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "XMLToJSON" = "$R0"'

  ${ToSnakeCase} "getHTTPSUrl" $R0
  StrCmp $R0 "get_https_url" 0 +3
    DetailPrint 'PASSED: ToSnakeCase "getHTTPSUrl" = "get_https_url"'
    Goto +2
    DetailPrint 'FAILED: ToSnakeCase "getHTTPSUrl" = "$R0"'

  ; ===== Mixed separator types =====

  ${ToPascalCase} "hello_world-foo bar" $R0
  StrCmp $R0 "HelloWorldFooBar" 0 +3
    DetailPrint 'PASSED: ToPascalCase mixed separators = "HelloWorldFooBar"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase mixed separators = "$R0"'

  ; ===== Unicode =====

  ${ToPascalCase} "überAll" $R0
  StrCmpS $R0 "ÜberAll" 0 +3
    DetailPrint 'PASSED: ToPascalCase "überAll" = "ÜberAll"'
    Goto +2
    DetailPrint 'FAILED: ToPascalCase "überAll" = "$R0"'

  ${ToSnakeCase} "ÄRGER" $R0
  StrCmpS $R0 "ärger" 0 +3
    DetailPrint 'PASSED: ToSnakeCase "ÄRGER" = "ärger"'
    Goto +2
    DetailPrint 'FAILED: ToSnakeCase "ÄRGER" = "$R0"'

  ; ===== Register preservation (word transforms) =====

  StrCpy $0 "reg0"
  StrCpy $1 "reg1"
  StrCpy $2 "reg2"
  StrCpy $3 "reg3"
  StrCpy $9 "reg9"
  StrCpy $R0 "regR0"
  ${ToPascalCase} "hello_world" $R1
  ${If} $0 == "reg0"
  ${AndIf} $1 == "reg1"
  ${AndIf} $2 == "reg2"
  ${AndIf} $3 == "reg3"
  ${AndIf} $9 == "reg9"
  ${AndIf} $R0 == "regR0"
    DetailPrint "PASSED: registers preserved after ToPascalCase"
  ${Else}
    DetailPrint "FAILED: registers clobbered: $$0=$0 $$1=$1 $$2=$2 $$3=$3 $$9=$9 $$R0=$R0"
  ${EndIf}

SectionEnd
