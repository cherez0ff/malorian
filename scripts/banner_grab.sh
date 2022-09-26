#!/bin/sh
for port in 443 465 563 587 636 695 898 989 990 992 993 994 995 5986; do openssl s_client -connect "$ip:$port" 2>&- | grep 'CN =' | awk -F 'CN = ' '{print $2}' | uniq; done
