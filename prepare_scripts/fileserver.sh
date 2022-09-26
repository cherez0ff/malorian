#!/bin/bash
mkdir /var/www/dav/lin/x86
mkdir /var/www/dav/win/x86

# Download Linux utilities
cd /var/www/dav/lin
wget -4 https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh
wget -4 https://github.com/DominicBreuker/pspy/releases/latest/download/pspy64
wget -4 https://raw.githubusercontent.com/stealthcopter/deepce/main/deepce.sh
wget -4 https://github.com/jpillora/chisel/releases/download/v1.7.7/chisel_1.7.7_linux_amd64.gz && gunzip chisel_1.7.7_linux_amd64.gz
wget -4 https://github.com/Fahrj/reverse-ssh/releases/latest/download/reverse-sshx64
cd /var/www/dav/win/x86
wget -4 https://github.com/DominicBreuker/pspy/releases/latest/download/pspy32
wget -4 https://github.com/jpillora/chisel/releases/download/v1.7.7/chisel_1.7.7_linux_386.gz && gunzip chisel_1.7.7_linux_386.gz 
wget -4 https://github.com/Fahrj/reverse-ssh/releases/latest/download/reverse-sshx86

# Download Windows utilities
cd /var/www/dav/win
wget -4 https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEAS.bat
wget -4 https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx64.exe
wget -4 https://github.com/jpillora/chisel/releases/download/v1.7.7/chisel_1.7.7_windows_amd64.gz && gunzip chisel_1.7.7_windows_amd64.gz
wget -4 https://github.com/Fahrj/reverse-ssh/releases/latest/download/reverse-sshx64.exe
wget -4 https://github.com/ParrotSec/mimikatz/raw/master/x64/mimikatz.exe -O mimikatzx64.exe
wget -4 https://raw.githubusercontent.com/411Hall/JAWS/master/jaws-enum.ps1
cd /var/www/dav/win/x86
wget -4 https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx86.exe
wget -4 https://github.com/jpillora/chisel/releases/download/v1.7.7/chisel_1.7.7_windows_386.gz && gunzip chisel_1.7.7_windows_386.gz
wget -4 https://github.com/Fahrj/reverse-ssh/releases/latest/download/reverse-sshx86.exe
wget -4 https://github.com/ParrotSec/mimikatz/raw/master/Win32/mimikatz.exe -O mimikatzx86.exe
