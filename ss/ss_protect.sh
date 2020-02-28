#!/bin/sh

DEBUG=true

#LOGCMD="cat a.txt"
LOGCMD="journalctl --no-pager --since today -u ss-server"

RESALT="repeat salt detected"
FAILSHAKE="failed to handshake with "
FAILSHAKE_END=": authentication error"

FWRELOAD="firewall-cmd --reload	"
FWLISTRULE="firewall-cmd --list-rich-rules "

PROTOCOL=tcp
PORT=443
ACTION=reject  #drop

PROTOCOL1=udp
PORT1=443
ACTION1=reject

#----------------------------------------------------#
# return substring's index (start from 0)
# otherwise, return -1
#
#----------------------------------------------------#
strindex() {
	x="${1%%$2*}"
	[[ "$x" = "$1" ]] && echo -1 || echo "${#x}"
}

#----------------------------------------------------#
# do protect action with ip address and ip familiy
# parameter :  ipaddr (for example, 13.25.68.21 or 2409:8880:3e01:200:100::b1)
#----------------------------------------------------#
do_protect(){
	local ipstr=$1
	local family="ipv4"
	if [[ "$ipstr" =~ ":" ]]; then family="ipv6"; fi

	if ! $DEBUG; then
		firewall-cmd --zone=public --add-rich-rule="rule family=$family source address=$ipstr port protocol=$PROTOCOL port=$PORT $ACTION"
		firewall-cmd --zone=public --add-rich-rule="rule family=$family source address=$ipstr port protocol=$PROTOCOL1 port=$PORT1 $ACTION1"
	else
		echo "firewall-cmd --zone=public --add-rich-rule='rule family=$family source address=$ipstr port protocol=$PROTOCOL port=$PORT $ACTION' "
	fi
}

#----------------------------------------------------#
# run app program
#
#----------------------------------------------------#
run() {
	local strs=`${LOGCMD}`
	local resalt=false

	while read -r line; do
		if $resalt && [[ $line =~ $FAILSHAKE ]]; then
			local first=$(strindex "$line" "$FAILSHAKE")
			local last=$(strindex "$line" "${FAILSHAKE_END}")

			local len=${#FAILSHAKE}
			first=$((first + len))
			if [ $first -le $last ]; then
				len=$((last - first))
				do_protect ${line:first:len}
			fi
		elif [[ $line =~ $RESALT ]]; then
			#echo "repeat salt found: $line"
			resalt=true
		else
			resalt=false
		fi
	done <<<"$strs"

	cat /dev/null > /var/spool/mail/root

	echo "run finished!"
}

#----------------------------------------------------#
# shell entry to exec!
#
#----------------------------------------------------#
main() {

	case $1 in
	run)
		run
		;;
	start)
		start
		;;
	*)
		echo "Usage: $0 start | run"
		;;
	esac
}

# shell entry to start
main $@



