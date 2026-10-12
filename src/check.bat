@echo off
setlocal

set "bin=%~dp0"
set "status=0"

if "%~1"=="" (
  call "%bin%err-fatal.bat" usage "check script..."
  exit /b 1
)

:next
if "%~1"=="" exit /b %status%
call :one "%~1"
shift /1
REM LINT:IGNORE W004
goto next

:one
set "script=%~1"
call "%bin%info.bat" checking "%script%"
if not exist "%script%" (
  call :problem "file not found"
  goto :eof
)
set "line1=."
set "line2=."
for /f "usebackq delims=" %%l in ("%script%") do (
  set "line1=%%l"
  goto got1
)

:got1
for /f "usebackq skip=1 delims=" %%l in ("%script%") do (
  set "line2=%%l"
  goto got2
)

:got2
if not "%line1%"=="@echo off" call :problem "line 1 is not @echo off"
set "head=%line2:~0,8%"
if not "%head%"=="setlocal" call :problem "line 2 is not setlocal"
goto :eof

:problem
call "%bin%err.bat" "%script%" "%~1"
set "status=1"
goto :eof
