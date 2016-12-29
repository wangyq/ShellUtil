@echo off
color 0A

set SVNDIR=svn-win32-1.8.17

REM 后面会有个'/'
set CUR_DIR=%~dp0


::取盘符信息
SET DRIVER_DIR=%~d0

REM 为了防止目录有空格，加了引号
set EXECUTABLE=%CUR_DIR%%SVNDIR%\bin\svnserve.exe

REM 请设置此目录为你的 仓储目录
REM 注意先用命令: "svnadmin.exe  create 你的仓储目录" 创建之
REM set REPOS_DIR=L:/svn_data/svn_repos
REM set /P REPOS_DIR=请输入SVN存储的路径(例如：L:/svn_data/svn_repos) :

ECHO "先用命令: 'svnadmin.exe  create 你的仓储目录' 创建之"

set REPOS_DRIVE=
set /P REPOS_DRIVE=请输入SVN存储的盘符(例如：C  D  E  F ...等, 回车默认为当前盘符) : 
IF "%REPOS_DRIVE%"=="" ( SET REPOS_DRIVE=%DRIVER_DIR%) ELSE ( SET REPOS_DRIVE=%REPOS_DRIVE%:)

set REPOS_RELPATH=
set /P REPOS_RELPATH=请输入SVN存储的路径(例如：Subversion/svn_repos) : 
IF "%REPOS_RELPATH%"=="" SET REPOS_RELPATH=Subversion/svn_repos


SET REPOS_DIR=%REPOS_DRIVE%/%REPOS_RELPATH%

if not exist  %REPOS_DIR%/nul (
  ECHO 目录 "%REPOS_DIR%" 不存在! 请检查输入!!!
  GOTO END
  )

ECHO ============================
ECHO 当前盘符: %DRIVER_DIR%
ECHO 当前路径: %CUR_DIR%
ECHO 可执行文件: %EXECUTABLE%
ECHO SVN仓储路径: %REPOS_DIR%
ECHO 访问路径: svn://localhost/仓库名(bupt/work)/
ECHO .

::ECHO 请按CTRL+C结束SVN运行!
::ECHO 正在运行SVN服务器......
::ECHO 访问路径: svn://localhost

REM 直接运行
::%EXECUTABLE% -d -r %REPOS_DIR%

REM echo SVN仓储位置: %REPOS_DIR%
echo 正在安装SVN服务器......
sc create svn binpath="%EXECUTABLE% --service -r %REPOS_DIR%" displayname= "Subversion Server" depend=Tcpip start=auto

echo 正在启动SVN服务器......
net start svn

REM 添加自动删除服务
REM ECHO =====================================
::SET /P MM_TEMP=请按任意键删除SVN服务......
::net stop svn
::sc delete svn

REM :END
echo . &pause
