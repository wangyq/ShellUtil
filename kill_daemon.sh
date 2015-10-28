#!/bin/bash
#
#if you want to running it in console, just using
# "nohup java -jar pmserv.jar >> /dev/null 2>&1 & "
#  get process id using " ps -ef | grep "java -jar pmserv.jar" | grep -v grep | awk  '{print   $2} ' "

#PROCESS_NAME="java -jar pmserv.jar"
#GET_PID_CMD="ps -ef | grep \"$PROCESS_NAME\" | grep -v grep | awk  '{print   \$2}'"
#echo $GET_PID_CMD

#PROCESS_ID=`$GET_PID_CMD`
#echo $PROCESS_ID

PROCESS_ID=`ps -ef | grep pmserv.jar | grep -v grep | awk  '{print   \$2}'`
#echo "process_id="$PROCESS_ID
if [ "$PROCESS_ID" != "" ];then
#kill -9 $PROCESS_ID
kill $PROCESS_ID
fi

#/srv/pmproject/pmserv/run_daemon.sh
