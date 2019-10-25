REM Please put the file in startup directory: "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp"
REM Or find the startup directory with command "shell:startup" in explorer.exe

set ws=WScript.CreateObject("WScript.Shell") 
ws.Run "D:/DeveTools/frp/frpc.exe -c D:/DeveTools/frp/frpc.ini",0

