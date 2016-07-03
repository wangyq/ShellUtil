#! /bin/sh

SWITCHID=00000000000C
INTERFACES=eth1,eth2

PTCP=6653

#switch ip and controller ip:port to connect
SWITCHIP=192.168.100.190
CONTROLLERIP=192.168.100.60
CPTCP=6633

start()
{
	SWID=$1
	if [ -z "$SWID" ] ; then
		SWID=$SWITCHID
	fi
	echo "Begin create ofswitch=$SWID with interfaces=$INTERFACES, ptcp=$PTCP ......"
	sudo ofdatapath --datapath-id=$SWID --interfaces=$INTERFACES ptcp:$PTCP --no-slicing
	echo "Done."
}

conn()
{
	CPIP=$1
	if [ -z "$CPIP" ] ; then
		CPIP=$CONTROLLERIP
	fi
	echo "Begin connect to controller=$CPIP..."
	ofprotocol tcp:$SWITCHIP: tcp:$CPIP:$CPTCP
}

run_cmd()
{
	echo "run command done."
}

show()
{
	dpctl tcp:127.0.0.1:$PTCP stats-flow table=0
}

#==== Here is the entry of script ====
main()
{
case $1 in
        start)
                start $2 ;;
        run)
                run_cmd ;;
        conn)
                conn $2 ;;
        show)
                show ;;
        *)
        echo "Usage: $0 start <id=12> | conn <controller-ip> | show "
esac
}

main $@
