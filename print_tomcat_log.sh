#!/bin/bash
APP_NAME=pmweb.war
TOMCAT_DIR=/srv/tomcat6
TOMCAT_LOG_FILE=$TOMCAT_DIR/logs/catalina.out
APP_DIR=$TOMCAT_DIR/webapps

LINES=20

cur_line=$(cat <$TOMCAT_LOG_FILE |wc -l)
cur_line=$(( $cur_line - $LINES))

echo "反复显示 TOMCAT日志: $TOMCAT_LOG_FILE ! "

while [ true ] ; do

	#文件当前行数
	num_lines=$(cat <$TOMCAT_LOG_FILE |wc -l)
	if [ $cur_line -gt $num_lines ] ; then 
		cur_line=$(( $num_lines - $LINES))
	elif [ $cur_line -eq $num_lines ] ; then
		continue
	fi
	#显示行数范围
	#sed -ne '10,30p' $TOMCAT_LOG_FILE
	sed -ne "$(($cur_line +1)),$(($num_lines))p" $TOMCAT_LOG_FILE

	#echo "$cur_line --> $num_lines"

	cur_line=$(($num_lines))
	sleep 1 
	
done


