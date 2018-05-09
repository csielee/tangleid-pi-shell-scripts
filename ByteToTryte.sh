#!/bin/bash
#   function:
#       encode byte to tryte ,1 byte => 2 tryte
#
#   reference from iota.lib.js https://github.com/iotaledger/iota.lib.js/blob/develop/lib/utils/asciiToTrytes.js
#   2018/5/10 csielee

if [ "$1" == "" ]; then
    echo "you need to give a bytes"
    exit -1
fi

bytes=$1

TRYTE_VALUES="9ABCDEFGHIJKLMNOPQRSTUVWXYZ"
trytes=""

for ((i=0;i<${#bytes};i=i+2))
do
    ((byte=16#${bytes:$i:2}))
    if [ "$byte" == "" ]; then
        echo "error byte code"
        exit -1
    fi
    first=$(($byte%27))
    second=$((($byte-$first)/27))
    trytes=$trytes${TRYTE_VALUES:$first:1}${TRYTE_VALUES:$second:1}
done

echo $trytes

exit 0