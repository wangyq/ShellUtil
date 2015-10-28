#! /bin/sh
RLTMPATH=/home/jiangshan/program/RLTM
pma=(11.1.11.2 11.2.21.2 11.2.22.2 11.2.23.2 11.3.31.2 11.4.41.2 11.4.42.2 11.5.51.2 11.5.52.2 11.5.53.2 11.6.61.2 11.6.62.2 11.7.71.2 11.7.72.2 11.8.81.2 11.8.82.2)
as=(11.1.11.1 11.2.21.1 11.2.22.1 11.2.23.1 11.3.31.1 11.4.41.1 11.4.42.1 11.5.51.1 11.5.52.1 11.5.53.1 11.6.61.1 11.6.62.1 11.7.71.1 11.7.72.1 11.8.81.1 11.8.82.1)
#pma=(PMA1-1 PMA2-1 PMA2-2 PMA2-3 PMA3-1 PMA4-1 PMA4-2 PMA5-1 PMA5-2 PMA5-3 PMA6-1 PMA6-2 PMA7-1 PMA7-2 PMA8-1 PMA8-2)
#as=(AS1-1 AS2-1 AS2-2 AS2-3 AS3-1 AS4-1 AS4-2 AS5-1 AS5-2 AS5-3 AS6-1 AS6-2 AS7-1 AS7-2 AS8-1 AS8-2)
for ip in ${pma[*]} ; do
	echo $ip
	ssh root@$ip "hostname;ps -e|grep rltm;ps -e|grep bgpmon;ps -ef|grep BGPmon.jar|grep -v grep;ps -e|grep pmad;exit"
done
for ip in ${as[*]} ; do
	echo $ip
	ssh root@$ip "hostname;ps -e | grep qconf;exit"
done
