#!/bin/bash
APP_NAME=pmweb.war
TOMCAT_DIR=/srv/tomcat6
APP_DIR=$TOMCAT_DIR/webapps

echo 使用 Tomcat 服务器时, 注意设置WEB-INF/web.xml中数据库连接信息。

if [ -f "$APP_NAME" ] ; then
	echo  File $APP_NAME found!
	ls -l $APP_NAME
else
	echo  File $APP_NAME not found!
	exit
fi

cp $APP_NAME $APP_DIR/
sudo service tomcat6 stop
sudo service tomcat6 start
sleep 3 
tail -n 30 $TOMCAT_DIR/logs/catalina.out

echo Tomcat6部署 "$ADD_NAME "完成! 
