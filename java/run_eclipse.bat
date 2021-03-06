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
SET JDK_DIR=%DRIVER_DIR%Java\jdk1.6.0_21

::ANT的安装路径
SET ANT_DIR=%DRIVER_DIR%Java\apache-ant-1.8.1

if exist  %ANT_DIR%/nul (
  SET ANT_HOME=%ANT_DIR%
  SET PATH=%PATH%;%ANT_DIR%/bin
  )

::设置JAVA环境变量
SET JAVA_HOME="%JDK_DIR%"
SET CLASS_PATH=".;%JDK_DIR%/lib/tools.jar;%JDK_DIR%/lib/dt.jar"

::设置PATH环境变量
SET PATH=%PATH%;%JDK_DIR%/bin

::
START eclipse.exe

::
exit