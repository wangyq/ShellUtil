#!/bin/bash
#
#if you want to running it in console, just using
# "nohup java -jar pmserv.jar >> /dev/null 2>&1 & "
#nohup java -jar pmserv.jar >> /dev/null 2>&1 & 

PMUSER=pmuser
PMDIR=/srv/pmproject/pmserv
PMSER_JAR=pmserv.jar

PREV_DIR=${PWD}
#切换目录cd 
cd ${PMDIR} 

#su $PMUSER  -c "java -jar ${PMDIR}/pmserv.jar >> /dev/null & "
nohup java -jar ${PMDIR}/pmserv.jar >> /dev/null 2>&1 & 

#su wangxiaomin -c "java -jar /srv/pmproject/pmserv/pmserv.jar >> /dev/null & "

cd $PREV_DIR
