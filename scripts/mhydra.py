#!/usr/bin/env python3
# TODO: add dowload request from file support
import sys
import os

import argparse
parser = argparse.ArgumentParser()

parser.add_argument('-i', '--ip',     help='IP', default=f"{os.environ['ip']}")
parser.add_argument('-u', '--user',   help='User related part', default=f"-L {os.environ['login_list']}")
parser.add_argument('-p', '--passwd', help='passwdword related part', default=f"-P {os.environ['pass_list']}")
parser.add_argument('-m', '--method', help='get/post', default="post")
parser.add_argument('-s', '--speed',  help='-t VALUE', default="1")
parser.add_argument('-b', '--body',   help='POST request body',  required=True)
parser.add_argument('-f', '--fail',   help='Text from failed requst reply', required=True)
parser.add_argument('-c', '--cookie', help='All after "Cookie: "')
parser.add_argument('-d', '--debug', action=argparse.BooleanOptionalAction, help='Use if needed -d arg')
parser.add_argument('--link',   help='URL after IP address',  default="/") # For some fucking reason if I add '-l' it fucking fails
args = parser.parse_args()

if args.debug:
    debug = '-d'
else:
    debug = ''

cmd = f'''/usr/sbin/hydra -IvVF {debug} {args.user} {args.passwd} -t {args.speed} {args.ip} http-{args.method}-form '''
cmd += f'''\'{args.link}:{args.body}:F={args.fail}'''
if args.cookie != '':
    cmd += r':H=Cookie\: '
    cmd += f'''{args.cookie}\''''
else:
    cmd += '\''

print(cmd)
os.system(cmd)
