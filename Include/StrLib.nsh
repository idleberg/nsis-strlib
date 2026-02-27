; ---------------------
;      StrLib.nsh
; ---------------------
;
; NSIS String Library — provides LogicLib string test operators
; and string transformation macros.
;
; Usage:
;   !include "StrLib.nsh"
;
; This includes both sub-headers:
;   StrLib\Logical.nsh    — LogicLib operators (StartsWith, EndsWith, Contains, etc.)
;   StrLib\Transforms.nsh — String transformations (Trim, ToPascalCase, Slugify, etc.)
;
; You may also include either sub-header individually if you only need
; part of the functionality.

!ifndef STRLIB_INCLUDED
  !define STRLIB_INCLUDED

  !include "StrLib\Logical.nsh"
  !include "StrLib\Transforms.nsh"

!endif ; STRLIB_INCLUDED
