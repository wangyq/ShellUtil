#!/bin/sh

# All signal's name and number can be found using command: "kill -l"
S_TERM=15   #SIGTERM=15, SIGKILL=9
S_RELOAD=1  #SIGHUP=1

APP_PATH=/var/goagent/default
APP_NAME=proxy.py
APP_EXEC=$APP_PATH/local/$APP_NAME



#----------------------------------------------------#
# get process'id from process name using grep command
# 
#
#----------------------------------------------------#
get_pid()
{
	local program=$1
        local pid=`ps -ef | grep "$program" | grep -v grep | awk  '{print   \$2}'`
	echo $pid
}

#----------------------------------------------------#
# run app program
#
#----------------------------------------------------#
run()
{
        #echo "run ......"
        python $APP_EXEC 
}

#----------------------------------------------------#
# start app program as daemon
#
#----------------------------------------------------#
start()
{
	#echo "start ......"
	nohup python $APP_EXEC > /dev/null 2>&1 &
	echo "start finished!"
}

#----------------------------------------------------#
#
#----------------------------------------------------#
stop()
{
	#echo "stop ......"
	local PID=`get_pid $APP_NAME`
        #echo $APP_NAME\' pid = $PID !
	if [ "$PID" != "" ];then
		kill -s $S_TERM  $PID
	else
		true	
		#echo $APP_NAME not found!
	fi
}

#----------------------------------------------------#
#
#----------------------------------------------------#
restart()
{
	stop
	start 
}

#----------------------------------------------------#
#
#----------------------------------------------------#
reload()
{
	#echo "reload ......"
        local PID=`get_pid $APP_NAME`
        #echo $APP_NAME\' pid = $PID !
	if [ "$PID" != "" ];then
        	kill -s $S_RELOAD  $PID
		echo "reload finished!"
	else
		echo $APP_NAME not found!
	fi
}

#----------------------------------------------------#
# shell entry to exec!
#
#----------------------------------------------------#
main()
{

case $1 in
	run)
		run ;;
	start)
		start ;;
	stop)
		stop ;;
	restart)
		stop
		start  ;;
	*)
        echo "Usage: $0 start | stop | restart | run"
esac
}

# shell entry to start
main $@


