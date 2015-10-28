#!/bin/bash
echo 使用JBoss服务器时, 注意设置WEB-INF/web.xml中数据库连接信息。

APP_NAME=pmweb.war
APP_DIR=/srv/jboss/standalone/deployments

if [ -f "$APP_NAME" ] ; then
	echo  File "$APP_NAME" found!
	ls -l $APP_NAME
else
	echo  File "$APP_NAME" not found!
	exit
fi

#cp $APP_NAME $APP_DIR/
#sudo service jboss stop
#sudo service jboss start
#sleep 5
tail -n 120 /var/log/jboss-as/console.log

echo JBoss7 部署 "$ADD_NAME "完成! 
