@echo off
color 0A

set SVNDIR=svn-win32-1.8.17

REM ������и�'/'
set CUR_DIR=%~dp0


::ȡ�̷���Ϣ
SET DRIVER_DIR=%~d0

REM Ϊ�˷�ֹĿ¼�пո񣬼�������
set EXECUTABLE=%CUR_DIR%%SVNDIR%\bin\svnserve.exe

REM �����ô�Ŀ¼Ϊ��� �ִ�Ŀ¼
REM ע����������: "svnadmin.exe  create ��Ĳִ�Ŀ¼" ����֮
REM set REPOS_DIR=L:/svn_data/svn_repos
REM set /P REPOS_DIR=������SVN�洢��·��(���磺L:/svn_data/svn_repos) :

ECHO "��������: 'svnadmin.exe  create ��Ĳִ�Ŀ¼' ����֮"

set REPOS_DRIVE=
set /P REPOS_DRIVE=������SVN�洢���̷�(���磺C  D  E  F ...��, �س�Ĭ��Ϊ��ǰ�̷�) : 
IF "%REPOS_DRIVE%"=="" ( SET REPOS_DRIVE=%DRIVER_DIR%) ELSE ( SET REPOS_DRIVE=%REPOS_DRIVE%:)

set REPOS_RELPATH=
set /P REPOS_RELPATH=������SVN�洢��·��(���磺Subversion/svn_repos) : 
IF "%REPOS_RELPATH%"=="" SET REPOS_RELPATH=Subversion/svn_repos


SET REPOS_DIR=%REPOS_DRIVE%/%REPOS_RELPATH%

if not exist  %REPOS_DIR%/nul (
  ECHO Ŀ¼ "%REPOS_DIR%" ������! ��������!!!
  GOTO END
  )

ECHO ============================
ECHO ��ǰ�̷�: %DRIVER_DIR%
ECHO ��ǰ·��: %CUR_DIR%
ECHO ��ִ���ļ�: %EXECUTABLE%
ECHO SVN�ִ�·��: %REPOS_DIR%
ECHO ����·��: svn://localhost/�ֿ���(bupt/work)/
ECHO .

::ECHO �밴CTRL+C����SVN����!
::ECHO ��������SVN������......
::ECHO ����·��: svn://localhost

REM ֱ������
::%EXECUTABLE% -d -r %REPOS_DIR%

REM echo SVN�ִ�λ��: %REPOS_DIR%
echo ���ڰ�װSVN������......
sc create svn binpath="%EXECUTABLE% --service -r %REPOS_DIR%" displayname= "Subversion Server" depend=Tcpip start=auto

echo ��������SVN������......
net start svn

REM ����Զ�ɾ������
REM ECHO =====================================
::SET /P MM_TEMP=�밴�����ɾ��SVN����......
::net stop svn
::sc delete svn

REM :END
echo . &pause
