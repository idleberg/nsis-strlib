
Name "StrLib Tests"
OutFile "StrLib.test.exe"
ShowInstDetails show
RequestExecutionLevel user
Unicode true

!include "StrLib.nsh"
!include "Assert.nsh"

Page instfiles

Section "StartsWith (case-insensitive)"
  ${Assert} "Hello World" ${StartsWith} "Hello" \
    '"Hello World" StartsWith "Hello"'
  ${AssertNot} "Hello World" ${StartsWith} "World" \
    '"Hello World" does not StartsWith "World"'
  ${AssertNot} "Hello World" ${StartsWith} "Bye" \
    '"Hello World" does not StartsWith "Bye"'
  ${Assert} "Hello World" ${StartsWith} "hello" \
    '"Hello World" StartsWith "hello" (case-insensitive)'
  ${Assert} "Hello" ${StartsWith} "" \
    '"Hello" StartsWith "" (empty needle)'
SectionEnd

Section "StartsWithS (case-sensitive)"
  ${Assert} "Hello World" ${StartsWithS} "Hello" \
    '"Hello World" StartsWithS "Hello"'
  ${AssertNot} "Hello World" ${StartsWithS} "hello" \
    '"Hello World" does not StartsWithS "hello"'
SectionEnd

Section "EndsWith (case-insensitive)"
  ${Assert} "Hello World" ${EndsWith} "World" \
    '"Hello World" EndsWith "World"'
  ${AssertNot} "Hello World" ${EndsWith} "Hello" \
    '"Hello World" does not EndsWith "Hello"'
  ${AssertNot} "Hello World" ${EndsWith} "Bye" \
    '"Hello World" does not EndsWith "Bye"'
  ${Assert} "Hello World" ${EndsWith} "world" \
    '"Hello World" EndsWith "world" (case-insensitive)'
  ${Assert} "setup.exe" ${EndsWith} ".exe" \
    '"setup.exe" EndsWith ".exe"'
  ${Assert} "setup.exe" ${EndsWith} ".EXE" \
    '"setup.exe" EndsWith ".EXE" (case-insensitive)'
SectionEnd

Section "EndsWithS (case-sensitive)"
  ${Assert} "setup.exe" ${EndsWithS} ".exe" \
    '"setup.exe" EndsWithS ".exe"'
  ${AssertNot} "setup.exe" ${EndsWithS} ".EXE" \
    '"setup.exe" does not EndsWithS ".EXE"'
SectionEnd

Section "Contains (case-insensitive)"
  ${Assert} "Hello World" ${Contains} "lo Wo" \
    '"Hello World" Contains "lo Wo"'
  ${AssertNot} "Hello World" ${Contains} "xyz" \
    '"Hello World" does not Contains "xyz"'
  ${Assert} "Hello World" ${Contains} "hello" \
    '"Hello World" Contains "hello" (case-insensitive)'
  ${Assert} "Hello World" ${Contains} "Hello" \
    '"Hello World" Contains "Hello" (at start)'
  ${Assert} "Hello World" ${Contains} "World" \
    '"Hello World" Contains "World" (at end)'
  ${Assert} "Hello" ${Contains} "Hello" \
    '"Hello" Contains "Hello" (exact match)'
  ${AssertNot} "Hi" ${Contains} "Hello World" \
    '"Hi" does not Contains "Hello World" (needle longer)'
  ${AssertNot} "" ${Contains} "x" \
    '"" does not Contains "x" (empty haystack)'
SectionEnd

Section "ContainsS (case-sensitive)"
  ${Assert} "Hello World" ${ContainsS} "lo Wo" \
    '"Hello World" ContainsS "lo Wo"'
  ${AssertNot} "Hello World" ${ContainsS} "hello" \
    '"Hello World" does not ContainsS "hello"'
  ${Assert} "Hello World" ${ContainsS} "Hello" \
    '"Hello World" ContainsS "Hello"'
SectionEnd

