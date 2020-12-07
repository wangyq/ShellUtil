@echo off
color 0A
echo 正在安装MySQL服务器......

REM set CUR_DIR=%CD%
set CUR_DIR=%~dp0
set MYNAME=MySQL
set EXECUTABLE=%CUR_DIR%bin\mysqld.exe

ECHO 命令行=%EXECUTABLE%

REM 命令行启动参考
REM mysqld.exe --console

REM 第一次初始化数据库, root空密码
REM call "%EXECUTABLE%"  --initialize-insecure

REM --local-service 基于安全性考虑
REM 服务不能启动，原因
REM call "%EXECUTABLE%" --install MySQL --defaults-file="%CUR_DIR%/my.--console" --local-service 
call "%EXECUTABLE%" --install MySQL --defaults-file="%CUR_DIR%my.ini"
REM call "%EXECUTABLE%" --install 

net start "MySQL"
echo 安装完成.
pause 
