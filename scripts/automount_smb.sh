#!/bin/bash
#TODO: add all access, not just  'READ ONLY'
if [ -n "$1" ]; then
  version="$1"
else
  version="2.0"
fi
for share in $(smbmap -H $ip -u $login -p $password | grep 'READ ONLY' | awk '{print $1}'); do
	mkdir "$share" 2>&-
	mount -t cifs -o vers=$version,username=$login,password=$password "//$ip/$share" "./$share" && \
		echo "$share is mounted"
done