Section "IsLowerCase"
  ${Assert} ${IsLowerCase} "hello" \
    'IsLowerCase "hello"'
  ${Assert} ${IsLowerCase} "hello world" \
    'IsLowerCase "hello world"'
  ${AssertNot} ${IsLowerCase} "Hello" \
    '"Hello" is not IsLowerCase'
  ${AssertNot} ${IsLowerCase} "HELLO" \
    '"HELLO" is not IsLowerCase'
  ${Assert} ${IsLowerCase} "" \
    'IsLowerCase "" (empty string)'
  ${Assert} ${IsLowerCase} "123" \
    'IsLowerCase "123" (no alpha chars)'
SectionEnd

Section "IsUpperCase"
  ${Assert} ${IsUpperCase} "HELLO" \
    'IsUpperCase "HELLO"'
  ${Assert} ${IsUpperCase} "HELLO WORLD" \
    'IsUpperCase "HELLO WORLD"'
  ${AssertNot} ${IsUpperCase} "Hello" \
    '"Hello" is not IsUpperCase'
  ${AssertNot} ${IsUpperCase} "hello" \
    '"hello" is not IsUpperCase'
  ${Assert} ${IsUpperCase} "" \
    'IsUpperCase "" (empty string)'
  ${Assert} ${IsUpperCase} "123" \
    'IsUpperCase "123" (no alpha chars)'
SectionEnd

Section "Register preservation (logical)"
  StrCpy $0 "preserved0"
  ${If} ${IsLowerCase} "hello"
    Nop
  ${EndIf}
  ${Assert} $0 == "preserved0" \
    'IsLowerCase preserves $$0'

  StrCpy $0 "preserved0"
  StrCpy $1 "preserved1"
  ${If} "test string" ${Contains} "str"
    Nop
  ${EndIf}
  ${Assert} $0 == "preserved0" \
    'Contains preserves $$0'
  ${Assert} $1 == "preserved1" \
    'Contains preserves $$1'
SectionEnd

Section "LogicLib integration"
  ; ElseIf
  StrCpy $R1 "C:\Program Files\MyApp\setup.exe"
  ${If} $R1 ${EndsWith} ".msi"
    StrCpy $R0 "msi"
  ${ElseIf} $R1 ${EndsWith} ".exe"
    StrCpy $R0 "exe"
  ${Else}
    StrCpy $R0 "unknown"
  ${EndIf}
  ${Assert} $R0 == "exe" \
    'ElseIf matched .exe'

  ; AndIf
  StrCpy $R1 "C:\Temp\logfile.txt"
  ${If} $R1 ${StartsWith} "C:\Temp"
  ${AndIf} $R1 ${EndsWith} ".txt"
    StrCpy $R0 "yes"
  ${Else}
    StrCpy $R0 "no"
  ${EndIf}
  ${Assert} $R0 == "yes" \
    'AndIf StartsWith + EndsWith'

  ; OrIf
  ${If} $R1 ${StartsWith} "D:\"
  ${OrIf} $R1 ${Contains} "log"
    StrCpy $R0 "yes"
  ${Else}
    StrCpy $R0 "no"
  ${EndIf}
  ${Assert} $R0 == "yes" \
    'OrIf (first false, second true)'
SectionEnd

Section "TrimLeft"
  ${TrimLeft} "  hello  " $R0
  ${Assert} $R0 == "hello  " \
    'TrimLeft "  hello  " = "hello  "'

  ${TrimLeft} "$\t$\nhello" $R0
  ${Assert} $R0 == "hello" \
    'TrimLeft tab+newline prefix'

  ${TrimLeft} "hello" $R0
  ${Assert} $R0 == "hello" \
    'TrimLeft no-op'

  ${TrimLeft} "" $R0
  ${Assert} $R0 == "" \
    'TrimLeft empty string'
SectionEnd

Section "TrimRight"
  ${TrimRight} "  hello  " $R0
  ${Assert} $R0 == "  hello" \
    'TrimRight "  hello  " = "  hello"'

  ${TrimRight} "hello$\t$\n" $R0
  ${Assert} $R0 == "hello" \
    'TrimRight tab+newline suffix'
SectionEnd

