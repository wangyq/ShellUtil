@ECHO OFF
COLOR 0A
REM ======================================
REM == net use [driver] \\192.168.9.154\shareFile "password" /user:"ftpname"  [/PERSISTENT:{YES | NO}]

SET DRIVER=Z:
SET SMBSERVER=192.168.0.125\tom\sharedir
SET USER=username
SET PASS=password

NET USE %DRIVER%  \\%SMBSERVER%  "%PASS%"     /user:"%USER%"   /PERSISTENT:NO

REM == NET USE %DRIVER%  /DELETE
