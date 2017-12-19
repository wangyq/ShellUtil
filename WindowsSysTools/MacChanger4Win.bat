@echo off
cls

CALL :RandMacAddress MAC
ECHO "Mac = %MAC%"

CALL :get-interfaces-netsh-info ifname NUM
ECHO "%ifname[0]% , %NUM% "

for /l %%i in (0,1,%NUM%) do ( 
   echo !ifname[%%i]! 
)

GOTO :EOF

:: --------------------------------------------------------------------------
:: Return the interfaces information from the netsh command
::
:get-interfaces-netsh-info 
	setlocal enableDelayedExpansion
	SET /A i=0
	FOR /F "skip=2 tokens=2,3*" %%a in ('netsh interface show interface') do (
		if /i "%%a" neq "State" (
			REM set %1[%%c].state=%%a
			REM set ints[!ii!].state=%%a
			set "%~1[!i!]=%%c"
			set /A i+=1
			echo "%%a , %%c, !i!, %~1[!i!]%"
		)
	)
	endlocal & set "%~2=%i%"
	goto :eof
	REM exit /b 0

REM ======================================
REM int value to HEX char
REM
:intToHex
::   %~1 variable to store the hex value
::   %~2 int32 string value
   setlocal enableDelayedExpansion
   set /A "num=%~2"
   set "hex="
   set "digits=0123456789ABCDEF"
   for /L %%a in (0,1,7) do (
      set /A "nibble=num&0xF", "num>>=4"
      for %%b in (!nibble!) do set "hex=!digits:~%%b,1!!hex!"
   )
   endlocal & set "%~1=%hex%"
   goto :eof

REM ======================================
REM %~1 variable to get random mac-address
REM 
:RandMacAddress
	setlocal enableDelayedExpansion
	call :intToHex hex0 "(%random%<<15)+%random%"
	call :intToHex hex1 "(%random%<<15)+%random%"
	set "rmac=00:%hex1:~-4,2%:%hex1:~-2,2%:%hex0:~-6,2%:%hex0:~-4,2%:%hex0:~-2,2%"
	::echo rmac=%rmac%
	endlocal & set "%~1=%rmac%"
	goto :eof

REM :eof
