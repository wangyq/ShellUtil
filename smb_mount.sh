#!/bin/sh

# for Centos , you need to install cifs file utility, as following:
# yum install cifs-utils
#

SMB_SERVER=//192.168.0.xx/down
MOUNT_DIR=/home/xx/Downloads/mydown
UID=xx
GID=XX

start()
{
    #sudo mount //192.168.6.84/gg /mnt/share/ -o iocharset=utf8,username=administrator,password=123,dir_mode=0777,file_mode=0777,
codepage=cp936,uid=0

    #sudo mount -t cifs -o username=user,password=xxx,uid=xx,gid=xx $SMB_SERVER $MOUNT_DIR
    #sudo mount -t cifs -o username=user,password=xxx,uid=$UID,gid=$GID $SMB_SERVER $MOUNT_DIR

    # Opened case with redhat - 
    # They said that if you are running RHEL 4,5,6 - 
    # you can only use SMBV1 protocol - You would need to upgrade to RHEL7 to use SMBv2 or 3 

    sudo mount -t cifs -o vers=1.0,username=user,password=xxx,uid=$UID,gid=$GID $SMB_SERVER $MOUNT_DIR
}

stop()
{
    sudo umount $MOUNT_DIR
}

case $1 in
        start)
                start ;;
        stop)
                stop ;;
        restart)
                stop
                start  ;;
        *)
        echo "Usage: $0 start | stop | restart "
esac

