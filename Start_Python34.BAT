@ECHO OFF
COLOR 0A
REM ======================================
REM ����Python�Ľű�

::��ǰ·��
SET CUR_DIR=%CD%

::ȡ�̷���Ϣ
CD \
SET DRIVER_DIR=%CD%
CD %CUR_DIR%

::Python�İ�װ·��
SET PYTHON_DIR=%DRIVER_DIR%devetools\Python34
if exist %PYTHON_DIR%/nul (
	SET PATH=%PATH%;%PYTHON_DIR%/;%PYTHON_DIR%/Scripts
)

::GIT�İ�װ·��
SET GIT_DIR=%DRIVER_DIR%devetools\Git
if exist  %GIT_DIR%/nul (
  SET PATH=%PATH%;%GIT_DIR%/bin
  git config --global user.name "wangyq"
  git config --global user.email "yinqingwang@gmail.com"
  )
  
::Subversion�İ�װ·��
SET SUBVERSION_DIR=E:\Subversion
if exist  %SUBVERSION_DIR%/nul (

  SET PATH=%PATH%;%SUBVERSION_DIR%/bin
  )
 
::����PATH��������
D:
CD \000\python
CALL CMD.EXE