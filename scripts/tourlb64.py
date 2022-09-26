#!/usr/sbin/python3
import urllib.parse
import sys
import base64

def urlencode(str_to_encode):
    return urllib.parse.quote_plus(str_to_encode)

def base64encode(str_to_encode):
    encodedBytes = base64.b64encode(str_to_encode.encode("utf-8"))
    encodedStr = str(encodedBytes, "utf-8")
    return encodedStr

print(base64encode(urlencode(sys.argv[1])))

