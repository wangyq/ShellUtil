
@ECHO OFF
COLOR 0A
REM ======================================
REM 运行JAVA的脚本

::当前路径
SET CUR_DIR=%CD%

CALL SET_JAVA.BAT

CD %CUR_DIR%\jboss-as-7.1.1.Final\bin
CALL jboss-admin.bat --connect command=:shutdown
