#!/bin/bash


wget https://github.com/ignis-sec/Pwdb-Public/raw/master/wordlists/ignis-10M.txt
wget https://github.com/danielmiessler/SecLists/raw/master/Passwords/xato-net-10-million-passwords-1000000.txt
wget https://github.com/danielmiessler/SecLists/blob/master/Passwords/Leaked-Databases/rockyou.txt.tar.gz && tar -xvf rockyou.txt.tar.gz  && rm rockyou.txt.tar.gz
cat * > passwords.txt



# Consider lang-specific
# https://github.com/ignis-sec/Pwdb-Public/tree/master/wordlists/language-specifics
