#!/bin/sh

#----- Begin author and version ------
# author: siwind (yinqingwang@gmail.com)
# date: Dec 30, 2015
# version: 1.0
#
#----- End of version -----


# when paste, just using ":set noautoindent"

#===================================
# copy conf data to each host.
copy_conf()
{
    TMP=/tmp/tmp.sh
    h=$1
    echo "Host : $h"

    scp all_data.sh root@$h:~/
    cp load_data.sh $TMP
    echo "GDATA=(\"\${DATA_$h[@]}\")" >> $TMP 
    #GDATA=("${DATA_R1[@]}")

    scp $TMP root@$h:~/load_data.sh

    scp ovs_run.sh root@$h:~/
}


run1()
{
#RRS="R1 R2 R3 R4 R5 R6 R7 R8"
RRS="R1 R2 R3 R4 R5 R6 "
for h in $RRS ; do

    #copy_conf $h

    ssh root@$h "hostname;exit"
    #scp ovs_run.sh root@$h:~/
    #ssh root@$h "hostname; ./ovs_run.sh start ;exit;"
    ssh root@$h "hostname; ./ovs_run.sh del; exit;"
    #ssh root@$h "hostname; ./ovs_run.sh del; ./ovs_run.sh add 172.16.16.10 ;exit;"
    #ssh root@$h "hostname; ./ovs_run.sh del; ./ovs_run.sh add 172.16.16.11 ;exit;"
    #ssh root@$h "hostname; ip link | grep ens;exit"
    #ssh root@$h "hostname; pacman -Sy openvswitch;exit"
    #echo $h
    #ssh-copy-id root@$h
    #echo "Archlinux-$h" > tmpfile
    #scp tmpfile root@$h:/etc/hostname
    #ssh root@$h "hostname;reboot;exit"
    #ssh root@$h "hostname;cat /etc/hostname;exit"

done
echo "Done"

}

run2()
{
RRS="SW LSU1 LSU2 GSU"
for h in $RRS ; do
    
    #copy_conf $h
    ssh root@$h "hostname;exit"
    #scp ovs_run.sh root@$h:~/
    #ssh root@$h "hostname; ./ovs_run.sh start ;exit;"
    #ssh root@$h "hostname; ./ovs_run.sh del; ./ovs_run.sh add 172.16.16.10 ;exit;"
    #ssh root@$h "hostname; ./ovs_run.sh del; ./ovs_run.sh add 172.16.16.11 ;exit;"
    #ssh root@$h "hostname; ip link | grep ens;exit"
    #ssh root@$h "hostname; pacman -Sy openvswitch;exit"
    #echo $h
    #ssh-copy-id root@$h
    #ssh-copy-id $h
    #ssh $h "hostname;exit"
    #echo "U-$h" > tmpfile
    #scp tmpfile root@$h:/etc/hostname
    #ssh root@$h "hostname;reboot;exit"
    #ssh root@$h "hostname;cat /etc/hostname;exit"

done

}

#====================================
#
run()
{
    run1
    #run2
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

#=============================================
#run()
#{
#low and hight of index
#LOW=2
#HIGH=9

#for i in $(seq 2 8)
#for i in $(seq $LOW $HIGH) ; do
        #ssh root@ESXi127 "cp /vmfs/volumes/datastore1/template/archlinux32/* /vmfs/volumes/datastore8/R${i}/"
        #echo $i
#done

#ARR=(AS1-1 AS2-1 AS2-2 AS2-3 AS3-1 AS4-1 AS4-2 AS5-1 AS5-2 AS5-3 AS6-1 AS6-2 AS7-1 AS7-2 AS8-1 AS8-2)
#for ele in ${ARR[*]} ; do

#RRS="R1 R2 R3 R4 R5 R6 R7 R8"
#for h in $RRS ; do
    
    #copy_conf $h

    #ssh root@$h "hostname;exit"
    #scp ovs_run.sh root@$h:~/
    #ssh root@$h "hostname; ./ovs_run.sh start ;exit;"
    #ssh root@$h "hostname; ./ovs_run.sh del; ./ovs_run.sh add 172.16.16.10 ;exit;"
    #ssh root@$h "hostname; ./ovs_run.sh del; ./ovs_run.sh add 172.16.16.11 ;exit;"
    #ssh root@$h "hostname; ip link | grep ens;exit"
    #ssh root@$h "hostname; pacman -Sy openvswitch;exit"
    #echo $h
    #ssh-copy-id root@$h
    #echo "Archlinux-$h" > tmpfile
    #scp tmpfile root@$h:/etc/hostname
    #ssh root@$h "hostname;reboot;exit"
    #ssh root@$h "hostname;cat /etc/hostname;exit"

#done

#}
