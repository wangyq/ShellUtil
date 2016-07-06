#!/bin/sh
#----- Begin author and version ------
# author: siwind (yinqingwang@gmail.com)
# date: Dec 30, 2015
# version: 1.0
#
#----- End of version -----

# paste using ":set noautoindent"

#The network prefix 
NETPRE=MYNET-

run()
{
DEBUG=$1

SW=vSwitch3

STARTVID=511


#LAN=(R1-R2 R1-R3 R2-R3 R2-R4 R3-R4 R3-R5 R4-R5 R4-R6 R5-R6)
#for net in R1-R2 R1-R3 R2-R3 R2-R4 R3-R4 R3-R5 R4-R5 R4-R6 R5-R6 ; do
#for net in ${LAN[*]} ; do

i=$STARTVID
LAN="R1-R2 R1-R3 R2-R3 R2-R4 R3-R4 R3-R5 R4-R5 R4-R6 R5-R6"
for net in $LAN ; do

    NETNAME=$NETPRE$net

    if [ -n "$DEBUG" ] ; then
        echo "esxcfg-vswitch -A $NETNAME $SW"
        echo "esxcfg-vswitch -p $NETNAME -v $i $SW"
    else
        esxcfg-vswitch -A $NETNAME $SW
        esxcfg-vswitch -p $NETNAME -v $i $SW

    fi
    #esxcfg-vswitch -A $net -v $i $SW  (error: must one opertation a time)
    #i=`expr $i+1`
    #((i++))
    i=$(($i + 1))
done

if [ -z "$DEBUG" ] ; then
    esxcfg-vswitch -l
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
    test)
        run test ;;
    *)
    echo "Usage: $0 run | test"
esac
}

# == shell entry to start == 
main $@
