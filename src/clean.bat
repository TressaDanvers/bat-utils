@echo off
setlocal

call build.bat clean
exit /b %errorlevel%
