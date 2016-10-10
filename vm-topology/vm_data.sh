#!/bin/sh


IDFILE=ID.TXT

#== global data of ( openflow-id interfaces )
DATA_R1=(0000000000000001 "ens34 ens35 ens36      " )
DATA_R2=(0000000000000002 "ens34 ens35 ens36      " )
DATA_R3=(0000000000000003 "ens34 ens35 ens36 ens37" )
DATA_R4=(0000000000000004 "ens34 ens35 ens36 ens37" )
DATA_R5=(0000000000000005 "ens34 ens35 ens36      " )
DATA_R6=(0000000000000006 "ens34 ens35 ens36      " )


get_id()
{
    if [ ! -f "$IDFILE" ] ; then
        echo "ID File '$IDFILE' not found!"
        return
    else
        ID=`cat $IDFILE`
        #echo "ID is $ID"
    fi

    if [ ! -n "$ID" ] ; then
        echo "ID is empty"
    fi

    echo $ID
}
#== get router id and router data ==
RID=`get_id`

#GDATA=("${DATA_R1[@]}")
eval RDATA=(\"\${DATA_R${RID}[@]}\")

test_value()
{
    echo " RID is $RID"
    echo " RDATA is ofid=${RDATA[0]} intf=${RDATA[1]}"
}



