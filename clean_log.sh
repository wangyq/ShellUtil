#!/bin/bash
#清理日志的脚本

#日志大小限制设置（ 单位: 字节），超出即清理
LOG_FILE_SIZE=100
#LOG_FILE_SIZE=1024000

#定义日志文件位置
logs=(/root/workspace/bgp_pma/run/pma.log /root/workspace/bgp_pma/run/ic.log /var/log/snmpd.log)

for ff in "${logs[@]}"; 
do

#文件大小
size=0
if [ -f $ff ] 
then 
        #取得日志文件大小值
        size=`ls -l $ff |awk '{print $5}'`
fi

#进行判断
if [ "$size"0 -gt "$LOG_FILE_SIZE"0 ]
then
        echo 开始清理: "$ff" , 大小= "$size"
        # > $ff
	#true > $ff
        #cat /dev/null > $ff
        #echo > $ff
	echo "" > $ff
fi

done

#清理完成
echo 清理日志完成!

