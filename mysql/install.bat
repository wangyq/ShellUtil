@echo off
color 0A
echo 正在安装Mysql服务器......

set CUR_DIR=%CD%
set EXECUTABLE=%CUR_DIR%\bin\mysqld.exe

REM 命令行启动参考
REM mysqld.exe --console

REM --local-service 基于安全性考虑
REM 服务不能启动，原因
REM call "%EXECUTABLE%" --install MySQL --defaults-file="%CUR_DIR%/my.--console" --local-service 
call "%EXECUTABLE%" --install MySQL --defaults-file="%CUR_DIR%/my.ini"
REM call "%EXECUTABLE%" --install 

net start "MySQL"
echo 安装完成.
pause 
