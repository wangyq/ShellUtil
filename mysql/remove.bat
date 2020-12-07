@echo off
color 2F
echo 正在卸载MySQL服务器......

set MYNAME=MySQL

net stop "MySQL"

REM set CUR_DIR=%CD%
set CUR_DIR=%~dp0
set EXECUTABLE=%CUR_DIR%bin\mysqld.exe

ECHO 命令行=%EXECUTABLE%

call "%EXECUTABLE%" --remove

echo 卸载完成.
pause
