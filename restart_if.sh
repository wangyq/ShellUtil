#!/bin/sh

if [ -z $1  ] ; then
        echo Usage: "restart_if.sh ifname"
        echo        where ifname is the interface name like 'eth0'.
        exit
fi

#now restart interface

/sbin/ifdown $1
/sbin/ifup $1
/etc/init.d/authSchoolNetwork.sh -i

echo restart interface "$1" finished!

