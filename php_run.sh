#!/bin/sh

#build php source using this:
#./configure --prefix=/usr/local/php5.5 --enable-fpm --with-fpm-systemd --enable-mbstring --with-mysql --with-curl --with-zlib --with-gd --enable-zip --with-config-file-path=/usr/local/php5.5

# All signal's name and number can be found using command: "kill -l"
S_TERM=SIGQUIT   #SIGQUIT=3, SIGTERM=15, SIGKILL=9
S_RELOAD=SIGUSR2  #SIGHUP=1 
APP_PATH=/usr/local/bin
APP_NAME=php-fpm
APP_EXEC=$APP_PATH/$APP_NAME

PID_FILE=/usr/local/var/run/php-fpm.pid 

#----------------------------------------------------#
# get process'id from process name using grep command
# 
#
#----------------------------------------------------#
get_pid()
{
	#local program=$1
        #local pid=`ps -ef | grep "$program" | grep -v grep | awk  '{print   \$2}'`
	if [ -f $PID_FILE ]; then
        	local pid=`cat $PID_FILE`
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
		echo "$APP_NAME is running! PID=$PID"
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
		run  ;;
	reload)
		reload ;;
	*)
        echo "Usage: $0 start | stop | restart "
esac
}

# shell entry to start
main $@


