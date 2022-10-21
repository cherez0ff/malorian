#!/usr/bin/python3
import requests
import json
import argparse
import sys
import os

#TODO: whois search
#TODO: mulypage answer case * 'pages': 1, |  2,3 ..
#TODO: old certs search

parser = argparse.ArgumentParser(add_help=True)
parser.add_argument('-f', '--file', help='Specify the list with domains')
parser.add_argument('-d', '--domain', help='Specify the single domain')
parser.add_argument('-a', '--apikey', help='Provide securitytrails API key')
args = parser.parse_args()

# Get environment variables
USER = os.getenv('USER')

if os.getenv('SECURITYTRAILS_TOKEN'):
    apikey = os.getenv('SECURITYTRAILS_TOKEN')
else:
    if args.apikey:
        apikey = args.apikey
    else:
        print('No SECURITYTRAILS_TOKEN env or -a argument!', file=sys.stderr)
        sys.exit(1)


args.apikey =
HEADERS = {
    "accept": "application/json",
    "APIKEY": apikey
}

def parse_responce(resp):
    ips = []
    for i in resp['records']:
        for j in i['values']:
            ips.append(j['ip'])
    return ips


def get_ips(domain):
    url = "https://api.securitytrails.com/v1/history/" + domain + "/dns/a"
    response = requests.get(url, headers=HEADERS)
    if response.status_code == 200:
        return parse_responce(response.json())
    else:
        print(f"Eror for {domain}: returned {str(response.status_code)}", file=sys.stderr)
        return []

def get_domains(args):
    if not args.domain:
        if not args.file:
            print('Specify domain of file with domains', file=sys.stderr)
            sys.exit(1)
        else:
            domains = []
            with open(args.file, 'r') as f:
                for domain in f:
                    domains.append(domain.replace('\n', ''))
            return domains
    else:
        return [args.domain]
    
# main
final_ips = []
for domain in get_domains(args):
    ips = get_ips(domain)
    final_ips.append(ips)
final_ips = sorted(set(final_ips))
for i in final_ips:
    print(i)
