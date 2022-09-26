#!/usr/sbin/python3
import urllib.parse
import sys
import base64

def urlencode(str_to_encode):
    return urllib.parse.quote_plus(str_to_encode)

print(urlencode(sys.argv[1]))
