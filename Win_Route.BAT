@ECHO OFF
COLOR 0A
REM ======================================
:: 修改Windows路由
::netsh interface set interface "本地连接" disabled
::netsh interface set interface "本地连接" enabled

:: -p 为添加永久/静态路由。(路由保留在注册表中, 重启后仍然保持!)
::ROUTE -p add 10.0.0.0 mask 255.0.0.0 10.108.100.1
::ROUTE -p add 192.168.0.0 mask 255.255.0.0 192.168.0.1
::ROUTE PRINT

SET INT_NAME_INNER="以太网-内网"
SET INT_NAME_SCHOOL="以太网-校园网"

SET DE_METRIC=10

:Menu
Cls
ECHO 1. 设置默认路由为192.168.0.0/24网段
ECHO 2. 设置默认路由为10.0.0.0/8网段
ECHO 3. 恢复默认
ECHO 4. 退出
Set /p c=请输入数字并按Enter确定：

:Goto
If Not "%c%"=="" Set c=%c:~0,1%
If "%c%"=="1" Goto Route192
If "%c%"=="2" Goto Route10
If "%c%"=="3" Goto Default
If "%c%"=="4" Goto Exit
Goto Menu

:Route192
ROUTE DELETE 0.0.0.0 
ROUTE ADD 0.0.0.0 MASK 0.0.0.0 192.168.0.1 
Goto Exit

::Route10
:Route10
ROUTE DELETE 0.0.0.0 
ROUTE ADD 0.0.0.0 MASK 0.0.0.0 10.108.100.1
Goto Exit

::Defaut route
:Default
ROUTE DELETE 0.0.0.0

::ECHO "interface set interface %INT_NAME_INNER% disabled"

netsh interface set interface %INT_NAME_INNER% disabled
netsh interface set interface %INT_NAME_SCHOOL% disabled

netsh interface set interface %INT_NAME_INNER% enabled
netsh interface set interface %INT_NAME_SCHOOL% enabled

ECHO 等待网卡重新启动....... & PAUSE 

Goto Exit
::Exit
:Exit
ROUTE PRINT

ECHO . & PAUSE 