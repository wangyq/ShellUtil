@echo off
color 0A
echo ���ڰ�װMysql������......

set CUR_DIR=%CD%
set EXECUTABLE=%CUR_DIR%\bin\mysqld.exe

REM �����������ο�
REM mysqld.exe --console

REM --local-service ���ڰ�ȫ�Կ���
REM ������������ԭ��
REM call "%EXECUTABLE%" --install MySQL --defaults-file="%CUR_DIR%/my.--console" --local-service 
call "%EXECUTABLE%" --install MySQL --defaults-file="%CUR_DIR%/my.ini"
REM call "%EXECUTABLE%" --install 

net start "MySQL"
echo ��װ���.
pause 
