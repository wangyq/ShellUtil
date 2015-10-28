
@ECHO OFF
COLOR 0A
REM ======================================
REM 运行JAVA的脚本


::当前路径
SET CUR_DIR=%CD%


CALL SET_JAVA.BAT

CD %CUR_DIR%\apache-tomcat-6.0.36\bin
shutdown.bat

CALL CMD.EXE