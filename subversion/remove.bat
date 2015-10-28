@echo off
color 2F
echo 正在卸载SVN服务器......

net stop svn
sc delete svn

echo . &pause