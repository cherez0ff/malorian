#/bin/bash
echo "net use Z: \\\\$lip\share /user:whatever\u p"
/usr/bin/smbserver.py -smb2support -ts -debug share /root/fileserver/ -username u -password p
