#!/usr/bin/env python3
import ldap3
import json
import sys
import os
import argparse
parser = argparse.ArgumentParser()

parser.add_argument('-l', dest="login", default=os.getenv('login'))
parser.add_argument('-p', dest="password", default=os.getenv('password'))
parser.add_argument('-d', dest="domain", default=os.getenv('domain'))
parser.add_argument('-s', '--search', dest="search_user", help="user to search", required=True)
args = parser.parse_args()

server_name = args.domain
DC1 = server_name.split('.')[0]
DC0 = server_name.split('.')[1]
login = args.login
password = args.password
search_user = args.search_user

server = ldap3.Server(server_name, get_info=ldap3.ALL)
conn = ldap3.Connection(server, user=f'''{DC1}\\{login}''', password=password, authentication=ldap3.NTLM, auto_bind=True)
conn.search(
    search_base=f'DC={DC1},DC={DC0}',
    search_filter = f'(&(objectCategory=person)(sAMAccountName={search_user}))',
    search_scope='SUBTREE',
    attributes = ['member']
)
for e in sorted(conn.entries):
    e_json = json.loads(e.entry_to_json())
    dn = e_json['dn']
    conn.search(
        search_base=f'DC={DC1},DC={DC0}',
        search_filter=f'(&(objectClass=group)(member={dn}))'
    )
    for e1 in sorted(conn.entries):
        e1_json = json.loads(e1.entry_to_json())
        print(e1_json['dn'])

