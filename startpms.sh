#!/bin/sh

DIR=/srv
APPS=(gatewayserv appmanager bdatamanager decano)
TIME_DELAY=1

for app in ${APPS[*]}; do
	nohup java -jar $DIR/$app/$app.jar >> /dev/null 2>&1 &
	sleep $TIME_DELAY
	echo start $DIR/$app/$app.jar finished!
done

#cd /srv/gatewayserv
#nohup java -jar gatewayserv.jar >> /dev/null 2>&1 &
#sleep 1
#cd /srv/appmanager
#java -jar appmanager.jar &
#sleep 1
#cd /srv/bdatamanager
#java -jar bdatamanager.jar &
#sleep 1
#cd /srv/decano
#java -jar decano.jar &
#sleep 1

echo Start Apache Tomcat ......
sh /srv/tomcat6/apache-tomcat-6.0.35/bin/startup.sh
echo ok
