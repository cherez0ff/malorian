#!/bin/bash
cd /root/scripts
git clone --depth 1 https://github.com/laluka/bypass-url-parser.git

git clone https://github.com/ihebski/DefaultCreds-cheat-sheet.git /opt/creds

curl -s https://raw.githubusercontent.com/ouch-org/ouch/master/install.sh | sh
wget -4 https://github.com/ouch-org/ouch/releases/latest/download/ouch-x86_64-linux-musl -O /usr/local/bin/ouch
chmod +x /usr/local/bin/ouch

wget -4 https://raw.githubusercontent.com/cherez0ff/os/master/roles/zsh/files/scripts/jstree

wget -4 https://raw.githubusercontent.com/t3l3machus/psudohash/main/psudohash.py
