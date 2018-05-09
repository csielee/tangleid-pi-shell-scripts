#!/bin/bash
#   function:
#       gen tangle id uuid
#
#   2018/5/10 csielee

if [ "$1" != "" ]; then
allMAC=$(ifconfig | grep $1 | awk '{print $5}' | tr -d :)
fi

if [ "$allMAC" == "" ]; then
allMAC=$(ifconfig | grep HW | awk '{print $5}' | tr -d :)
fi

for mac in $allMAC
do
    trytes=$(./ByteToTryte.sh ${mac:${#mac}-8:8})
    echo LASS$trytes
done