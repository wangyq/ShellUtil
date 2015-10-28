#!/bin/bash

#-------------------------------------
# Author: siwind
# QQ: 2307364086
#
#-------------------------------------

DES_IP=www.sina.com

#接外网的网络接口
DES_INF=eth0

#自动登录脚本位置
AUTH_FILE=/usr/local/bin/authBuptGw.sh

#日志文件
LOG_FILE=/var/log/auto_conn.log

#日志大小限制设置（ 单位: 字节），超出即清理
LOG_FILE_SIZE=1024000

MAX_COUNT=3

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

function reset_auth
{
	ifdown $DES_INF
	ifup   $DES_INF
	bash $AUTH_FILE -i
}

function clear_log
{
	# reset log file size
	#文件大小
	size=0
	if [ -f $LOG_FILE ] ; then
	        #取得日志文件大小值
        	size=`ls -l $LOG_FILE |awk '{print $5}'`

		#进行判断
	        if [ "$size"0 -gt "$LOG_FILE_SIZE"0 ]; then
	                echo 开始清理: "$LOG_FILE" , 大小= "$size"
        	        true > $LOG_FILE
        	fi

	fi
}

#当前时间
CUR_TIME=`date`

clear_log

testconn

if [ $? -ne 0 ] ; then
	echo ping $DES_IP error!
	echo [$CUR_TIME]: ping $DES_IP error! reset interface $DES_INF! >> $LOG_FILE
	reset_inf
	testconn

	if [ $? -ne 0 ] ; then
		i=1
		while [ $i -le $MAX_COUNT ]
		do
			reset_auth
			echo [$CUR_TIME]: reset interface and re-auth network for $i time! >> $LOG_FILE
			testconn

			if [ $? -eq 0 ] ; then
				echo [$CUR_TIME]: reset interface and re-auth network OK! >> $LOG_FILE
				break
			fi

			i=$[$i + 1]
		done
	fi

#	if [ $? -eq 0 ]; then
#		bash $AGENT_FILE restart
#		echo [$CUR_TIME]: restart agent OK! >> $LOG_FILE
#	fi
else
	echo ping $DES_IP OK!
	echo [$CUR_TIME]: ping $DES_IP OK! >> $LOG_FILE
fi

