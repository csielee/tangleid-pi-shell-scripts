#!/bin/bash
#   shell script library for TangleID
#
#   2018/5/29 csielee

TangleID_backend="http://node0.puyuma.org/tangleid_backend/api/"

function byteToTryte {

    if [ "$1" == "" ]; then
        #echo "you need to give a bytes"
        return -1
    fi

    bytes=$1

    TRYTE_VALUES="9ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    trytes=""

    for ((i=0;i<${#bytes};i=i+2))
    do
        ((byte=16#${bytes:$i:2}))
        if [ "$byte" == "" ]; then
            #echo "error byte code"
            return -1
        fi
        first=$(($byte%27))
        second=$((($byte-$first)/27))
        trytes=$trytes${TRYTE_VALUES:$first:1}${TRYTE_VALUES:$second:1}
    done

    echo $trytes

    return 0
}

function genUUID {

    if [ "$1" != "" ]; then
    allMAC=$(ifconfig | grep $1 | awk '{print $5}' | tr -d :)
    fi

    if [ "$allMAC" == "" ]; then
    allMAC=$(ifconfig | grep HW | awk '{print $5}' | tr -d :)
    fi

    for mac in $allMAC
    do
        trytes=$(byteToTryte ${mac:${#mac}-8:8})
        echo LASS$trytes
    done
    return 0
}

function POST {
    RES=$(curl -s $TangleID_backend \
        -X POST \
        -H 'Content-Type: application/json' \
        -d ''"$*"'')

    if [ $RES -ne 0 ]; then
        echo 'Assert failed: "' $* '"'
        return -1
    else
        echo $RES
        return 0
    fi
}
