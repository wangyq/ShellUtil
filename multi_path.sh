#!/bin/bash
# This script is done by : Robert Kurjata Sep, 2003.
# feel free to use it in any usefull way

# CONFIGURATION
IP=/sbin/ip
PING=/bin/ping

#--------------- LINK PART -----------------
# EXTIFn - interface name
# EXTIPn - outgoing IP
# EXTMn  - netmask length (bits)
# EXTGWn - outgoing gateway
#-------------------------------------------

# LINK 1
EXTIF1=eth2
EXTIP1=
EXTM1=
EXTGW1=

# LINK 2
EXTIF2=eth1
EXTIP2=
EXTM2=
EXTGW2=

#ROUTING PART
# removing old rules and routes

echo "removing old rules"
${IP} rule del prio 50 table main
${IP} rule del prio 201 from ${EXTIP1}/${EXTM1} table 201
${IP} rule del prio 202 from ${EXTIP2}/${EXTM2} table 202
${IP} rule del prio 221 table 221
echo "flushing tables"
${IP} route flush table 201
${IP} route flush table 202
${IP} route flush table 221
echo "removing tables"
${IP} route del table 201
${IP} route del table 202
${IP} route del table 221

# setting new rules
echo "Setting new routing rules"

# main table w/o default gateway here
${IP} rule add prio 50 table main
${IP} route del default table main

# identified routes here
${IP} rule add prio 201 from ${EXTIP1}/${EXTM1} table 201
${IP} rule add prio 202 from ${EXTIP2}/${EXTM2} table 202

${IP} route add default via ${EXTGW1} dev ${EXTIF1} src ${EXTIP1} proto static table 201
${IP} route append prohibit default table 201 metric 1 proto static

${IP} route add default via ${EXTGW2} dev ${EXTIF2} src ${EXTIP2} proto static table 202
${IP} route append prohibit default table 202 metric 1 proto static

# mutipath
${IP} rule add prio 221 table 221

${IP} route add default table 221 proto static \
            nexthop via ${EXTGW1} dev ${EXTIF1} weight 2\
            nexthop via ${EXTGW2} dev ${EXTIF2} weight 3

${IP} route flush cache

while : ; do
  ${PING} -c 1 ${EXTGW1}
  ${PING} -c 1 ${EXTGW2}
  sleep 60
done

