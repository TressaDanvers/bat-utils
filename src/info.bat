@echo off
setlocal enabledelayedexpansion

set "status=0"
call "%~dp0"ansi.bat

if "%~1"=="" (
  echo !blue!info:!default! usage:!normal! info[.bat] first [rest...] 1>&2
  set "status=2"
  goto end
)

set "first=%~1"
set "rest=%*"
set "rest=!rest:"=!"
set "rest=!rest:*%~1=!"

if defined rest (
  echo !blue!info:!default! !first!:!normal!!rest!
) else (
  echo !blue!info:!default!!normal! !first!
)

:end
endlocal
exit /b %status%
