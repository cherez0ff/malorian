#!/bin/bash
mkdir -p /root/wordlists/disco 2>/dev/null
cd /root/wordlists/disco
wget -4 https://wordlists-cdn.assetnote.io/data/manual/best-dns-wordlist.txt                           -O dns.txt
wget -4 https://wordlists-cdn.assetnote.io/data/automated/httparchive_subdomains_2022_08_28.txt        -O vhosts.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/common.txt -O common.txt
wget -4 https://wordlists-cdn.assetnote.io/data/automated/httparchive_directories_1m_2022_08_28.txt    -O webroutes_tmp.txt
awk '!a[$0]++' webroutes_tmp.txt > webroutes_tmp.txt # remove duplicates without change of order
cat common.txt > webroutes.txt
webroutes.txt
cut -b 1 --complement webroutes_tmp.txt >> webroutes.txt # delete fist slash from webroutes
rm webroutes_tmp.txt
wget -4 https://github.com/danielmiessler/SecLists/raw/master/Discovery/Web-Content/directory-list-lowercase-2.3-big.txt -O webdirs.txt
wget -4 https://wordlists-cdn.assetnote.io/data/automated/httparchive_apiroutes_2022_08_28.txt         -O api.txt
wget -4 https://wordlists-cdn.assetnote.io/data/automated/httparchive_parameters_top_1m_2022_08_28.txt -O params.txt
wget -4 https://wordlists-cdn.assetnote.io/data/manual/aspx_lowercase.txt                              -O aspx.txt
wget -4 https://wordlists-cdn.assetnote.io/data/automated/httparchive_parameters_top_1m_2022_08_28.txt -O jsp.txt
wget -4 https://wordlists-cdn.assetnote.io/data/automated/httparchive_php_2022_08_28.txt               -O php.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Web-Content/web-all-content-types.txt -O content_types.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Infrastructure/All-Ipv4-ClassA-10.10.txt -O class_a.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/Infrastructure/All-Ipv4-ClassC-192.168.txt -O class_c.txt

mkdir -p cd /root/wordlists/creds 2>/dev/null
cd /root/wordlists/creds
wget -4 https://github.com/danielmiessler/SecLists/raw/master/Usernames/xato-net-10-million-usernames.txt                                 -O usernames.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Leaked-Databases/rockyou-75.txt                        -O rockyou.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Discovery/SNMP/snmp.txt                                          -O snmp.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/tomcat-betterdefaultpasslist.txt   -O tomcat.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/oracle-betterdefaultpasslist.txt   -O oracle.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/postgres-betterdefaultpasslist.txt -O postgres.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/mssql-betterdefaultpasslist.txt    -O mssql.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/mysql-betterdefaultpasslist.txt    -O mysql.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/telnet-betterdefaultpasslist.txt   -O telnet.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/ssh-betterdefaultpasslist.txt      -O ssh.txt
wget -4 https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/ftp-betterdefaultpasslist.txt      -O ftp.txt
curl https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/Default-Credentials/default-passwords.txt              >> tmp_passwords.txt
curl https://raw.githubusercontent.com/danielmiessler/SecLists/master/Passwords/xato-net-10-million-passwords-1000.txt                 >> tmp_passwords.txt
curl https://raw.githubusercontent.com/ignis-sec/Pwdb-Public/master/wordlists/ignis-1K.txt                                             >> tmp_passwords.txt
awk '!a[$0]++' tmp_passwords.txt > default_passwords.txt # remove duplicates without change of order
rm tmp_passwords.txt




#Static:
#LFI-lin
#LFI-win
#bak extensions
#all extensions

# STATIC:

############
############ OLD
############

#mkdir /opt/ignis

#cd /opt/ignis
#wget -4 -4 https://raw.githubusercontent.com/ignis-sec/Pwdb-Public/master/wordlists/ignis-1M.txt && \
#    wget -4 -4 https://raw.githubusercontent.com/ignis-sec/Pwdb-Public/master/wordlists/ignis-1K.txt
#cd /opt/seclists/Discovery/Web-Content/
#cat RobotsDisallowed-Top500.txt Logins.fuzz.txt common.txt Common-DB-Backups.txt UnixDotfiles.fuzz.txt Passwords.fuzz.txt CommonBackdoors-*.txt > /root/wordlists/dir_common.txt && \
#    cp /opt/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-medium.txt /root/wordlists/dir_medium.txt && \
#    cp /opt/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-big.txt /root/wordlists/dir_big.txt
##grep -v -f /root/wordlists/dir_medium.txt /root/wordlists/dir_big.txt > /root/wordlists/dir_big_wo_med.txt
#cp -r /opt/seclists/Passwords/Default-Credentials/* /root/wordlists/defcreds

#cd /opt/seclists/Usernames/
#sort top-usernames-shortlist.txt \
#    Names/malenames-usa-top1000.txt  \
#    Names/femalenames-usa-top1000.txt \
#    Names/familynames-usa-top1000.txt \
#    Names/names.txt | tr '[:upper:]' '[:lower:]' | uniq > /root/wordlists/usernames.txt && \
#    cp top-usernames-shortlist.txt /root/wordlists/usernames_def.txt
#
#cd /opt/seclists/Passwords/
#tar xvf ./Leaked-Databases/rockyou.txt.tar.gz -C /root/wordlists
#sort xato-net-10-million-passwords-1000.txt \
#    probable-v2-top1575.txt \
#    Leaked-Databases/rockyou-25.txt \
#    /opt/ignis/ignis-1K.txt | uniq  > /root/wordlists/passwords_short.txt
#wget -4 -4 https://github.com/zacheller/rockyou/raw/master/rockyou.txt.tar.gz && \
#    tar -xvf rockyou.txt.tar.gz && \
#    rm rockyou.txt.tar.gz
#sort /opt/sqlmap/data/txt/common-files.txt | uniq > /root/wordlists/common-files.txt
#wget -4 -4 https://raw.githubusercontent.com/s0md3v/Arjun/master/arjun/db/large.txt -O /root/wordlists/arjun_params.txt
#
#sort /usr/share/nmap/nselib/data/vhosts-full.lst \
#    /opt/metasploit/data/wordlists/namelist.txt | uniq > /root/wordlists/dns_enum_short.txt
#cat /root/wordlists/dns_enum_short.txt \
#    /opt/seclists/Discovery/DNS/subdomains-top1million-110000.txt > /root/wordlists/dns_enum.txt