Section "Trim"
  ${Trim} "  hello  " $R0
  ${Assert} $R0 == "hello" \
    'Trim "  hello  " = "hello"'

  ${Trim} "hello" $R0
  ${Assert} $R0 == "hello" \
    'Trim no-op'

  ${Trim} "   " $R0
  ${Assert} $R0 == "" \
    'Trim all-whitespace = ""'
SectionEnd

Section "PadLeft"
  ${PadLeft} "hi" 5 "0" $R0
  ${Assert} $R0 == "000hi" \
    'PadLeft "hi" 5 "0" = "000hi"'

  ${PadLeft} "hello" 3 "0" $R0
  ${Assert} $R0 == "hello" \
    'PadLeft no-op (already >= target)'

  ${PadLeft} "x" 5 "ab" $R0
  ${Assert} $R0 == "ababx" \
    'PadLeft multi-char pad = "ababx"'

  ${PadLeft} "hi" 5 "" $R0
  ${Assert} $R0 == "hi" \
    'PadLeft empty pad = no-op'
SectionEnd

Section "PadRight"
  ${PadRight} "hi" 5 "." $R0
  ${Assert} $R0 == "hi..." \
    'PadRight "hi" 5 "." = "hi..."'

  ${PadRight} "hello" 3 "." $R0
  ${Assert} $R0 == "hello" \
    'PadRight no-op (already >= target)'
SectionEnd

Section "ToLowerCase"
  ${ToLowerCase} "Hello World" $R0
  ${Assert} $R0 == "hello world" \
    'ToLowerCase "Hello World" = "hello world"'

  ${ToLowerCase} "ALLCAPS" $R0
  ${Assert} $R0 == "allcaps" \
    'ToLowerCase "ALLCAPS" = "allcaps"'

  ${ToLowerCase} "already" $R0
  ${Assert} $R0 == "already" \
    'ToLowerCase no-op'
SectionEnd

Section "ToUpperCase"
  ${ToUpperCase} "Hello World" $R0
  ${Assert} $R0 == "HELLO WORLD" \
    'ToUpperCase "Hello World" = "HELLO WORLD"'

  ${ToUpperCase} "alllower" $R0
  ${Assert} $R0 == "ALLLOWER" \
    'ToUpperCase "alllower" = "ALLLOWER"'

  ${ToUpperCase} "ALREADY" $R0
  ${Assert} $R0 == "ALREADY" \
    'ToUpperCase no-op'
SectionEnd

Section "ToPascalCase"
  ${ToPascalCase} "hello_world" $R0
  ${Assert} $R0 == "HelloWorld" \
    'ToPascalCase "hello_world" = "HelloWorld"'

  ${ToPascalCase} "hello world" $R0
  ${Assert} $R0 == "HelloWorld" \
    'ToPascalCase "hello world" = "HelloWorld"'

  ${ToPascalCase} "hello-world" $R0
  ${Assert} $R0 == "HelloWorld" \
    'ToPascalCase "hello-world" = "HelloWorld"'

  ${ToPascalCase} "helloWorld" $R0
  ${Assert} $R0 == "HelloWorld" \
    'ToPascalCase "helloWorld" = "HelloWorld"'

  ${ToPascalCase} "HTMLParser" $R0
  ${Assert} $R0 == "HtmlParser" \
    'ToPascalCase "HTMLParser" = "HtmlParser"'
SectionEnd

Section "ToCamelCase"
  ${ToCamelCase} "hello_world" $R0
  ${Assert} $R0 == "helloWorld" \
    'ToCamelCase "hello_world" = "helloWorld"'

  ${ToCamelCase} "hello world" $R0
  ${Assert} $R0 == "helloWorld" \
    'ToCamelCase "hello world" = "helloWorld"'

  ${ToCamelCase} "HelloWorld" $R0
  ${Assert} $R0 == "helloWorld" \
    'ToCamelCase "HelloWorld" = "helloWorld"'

  ${ToCamelCase} "HTML_parser" $R0
  ${Assert} $R0 == "htmlParser" \
    'ToCamelCase "HTML_parser" = "htmlParser"'
SectionEnd

