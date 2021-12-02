# Cisco Joy
A package for capturing and analyzing network flow data and intraflow data, for network research, forensics, and security monitoring.  
https://github.com/cisco/joy  
https://developer.cisco.com/codeexchange/github/repo/cisco/joy/  

## Install on Ubuntu 20.04
https://github.com/cisco/joy/wiki/Building  
```bash
apt-get install build-essential libssl-dev libpcap-dev libcurl4-openssl-dev

git clone https://github.com/cisco/joy.git
cd joy

./configure --enable-gzip
make clean
make
```

## Using Joy
The command line syntax to invoke joy is:
```bash
# joy [options] [file1 [file2 ... ]]

joy bidir=1 browse.pcap | gunzip
{"version":"1.74","interface":"none","promisc":0,"output":"none", ... }
{"sa":"10.0.2.15","da":"74.125.228.207","pr":6,"sp":43039,"dp":443, ... }
{"sa":"10.0.2.15","da":"74.125.228.195","pr":6,"sp":54210,"dp":443, ... }
{"sa":"10.0.2.15","da":"74.125.228.104","pr":6,"sp":47443,"dp":443, ... }
...
```
