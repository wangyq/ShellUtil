#!/bin/sh

base=$(cut -d '.' -f1 /proc/uptime); 
seconds=$(date +%s); 
dmesg | sed 's/\]//;s/\[//;s/\([^.]\)\.\([^ ]*\)\(.*\)/\1\n\3/' | 
while read first; do 
  read second; 
  first=`date +"%d/%m/%Y %H:%M:%S" --date="@$(($seconds - $base + $first))"`;
  printf "[%s] %s\n" "$first" "$second"; 
done
exit 0

