#!/bin/bash
cd /root/scripts
git clone --depth 1 https://github.com/laluka/bypass-url-parser.git

git clone https://github.com/ihebski/DefaultCreds-cheat-sheet.git /opt/creds

curl -s https://raw.githubusercontent.com/ouch-org/ouch/master/install.sh | sh
wget -4 https://github.com/ouch-org/ouch/releases/latest/download/ouch-x86_64-linux-musl -O /usr/local/bin/ouch
