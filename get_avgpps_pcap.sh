#!/bin/bash
# Get Average packet rate from PCAP file
capinfos -x $1 | grep 'Average packet rate' | awk '{print $4}' | tr -d ',.'
