# Argus
Argus is a Real Time Flow Monitor that is designed to perform comprehensive data network traffic auditing.  
https://openargus.org/  
https://openargus.org/using-argus  

# Install on Ubuntu 20.04

```bash
# Requirements
apt install build-essential flex bison

# Argus-3.0.8.2
wget http://qosient.com/argus/src/argus-3.0.8.2.tar.gz
wget http://qosient.com/argus/src/argus-clients-3.0.8.2.tar.gz

tar xvzf argus-3.0.8.2.tar.gz
tar xvzf argus-clients-3.0.8.2.tar.gz

cd argus-3.0.8.2
./configure
make
mane install

cd ..
cd argus-clients-3.0.8.2
./configure
make
make install
```
# Using Argus

Convert PCAP to argus: `argus -r packet.pcap -w packet.argus`

Read argus file: `ra -r packet.argus`

![Using-Argus](argus.packet.processing.png)
