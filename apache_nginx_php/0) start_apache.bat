@echo off
color 0A

:: httpd.exe -h|/?
:: httpd -t  语法检查
:: httpd -k start|restart|stop|shutdown
:: httpd -k install|uninstall


set CUR_DIR=%~dp0
set APACHEDIR=Apache24
set EXECUTABLE=%CUR_DIR%\%APACHEDIR%\bin\httpd.exe

echo 正在启动Apache HTTP服务器......
echo  结束请按 "Ctrl + C"  ......

"%EXECUTABLE%" -t

"%EXECUTABLE%"

echo 已经运行结束. & pause


