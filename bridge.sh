#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Must be root"
	exit
fi

FROM="eth0"
TO="wlan0"
# Allow overriding from eth0 by passing in a single argument
if [ $# -eq 2 ]; then
    FROM="$1"
    TO="$2"
fi



sudo iptables -t nat -A POSTROUTING -o $FROM -j MASQUERADE  
sudo iptables -A FORWARD -i $FROM -o $TO -m state --state RELATED,ESTABLISHED -j ACCEPT  
sudo iptables -A FORWARD -i $TO -o $FROM -j ACCEPT
