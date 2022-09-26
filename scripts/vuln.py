#!/usr/bin/env python3
import vulners
import json
import argparse

parser = argparse.ArgumentParser(description='Script to get vulns of a software')
parser.add_argument('--product', type=str, help='product name', required=True)
parser.add_argument('--version', nargs='?', type=str, help='version')
parser.add_argument('--cvss', nargs='?', type=str, help='minimal cvss', default="6")
parser.add_argument('--api_key', type=str, help='API key', required=True)
args = parser.parse_args()
#vulners_api = vulners.Vulners(api_key=args.api_key)
vulners_api = vulners.VulnersApi(api_key=args.api_key)

exploits = vulners_api.find_exploit_all(f"{args.product} {args.version}")
results = vulners_api.get_software_vulnerabilities(args.product, args.version)
#print(results)
#print(search_str)

#if args.version:
#    search_str = f'''type:cve affectedSoftware.name:"{args.product}" cvss.score:[{args.cvss} TO 10] order:published affectedSoftware.version:"{args.version}"'''
#else:
#    search_str = f'''type:cve affectedSoftware.name:"{args.product}" cvss.score:[{args.cvss} TO 10] order:published'''

#print(search_str)
#with open('file.json', 'w') as fp:
#    json.dump(results, fp)
#result_list = vulners_api.find_all(search_str)


for result in results['NVD']:
    cvss = int(result['cvss'].get('score'))
    if cvss >= int(args.cvss):
        print(result['title'])
        print(result['description'[:100]])
        print('\n')

print('---------------------------------')

for result in exploits:
    print(result['title'][:100])
    print(result['published'])
    print(result['href'])
    print(result['cvss'].get('score'))
    print(result['cvelist'])
    print('\n')
