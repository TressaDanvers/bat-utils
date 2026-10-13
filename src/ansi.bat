@echo off
for /f "tokens=1 delims= " %%e in ('echo prompt $E ^| cmd') do set "esc=%%e"
set "red=%esc%[1;31m"
set "yellow=%esc%[1;33m"
set "blue=%esc%[1;34m"
set "green=%esc%[1;32m"
set "default=%esc%[39m"
set "normal=%esc%[22m"
exit /b 0
