@ECHO OFF
COLOR 0A
REM ======================================
:: �޸�Windows·��
::netsh interface set interface "��������" disabled
::netsh interface set interface "��������" enabled

:: -p Ϊ��������/��̬·�ɡ�(·�ɱ�����ע�����, ��������Ȼ����!)
::ROUTE -p add 10.0.0.0 mask 255.0.0.0 10.108.100.1
::ROUTE -p add 192.168.0.0 mask 255.255.0.0 192.168.0.1
::ROUTE PRINT

SET INT_NAME_INNER="��̫��-����"
SET INT_NAME_SCHOOL="��̫��-У԰��"

SET DE_METRIC=10

:Menu
Cls
ECHO 1. ����Ĭ��·��Ϊ192.168.0.0/24����
ECHO 2. ����Ĭ��·��Ϊ10.0.0.0/8����
ECHO 3. �ָ�Ĭ��
ECHO 4. �˳�
Set /p c=���������ֲ���Enterȷ����

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

ECHO �ȴ�������������....... & PAUSE 

Goto Exit
::Exit
:Exit
ROUTE PRINT

ECHO . & PAUSE 