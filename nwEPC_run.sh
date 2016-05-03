#!/bin/sh

#NWEPC_PATH=~/bin/nwepc-0.16
NWEPC_PATH=i~/bin/nwepc-0.17
APP_MME=$NWEPC_PATH/nw-mme-emu/nwLteMmeEmu
APP_GW=$NWEPC_PATH/nw-sae-gw/nwLteSaeGw

#Set Log Level: DEBG INFO NOTI WARN ERRO CRIT ALER EMER 
#default is : INFO
#export NW_LOG_LEVEL=DEBG

mme()
{
    $APP_MME --mme-ip 10.0.0.1 --sgw-ip 10.0.0.6 --pgw-ip 10.0.0.8 --gtpu-ip 10.0.0.1 --num-of-ue 1 --tun-if eth2 
    #$APP_MME --mme-ip 10.0.0.1 --sgw-ip 10.0.0.6 --pgw-ip 10.0.0.8 --gtpu-ip 10.0.0.1 --num-of-ue 1 --tun-if eth2 --session-timeout 120 --reg-per-sec 100
    #$APP_MME --mme-ip 10.0.0.1 --sgw-ip 10.0.0.6 --pgw-ip 10.0.0.8 --gtpu-ip 10.0.0.1 --num-of-ue 2 --session-timeout 120 --reg-per-sec 100

    echo "Run nwEPC's MME finished!"
}

sgwpgw()
{
    $APP_GW --sgw-s11-ip 10.0.0.6 --sgw-s5-ip 10.0.0.7 --pgw-s5-ip 10.0.0.8 --gtpu-ip 10.0.0.6 --apn lte5g --ippool-subnet 192.168.10.0 --ippool-mask 255.255.255.0 --sgi-if eth2 -cgw
    #$APP_GW --sgw-s11-ip 10.0.0.6 --sgw-s5-ip 10.0.0.7 --pgw-s5-ip 10.0.0.8 --gtpu-ip 10.0.0.6 --apn 3gpp --ippool-subnet 192.168.10.0 --ippool-mask 255.255.255.0 -cgw

    echo "Run Sgw/Pgw finished!"
}

#----------------------------------------------------#
# shell entry to exec!
#
#----------------------------------------------------#
main()
{

case $1 in
        mme)
                mme ;;
        sgwpgw)
                sgwpgw ;;
        *)
        echo "Usage: $0 mme | sgwpgw"
esac
}

# shell entry to start
main $@
