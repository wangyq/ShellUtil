#!/bin/sh

#  use a netctl hook to run a command each time a netctl profile is re-/started for a specific network interface
# /etc/netctl/interfaces/[your-interface]
# /usr/bin/macchanger -r interface 

#macaddr=$(echo $FQDN|md5sum|sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/')
#macaddr=$(dd if=/dev/urandom bs=1024 count=1 2>/dev/null|md5sum|sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\)\(..\).*$/\1:\2:\3:\4:\5:\6/')


run()
{
INTFS="ens34 "

for f in $INTFS ; do
    macaddr=$(dd if=/dev/urandom bs=1024 count=1 2>/dev/null|md5sum|sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\)\(..\).*$/\1:\2:\3:\4:\5:\6/')

    echo "interfac:  $f macaddr = $macaddr"
    ip link set dev $f down
    ip link set dev $f address $macaddr
    ip link set dev $f up
    ip link show $f

done

}

changemac()
{
	INTF=$1
	echo "interface is: $INTF"
	if [ -z "$INTF" ] ; then
		return
	fi

    macaddr=$(dd if=/dev/urandom bs=1024 count=1 2>/dev/null|md5sum|sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\)\(..\).*$/\1:\2:\3:\4:\5:\6/')

	ip link set dev $INTF down
	ip link set dev $INTF address $macaddr
	ip link set dev $INTF up
	ip link show $INTF
}

# entry for run

#changemac "eth0"

usage()
{
    #echo "$# parameters"    
    echo "Usage: "
    echo "     $0 INTF1 INTF2 ..."
    echo "        where INTF1,INTF2 is the network interface name, such as eth0, enp3s0, etc."	
}

#----------------------------------------------------#
# shell entry to exec!
#
#----------------------------------------------------#
main()
{
	if [ $# = 0 ] ; then
		usage $@;
		return ;
	fi
	for f in $*;
    do
        changemac $f
    done;
}

# shell entry to start
main $@

