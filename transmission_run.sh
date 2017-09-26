#!/bin/sh

# All signal's name and number can be found using command: "kill -l"
S_TERM=15   #SIGTERM=15, SIGKILL=9
S_RELOAD=1  #SIGHUP=1

#APP_PATH=/usr/local/bin
APP_PATH=/usr/bin
APP_NAME=transmission-daemon
APP_EXEC=$APP_PATH/$APP_NAME



get_pid()
{
	local program=$1
        local pid=`ps -ef | grep "$program" | grep -v grep | awk  '{print   \$2}'`
	echo $pid
}

start()
{
	#echo "start ......"
	#$APP_EXEC -e /dev/null
    sudo runuser - p203 -s /bin/sh -c "nohup $APP_EXEC -e /dev/null >/dev/null 2>&1 &"

	echo "start finished!"
}

stop()
{
	#echo "stop ......"
	local PID=`get_pid $APP_NAME`
        #echo $APP_NAME\' pid = $PID !
	if [ "$PID" != "" ];then
		sudo kill -s $S_TERM  $PID
	else
		true	
		#echo $APP_NAME not found!
	fi
}

restart()
{
	stop
	start 
}

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

case $1 in
	start)
		restart ;;
	stop)
		stop ;;
	restart)
		stop
		start  ;;
	reload)
		reload ;;
	*)
        echo "Usage: $0 start | stop | restart | reload"
esac

