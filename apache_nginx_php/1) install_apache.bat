@echo off
color 0A

set CUR_DIR=%~dp0
set EXECUTABLE=%CUR_DIR%\bin\httpd.exe

echo ���ڰ�װApache HTTP������......

REM �������Ƿ���ȷ
"%EXECUTABLE%" -t
"%EXECUTABLE%" -k install
"%EXECUTABLE%" -k start

echo Apache HTTP�������Ѿ�����......

echo ==== �������ֹͣ��ɾ��Apache HTTP ������. & pause
REM net stop "Apache2"
"%EXECUTABLE%" -k stop
"%EXECUTABLE%" -k uninstall

echo ж�����.
pause

