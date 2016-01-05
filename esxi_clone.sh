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
#parameter: vmpath vmname [DEBUG] 
register_vm()
{
    vmpath=$1
    vmname=$2
    DEBUG=$3
    
    if [ -n "$DEBUG" ]; then
        echo "Path=$vmpath, Name=$vmname"
        echo "vim-cmd solo/registervm $vmpath $vmname"
    else
        #vim-cmd solo/registervm [path] [name]
        vim-cmd solo/registervm $vmpath $vmname
    fi

}

#==== need clone vmx file and vmdk file both ==
# parameter: srcpath dstpath vmname [DEBUG]
clone_vm()
{
    srcpath=$1
    dstpath=$2
    vmname=$3
    DEBUG=$4
    
    if [ -n "$DEBUG" ]; then
        echo "cp $srcpath/$vmname.vmx $dstpath/$vmname.vmx"
        echo "vmkfstools -i $srcpath/$vmname.vmdk -d thin $dstpath/$vmname.vmdk"
    else
        cp $srcpath/$vmname.vmx $dstpath/$vmname.vmx
        vmkfstools -i $srcpath/$vmname.vmdk -d thin $dstpath/$vmname.vmdk
    fi

}

run()
{
DEBUG=$1

#low and hight of index
L=2
H=9

#vm name to copy by
VMNAME=archlinux32
SRCDIR=./WR1

#destiname vm prefix
DSTPREF=WR

DSTDIR=.

#for i in $(seq 2 8)
for i in $(seq $L $H)
    do
        dstname=${DSTPREF}$i
        dst=${DSTDIR}/$dstname

        if [ "$dst"x = "$SRCDIR"x ]; then
            echo "Source and Destination vm is the same. DIR=$dst"
            exit
        fi

        clone_vm $SRCDIR $dst $VMNAME $DEBUG

        register_vm $dst/$VMNAME.vmx $dstname $DEBUG

        #ssh root@ESXi127 "cp /vmfs/volumes/datastore1/template/archlinux32/* /vmfs/volumes/datastore8/R${i}/"
        #echo $i
        
        #echo $VM$i
        #mkdir $VM$i
        #echo $ORIG/archlinux32.vmx $VM$i/
        #cp $ORIG/archlinux32.vmx $VM$i/
        #echo -i ./$ORIG/archlinux32.vmdk -d thin ./$VM$i/archlinux32.vmdk
        #vmkfstools -i ./$ORIG/archlinux32.vmdk -d thin ./$VM$i/archlinux32.vmdk


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
    test)
        run test;;
    *)
    echo "Usage: $0 run | test"
esac
}

# == shell entry to start == 
main $@

