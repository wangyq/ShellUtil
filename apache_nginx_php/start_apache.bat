@echo off
color 0A

:: httpd.exe -h|/?
:: httpd -t  语法检查
:: httpd -k start|restart|stop|shutdown
:: httpd -k install|uninstall


echo 正在启动Apache HTTP服务器......

set CUR_DIR=%CD%
set EXECUTABLE=%CUR_DIR%\bin\httpd.exe

call "%EXECUTABLE%" 


echo 已经运行结束. & pause


