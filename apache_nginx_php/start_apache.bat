@echo off
color 0A

:: httpd.exe -h|/?
:: httpd -t  �﷨���
:: httpd -k start|restart|stop|shutdown
:: httpd -k install|uninstall


echo ��������Apache HTTP������......

set CUR_DIR=%CD%
set EXECUTABLE=%CUR_DIR%\bin\httpd.exe

call "%EXECUTABLE%" 


echo �Ѿ����н���. & pause


