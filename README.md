# StrLib

A string library for [NSIS](https://nsis.sourceforge.io/) providing LogicLib string-test operators and string transformation macros.

## Minimum Requirements

- NSIS 3.0 (Unicode)
- Windows 2000 / Windows Vista for the `${Slugify}` macro

## Installation

Compile `installme.nsi` and execute it:

```powershell
makensis -DINSTALLNAME=StrLib installme.nsi
```

Alternatively, copy the contents of `Include\` to `${NSISDIR}\Include\`:

```
NSIS\Include\StrLib.nsh
NSIS\Include\StrLib\Logical.nsh
NSIS\Include\StrLib\Transforms.nsh
```

## Usage

```nsis
!include "StrLib.nsh"
```

## Macros

### String tests

LogicLib operators for use with `${If}`, `${IfNot}`, `${ElseIf}`, `${AndIf}`, `${OrIf}`, etc.

| Macro            | Example                          | Description                     |
| ---------------- | -------------------------------- | ------------------------------- |
| `${StartsWith}`  | `${If} $0 ${StartsWith} "http"`  | Case-insensitive prefix test    |
| `${StartsWithS}` | `${If} $0 ${StartsWithS} "HTTP"` | Case-sensitive prefix test      |
| `${EndsWith}`    | `${If} $0 ${EndsWith} ".exe"`    | Case-insensitive suffix test    |
| `${EndsWithS}`   | `${If} $0 ${EndsWithS} ".EXE"`   | Case-sensitive suffix test      |
| `${Contains}`    | `${If} $0 ${Contains} "temp"`    | Case-insensitive substring test |
| `${ContainsS}`   | `${If} $0 ${ContainsS} "Temp"`   | Case-sensitive substring test   |

### String transformations

All transformations follow the same calling convention: `${Macro} INPUT OUTPUT`.

| Macro               | Input             | Output            | Description                            |
| ------------------- | ----------------- | ----------------- | -------------------------------------- |
| `${TrimLeft}`       | `"  hello  "`     | `"hello  "`       | Remove leading whitespace              |
| `${TrimRight}`      | `"  hello  "`     | `"  hello"`       | Remove trailing whitespace             |
| `${Trim}`           | `"  hello  "`     | `"hello"`         | Remove leading and trailing whitespace |
| `${PadLeft}`        | `"hi" 5 "0"`      | `"000hi"`         | Pad on the left to target length       |
| `${PadRight}`       | `"hi" 5 "."`      | `"hi..."`         | Pad on the right to target length      |
| `${ToLowerCase}`    | `"Hello World"`   | `"hello world"`   | Convert to lowercase                   |
| `${ToUpperCase}`    | `"Hello World"`   | `"HELLO WORLD"`   | Convert to uppercase                   |
| `${ToCapitalCase}`  | `"hello_world"`   | `"Hello World"`   | Convert to Capital Case                |
| `${ToPascalCase}`   | `"hello_world"`   | `"HelloWorld"`    | Convert to PascalCase                  |
| `${ToCamelCase}`    | `"hello_world"`   | `"helloWorld"`    | Convert to camelCase                   |
| `${ToSnakeCase}`    | `"helloWorld"`    | `"hello_world"`   | Convert to snake_case                  |
| `${ToConstantCase}` | `"helloWorld"`    | `"HELLO_WORLD"`   | Convert to CONSTANT_CASE               |
| `${ToKebabCase}`    | `"helloWorld"`    | `"hello-world"`   | Convert to kebab-case                  |
| `${Slugify}`        | `"Ärger über Öl"` | `"arger-uber-ol"` | URL-safe slug                          |

See [example](Examples\StrLib.nsi) for details.

## Known Issues

### File Encoding

These macros expect your script files to be encoded properly as UTF-8 with BOM.

## License

[The MIT License](LICENSE) - Feel free to use, modify, and distribute this code.
