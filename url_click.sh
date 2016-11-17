#!/bin/sh

#====================================================
#获得区间[min,max]的随机数
#Usage: random min max
#
function random()
{
    min=$1
    max=$(($2-$1+1))   #range
    num=$(date +%s%N)  #too long to calculate!
    echo $((num%max+min))   #进行求余数运算即可
}

# run app program
#
#----------------------------------------------------#
run()
{
URL="http://www.sdnlab.com/18092.html 
    http://www.sdnlab.com/17863.html "

COUNT=200
rmin=5
rmax=20

    for i in $(seq 1 $COUNT); do
        for u in $URL; do
            #echo $u
            s=$(random $rmin $rmax)
            sleep $s             #sleep second.
            #curl -s -X GET $u
            curl -o /dev/null $u
        done
    done
    for v in $URL ; do
        echo $v
    done

    echo "run finished!"
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
	*)
        echo "Usage: $0 start | run"
esac
}

# shell entry to start
main $@


