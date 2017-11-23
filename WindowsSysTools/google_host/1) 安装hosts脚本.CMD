
@ECHO OFF

::
set CURDIR=%~dp0

:main

REM color 2e
echo.-----------------------------------------------------------
echo.请选择使用：
echo.
echo. 1.使用IPv6 hosts（即在下面输入1）
echo.
echo. 2.使用IPv4 hosts（即在下面输入2）
echo.
echo. 0.恢复初始 hosts（即在下面输入0）
echo.-----------------------------------------------------------

if exist "%SystemRoot%\System32\choice.exe" goto Win7Choice

set /p choice=请输入数字并按回车键确认:

echo.
if %choice%==0 goto SetOriginHost
if %choice%==1 goto SetIPv6Host
if %choice%==2 goto SetIPv4Host
cls
"set choice="
echo 您输入有误，请重新选择。
ping 127.0.1 -n "2">nul
goto main

:Win7Choice
choice /C 012 /N /M "请输入相应数字："
::应先判断数值最高的错误码, 直到1为止
if errorlevel 3 goto SetIPv4Host
if errorlevel 2 goto SetIPv6Host
if errorlevel 1 goto SetOriginHost
cls
goto main

:SetOriginHost
@ECHO ON
copy /y "%CURDIR%hosts.old.txt" "%SystemRoot%\System32\drivers\etc\hosts"

::end of set origin hosts file
goto EndOfInstallHost

:SetIPv4Host
@ECHO ON
copy /y "%CURDIR%hosts.ipv4.txt" "%SystemRoot%\System32\drivers\etc\hosts"

goto EndOfInstallHost

:SetIPv6Host
@ECHO ON
copy /y "%CURDIR%hosts.ipv6.txt" "%SystemRoot%\System32\drivers\etc\hosts"

:EndOfInstallHost
REM flush DNS
::ipconfig /flushdns
for /L %%i in (1,1,3) do ipconfig /flushdns

echo 请按任意键退出。
@Pause>nul