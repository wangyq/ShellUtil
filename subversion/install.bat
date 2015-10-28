@echo off
color 0A


set CUR_DIR=%CD%


::取盘符信息
CD \
SET DRIVER_DIR=%CD%
CD %CUR_DIR%


REM 为了防止目录有空格，加了引号
set EXECUTABLE="%CUR_DIR%\bin\svnserve.exe"

REM 请设置此目录为你的 仓储目录
REM 注意先用命令: "svnadmin.exe  create 你的仓储目录" 创建之
REM set REPOS_DIR=L:/svn_data/svn_repos
REM set /P REPOS_DIR=请输入SVN存储的路径(例如：L:/svn_data/svn_repos) :
set /P REPOS_DRIVE=请输入SVN存储的盘符(例如：C  D  E  F ...等) : 
set /P REPOS_RELPATH=请输入SVN存储的路径(例如：svn_data/svn_repos) : 
IF "%REPOS_RELPATH%"=="" SET REPOS_RELPATH=svn_data/svn_repos

SET REPOS_DIR=%REPOS_DRIVE%:/%REPOS_RELPATH%

if not exist  %REPOS_DIR%/nul (
  ECHO 目录%REPOS_DIR%不存在! 请检查输入!!!
  GOTO END
  )

echo SVN仓储位置: %REPOS_DIR%
echo 正在安装SVN服务器......
sc create svn binpath= "%EXECUTABLE% --service -r %REPOS_DIR%" displayname= "Subversion Server" depend= Tcpip start= auto

echo 正在启动SVN服务器......
net start svn

REM 添加自动删除服务
ECHO =====================================================
SET /P MM_TEMP=请按任意键删除SVN服务......
CALL REMOVE.BAT

:END
echo . &pause
