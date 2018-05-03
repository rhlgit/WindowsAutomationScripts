@echo off
set counter=%ewt%
rem set counter=20
set zero=0

:TIMER
IF "%counter%"=="%zero%" (
    echo Time is up!
) ELSE (
    rem echo still %counter% seconds...
	ping -n 2 localhost > nul
	set /a counter=%counter%-1
	title %counter%
	title 
	title %counter%
	title 
	title %counter%
	title 
	title %counter%
	title 
	title %counter%
	title 
	title %counter%
	goto :TIMER
)

:EXIT
echo Done!
pause
rem echo. Have a nice day!
rem ping -n %1 localhost > nul
