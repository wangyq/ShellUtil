#!/bin/sh

#esxcfg-vswitch -l
#esxcfg-vswitch -A pg_name -v vid vSwitch3


run()
{
SW=vSwitch3

i=15
#LAN=(R1-R2 R1-R3 R2-R3 R2-R4 R3-R4 R3-R5 R4-R5 R4-R6 R5-R6)
for net in R1-R2 R1-R3 R2-R3 R2-R4 R3-R4 R3-R5 R4-R5 R4-R6 R5-R6 ; do
#for net in ${LAN[@]} ; do
#for net in ${LAN[*]} ; do
    
    #echo "$net i=$i"
    echo "esxcfg-vswitch -A $net $SW"
    esxcfg-vswitch -A $net $SW
    echo "esxcfg-vswitch -p $net -v $i $SW"
    esxcfg-vswitch -p $net -v $i $SW
    #esxcfg-vswitch -A $net -v $i $SW
    #i=`expr $i+1`
    #((i++))
    i=$(($i + 1))
done

esxcfg-vswitch -l

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
    *)
    echo "Usage: $0 run"
esac
}

# == shell entry to start == 
main $@
