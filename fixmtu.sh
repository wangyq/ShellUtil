#!/bin/sh

if [ -z "$1" ]; then
	echo Usage: $0 device
	exit
fi

#Find device's parameters
MTU_STR="`ip link show $1`"
if [ -z "$MTU_STR" ]; then
	echo DEVICE "$1" not found!
	exit
fi

CURRENT_MTU="`echo $MTU_STR | grep -Poi '(?<=MTU:)([0-9]+)'`"
if [ -z "$CURRENT_MTU" ]; then
	CURRENT_MTU="`echo $MTU_STR | grep -Poi '(?<=mtu )([0-9]+)'`"
fi

#echo $MTU_STR
#echo "Current MTU = $CURRENT_MTU"

if [ -z "$CURRENT_MTU" ]; then
	echo cann\'t find mtu value!
	exit
fi

FIXED_MTU="`expr $CURRENT_MTU + 4`"
#echo "Fixed MTU=$FIXED_MTU"

ip link set $1 mtu $FIXED_MTU
echo "Increased MTU for $1 to $FIXED_MTU (from $CURRENT_MTU) to fix MPPE Microsoft Point-to-Point bug #330973"


#CURRENT_MTU="`ifconfig $1 | grep -Po '(?<=MTU:)([0-9]+)'`"
#CURRENT_MTU="`ip link show $1 | grep -Po '(?<=MTU:)([0-9]+)'`"
#echo MTU=$CURRENT_MTU
#if [ -z "$CURRENT_MTU" ]; then
	#CURRENT_MTU="`ifconfig $1 | grep -Po '(?<=mtu )([0-9]+)'`"
#	CURRENT_MTU="`ip link show $1 | grep -Po '(?<=mtu )([0-9]+)'`"
#fi
#echo MTU=$CURRENT_MTU

#FIXED_MTU="`expr $CURRENT_MTU + 4`"
#echo MTU=$FIXED_MTU
#ifconfig $1 mtu $FIXED_MTU
#ip link set $1 mtu $FIXED_MTU
#echo "Increased MTU for $1 to $FIXED_MTU (from $CURRENT_MTU) to fix MPPE Microsoft Point-to-Point bug #330973"

