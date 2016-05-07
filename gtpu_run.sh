#!/bin/sh

init()
{

# Clear the iptables mangle table
iptables -P INPUT ACCEPT
iptables -F
iptables -t mangle -F

# Remove GTPU KLM
rmmod xt_GTPU

# Insert the GTPU KLM
insmod ./Bin/xt_GTPU.ko

# Copy the userland iptables extenstion library
if [ -d /lib/xtables ]; then
    /bin/cp -f ./Bin/libxt_GTPU.so /lib/xtables/
fi

if [ -d /lib/iptables ]; then
    /bin/cp -f ./Bin/libxt_GTPU.so /lib/iptables/libipt_GTPU.so
fi
}

UE_IP=192.168.10.254
LOCAL_IP=10.0.0.1
LOCAL_ID=100

REMOTE_IP=10.0.0.6
REMOTE_ID=200

tun1()
{

init

# Some sample commands for demonstration
iptables -t mangle -A PREROUTING -s $UE_IP -j GTPU --own-ip $LOCAL_IP --own-tun $LOCAL_ID --peer-ip $REMOTE_IP --peer-tun $REMOTE_ID --action add
iptables -t mangle -A PREROUTING -s $REMOTE_IP -d $LOCAL_IP -p udp --dport 2152 -j GTPU --action remove
}

tun2()
{

init

# Some sample commands for demonstration
iptables -t mangle -A PREROUTING -d $UE_IP -j GTPU --own-ip $REMOTE_IP --own-tun $REMOTE_ID --peer-ip $LOCAL_IP --peer-tun $LOCAL_ID --action add
iptables -t mangle -A PREROUTING -s $LOCAL_IP -d $REMOTE_IP -p udp --dport 2152 -j GTPU --action remove
}

#----------------------------------------------------#
# shell entry to exec!
#
#----------------------------------------------------#
main()
{

case $1 in
        tun1)
                tun1 ;;
        tun2)
                tun2 ;;
        *)
        echo "Usage: $0 tun1 | tun2"
esac
}

# shell entry to start
main $@

