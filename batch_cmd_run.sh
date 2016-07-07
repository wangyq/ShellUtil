#!/bin/sh

#----- Begin author and version ------
# author: siwind (yinqingwang@gmail.com)
# date: Dec 30, 2015
# version: 1.0
#
#----- End of version -----


# when paste, just using ":set noautoindent"

#====================================
#
run()
{
#low and hight of index
LOW=2
HIGH=9

#for i in $(seq 2 8)
#for i in $(seq $LOW $HIGH) ; do
        #ssh root@ESXi127 "cp /vmfs/volumes/datastore1/template/archlinux32/* /vmfs/volumes/datastore8/R${i}/"
        #echo $i
#done

#ARR=(AS1-1 AS2-1 AS2-2 AS2-3 AS3-1 AS4-1 AS4-2 AS5-1 AS5-2 AS5-3 AS6-1 AS6-2 AS7-1 AS7-2 AS8-1 AS8-2)
#for ele in ${ARR[*]} ; do
RRS="R1 R2 R3 R4 R5 R6 R7 R8"
#RRS="R8"
for h in $RRS ; do
    echo $h
    #ssh-copy-id root@$h
    #echo "Archlinux-$h" > tmpfile
    #scp tmpfile root@$h:/etc/hostname
    #ssh root@$h "hostname;reboot;exit"
    #ssh root@$h "hostname;cat /etc/hostname;exit"
    
done

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
        test;;
    *)
    echo "Usage: $0 run | test"
esac
}

# == shell entry to start == 
main $@

