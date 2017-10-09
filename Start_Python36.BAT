@ECHO OFF
COLOR 0A
REM ======================================
REM 运行Python的脚本

::当前路径
SET CUR_DIR=%~dp0

::取盘符信息
SET DRIVER_DIR=%~d0

::Python的安装路径
SET PYTHON_DIR=%DRIVER_DIR%/devetools\Python36

if exist %PYTHON_DIR%/nul ( 
	SET PATH=%PATH%;%PYTHON_DIR%/;%PYTHON_DIR%/Scripts
)

::GIT的安装路径
SET GIT_DIR=%DRIVER_DIR%/devetools\Git
if exist  %GIT_DIR%/nul (
  SET PATH=%PATH%;%GIT_DIR%/bin
  git config --global user.name "wangyq"
  git config --global user.email "yinqingwang@gmail.com"
  )
  
::Subversion的安装路径
SET SUBVERSION_DIR=E:\Subversion
if exist  %SUBVERSION_DIR%/nul (

  SET PATH=%PATH%;%SUBVERSION_DIR%/bin
  )
 
::设置PATH环境变量
D:
CD \000\python
CALL CMD.EXE
