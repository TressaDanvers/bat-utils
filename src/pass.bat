@echo off
setlocal enabledelayedexpansion

set "status=0"
call "%~dp0"ansi.bat

if "%~1"=="" (
  echo !green!success:!default! usage:!normal! pass[.bat] first [rest...] 1>&2
  set "status=2"
  goto end
)

set "first=%~1"
set "rest=%*"
set "rest=!rest:"=!"
set "rest=!rest:*%~1=!"

if defined rest (
  echo !green!success:!default! !first!:!normal!!rest!
) else (
  echo !green!success:!default!!normal! !first!
)

:end
endlocal
exit /b %status%
