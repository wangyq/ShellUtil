@ECHO OFF
COLOR 0B
REM ======================================
:: 修改DNS 配置以适应vpn
::netsh interface set interface "本地连接" disabled
::netsh interface set interface "本地连接" enabled

:: -p 为添加永久/静态路由。(路由保留在注册表中, 重启后仍然保持!)
::ROUTE -p add 10.0.0.0 mask 255.0.0.0 10.108.100.1
::ROUTE -p add 192.168.0.0 mask 255.255.0.0 192.168.0.1
::ROUTE PRINT
ECHO 配置 DNS 适应VPN
SET INF=以太网
SET DNS=192.168.16.1

netsh interface ip set dns name="%INF%" source=dhcp 

netsh interface ip show config %INF%

ECHO . & PAUSE 