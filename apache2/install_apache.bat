@echo off
color 0A
echo ���ڰ�װApache HTTP������......

set CUR_DIR=%CD%
set EXECUTABLE=%CUR_DIR%\bin\httpd.exe

call "%EXECUTABLE%" -t
call "%EXECUTABLE%" -k install

REM net start "Apache2.2"
call "%EXECUTABLE%" -k start

echo ��װ���.
pause 

