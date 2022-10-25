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
parser.add_argument('-o', '--output', help='Specify output file')
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
        print(f"\nEror for {domain}: returned {str(response.status_code)}", file=sys.stderr)
        return []

def get_domains(args):
    if args.domain:
        return [args.domain]
    else:
        if args.file:
            domains = []
            with open(args.file, 'r') as f:
                for domain in f:
                    domains.append(domain.replace('\n', ''))
            return domains
        else:
            print('Specify file with domains', file=sys.stderr)
            sys.exit(1)
    

def remove_local_ranges(ips):
    for ip in ips:
        octets = [int(x) for x in ip.split(".")]
        net127 = (octets[0] == 127)
        net192 = (octets[0] == 192 and octets[1] == 168)
        net172 = (octets[0] == 172 and (octets[1] in [16-32]))
        net10 = (octets[0] == 10)
        if net127 or net192 or net172  or net10:
            ips.remove(ip)
    return ips



# main
final_ips = []
for domain in get_domains(args):
    ips = get_ips(domain)
    final_ips += ips
    if ips:
        print(f'\nDomain {domain}:')
        for i in ips: print(i)

if args.output:
    final_ips = remove_local_ranges(sorted(set(final_ips)))
    with open(args.output, 'w') as fp:
        for item in final_ips:
            fp.writelines(item+'\n')
