@ECHO OFF
COLOR 0A
REM ======================================
REM 运行JAVA的脚本

::当前路径
SET CUR_DIR=%CD%

::取盘符信息
CD \
SET DRIVER_DIR=%CD%
CD %CUR_DIR%

::JDK的安装路径
::SET JDK_DIR=%CUR_DIR%/jdk1.6.0_21
SET JDK_DIR=%DRIVER_DIR%Java\jdk1.7.0_40_x64



::MYSQL的安装路径
SET MYSQL_DIR=%DRIVER_DIR%mysql-5.1.51-win32
if exist  %MYSQL_DIR%/nul (
  
  SET PATH=%PATH%;%MYSQL_DIR%/bin
  )

::ANT的安装路径
SET ANT_DIR=%DRIVER_DIR%Java\apache-ant-1.8.4

if exist  %ANT_DIR%/nul (
  SET ANT_HOME=%ANT_DIR%
  SET PATH=%PATH%;%ANT_DIR%/bin
  )


::MAVEN的安装路径
SET MAVEN_DIR=%DRIVER_DIR%Java\apache-maven
if exist  %MAVEN_DIR%/nul (
  SET M2_HOME=%MAVEN_DIR%
  SET PATH=%PATH%;%MAVEN_DIR%/bin
  )


::GIT的安装路径
SET GIT_DIR=%DRIVER_DIR%Java\Git
if exist  %GIT_DIR%/nul (
  SET gitdir=%GIT_DIR%
  SET PATH=%PATH%;%GIT_DIR%/cmd
  )
  
::Subversion的安装路径
SET SUBVERSION_DIR=E:\Subversion
if exist  %SUBVERSION_DIR%/nul (

  SET PATH=%PATH%;%SUBVERSION_DIR%/bin
  )
  
::设置JAVA环境变量
SET JAVA_HOME="%JDK_DIR%"
SET CLASSPATH=".;%JDK_DIR%/lib/tools.jar;%JDK_DIR%/lib/dt.jar"

::设置PATH环境变量
SET PATH=%PATH%;%JDK_DIR%/bin
D:
CD \000\java
CALL CMD.EXE
