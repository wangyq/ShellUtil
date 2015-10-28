@echo off
color 2F
echo 正在卸载MySQL服务器......

net stop "MySQL"

set CUR_DIR=%CD%
set EXECUTABLE=%CUR_DIR%\bin\mysqld.exe

call "%EXECUTABLE%" --remove

echo 卸载完成.
pause
