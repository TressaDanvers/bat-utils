@echo off
setlocal

set "bin=%~dp0"
set "status=0"

if "%~1"=="" (
  call "%bin%err-fatal.bat" usage "check script..."
  exit /b 1
)

where blinter.exe > nul 2>&1
if errorlevel 1 (
  call "%bin%err-fatal.bat" check "blinter is not installed"
  exit /b 1
)

:next
if "%~1"=="" exit /b %status%
call :check_one "%~1"
shift /1
REM LINT:IGNORE W004
goto next

:check_one
call "%bin%info.bat" checking "%~1"
call blinter.exe "%~1"
if errorlevel 1 (
  call "%bin%err.bat" "%~1" "blinter found a problem"
  set "status=1"
)
exit /b 0
