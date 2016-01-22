@echo off
color 0A
echo 正在安装Apache HTTP服务器......

set CUR_DIR=%CD%
set EXECUTABLE=%CUR_DIR%\bin\httpd.exe

call "%EXECUTABLE%" -t
call "%EXECUTABLE%" -k install

REM net start "Apache2.2"
call "%EXECUTABLE%" -k start

echo 安装完成.
pause 

