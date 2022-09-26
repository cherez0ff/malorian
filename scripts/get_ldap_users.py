#!/usr/bin/env python3
import ldap3
from ldap3.utils.conv import escape_filter_chars
import json
import sys
import os
import argparse
parser = argparse.ArgumentParser()

parser.add_argument('-l', dest="login", default=os.getenv('login'))
parser.add_argument('-p', dest="password", default=os.getenv('password'))
parser.add_argument('-d', dest="domain", default=os.getenv('domain'))
parser.add_argument('-s', '--search', dest="search_group", help="Group to search", required=True)
args = parser.parse_args()

server_name = args.domain
DC1 = server_name.split('.')[0]
DC0 = server_name.split('.')[1]
login = args.login
password = args.password
search_group = args.search_group

server = ldap3.Server(server_name, get_info=ldap3.ALL)
conn = ldap3.Connection(server, user=f'''{DC1}\\{login}''', password=password, authentication=ldap3.NTLM, auto_bind=True)

conn.search(
    search_base=f'DC={DC1},DC={DC0}',
    search_filter=f'(&(objectClass=group)(cn={search_group}))',
    search_scope='SUBTREE',
    attributes = ['member']
)

for entry in conn.entries:
    for member in entry.member.values:
        member = escape_filter_chars(member)
        conn.search(
            search_base=f'DC={DC1},DC={DC0}',
            search_filter=f'(distinguishedName={member})',
            attributes=['sAMAccountName']
        )
        user_sAMAccountName = conn.entries[0].sAMAccountName.values
        if len(user_sAMAccountName) > 1:
            print('More then 1 user per member?')
            sys.exit(1)
        username = user_sAMAccountName[0]
        print(username, member)
