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
SET JDK_DIR=%DRIVER_DIR%Java\jdk1.7.0_40_x64



::MYSQL�İ�װ·��
SET MYSQL_DIR=%DRIVER_DIR%mysql-5.1.51-win32
if exist  %MYSQL_DIR%/nul (
  
  SET PATH=%PATH%;%MYSQL_DIR%/bin
  )

::ANT�İ�װ·��
SET ANT_DIR=%DRIVER_DIR%Java\apache-ant-1.8.4

if exist  %ANT_DIR%/nul (
  SET ANT_HOME=%ANT_DIR%
  SET PATH=%PATH%;%ANT_DIR%/bin
  )


::MAVEN�İ�װ·��
SET MAVEN_DIR=%DRIVER_DIR%Java\apache-maven
if exist  %MAVEN_DIR%/nul (
  SET M2_HOME=%MAVEN_DIR%
  SET PATH=%PATH%;%MAVEN_DIR%/bin
  )


::GIT�İ�װ·��
SET GIT_DIR=%DRIVER_DIR%Java\Git
if exist  %GIT_DIR%/nul (
  SET gitdir=%GIT_DIR%
  SET PATH=%PATH%;%GIT_DIR%/cmd
  )
  
::Subversion�İ�װ·��
SET SUBVERSION_DIR=E:\Subversion
if exist  %SUBVERSION_DIR%/nul (

  SET PATH=%PATH%;%SUBVERSION_DIR%/bin
  )
  
::����JAVA��������
SET JAVA_HOME="%JDK_DIR%"
SET CLASSPATH=".;%JDK_DIR%/lib/tools.jar;%JDK_DIR%/lib/dt.jar"

::����PATH��������
SET PATH=%PATH%;%JDK_DIR%/bin
D:
CD \000\java
CALL CMD.EXE
