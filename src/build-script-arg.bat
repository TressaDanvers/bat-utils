@echo off
setlocal

if not "%~2"=="" goto bad
if "%~1"=="" exit /b 0
if "%~1"=="deploy" exit /b 0
if "%~1"=="clean" exit /b 0
if "%~1"=="check" exit /b 0

:bad
call "%~dp0err-fatal.bat" usage "build.bat [deploy|clean|check]"
exit /b 1
