#!/bin/bash

display_usage() {
        echo "This script must be run with super-user privileges."
        echo -e "\n\tUsage: $0 <interface> <pcap-file> \n"
        }
# if less than two arguments supplied, display usage
        if [  $# -le 1 ]
        then
                display_usage
                exit 1
        fi

# check whether user had supplied -h or --help . If yes display usage
        if [[ ( $# == "--help") ||  $# == "-h" ]]
        then
                display_usage
                exit 0
        fi

# display usage if the script is not run as root user
        if [[ "$EUID" -ne 0 ]]; then
                echo "This script must be run as root!"
                exit 1
        fi


iface=$1
pcapfile=$2

# Start tshark
tshark -F pcap -i $iface -w $pcapfile-replay.pcap > /dev/null 2>&1 &

# Start tcpreplay
tcpreplay --intf1=$iface --multiplier=1.000000 --preload-pcap $pcapfile > $pcapfile-replay.log

# Kill tshark
pkill tshark
