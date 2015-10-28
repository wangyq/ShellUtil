REM  ======================================
REM  SVN COMMAND HELP:
REM  SVN HELP;   SVN LIST SVN://LOCALHOST/WSYBT; SVN LIST SVN://LOCALHOST/MYHOME;
REM  SVN CHECKOUT; SVN COMMIT; SVN UPDATE;SVN ADD
REM  svn commit -m "请在此处键入您的理由" 
REM 初始化导入命令实例：
REM W:\>svn --username developer --password developer import work svn://localhost/work
REM svn list http://192.168.1.253/svn/mpls

@ECHO OFF
color 0A
SET CUR_DIR=%CD%
SET PATH=%CUR_DIR%\bin;%PATH%
SET SVN_EDITOR=NOTEPAD.EXE
CALL CMD.EXE