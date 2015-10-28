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
export LD_LIBRARY_PATH=$LIB_DIR:$LD_LIBRARY_PATH

#
echo make sure user \"$USER\" has read-write privileges in directory \"$PID_DIR\" !

start()
{
	for d in ${DAEMON[*]}; do
		$EXEC_DIR/$d -f $CONF_DIR/$d.conf -i $PID_DIR/$d.pid -u $USER -g $USER -d
		ps -ef | grep $d | grep -v grep
		if [ $d = "zebra" ] ; then
			sleep $TIME_DELAY
		fi
	done
	echo "start (${DAEMON[*]})  finished!"
}

stop()
{
	for d in ${DAEMON[*]}; do
		killall $d
		#rm -f $PID_DIR/$d.pid
	done
	rm -f $PID_DIR/*
	echo "stop (${DAEMON[*]})  finished!"
}

case $1 in
	start)
		start ;;
	stop)
		stop ;;
	restart)
		stop
		start  ;;
	*)
        echo "Usage: $0 start | stop | restart"
esac

