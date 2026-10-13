@echo off
setlocal enabledelayedexpansion

set "status=0"
call "%~dp0"ansi.bat

if "%~1"=="" (
  echo !red!error:!default! usage:!normal! err[.bat] first [rest...] 1>&2
  set "status=2"
  goto end
)

set "first=%~1"
set "rest=%*"
set "rest=!rest:"=!"
set "rest=!rest:*%~1=!"

if defined rest (
  echo !red!error:!default! !first!:!normal!!rest! 1>&2
) else (
  echo !red!error:!default!!normal! !first! 1>&2
)

:end
endlocal
exit /b %status%
