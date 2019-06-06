@echo off
color 0A

set CUR_DIR=%~dp0
set APACHEDIR=Apache24
set EXECUTABLE=%CUR_DIR%\%APACHEDIR%\bin\httpd.exe

echo 正在安装Apache HTTP服务器......

REM 检查参数是否正确
"%EXECUTABLE%" -t
"%EXECUTABLE%" -k install
"%EXECUTABLE%" -k start

echo Apache HTTP服务器已经运行......

echo ==== 按任意键停止并删除Apache HTTP 服务器. & pause
REM net stop "Apache2"
"%EXECUTABLE%" -k stop
"%EXECUTABLE%" -k uninstall

echo 卸载完成.
pause

