#!/bin/sh

HOST=192.168.0.1
PORT=1080

export http_proxy=socks5://$HOST:$PORT
export https_proxy=socks5://$HOST:$PORT
export ftp_proxy=socks5://$HOST:$PORT
export rsync_proxy=http://$HOST:$PORT

#socket 5
export all_proxy="socks5://$PROXYSERVER:1080"

export no_proxy="*10.*.*.*,192.168.*.*,*.local,localhost,127.0.0.1"


