#!/bin/sh

#str="address=2400:10:20:a:1"
str="923482093a:39"
str1=${str^^}
echo "str1=$str1"

if [[ "$str" =~ "[0-9]{0,3}.[0-9]{0,3}.[0-9]{0,3}.[0-9]{0,3}" ]]; then 
	echo "IPv4"
elif [[ "$str" =~ "" ]]
	echo "IPv6"
else echo "error address."
fi

