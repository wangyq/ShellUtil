#! /bin/sh

#switch ip and controller ip:port to connect
CONTROLLERIP=172.16.16.10
CPTCP=6633

BRNAME=br0

# ======================
# load variable from file.
if [ -x ./load_data.sh ]; then
. ./load_data.sh
else
    echo "Error: file not found!(load_data.sh)"
fi

#OFID=0000000000000009
#INTERFACES="ens34 ens35"

# == set global variable ==
OFID=${GDATA[0]}
INTERFACES=${GDATA[1]}

#=================
#
start()
{
        sudo systemctl restart ovsdb-server
        sudo systemctl restart ovs-vswitchd
        
}

stop()
{
        sudo systemctl stop ovsdb-server
        sudo systemctl stop ovs-vswitchd
}

add()
{
        echo "Make sure bridge interface is up! interfaces=$INTERFACES"

        CP_IP=$1
        if [ -z "$CP_IP" ] ; then
            CP_IP=$CONTROLLERIP
        fi
        echo "CONTROLLER IP=$CP_IP"

        sudo ovs-vsctl add-br $BRNAME
        sudo ovs-vsctl set-fail-mode  $BRNAME secure

        for int in $INTERFACES ; do
            sudo ifconfig $int up
            sudo ovs-vsctl add-port $BRNAME $int
            #sudo ovs-vsctl add-port $BRNAME ens35
        done

        sudo ovs-vsctl set bridge $BRNAME protocols=OpenFlow13 other-config:datapath-id=$OFID
        sudo ovs-vsctl set-controller $BRNAME tcp:$CP_IP:$CPTCP
        echo "Start done."
}

del()
{
        sudo ovs-vsctl del-controller $BRNAME
        sudo ovs-vsctl del-br $BRNAME
        echo "Delete ovs bridge done!"
}

show()
{
        sudo ovs-vsctl show
        echo "Now show flow table now : "
        sudo ovs-ofctl -O OpenFlow13 dump-flows $BRNAME
}

run_cmd()
{
        echo "run command done."
}

#==== Here is the entry of script ====
main()
{
case $1 in
        start)
                start ;;
        add)
                add $2 ;;
        del)
                del ;;
        run)
                run_cmd ;;
        stop)
                stop ;;
        show)
                show ;;
        *)
        echo "Usage: $0 start | stop | add <controller-ip> | del | show "
esac
}

main $@
