@echo off
color 0A

set CUR_DIR=%~dp0

::ȡ�̷���Ϣ
SET DRIVER_DIR=%~d0

REM Ϊ�˷�ֹĿ¼�пո񣬼�������
set EXECUTABLE="%CUR_DIR%bin\svnserve.exe"

REM �����ô�Ŀ¼Ϊ��� �ִ�Ŀ¼
REM ע����������: "svnadmin.exe  create ��Ĳִ�Ŀ¼" ����֮
REM set REPOS_DIR=L:/svn_data/svn_repos
REM set /P REPOS_DIR=������SVN�洢��·��(���磺L:/svn_data/svn_repos) :

::set /P REPOS_DRIVE=������SVN�洢���̷�(���磺C  D  E  F ...��) : 
::set /P REPOS_RELPATH=������SVN�洢��·��(���磺svn_data/svn_repos) : 
::IF "%REPOS_RELPATH%"=="" SET REPOS_RELPATH=svn_data/svn_repos

::SET REPOS_DIR=%REPOS_DRIVE%:/%REPOS_RELPATH%
SET REPOS_DIR=%DRIVER_DIR%\svn_data\svn_repos

if not exist  %REPOS_DIR%/nul (
  ECHO Ŀ¼%REPOS_DIR%������! ��������!!!
  GOTO END
  )
 
ECHO ��ǰ�̷�: %DRIVER_DIR%
ECHO ��ǰ·��: %CUR_DIR%
ECHO ��ִ���ļ�: %EXECUTABLE%
ECHO SVN�ִ�·��: %REPOS_DIR%

ECHO �밴CTRL+C����SVN����!
ECHO ��������SVN������......
ECHO ����·��: svn://localhost

%EXECUTABLE% -d -r %REPOS_DIR%

REM echo SVN�ִ�λ��: %REPOS_DIR%
REM echo ���ڰ�װSVN������......
REM sc create svn binpath= "%EXECUTABLE% --service -r %REPOS_DIR%" displayname= "Subversion Server" depend= Tcpip start= auto

REM echo ��������SVN������......
REM net start svn

REM ����Զ�ɾ������
REM ECHO =====================================
REM SET /P MM_TEMP=�밴�����ɾ��SVN����......
REM net stop svn
REM sc delete svn

REM :END
echo . &pause
