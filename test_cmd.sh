#!/bin/sh


#exec cmd;
#for h in R1 R2 R3 R4 R5 R6 R7 R8 R111 R112 R113 R114 R121 R122 R123  R124 R131 R132 R133 R134  R135 R136 R137 R138 R211 R212 R213 R214 R221 R222 R223 R224 R231 R232 R233 R234 R235 R236 R237 R238 ;


for h in ;
#for h in R2 R3 R4 R5 R6 R7 R8;
#不包含R1路由器
#for h in R2 R3 R4 R5 R6 R7 R8 R111 R112 R113 R114 R121 R122 R123  R124 R131 R132 R133 R134  R135 R136 R137 R138 R211 R212 R213 R214 R221 R222 R223 R224 R231 R232 R233 R234 R235 R236 R237 R238 ;
do
	echo begin execute command in host "$h" ...
	#ssh root@$h "hostname; exit;"
	#ssh root@$h "hostname; ntpdate pmweb; exit;"

	# == install CR30 to every machine
	#ssh root@$h "hostname; cd workspace/CR30/ ; ./run_all.sh; exit;"	
	scp CR30.tar.gz root@$h:~/workspace
	ssh root@$h "cd workspace; tar xzf CR30.tar.gz; cd CR30/ ; cp conf/config.vty.$h config.vty; rm ../CR30.tar.gz; make; exit;"	
done

