#!/bin/sh

#for i in $(seq 2 4)
#    do
        #ssh root@ESXi127 "cp /vmfs/volumes/datastore1/template/archlinux32/* /vmfs/volumes/datastore8/R${i}/"
#        echo $i
        #mkdir PC-$i
        #cp ./template/winxp/WinXP.vmx PC-$i/WinXP.vmx
        #vmkfstools -i /vmfs/volumes/datastore1/template/winxp/WinXP.vmdk -d thin /vmfs/volumes/datastore1/PC-$i/WinXP.vmdk
#    done


run()
{
#low and hight of index
L=1
H=9

#for i in $(seq 2 8)
for i in $(seq $L $H)
    do
        #ssh root@ESXi127 "cp /vmfs/volumes/datastore1/template/archlinux32/* /vmfs/volumes/datastore8/R${i}/"
        echo $i
        #mkdir WR$i
        #cp WR1/archlinux32.vmx WR$i/
        #vmkfstools -i ./WR1/archlinux32.vmdk -d thin ./WR$i/archlinux32.vmdk
        
        #mkdir PC$i
        #cp ./template/winxp/WinXP.vmx PC$i/WinXP.vmx
        #vmkfstools -i ./template/winxp/WinXP.vmdk -d thin ./PC$i/WinXP.vmdk
        #vmkfstools -i /vmfs/volumes/datastore1/template/winxp/WinXP.vmdk -d thin /vmfs/volumes/datastore1/PC-$i/WinXP.vmdk
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
    echo "Usage: $0 run"
esac
}

# == shell entry to start == 
main $@

