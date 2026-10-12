@echo off
setlocal

set "PREFIX=%~1"
call build.bat deploy
exit /b %errorlevel%
