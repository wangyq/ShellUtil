@echo off
color 2F
echo ����ж��MySQL������......

net stop "MySQL"

set CUR_DIR=%CD%
set EXECUTABLE=%CUR_DIR%\bin\mysqld.exe

call "%EXECUTABLE%" --remove

echo ж�����.
pause
