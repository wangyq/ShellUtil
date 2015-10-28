
@ECHO OFF
COLOR 0A
REM ======================================
REM 运行JAVA的脚本

::当前路径
SET CUR_DIR=%CD%

CALL SET_JAVA.BAT

CD %CUR_DIR%\apache-tomcat-7.0.30\bin
CALL startup.bat

REM 添加自动删除服务
ECHO =====================================================
SET /P MM_TEMP=请按任意键删除 Apache TOMCAT 服务......
shutdown.bat