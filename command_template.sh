#!/bin/sh



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
        # nohup /bin/sh -c "command_file.sh" > /dev/null 2>&1 &

    a=(12 "a b c" haha 12 4)
    b=("${a[@]}")  # a and b just the same value!

    for v in "${a[@]}" ; do
        echo $v
    done

    for i in $(seq 1 10); do
        echo $i
    done

    c="one two three four"
    for v in $c ; do
        echo $v
    done

    echo "run finished!"
}

#----------------------------------------------------#
# start app program as daemon
#
#----------------------------------------------------#
start()
{
	echo "start finished!"
}

#----------------------------------------------------#
#
#----------------------------------------------------#
stop()
{
	echo "stop ......"
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
		restart ;;
	stop)
		stop ;;
	restart)
		stop
		start  ;;
	reload)
		reload ;;
	*)
        echo "Usage: $0 start | stop | restart | reload | run"
esac
}

# shell entry to start
main $@


