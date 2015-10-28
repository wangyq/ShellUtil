#!/bin/bash

#Conf file directory
CONF_DIR=/etc/quagga
RUN_DIR=/var/run/quagga

#conf file to copy!
CONF=(zebra ospfd bgpd)

PACKAGE=$1
#QUAGGA=`echo "$PACKAGE"|awk -F '.tar' '{print $1}' `
#SUFF=`echo "$PACKAGE"|awk -F '.tar' '{print $2}' `
QUAGGA=${PACKAGE%%.tar*}
SUFF=${PACKAGE##*.tar}


#echo "Quagga=$QUAGGA, and suffix=$SUFF"
#exit

#check input parameter
if [ -z "$QUAGGA" ]; then
        echo "Usage: $0 quagga_package_name"
	exit
fi

#check if file exist
if [ ! -f "$PACKAGE" ] ; then
	echo "File $PACKAGE not found!"
	exit
fi

#check if file is a quagga's src package name
if [ "$PACKAGE" != "quagga"* ] ; then
	echo "$PACKAGE is not a valid quagga's src package!"
	exit
fi

echo "You should run "
echo "    'sudo yum install net-snmp net-snmp-devel net-snmp-perl net-snmp-utils (CentOS) to enable snmp!"
echo "You should run 'sudo yum install readline-devel (CentOS) first!"
echo "You should run 'sudo apt-get install libreadline6-dev (Ubuntu) first!"

#check file's compression type
if [ "$SUFF" = ".gz" ] ; then
	tar xzf $PACKAGE
elif [ "$SUFF" = ".bz2" ] ; then
	tar xjf $PACKAGE
elif [ "$SUFF" = ".xz" ] ; then
	tar xJf $PACKAGE
else
	echo "'$PACKAGE' File format unknown!"
	exit
fi

cd $QUAGGA

sudo mkdir $RUN_DIR
sudo chmod 777 $RUN_DIR

sudo mkdir $CONF_DIR
sudo chmod 777 $CONF_DIR

#copy conf file to destination directory
for ff in ${CONF[*]} ; do
	src_file=$ff.conf.sample
	dst_file=$ff.conf
	if [ ! -f "$CONF_DIR/$dst_file" ] ; then
		sudo cp $ff/$src_file $CONF_DIR/$dst_file
	fi
done

#
./configure --enable-vtysh --localstatedir=$RUN_DIR --sysconfdir=$CONF_DIR

#./configure --enable-vtysh --localstatedir=/var/run/quagga --sysconfdir=/etc/quagga

#./configure --enable-snmp=smux --enable-vtysh --localstatedir=$RUN_DIR --sysconfdir=$CONF_DIR

make && sudo make install && sudo ldconfig

cd ..

echo "install $QUAGGA finished!"

