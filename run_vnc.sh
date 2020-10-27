#!/bin/sh

#
# firewall-cmd --permanent --zone=home --change-interface=eth0
# firewall-cmd --zone=home --permanent --add-port=5901-5906/tcp
# firewall-cmd --reload

# firewall-cmd --get-active-zones

#VNC_PATH=/opt/TigerVNC/bin
#VNC_EXEC=$VNC_PATH/vncserver
VNC_EXEC=vncserver
SCREEN=1440x900
#SCREEN=1260x700
DEFAULT_PORT=2

#====================================================================
# Usage: run_vnc <START/STOP>  <only-stop> <start-port> <end-port>
#
run_vnc()
{
	START=$1  # whether start

	num=$#
	#echo "num=$#"	
	if [ "$num" -ge "3" ] ; then
		sp=$2
		ep=$3
	elif [ "$num" -eq "2" ]; then
		sp=$2
		ep=$2
	else
		sp=$DEFAULT_PORT
		ep=$DEFAULT_PORT
	fi

	echo "start-port=$sp, end-port=$ep"
	
	for port in $(seq $sp $ep); do  #range is [sp,ep]
		$VNC_EXEC -kill :$port   # first stop now!
		if [ "$START" = "START" ] ; then
			$VNC_EXEC :$port -geometry $SCREEN
		fi
	done
}

show()
{
	var=`ps -ef | grep vnc | grep desktop`
	echo "VNC Server is:"
	echo "$var"
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
			run_vnc "START" $2 $3 ;;
        stop)
            run_vnc "STOP"  $2 $3 ;;
		restart)
			run_vnc "STOP"  $2 $3
			run_vnc "START" $2 $3 ;;
		show)
			show ;;
        *)
        echo "Usage: $0 start <start-port> <end-port> | stop <start-port> <end-port> | restart | show"
		echo "       where port number is from 1 to 20."
		echo "       default port is 2"
esac
}

# shell entry to start
main $@

