@echo off
color 2F
echo 正在卸载Apache HTTP服务器......

set CUR_DIR=%~dp0

set EXECUTABLE=%CUR_DIR%\bin\httpd.exe

REM net stop "Apache2"
call "%EXECUTABLE%" -k stop

call "%EXECUTABLE%" -k uninstall

echo 卸载完成.
pause

