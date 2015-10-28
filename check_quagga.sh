#!/bin/bash

EXEC_DIR=/usr/local/sbin
CONF_DIR=/etc/quagga
LIB_DIR=/usr/local/lib
PID_DIR=/var/run/quagga
DAEMON=(zebra ospfd bgpd)
USER=root
TIME_DELAY=2

#DAEMON=(zebra ospfd ospf6d ripd bgpd) 
#set librery path
#export LD_LIBRARY_PATH=$LIB_DIR:$LD_LIBRARY_PATH

#

for d in ${DAEMON[*]}; do
	ps -ef | grep $d | grep -v grep
done
