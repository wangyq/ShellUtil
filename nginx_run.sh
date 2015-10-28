#!/bin/sh

# All signal's name and number can be found using command: "kill -l"
S_TERM=SIGQUIT   #SIGQUIT=3, SIGTERM=15, SIGKILL=9
S_RELOAD=SIGHUP  #SIGHUP=1

APP_PATH=/usr/local/nginx
APP_NAME=nginx
APP_EXEC=$APP_PATH/sbin/$APP_NAME

NGINX_PID_FILE=/usr/local/nginx/logs/nginx.pid

#----------------------------------------------------#
# get process'id from process name using grep command
# 
#
#----------------------------------------------------#
get_pid()
{
	#local program=$1
        #local pid=`ps -ef | grep "$program" | grep -v grep | awk  '{print   \$2}'`
	if [ -f $NGINX_PID_FILE ]; then
        	local pid=`cat $NGINX_PID_FILE`
		echo $pid
	else
		echo ""
	fi
}

#----------------------------------------------------#
# run app program
#
#----------------------------------------------------#
run()
{
        #echo "run ......"
        # nohup /bin/sh -c "command_file.sh" > /dev/null 2>&1 &

        sudo $APP_EXEC

        echo "run finished!"
}

#----------------------------------------------------#
# start app program as daemon
#
#----------------------------------------------------#
start()
{
	#echo "start ......"
	#nohup /bin/sh -c "$APP_EXEC" > /dev/null 2>&1 &
	
	local PID=`get_pid`
	if [ "$PID" != "" ];then
		echo "nginx is running! PID=$PID"
	else
		sudo $APP_EXEC
		echo "start finished!"
	fi
}

#----------------------------------------------------#
#
#----------------------------------------------------#
stop()
{
	#echo "stop ......"
	local PID=`get_pid`
        #echo $APP_NAME\' pid = $PID !
	if [ "$PID" != "" ];then
		sudo kill -s $S_TERM  $PID
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
        local PID=`get_pid`
        #echo $APP_NAME\' pid = $PID !
	if [ "$PID" != "" ];then
        	sudo kill -s $S_RELOAD  $PID
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
		sleep 5
		run  ;;
	reload)
		reload ;;
	*)
        echo "Usage: $0 start | stop | restart | reload "
esac
}

# shell entry to start
main $@


