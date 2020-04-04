#!/bin/bash
POD=$1
yum install -y tcpdump &
tcpdump -A -U -s0 -i eth0 -vv -w /home/sn1f-$POD -C 10 -nl port http or port https &
sleep 5
