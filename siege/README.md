# SIEGE - A HTTP/FTP load tester and benchmarking utility
https://www.joedog.org/  
https://www.joedog.org/siege-faq/  
https://github.com/JoeDog/siege  

## Windows
- Download siege-windows-4.1.3.zip
- Extract to C:\siege-windows and run C:\siege-windows\siege.exe

## Requisitos Ubuntu 20.04
```bash
apt install build-essential zlib1g zlib1g-dev openssl libssl-dev
```

## Instalação
```bash
wget http://download.joedog.org/siege/siege-4.1.1.tar.gz
# OR https://github.com/JoeDog/siege/archive/refs/tags/v4.1.1.tar.gz

tar xvzf siege-4.1.1.tar.gz
cd siege-4.1.1 
./configure
make
make install
```

## Desinstalação
```
cd siege-4.1.1 
make uninstall
make distclean
```

## Can I run siege with multiple IP addresses from the same machine?
https://www.joedog.org/siege-faq/#a20

Yes. The best solution we’ve found comes to us from Robert Hartman although it is GNU/Linux specific and it requires IP tables support. Basically there are two steps.

1.) Add IP aliases. Example:
```bash
#!/bin/bash
for i in $(seq 101 150)
do
  ifconfig eth0:$i 192.168.1.$i
done
```
To delete aliases:
```bash
#!/bin/bash
for i in $(seq 101 150)
do
  ifconfig eth0:$i del 192.168.1.$i
done
```

2.) Reverse NAT with iptables. So that the Linux kernel acts as a client from more than one IP address use iptables to do reverse natting. Example:
```bash
iptables -t nat -A POSTROUTING -o eth0 -j SNAT –to 192.168.1.1-192.168.1.254
```
NOTES:
>This method can be used for Class B address spaces as well with proper masking on the eth0 interface. Robert tested this to work with 2500+ IPs on a single ethernet card. You can contact Robert via email: “robert at roberthartman dot net”
