#!/usr/sbin/python3
import sys

def generate_usernames(surname, other_names, append=''):
    resultList = []
    for name in other_names:
        s = surname
        n1 = name
        n2 = name[0]
        n3 = name[0:3]
        resultList.append(s)
        resultList.append(n1)
        for d in ['_', '.', '']:
            resultList.append(s + d + n1 + append)
            resultList.append(s + d + n2 + append)
            resultList.append(s + d + n3 + append)
            resultList.append(n1 + d + s + append)
            resultList.append(n2 + d + s + append)
            resultList.append(n3 + d + s + append)
    return resultList

names = sys.argv[1].split(' ')
surename = names[0]
other_names = names[1:]
if len(sys.argv) > 2:
    append = sys.argv.get(2)
else:
    append = ''

#TODO: add append range
#TODO: add lower/upper case sensitivity
generated_names = generate_usernames(surename, other_names, append)
for i in generated_names: print(i)
for i in generated_names: print(i.lower())