Section "ToSnakeCase"
  ${ToSnakeCase} "helloWorld" $R0
  ${Assert} $R0 == "hello_world" \
    'ToSnakeCase "helloWorld" = "hello_world"'

  ${ToSnakeCase} "HelloWorld" $R0
  ${Assert} $R0 == "hello_world" \
    'ToSnakeCase "HelloWorld" = "hello_world"'

  ${ToSnakeCase} "hello-world" $R0
  ${Assert} $R0 == "hello_world" \
    'ToSnakeCase "hello-world" = "hello_world"'

  ${ToSnakeCase} "HTMLParser" $R0
  ${Assert} $R0 == "html_parser" \
    'ToSnakeCase "HTMLParser" = "html_parser"'
SectionEnd

Section "ToConstantCase"
  ${ToConstantCase} "helloWorld" $R0
  ${Assert} $R0 == "HELLO_WORLD" \
    'ToConstantCase "helloWorld" = "HELLO_WORLD"'

  ${ToConstantCase} "HelloWorld" $R0
  ${Assert} $R0 == "HELLO_WORLD" \
    'ToConstantCase "HelloWorld" = "HELLO_WORLD"'

  ${ToConstantCase} "hello_world" $R0
  ${Assert} $R0 == "HELLO_WORLD" \
    'ToConstantCase "hello_world" = "HELLO_WORLD"'

  ${ToConstantCase} "HTMLParser" $R0
  ${Assert} $R0 == "HTML_PARSER" \
    'ToConstantCase "HTMLParser" = "HTML_PARSER"'
SectionEnd

Section "ToCapitalCase"
  ${ToCapitalCase} "hello_world" $R0
  ${Assert} $R0 == "Hello World" \
    'ToCapitalCase "hello_world" = "Hello World"'

  ${ToCapitalCase} "helloWorld" $R0
  ${Assert} $R0 == "Hello World" \
    'ToCapitalCase "helloWorld" = "Hello World"'

  ${ToCapitalCase} "hello-world" $R0
  ${Assert} $R0 == "Hello World" \
    'ToCapitalCase "hello-world" = "Hello World"'
SectionEnd

Section "ToKebabCase"
  ${ToKebabCase} "helloWorld" $R0
  ${Assert} $R0 == "hello-world" \
    'ToKebabCase "helloWorld" = "hello-world"'

  ${ToKebabCase} "HelloWorld" $R0
  ${Assert} $R0 == "hello-world" \
    'ToKebabCase "HelloWorld" = "hello-world"'

  ${ToKebabCase} "hello_world" $R0
  ${Assert} $R0 == "hello-world" \
    'ToKebabCase "hello_world" = "hello-world"'
SectionEnd

Section "Slugify"
  ${Slugify} "Hello World" $R0
  ${Assert} $R0 == "hello-world" \
    'Slugify "Hello World" = "hello-world"'

  ${Slugify} "Hello World 123" $R0
  ${Assert} $R0 == "hello-world-123" \
    'Slugify "Hello World 123" = "hello-world-123"'

  ${Slugify} "  --Multiple   Spaces--  " $R0
  ${Assert} $R0 == "multiple-spaces" \
    'Slugify strips leading/trailing/consecutive separators'
SectionEnd

Section "Reverse"
  ${Reverse} "Hello" $R0
  ${Assert} $R0 == "olleH" \
    'Reverse "Hello" = "olleH"'

  ${Reverse} "abcdef" $R0
  ${Assert} $R0 == "fedcba" \
    'Reverse "abcdef" = "fedcba"'

  ${Reverse} "a" $R0
  ${Assert} $R0 == "a" \
    'Reverse "a" = "a"'

  ${Reverse} "" $R0
  ${Assert} $R0 == "" \
    'Reverse "" = ""'

  ${Reverse} "Hello World" $R0
  ${Assert} $R0 == "dlroW olleH" \
    'Reverse "Hello World" = "dlroW olleH"'
SectionEnd

