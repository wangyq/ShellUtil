@ECHO OFF
COLOR 0B
REM ======================================
:: �޸�DNS ��������Ӧvpn
::netsh interface set interface "��������" disabled
::netsh interface set interface "��������" enabled

:: -p Ϊ�������/��̬·�ɡ�(·�ɱ�����ע�����, ��������Ȼ����!)
::ROUTE -p add 10.0.0.0 mask 255.0.0.0 10.108.100.1
::ROUTE -p add 192.168.0.0 mask 255.255.0.0 192.168.0.1
::ROUTE PRINT
ECHO ���� DNS ��ӦVPN
SET INF=��̫��
SET DNS=192.168.16.1

netsh interface ip set dns name="%INF%" source=dhcp 

netsh interface ip show config %INF%

ECHO . & PAUSE 