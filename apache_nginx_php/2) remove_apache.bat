@echo off
color 2F
echo ����ж��Apache HTTP������......

set CUR_DIR=%~dp0

set EXECUTABLE=%CUR_DIR%\bin\httpd.exe

REM net stop "Apache2"
call "%EXECUTABLE%" -k stop

call "%EXECUTABLE%" -k uninstall

echo ж�����.
pause

