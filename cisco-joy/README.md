# Cisco Joy
A package for capturing and analyzing network flow data and intraflow data, for network research, forensics, and security monitoring.  
https://github.com/cisco/joy  
https://developer.cisco.com/codeexchange/github/repo/cisco/joy/  

# Install on Ubuntu 20.04
https://github.com/cisco/joy/wiki/Building  
```bash
apt-get install build-essential libssl-dev libpcap-dev libcurl4-openssl-dev

git clone https://github.com/cisco/joy.git
cd joy

./configure --enable-gzip
make clean
make
```
