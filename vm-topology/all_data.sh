#!/bin/sh

#===================================
# create custom all data conf file.
# usage: create_all_conf [conf-file] [tmp-file] [host]
#
create_all_conf()
{
    TMPFILE=/tmp/tmp.sh

    CONF=$1
    TMPFILE=$2
    HOST=$3

    echo "Create all_conf_file = Conf-File: $CONF, Tmp-File: $TMPFILE, Host : $HOST"
   
    #Conf-file 
    if [ -z "$CONF" ] ; then
        echo "Conf-File name is null"
        exit
    fi
    if [ ! -x "$CONF" ]; then
        echo "Conf-File is not exist or NOT executable!"
        exit
    fi

    #Tmp-file     
    if [ -z "$TMPFILE" ] ; then
        echo "Tmp-File name is null"
        exit
    fi

    #Host 
    if [ -z "$HOST" ] ; then
        echo "Host name is null"
        exit
    fi

    cp $CONF $TMPFILE
    
    echo "" >> $TMPFILE
    echo "GDATA=(\"\${DATA_$HOST[@]}\")" >> $TMPFILE
    
    #scp All_data.sh root@$h:~/
}

#== global data of ( interfaces openflow-id )
DATA_R1=(0000000000000001 "ens34 ens35 ens36      " )
DATA_R2=(0000000000000002 "ens34 ens35 ens36      " )
DATA_R3=(0000000000000003 "ens34 ens35 ens36 ens37" )
DATA_R4=(0000000000000004 "ens34 ens35 ens36 ens37" )
DATA_R5=(0000000000000005 "ens34 ens35 ens36      " )
DATA_R6=(0000000000000006 "ens34 ens35 ens36      " )

# ==== reset interfaces ==
#OFID=${GDATA[0]}
#INTERFACES=${GDATA[1]}

#GDATA=$DATA_R1
#GDATA=("${DATA_R1[@]}")

#create_all_conf all_data.sh /tmp/tmp.sh R2


