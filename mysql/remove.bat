@echo off
color 2F
echo ����ж��MySQL������......

set MYNAME=MySQL

net stop "MySQL"

REM set CUR_DIR=%CD%
set CUR_DIR=%~dp0
set EXECUTABLE=%CUR_DIR%bin\mysqld.exe

ECHO ������=%EXECUTABLE%

call "%EXECUTABLE%" --remove

echo ж�����.
pause
