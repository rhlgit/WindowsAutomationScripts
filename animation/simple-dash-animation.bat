@echo off

:main
cls
echo ------------
ping localhost -n 1 >nul
echo -----------
ping localhost -n 1 >nul
echo ----------
ping localhost -n 1 >nul
echo ---------
ping localhost -n 1 >nul
echo --------
ping localhost -n 1 >nul
echo -------
ping localhost -n 1 >nul
echo ------
ping localhost -n 1 >nul
echo -----
ping localhost -n 1 >nul
echo ----
ping localhost -n 1 >nul
echo ---
ping localhost -n 1 >nul
echo ----
ping localhost -n 1 >nul
echo -----
ping localhost -n 1 >nul
echo ------
ping localhost -n 1 >nul
echo -------
ping localhost -n 1 >nul
echo --------
ping localhost -n 1 >nul
echo ---------
ping localhost -n 1 >nul
echo ----------
ping localhost -n 1 >nul
echo -----------
ping localhost -n 1 >nul
echo ------------
ping localhost -n 1 >nul
echo.
echo.
echo Again - Yes/No?
echo.

set /p x=
if /I %x%== Yes goto Yes
if /I %x%== No goto No
echo Answer with Yes or No

:Yes
cls
echo Ok lets go!
pause > nul
goto main

:No
cls
echo Ok lets go!
pause > nul
exit
