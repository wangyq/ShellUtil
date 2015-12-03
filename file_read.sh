#!/bin/sh

dos2unix()
{
    SRC_FILE="tt.txt"
    DES_FILE="aa.txt"
    
    echo -n "" > $DES_FILE  #first create an empty des_file
    #echo -n "" > $DES_FILE  #first create an empty des_file
    #touch $DES_FILE

    while IFS='' read -r line || [[ -n "$line" ]]; do
        echo $line
        #echo "$line" >> $DES_FILE
        #echo -e "$line" >> $DES_FILE
        #printf "%s" "$line" >> $DES_FILE
    done < $SRC_FILE
}

dos2unix 

