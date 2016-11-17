#!/bin/sh

#====================================================
#获得区间[min,max]的随机数
#Usage: random min max
#
function random()
{
MAXVALUE=2147483647
    min=$1
    max=$2 
    if [ $MAXVALUE -lt $max ]; then
        echo "Error: number is out of rang! $max"
        exit
    fi

    base=$((max-min+1))   # range, caution may be MAXVALUE+1

    if [ $base -le 0 -o $base -gt $MAXVALUE ]; then 
        echo "Error: range=[$min $max]"
        exit
    fi

    #num=$(date +%s%N)  #too long to calculate!
    #num=`od -An -N4 -i /dev/urandom`  # 4-byte value
    if [ $max -lt 256 ]; then num=`od -An -N1 -i /dev/urandom`
    elif [ $max -lt 65536 ]; then num=`od -An -N2 -i /dev/urandom`
    elif [ $max -lt 16777216 ]; then num=`od -An -N3 -i /dev/urandom`
    else
        num=`od -An -N2 -i /dev/urandom`
        if [ 0 -gt $num ]; then num=$((-num)); fi
    fi

    echo $((num%base+min))   #进行求余数运算即可
}


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


