#!/bin/sh

DEBUG=true

LOGCMD="journalctl --no-pager --since today -u ss-server"

RESALT="repeat salt detected"
FAILSHAKE="failed to handshake with "
FAILSHAKE_END=": authentication error"

FWRELOAD="firewall-cmd --reload	"
FWLISTRULE="firewall-cmd --list-rich-rules "

PROTOCOL=tcp
PORT=44444
ACTION=reject

PROTOCOL1=udp
PORT1=44444
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

is_ipv6_str() {
	local str=${1^^} #to upper case
	local len=${#str}
	if [ $len -gt 15 ]; then echo true; fi
	if [[ $str = "*A*" ]] || [[ $str = "*B*" ]] || [[ $str = "*C*" ]] || [[ $str = "*D*" ]] || [[ $str = "*E*" ]] || [[ $str = "*F*" ]] || [[ $str = "*::*" ]]; then echo true; fi

	echo false
}

#----------------------------------------------------#
# run app program
#
#----------------------------------------------------#
run() {
	strs=$(cat a.txt)
	#strs=`$LOGCMD`

	local resalt=false

	while read -r line; do
		if $resalt && [[ $line =~ $FAILSHAKE ]]; then
			afirst=$(strindex "$line" "$FAILSHAKE")
			last=$(strindex "$line" "${FAILSHAKE_END}")

			alen=${#FAILSHAKE}
			first=$((afirst + alen))
			if [ $first -le $last ]; then
				len=$((last - first))
				ipstr=${line:first:len}
				isIPv6=$(is_ipv6_str $ipstr)

				if $isIPv6; then family="ipv6"; else family="ipv4"; fi
				if ! $DEBUG; then
					firewall-cmd --zone=public --add-rich-rule="rule family=$family source address=$ipstr port protocol=$PROTOCOL port=$PORT $ACTION"
					firewall-cmd --zone=public --add-rich-rule="rule family=$family source address=$ipstr port protocol=$PROTOCOL1 port=$PORT1 $ACTION1"
				else
					echo "firewall-cmd --zone=public --add-rich-rule='rule family=$family source address=$ipstr port protocol=$PROTOCOL port=$PORT $ACTION' "
				fi
			fi
		elif [[ $line =~ $RESALT ]]; then
			#echo "repeat salt found: $line"
			resalt=true
		else
			resalt=false
		fi

	done <<<"$strs"

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
