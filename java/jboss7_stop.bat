
@ECHO OFF
COLOR 0A
REM ======================================
REM ����JAVA�Ľű�

::��ǰ·��
SET CUR_DIR=%CD%

CALL SET_JAVA.BAT

CD %CUR_DIR%\jboss-as-7.1.1.Final\bin
CALL jboss-admin.bat --connect command=:shutdown
