@echo off
color 0A
echo ���ڰ�װMySQL������......

REM set CUR_DIR=%CD%
set CUR_DIR=%~dp0
set MYNAME=MySQL
set EXECUTABLE=%CUR_DIR%bin\mysqld.exe

ECHO ������=%EXECUTABLE%

REM �����������ο�
REM mysqld.exe --console

REM ��һ�γ�ʼ�����ݿ�, root������
REM call "%EXECUTABLE%"  --initialize-insecure

REM --local-service ���ڰ�ȫ�Կ���
REM ������������ԭ��
REM call "%EXECUTABLE%" --install MySQL --defaults-file="%CUR_DIR%/my.--console" --local-service 
call "%EXECUTABLE%" --install MySQL --defaults-file="%CUR_DIR%my.ini"
REM call "%EXECUTABLE%" --install 

net start "MySQL"
echo ��װ���.
pause 
