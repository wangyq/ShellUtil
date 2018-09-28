#!/bin/sh

# for Centos , you need to install cifs file utility, as following:
# yum install cifs-utils
#

SMB_SERVER=//192.168.0.xx
MOUNT_DIR=/home/xx/Downloads/mydown

#username and password for shared folder
USERNAME=xx
PASSWD=xx

#mount as local userid and group id
USERID=yy
GRPID=yy


do_mount()
{
	SDIR=$1
	MDIR=$2

	echo "Mount ${SMB_SERVER}/$SDIR to $MDIR. "
	sudo mount -t cifs ${SMB_SERVER}/$SDIR $MDIR -o username=$USERNAME,password=$PASSWD,gid=$GRPID,uid=$USERID
	echo "Done."
}

do_umount()
{
    MDIR=$1

    echo "UnMount from $MDIR. "
    sudo umount $MDIR 
    echo "Done."
}

start()
{

	DIR=$1
echo "Dir = $DIR"

    #sudo mount //192.168.0.84/gg /mnt/share/ -o iocharset=utf8,username=administrator,password=123,dir_mode=0777,file_mode=0777,codepage=cp936,uid=0

    #sudo mount -t cifs -o username=user,password=xxx,uid=xx,gid=xx $SMB_SERVER $MOUNT_DIR
    #sudo mount -t cifs -o username=user,password=xxx,uid=$UID,gid=$GID $SMB_SERVER $MOUNT_DIR

    # Opened case with redhat - 
    # They said that if you are running RHEL 4,5,6 - 
    # you can only use SMBV1 protocol - You would need to upgrade to RHEL7 to use SMBv2 or 3 

    #sudo mount -t cifs -o vers=1.0,username=user,password=xxx,uid=$UID,gid=$GID $SMB_SERVER $MOUNT_DIR

case $DIR in
        000)
                do_mount 000 /home/xx/bin/000 ;;
        temp)
                do_mount Temp /home/xx/bin/Temp  ;;
        *)
        echo "Missing mount DIR or parameter wrong!"
esac

}

stop()
{
	DIR=$1
	echo "Dir = $DIR"
	
case $DIR in
        000)

                do_umount /home/wang/bin/000 ;;
        temp)
                do_umount /home/wang/bin/Temp  ;;
        *)
        echo "Missing mount DIR or parameter wrong!"
esac
}

usage()
{
	PROG=$1
    echo "Usage: $PROG start <dir> | stop <dir> | restart <dir> | run"

}

#----------------------------------------------------#
# shell entry to exec!
#
#----------------------------------------------------#
main()
{

NUM=$#
T=$2

#echo "Num = $NUM"

if [ $NUM -lt 2 ] ; then
	usage $0
	exit
fi

case $1 in
        run)
                run $T;;
        start)
                start $T;;
        stop)
                stop $T;;
        restart)
                stop
                start  $T;;
        reload)
                reload $T;;
        *)
        #echo "Usage: $0 start <dir> | stop <dir> | restart <dir> | reload | run"
        #echo "Usage: $0 start <dir> | stop <dir> | restart <dir> | run"
		usage $0
esac
}

# shell entry to start
main $@

