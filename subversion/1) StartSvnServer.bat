REM ����Ҫ����ԱȨ�����д˽ű�

@echo off
REM �����ô�Ŀ¼Ϊ��� �ִ�Ŀ¼
REM ע����������: "svnadmin.exe  create ��Ĳִ�Ŀ¼" ����֮
REM set REPOS_DIR=L:/svn_data/svn_repos
REM set /P REPOS_DIR=������SVN�洢��·��(���磺L:/svn_data/svn_repos) :

::set /P REPOS_DRIVE=������SVN�洢���̷�(���磺C  D  E  F ...��) : 
::set /P REPOS_RELPATH=������SVN�洢��·��(���磺svn_data/svn_repos) : 
::IF "%REPOS_RELPATH%"=="" SET REPOS_RELPATH=svn_data/svn_repos

::SET REPOS_DIR=%REPOS_DRIVE%:/%REPOS_RELPATH%
::SET REPOS_DIR=%DRIVER_DIR%\svn_data\svn_repos

color 0A

SET SVNSERVER_DIR=E:\svn-win32-1.8.17

REM Ϊ�˷�ֹĿ¼�пո񣬼�������
set EXECUTABLE="%SVNSERVER_DIR%\bin\svnserve.exe"
::���ڴ�Ŀ¼�´���ÿ���洢��, ����paper, project, etc.
SET REPOS_DIR=E:\svn_data\svn_repo
::��汾������, �û�ͳһ��֤
SET CONF_FILE=E:\svn_data\svn_repo\conf\svnserve.conf


::Ĭ�϶˿�3690
SET DEFAULT_PORT=3690
::���ޱ��ط���
SET HOST=localhost

if not exist  %REPOS_DIR%/nul (
  ECHO Ŀ¼%REPOS_DIR%������! ��������!!!
  GOTO END
  )
 
ECHO ��ִ���ļ�: %EXECUTABLE%
ECHO SVN�ִ�·��: %REPOS_DIR%
ECHO ���ʶ˿�(Ĭ��3690):%DEFAULT_PORT%, ��������: %HOST%

ECHO �밴CTRL+C���� SVN-Server ����!
ECHO ��������SVN������......
ECHO ����·��: svn://localhost/[�洢��]

%EXECUTABLE% -d -r %REPOS_DIR% --listen-port %DEFAULT_PORT% --config-file %CONF_FILE% --listen-host %HOST%

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