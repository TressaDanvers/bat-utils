@echo off
setlocal
set "PREFIX=%~1"
call build.bat deploy
endlocal
exit /b %errorlevel%
