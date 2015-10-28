#!/bin/bash
echo 使用Glassfish服务器时, 注意设置WEB-INF/web.xml中数据库连接信息。

APP_NAME=pmweb.war
GLASSFISH_DIR=/srv/glassfish3
APP_DIR=$GLASSFISH_DIR/glassfish/domains/domain1/autodeploy/

if [ -f "$APP_NAME" ] ; then
	echo  File "$APP_NAME" found!
	ls -l $APP_NAME
else
	echo  File "$APP_NAME" not found!
	exit
fi

cp $APP_NAME $APP_DIR/
#$GLASSFISH_DIR/bin/asadmin stop-domain
#$GLASSFISH_DIR/bin/asadmin start-domain
sleep 3 
tail -n 40 $GLASSFISH_DIR/glassfish/domains/domain1/logs/server.log

echo Glassfish3 部署 "$ADD_NAME "完成! 
