import tftpy
import sys

files_list_path = sys.argv[1]
ip = sys.argv[2]
port = sys.argv[3]

files = []
with open(files_list_path) as fp:
   for line in fp:
       files.append(line)

client = tftpy.TftpClient(ip, port)
for filenames in files:
    client.download(filename, filename, timeout=3)
#TODO: need error hanlings?
