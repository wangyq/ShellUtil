#!/bin/sh
#----- Begin author and version ------
# author: siwind (yinqingwang@gmail.com)
# date: Dec 30, 2015
# version: 1.0
#
#----- End of version -----

# paste using ":set noautoindent"

run()
{

LAN="R1-R2 R1-R3 R2-R3 R2-R4 R3-R4 R3-R5 R4-R5 R4-R6 R5-R6"
i=0
for net in $LAN ; do

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

