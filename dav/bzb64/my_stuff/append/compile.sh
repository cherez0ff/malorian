#!/bin/sh
gcc -o append.x64 append.c
gcc -o append.x86 append.c -m32
gcc -o append.static.x64 -static append.c
gcc -o append.static.x86 -static append.c -m32
