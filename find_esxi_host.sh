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
RES=()   #array items
NET="192.168.0"
j=0
#IPS=$(seq 10 13)
IPS=$(seq 254)
for i in $IPS ; do
    echo | nc -nvw1 $NET.$i 902 | if grep -iq "VMware"; then
        #echo $NET.$i >> a.txt
        RES[$j]="$NET.$i"
        echo "$NET.$i looks like an ESX(i) host."

        #i=`expr $i+1`
        #((i++))
        j=$(($j + 1))

    fi
done

length=${#RES[@]}
echo "Possible ESXi host number is $length :"

for ((i=0; i<$length; i++));do
    echo ${RES[$i]}
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
    *)
    echo "Usage: $0 run  "
esac
}

# == shell entry to start == 
main $@

