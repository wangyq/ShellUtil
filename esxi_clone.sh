#!/bin/sh



#for i in $(seq 2 4)
#    do
        #ssh root@ESXi127 "cp /vmfs/volumes/datastore1/template/archlinux32/* /vmfs/volumes/datastore8/R${i}/"
#        echo $i
        #mkdir PC-$i
        #cp ./template/winxp/WinXP.vmx PC-$i/WinXP.vmx
        #vmkfstools -i /vmfs/volumes/datastore1/template/winxp/WinXP.vmdk -d thin /vmfs/volumes/datastore1/PC-$i/WinXP.vmdk
#    done

#low and hight of index
L=1
H=9

for I in $(seq ${L} ${H})
    do
        PC=PC-${I}
        echo $PC
    done

