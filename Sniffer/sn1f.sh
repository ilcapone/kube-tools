#!/bin/bash
POD=$1
yum install -y tcpdump &
sleep 5
tcpdump -A -U -s0 -i eth0 -vv -w /home/sn1f-$POD -C 1 -nl port http or port https &
sleep 5
