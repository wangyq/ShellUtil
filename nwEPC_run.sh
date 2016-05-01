#!/bin/sh

NWEPC_PATH=~/bin/nwepc-0.16
APP_MME=$NWEPC_PATH/nw-mme-emu/nwLteMmeEmu
APP_GW=$NWEPC_PATH/nw-sae-gw/nwLteSaeGw

#Set Log Level: DEBG INFO NOTI WARN ERRO CRIT ALER EMER 
#default is : INFO
#export NW_LOG_LEVEL=DEBG

mme()
{
    #sudo $APP_MME --mme-ip 10.0.0.1 --sgw-ip 10.0.0.6 --pgw-ip 10.0.0.8 --gtpu-ip 10.0.0.1 --num-of-ue 10 --tun-if eth2
    sudo $APP_MME --mme-ip 10.0.0.1 --sgw-ip 10.0.0.6 --pgw-ip 10.0.0.8 --gtpu-ip 10.0.0.1 --tun-if eth2
    echo "Run nwEPC's MME finished!"
}

sgwpgw()
{
    sudo $APP_GW --sgw-s11-ip 10.0.0.6 --sgw-s5-ip 10.0.0.7 --pgw-s5-ip 10.0.0.8 --gtpu-ip 10.0.0.6 --apn lte5g --ippool-subnet 10.10.10.0 --ippool-mask 255.255.255.0 --sgi-if eth2 -cgw

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
