#!/bin/sh

HOST=127.0.0.1
PORT=2080
METHOD=socks5

export http_proxy=$METHOD://$HOST:$PORT
export https_proxy=$METHOD://$HOST:$PORT
export ftp_proxy=$METHOD://$HOST:$PORT
export rsync_proxy=$METHOD://$HOST:$PORT

#socket 5
export all_proxy="$METHOD://$PROXYSERVER:1080"

export no_proxy="*10.*.*.*,192.168.*.*,*.local,localhost,127.0.0.1"
