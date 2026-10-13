@echo off
setlocal

cd /d "%~dp0"
call .\src\build-script-arg.bat "%~1" "%~2" || exit /b 1

if "%~1"=="" goto build
if "%~1"=="deploy" goto deploy
if "%~1"=="clean" goto clean
if "%~1"=="check" goto check

:build
call .\src\err-fatal.bat build "this project has no build"
endlocal
exit /b 1

:deploy
REM LINT:IGNORE SEC006
if not defined PREFIX set "PREFIX=C:\Program Files\bat-utils"
if not exist "%PREFIX%\bin" mkdir "%PREFIX%\bin"
if not exist "%PREFIX%\bin" (
  call .\src\err-fatal.bat deploy "cannot make %PREFIX%\bin"
  endlocal
  exit /b 1
)
for %%f in (.\src\*.bat) do call :deploy_one "%%f" || exit /b 1
call :path_add || exit /b 1
endlocal
exit /b 0

:deploy_one
set "name=%~nx1"
call .\src\info.bat deploying "%PREFIX%\bin\%name%"
REM LINT:IGNORE P022
copy /y "%~1" "%PREFIX%\bin\%name%" > nul
if errorlevel 1 (
  call .\src\err-fatal.bat deploy "cannot copy %~1"
  exit /b 1
)
exit /b 0

:path_add
set "regkey=HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
set "bindir=%PREFIX%\bin"
set "regtype=REG_EXPAND_SZ"
set "syspath="
for /f "tokens=1,2,* delims= " %%a in ('reg query "%regkey%" /v Path') do (
  if /i "%%a"=="Path" set "regtype=%%b"
  if /i "%%a"=="Path" set "syspath=%%c"
)
if not defined syspath (
  call .\src\err-fatal.bat deploy "cannot read the system path"
  exit /b 1
)
set "found="
for %%p in ("%syspath:;=" "%") do if /i "%%~p"=="%bindir%" set "found=1"
if defined found exit /b 0
call .\src\info.bat adding "%bindir% to the system path"
REM LINT:IGNORE P022
reg add "%regkey%" /v Path /t %regtype% /d "%syspath%;%bindir%" /f > nul
if errorlevel 1 (
  call .\src\err-fatal.bat deploy "cannot add %bindir% to the system path"
  exit /b 1
)
exit /b 0

:clean
call .\src\err-fatal.bat clean "bat-utils has nothing to clean"
endlocal
exit /b 1

:check
call .\src\check-bat.bat .\.
endlocal & exit /b %errorlevel%
