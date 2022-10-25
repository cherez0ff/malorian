#!/bin/bash
input="/root/hack/hostnames.txt"
mkdir ~/audit
cd ~/audit
while read -r i
do
  /root/scripts/nmap1 $i > $i.txt;
done < "$input"
