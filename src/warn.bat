@echo off
setlocal enabledelayedexpansion

set "status=0"
call "%~dp0"ansi.bat

if "%~1"=="" (
  echo !yellow!warning:!default! usage:!normal! warn[.bat] first [rest...] 1>&2
  set "status=2"
  goto end
)

set "first=%~1"
set "rest=%*"
set "rest=!rest:"=!"
set "rest=!rest:*%~1=!"

if defined rest (
  echo !yellow!warning:!default! !first!:!normal!!rest! 1>&2
) else (
  echo !yellow!warning:!default!!normal! !first! 1>&2
)

:end
endlocal
exit /b %status%
