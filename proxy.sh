#!/bin/sh

PROXYSERVER=192.168.10.1
PROXYPORT=1234
PROXYPORT5=1080

#export http_proxy=http://10.203.0.1:5187/
export http_proxy=http://$PROXYSERVER:$PROXYPORT/
export https_proxy=$http_proxy
export ftp_proxy=$http_proxy
export rsync_proxy=$http_proxy
export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"

#socket 5
export all_proxy="socks5://$PROXYSERVER:1080"

