
@ECHO OFF
COLOR 0A
REM ======================================
REM ����JAVA�Ľű�

::��ǰ·��
SET CUR_DIR=%CD%

CALL SET_JAVA.BAT

CD %CUR_DIR%\apache-tomcat-7.0.30\bin
CALL startup.bat

REM ����Զ�ɾ������
ECHO =====================================================
SET /P MM_TEMP=�밴�����ɾ�� Apache TOMCAT ����......
shutdown.bat