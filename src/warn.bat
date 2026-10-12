@echo off
setlocal enabledelayedexpansion

for /f "tokens=1 delims= " %%e in ('echo prompt $E ^| cmd') do set "esc=%%e"
set "tag=!esc![1;33mwarn:!esc![39m"

if "%~1"=="" (
  echo !tag! usage:!esc![22m warn first [rest...] 1>&2
  exit /b 2
)

set "first=%~1"
shift /1
set "rest="

:collect
if "%~1"=="" goto collected
set "rest=!rest! %~1"
shift /1
REM LINT:IGNORE W004
goto collect

:collected
if defined rest (
  echo !tag! !first!:!esc![22m!rest! 1>&2
) else (
  echo !tag!!esc![22m !first! 1>&2
)
