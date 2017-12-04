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

# entry for run
run

