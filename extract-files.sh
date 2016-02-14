#!/bin/bash
#######################################################################################################
#
# Based on: https://github.com/playfulgod/android_device_lge_l1m/blob/8b597e17685d3882942ce5bd8928308088632dae/extract-files.sh
#
# Adapted to F3Q and enhanced by MD5 checksum checks by xdajog
#######################################################################################################
VENDOR=lge
DEVICE=fx3q

#this is the correct path but for the moment we do not use it because of too much changes needed
BASE=../../../vendor/$VENDOR/$DEVICE/proprietary

rm -rf $BASE/*

for FILE in `cat proprietary-files.txt | grep -v ^# | grep -v ^$`; do
    DIR=`dirname $FILE`
    if [ ! -d $BASE/$DIR ]; then
        mkdir -p $BASE/$DIR
    fi
    # Ensuring the files are REALLY fetched correctly takes much time but it
    # is so DAMN important! Think about there was a transfer error and you get
    # various problems in ROM later! This will eat your mind believe me.
    MD5C=3
    while [ $MD5C -ne 0 ];do
	unset RMD5
        adb pull /system/$FILE $BASE/$FILE
        PRMD5=$(adb shell "md5sum /system/$FILE")
        RMD5=$(echo $PRMD5 |cut -d " " -f1)
        LMD5=$(md5sum $BASE/$FILE |cut -d ' ' -f1)
        if [ "x$RMD5" != "x$LMD5" ];then 
            echo "MD5 mismatch ($RMD5 vs. $LMD5)! Starting re-fetch!"
        else
            echo "checksum check OK."
            MD5C=0
        fi
    done
    #[ $? -ne 0 ] && echo "Error occured while fetching by adb. stopped!" && exit 2
done

./setup-makefiles.sh
