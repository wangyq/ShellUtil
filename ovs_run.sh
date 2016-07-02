#! /bin/sh

BRNAME=br0

PTCP=6653

#switch ip and controller ip:port to connect
SWITCHIP=192.168.100.190
CONTROLLERIP=192.168.100.155
CPTCP=6633

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

create()
{
        echo "Make sure bridge interface is up!"

        CP_IP=$1
        if [ -z "$CP_IP" ] ; then
            CP_IP=$CONTROLLERIP
        fi
        echo "CONTROLLER IP=$CP_IP"

        sudo ovs-vsctl add-br $BRNAME
        sudo ovs-vsctl set-fail-mode  $BRNAME secure
        sudo ovs-vsctl add-port $BRNAME ens34
        sudo ovs-vsctl add-port $BRNAME ens35
        sudo ovs-vsctl set-controller $BRNAME tcp:$CP_IP:$CPTCP
        echo "Start done."
}

destroy()
{
        sudo ovs-vsctl del-controller $BRNAME
        sudo ovs-vsctl del-br $BRNAME
        echo "Destroy done!"
}

show()
{
        sudo ovs-vsctl show
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
        create)
                create $2 ;;
        destroy)
                destroy ;;
        run)
                run_cmd ;;
        stop)
                stop ;;
        show)
                show ;;
        *)
        echo "Usage: $0 start | stop | create <controller-ip> | show "
esac
}

main $@
