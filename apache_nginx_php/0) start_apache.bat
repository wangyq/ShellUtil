@echo off
color 0A

:: httpd.exe -h|/?
:: httpd -t  �﷨���
:: httpd -k start|restart|stop|shutdown
:: httpd -k install|uninstall


set CUR_DIR=%~dp0
set APACHEDIR=Apache24
set EXECUTABLE=%CUR_DIR%\%APACHEDIR%\bin\httpd.exe

echo ��������Apache HTTP������......
echo  �����밴 "Ctrl + C"  ......

"%EXECUTABLE%" -t

"%EXECUTABLE%"

echo �Ѿ����н���. & pause