Section "Edge cases"
  ; Empty string
  ${ToPascalCase} "" $R0
  ${Assert} $R0 == "" \
    'ToPascalCase "" = ""'

  ${ToSnakeCase} "" $R0
  ${Assert} $R0 == "" \
    'ToSnakeCase "" = ""'

  ; Single character
  ${ToPascalCase} "a" $R0
  ${Assert} $R0 == "A" \
    'ToPascalCase "a" = "A"'

  ${ToCamelCase} "A" $R0
  ${Assert} $R0 == "a" \
    'ToCamelCase "A" = "a"'

  ; Digits preserved
  ${ToPascalCase} "hello2World" $R0
  ${Assert} $R0 == "Hello2world" \
    'ToPascalCase "hello2World" = "Hello2world"'

  ${ToSnakeCase} "hello2World" $R0
  ${Assert} $R0 == "hello2_world" \
    'ToSnakeCase "hello2World" = "hello2_world"'

  ${ToCamelCase} "version2" $R0
  ${Assert} $R0 == "version2" \
    'ToCamelCase "version2" = "version2"'

  ${ToKebabCase} "version2" $R0
  ${Assert} $R0 == "version2" \
    'ToKebabCase "version2" = "version2"'

  ${ToConstantCase} "hello2World" $R0
  ${Assert} $R0 == "HELLO2_WORLD" \
    'ToConstantCase "hello2World" = "HELLO2_WORLD"'

  ${ToPascalCase} "123abc" $R0
  ${Assert} $R0 == "123abc" \
    'ToPascalCase "123abc" = "123abc"'

  ; Consecutive / leading / trailing separators
  ${ToPascalCase} "__hello__world__" $R0
  ${Assert} $R0 == "HelloWorld" \
    'ToPascalCase "__hello__world__" = "HelloWorld"'

  ${ToSnakeCase} "--hello--world--" $R0
  ${Assert} $R0 == "hello_world" \
    'ToSnakeCase "--hello--world--" = "hello_world"'

  ${ToKebabCase} "  hello  world  " $R0
  ${Assert} $R0 == "hello-world" \
    'ToKebabCase "  hello  world  " = "hello-world"'

  ; All-uppercase
  ${ToPascalCase} "HELLO" $R0
  ${Assert} $R0 == "Hello" \
    'ToPascalCase "HELLO" = "Hello"'

  ${ToSnakeCase} "HELLOWORLD" $R0
  ${Assert} $R0 == "helloworld" \
    'ToSnakeCase "HELLOWORLD" = "helloworld" (no boundary)'

  ; Acronym chains
  ${ToPascalCase} "XMLToJSON" $R0
  ${Assert} $R0 == "XmlToJson" \
    'ToPascalCase "XMLToJSON" = "XmlToJson"'

  ${ToSnakeCase} "getHTTPSUrl" $R0
  ${Assert} $R0 == "get_https_url" \
    'ToSnakeCase "getHTTPSUrl" = "get_https_url"'

  ; Mixed separator types
  ${ToPascalCase} "hello_world-foo bar" $R0
  ${Assert} $R0 == "HelloWorldFooBar" \
    'ToPascalCase mixed separators = "HelloWorldFooBar"'

  ; Unicode
  ${ToPascalCase} "überAll" $R0
  ${Assert} $R0 S== "ÜberAll" \
    'ToPascalCase "überAll" = "ÜberAll"'

  ${ToSnakeCase} "ÄRGER" $R0
  ${Assert} $R0 S== "ärger" \
    'ToSnakeCase "ÄRGER" = "ärger"'
SectionEnd

Section "Register preservation (transforms)"
  StrCpy $0 "reg0"
  StrCpy $1 "reg1"
  StrCpy $2 "reg2"
  StrCpy $3 "reg3"
  StrCpy $9 "reg9"
  StrCpy $R0 "regR0"
  ${ToPascalCase} "hello_world" $R1
  ${Assert} $0 == "reg0" \
    'ToPascalCase preserves $$0'
  ${Assert} $1 == "reg1" \
    'ToPascalCase preserves $$1'
  ${Assert} $2 == "reg2" \
    'ToPascalCase preserves $$2'
  ${Assert} $3 == "reg3" \
    'ToPascalCase preserves $$3'
  ${Assert} $9 == "reg9" \
    'ToPascalCase preserves $$9'
  ${Assert} $R0 == "regR0" \
    'ToPascalCase preserves $$R0'
SectionEnd

Section "Summary"
  ${AssertSummary}
SectionEnd
