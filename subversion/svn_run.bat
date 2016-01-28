@echo off
color 0A

set CUR_DIR=%~dp0

::取盘符信息
SET DRIVER_DIR=%~d0

REM 为了防止目录有空格，加了引号
set EXECUTABLE="%CUR_DIR%bin\svnserve.exe"

REM 请设置此目录为你的 仓储目录
REM 注意先用命令: "svnadmin.exe  create 你的仓储目录" 创建之
REM set REPOS_DIR=L:/svn_data/svn_repos
REM set /P REPOS_DIR=请输入SVN存储的路径(例如：L:/svn_data/svn_repos) :

::set /P REPOS_DRIVE=请输入SVN存储的盘符(例如：C  D  E  F ...等) : 
::set /P REPOS_RELPATH=请输入SVN存储的路径(例如：svn_data/svn_repos) : 
::IF "%REPOS_RELPATH%"=="" SET REPOS_RELPATH=svn_data/svn_repos

::SET REPOS_DIR=%REPOS_DRIVE%:/%REPOS_RELPATH%
SET REPOS_DIR=%DRIVER_DIR%\svn_data\svn_repos

if not exist  %REPOS_DIR%/nul (
  ECHO 目录%REPOS_DIR%不存在! 请检查输入!!!
  GOTO END
  )
 
ECHO 当前盘符: %DRIVER_DIR%
ECHO 当前路径: %CUR_DIR%
ECHO 可执行文件: %EXECUTABLE%
ECHO SVN仓储路径: %REPOS_DIR%

ECHO 请按CTRL+C结束SVN运行!
ECHO 正在运行SVN服务器......
ECHO 访问路径: svn://localhost

%EXECUTABLE% -d -r %REPOS_DIR%

REM echo SVN仓储位置: %REPOS_DIR%
REM echo 正在安装SVN服务器......
REM sc create svn binpath= "%EXECUTABLE% --service -r %REPOS_DIR%" displayname= "Subversion Server" depend= Tcpip start= auto

REM echo 正在启动SVN服务器......
REM net start svn

REM 添加自动删除服务
REM ECHO =====================================
REM SET /P MM_TEMP=请按任意键删除SVN服务......
REM net stop svn
REM sc delete svn

REM :END
echo . &pause
