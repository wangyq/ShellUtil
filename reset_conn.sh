#!/bin/bash

if [ -z $1  ] ; then
        echo Usage: "reset_conn.sh ifname"
        echo        where ifname is the interface name like 'eth0'.
        exit
fi

DES_IP=10.108.100.1
DES_INF=$1
LOG_FILE=/var/log/reset_conn.log
LOG_FILE_SIZE=1024000

#test if network is correct!
function testconn
{
        ping -c 3 $DES_IP

}

function reset_inf
{
        ifdown $DES_INF
        ifup   $DES_INF
}

#当前时间
CUR_TIME=`date`

testconn
if [ $? -ne 0 ] ; then
        echo ping $DES_IP error!
        echo [$CUR_TIME]: ping $DES_IP error! reset interface $DES_INF! >> $LOG_FILE
        reset_inf
        testconn
        if [ $? -ne 0 ] ; then
		echo [$CUR_TIME]: ping error! reset again! >> $LOG_FILE
                reset_inf
        fi
else
        echo ping $DES_IP OK!
        echo [$CUR_TIME]: ping $DES_IP OK! >> $LOG_FILE
fi


# reset log file size
#文件大小
size=0
if [ -f $LOG_FILE ] 
then 
        #取得日志文件大小值
        size=`ls -l $LOG_FILE |awk '{print $5}'`

#进行判断
        if [ "$size"0 -gt "$LOG_FILE_SIZE"0 ]
        then
                echo 开始清理: "$LOG_FILE" , 大小= "$size"
                true > $LOG_FILE
        fi

fi
