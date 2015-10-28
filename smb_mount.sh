#!/bin/sh

SMB_SERVER=//192.168.0.xx/down
MOUNT_DIR=/home/xx/Downloads/mydown
UID=xx
GID=XX

start()
{
    #sudo mount //192.168.6.84/gg /mnt/share/ -o iocharset=utf8,username=administrator,password=123,dir_mode=0777,file_mode=0777,
codepage=cp936,uid=0

    #sudo mount -t cifs -o username=user,password=123456789,uid=xx,gid=xx $SMB_SERVER $MOUNT_DIR
    sudo mount -t cifs -o username=user,password=123456789,uid=$UID,gid=$GID $SMB_SERVER $MOUNT_DIR
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

