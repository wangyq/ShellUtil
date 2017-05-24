
@echo off
color 0A

:: 
netsh wlan set hostednetwork  mode=disallow
netsh wlan set hostednetwork  mode=allow ssid=mywifi key=12345678
netsh wlan start hostednetwork
netsh wlan show hostednetwork
ipconfig

echo 按任意键删除SSID共享网络...
pause

netsh wlan stop hostednetwork
netsh wlan set hostednetwork  mode=disallow


