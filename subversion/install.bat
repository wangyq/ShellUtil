@echo off
color 0A


set CUR_DIR=%CD%


::ȡ�̷���Ϣ
CD \
SET DRIVER_DIR=%CD%
CD %CUR_DIR%


REM Ϊ�˷�ֹĿ¼�пո񣬼�������
set EXECUTABLE="%CUR_DIR%\bin\svnserve.exe"

REM �����ô�Ŀ¼Ϊ��� �ִ�Ŀ¼
REM ע����������: "svnadmin.exe  create ��Ĳִ�Ŀ¼" ����֮
REM set REPOS_DIR=L:/svn_data/svn_repos
REM set /P REPOS_DIR=������SVN�洢��·��(���磺L:/svn_data/svn_repos) :
set /P REPOS_DRIVE=������SVN�洢���̷�(���磺C  D  E  F ...��) : 
set /P REPOS_RELPATH=������SVN�洢��·��(���磺svn_data/svn_repos) : 
IF "%REPOS_RELPATH%"=="" SET REPOS_RELPATH=svn_data/svn_repos

SET REPOS_DIR=%REPOS_DRIVE%:/%REPOS_RELPATH%

if not exist  %REPOS_DIR%/nul (
  ECHO Ŀ¼%REPOS_DIR%������! ��������!!!
  GOTO END
  )

echo SVN�ִ�λ��: %REPOS_DIR%
echo ���ڰ�װSVN������......
sc create svn binpath= "%EXECUTABLE% --service -r %REPOS_DIR%" displayname= "Subversion Server" depend= Tcpip start= auto

echo ��������SVN������......
net start svn

REM ����Զ�ɾ������
ECHO =====================================================
SET /P MM_TEMP=�밴�����ɾ��SVN����......
CALL REMOVE.BAT

:END
echo . &pause
