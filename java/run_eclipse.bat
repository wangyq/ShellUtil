@ECHO OFF
COLOR 0A
REM ======================================
REM ����JAVA�Ľű�

::��ǰ·��
SET CUR_DIR=%CD%

::ȡ�̷���Ϣ
CD \
SET DRIVER_DIR=%CD%
CD %CUR_DIR%

::JDK�İ�װ·��
::SET JDK_DIR=%CUR_DIR%/jdk1.6.0_21
SET JDK_DIR=%DRIVER_DIR%Java\jdk1.6.0_21

::ANT�İ�װ·��
SET ANT_DIR=%DRIVER_DIR%Java\apache-ant-1.8.1

if exist  %ANT_DIR%/nul (
  SET ANT_HOME=%ANT_DIR%
  SET PATH=%PATH%;%ANT_DIR%/bin
  )

::����JAVA��������
SET JAVA_HOME="%JDK_DIR%"
SET CLASS_PATH=".;%JDK_DIR%/lib/tools.jar;%JDK_DIR%/lib/dt.jar"

::����PATH��������
SET PATH=%PATH%;%JDK_DIR%/bin

::
START eclipse.exe

::
exit