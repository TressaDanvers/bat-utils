@echo off
setlocal

set "status=0"

if "%~1"=="" (
  call "%~dp0"err-fatal.bat usage "check-bat[.bat] script..."
  endlocal
  exit /b 1
)

REM LINT:IGNORE W009
where blinter.exe > nul 2>&1
if errorlevel 1 (
  call "%~dp0"err-fatal.bat check "blinter is not installed"
  endlocal
  exit /b 1
)

:next
if "%~1"=="" exit /b %status%
call :check_one "%~1"
shift /1
REM LINT:IGNORE W004
goto next

:check_one
call "%~dp0"info.bat check "%~1"
call blinter.exe "%~1"
if errorlevel 1 (
  call "%~dp0"err.bat check "%~1: blinter found a problem"
  set "status=1"
)
exit /b 0
