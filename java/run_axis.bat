
@ECHO OFF
COLOR 0A
SET AXIS2_PATH=axis2-1.6.2
REM ======================================
REM ����JAVA�Ľű�

::��ǰ·��
SET CUR_DIR=%CD%
SET AXIS2_HOME=%CUR_DIR%\%AXIS2_PATH%
SET PATH=%PATH%;%AXIS2_HOME%\bin

CALL SET_JAVA.BAT

CD %CUR_DIR%
CALL CMD.EXE
