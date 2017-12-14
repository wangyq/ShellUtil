REM 不需要管理员权限运行此脚本

@echo off
REM 请设置此目录为你的 仓储目录
REM 注意先用命令: "svnadmin.exe  create 你的仓储目录" 创建之
REM set REPOS_DIR=L:/svn_data/svn_repos
REM set /P REPOS_DIR=请输入SVN存储的路径(例如：L:/svn_data/svn_repos) :

::set /P REPOS_DRIVE=请输入SVN存储的盘符(例如：C  D  E  F ...等) : 
::set /P REPOS_RELPATH=请输入SVN存储的路径(例如：svn_data/svn_repos) : 
::IF "%REPOS_RELPATH%"=="" SET REPOS_RELPATH=svn_data/svn_repos

::SET REPOS_DIR=%REPOS_DRIVE%:/%REPOS_RELPATH%
::SET REPOS_DIR=%DRIVER_DIR%\svn_data\svn_repos

color 0A

SET SVNSERVER_DIR=E:\svn-win32-1.8.17

REM 为了防止目录有空格，加了引号
set EXECUTABLE="%SVNSERVER_DIR%\bin\svnserve.exe"
::请在此目录下创建每个存储库, 例如paper, project, etc.
SET REPOS_DIR=E:\svn_data\svn_repo
::多版本库配置, 用户统一认证
SET CONF_FILE=E:\svn_data\svn_repo\conf\svnserve.conf


::默认端口3690
SET DEFAULT_PORT=3690
::仅限本地访问
SET HOST=localhost

if not exist  %REPOS_DIR%/nul (
  ECHO 目录%REPOS_DIR%不存在! 请检查输入!!!
  GOTO END
  )
 
ECHO 可执行文件: %EXECUTABLE%
ECHO SVN仓储路径: %REPOS_DIR%
ECHO 访问端口(默认3690):%DEFAULT_PORT%, 监听主机: %HOST%

ECHO 请按CTRL+C结束 SVN-Server 运行!
ECHO 正在运行SVN服务器......
ECHO 访问路径: svn://localhost/[存储库]

%EXECUTABLE% -d -r %REPOS_DIR% --listen-port %DEFAULT_PORT% --config-file %CONF_FILE% --listen-host %HOST%

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