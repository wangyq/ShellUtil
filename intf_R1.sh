#!/bin/sh

#add interface's alias names

#set multi-ip in single nic
#INTFS=(lo=12.0.0.1/24 eth1=1.1.2.1/24,1.1.2.20/24 eth2=1.1.3.1/24 eth3=1.1.4.1/24)

#INTFS=(lo=127.0.0.1/8,12.0.0.4/32 eth1=1.1.1.4/24,1.1.2.1/24,2.2.2.2/24 )
INTFS=(eth1=1.1.1.4/24,1.1.2.1/24,2.2.2.2/24 )

#INTFS=(eth1=1.1.2.1/24 eth2=1.1.3.1/24 eth3=1.1.4.1/24)
#INTFS=(eth1=1.1.1.3/24 )

#-------------
#
#split_to_arr()
#{
#	local str=$1
#	IFS="," 
#	local arr=($str) 
#	IFS="$OLD_IFS"
#	echo $arr
#}

start()
{
for f in ${INTFS[*]}; do
	#echo $f
	#inf=${f:0:4}
	#addr=${f#=}
	inf=${f%=*}
	addr=${f#*=}
	echo Start inf=$inf, addr=$addr ......
	if [ -n "$inf" -a -n "$addr" ] ; then
		ip link set $inf up
		#addrs=`split_to_arr $addr`
		num=0
		flag=0
		addrs=(${addr//,/ })
		for ad in ${addrs[*]}; do
			echo inf=$inf, addr=$ad
			if [  "$flag" = "0" ]; then
				ip addr add $ad dev $inf
				flag=1
			else
				ip addr add $ad label $inf:$num dev $inf 
				num=`expr $num + 1`
			fi
		done
	fi
done
}

stop()
{
	for f in ${INTFS[*]}; do
		inf=${f%=*}
		addr=${f#*=}
		echo Stop inf=$inf, addr=$addr ......
		if [ -n "$inf" -a -n "$addr" ] ; then
			ip addr flush dev $inf
			ip link set $inf down
		fi
	done
}

show()
{
for f in ${INTFS[*]}; do
        #echo $f
        #inf=${f:0:4}
        #addr=${f#=}
        inf=${f%=*}
        addr=${f#*=}
        #echo inf=$inf, addr=$addr
	if [ -n "$inf" -a -n "$addr" ] ; then
        	ip addr show dev $inf
	fi
done
}

#----------------------------------------------------#
# shell entry to exec!
#
#----------------------------------------------------#
main()
{

case $1 in
        start)
                start ;;
        stop)
                stop ;;
	restart)
		stop 
		start ;;
	show)
		show ;;
        *)
        echo "Usage: $0 start | stop | restart | show"
esac
}

# shell entry to start
main $@

