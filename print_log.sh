#!/bin/bash

#LOG_FILE=$TOMCAT_DIR/logs/catalina.out

print_log()
{

	LOG_FILE=$1

	LINES=20

	if [ !  -r $LOG_FILE ] ; then
		echo "File \"$LOG_FILE\" cann't read!"
		exit
	fi

	cur_line=$(cat <$LOG_FILE |wc -l)
	if [ $cur_line -le $LINES ] ; then
		cur_line=0
	else
		cur_line=$(( $cur_line - $LINES))
	fi

	echo "反复显示 日志文件: $LOG_FILE ! "

	while [ true ] ; do

		#文件当前行数
		num_lines=$(cat <$LOG_FILE |wc -l)
		if [ $cur_line -gt $num_lines ] ; then 
			cur_line=$(( $num_lines - $LINES))
		elif [ $cur_line -eq $num_lines ] ; then
			continue
		fi
		#显示行数范围
		#sed -ne '10,30p' $TOMCAT_LOG_FILE
		sed -ne "$(($cur_line +1)),$(($num_lines))p" $LOG_FILE

		#echo "$cur_line --> $num_lines"

		cur_line=$(($num_lines))
		sleep 1 
	
	done

}

main()
{
	if [ $# -lt 1 ] ; then
		echo "Usage: $0 log_filename"
		exit
	fi
	print_log $1
}

main $@

