#!/bin/sh

DIR=/srv
APPS=(gatewayserv appmanager bdatamanager decano)
TIME_DELAY=1

get_pid()
{
        local program=$1
        local pid=`ps -ef | grep "$program" | grep -v grep | awk  '{print   \$2}'`
        echo $pid
}

for app in ${APPS[*]}; do
	pid=`get_pid $app.jar`
	if [ "$pid" != "" ] ; then
		kill $pid
		echo Stop "$app.jar (pid=$pid)" finished!
	else
		echo Stop "$app.jar" error: process not found!
	fi
done

echo Stop Apache Tomcat ......
sh /srv/tomcat6/apache-tomcat-6.0.35/bin/shutdown.sh
echo Stop pms finished!
