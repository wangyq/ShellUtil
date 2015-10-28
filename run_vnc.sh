#!/bin/sh

VNC_PATH=/opt/TigerVNC/bin
VNC_EXEC=$VNC_PATH/vncserver
SCREEN=1440x900
#SCREEN=1260x700
PORT=2

if [ $# -eq 0 ] ; then
        echo "Usage: $0 start | stop | restart"
        exit 
fi

if [ $1 = "start" ] ; then
        $VNC_EXEC -kill :$PORT
        $VNC_EXEC :$PORT -geometry $SCREEN
elif [ $1 = "stop" ] ; then
        $VNC_EXEC -kill :$PORT

elif [ $1 = "restart" ] ; then
        $VNC_EXEC -kill :$PORT
        $VNC_EXEC :$PORT -geometry $SCREEN
else
        echo Unkown paramter: "$1".   
fi
