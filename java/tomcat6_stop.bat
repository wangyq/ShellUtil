
@ECHO OFF
COLOR 0A
REM ======================================
REM ����JAVA�Ľű�


::��ǰ·��
SET CUR_DIR=%CD%


CALL SET_JAVA.BAT

CD %CUR_DIR%\apache-tomcat-6.0.36\bin
shutdown.bat

CALL CMD.EXE