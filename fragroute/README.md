# Fragroute

## Links
- [fragroute](https://www.monkey.org/~dugsong/fragroute/)
- [libdnet](http://libdnet.sourceforge.net/)

## Pacotes compliados:
- fragroute_1.2-8kali1_amd64.deb - [Kali Linux 2.0 (Debian 10)](http://kalirepo.pxinfra.net/kali-rolling/pool/main/f/fragroute/)
- fragroute_1.2-7.1_amd64.deb - [Ubuntu 8.04 LTS (Hardy)](https://launchpad.net/ubuntu/hardy/amd64/fragroute/1.2-7.1)

## Instalação Debian 10

### Requisitos
- libc6 (>= 2.14)
- libdumbnet1 (>= 1.8)
- libevent-2.1-6 (>= 2.1.8-stable)
- libpcap0.8 (>= 0.9.8)
- [libdnet 1.11](http://libdnet.sourceforge.net/)

```bash
apt install  libc6 libdumbnet1 libevent-2.1-6 libpcap0.8
```
### Instalar libdnet
```bash
cd /root
wget https://ufpr.dl.sourceforge.net/project/libdnet/libdnet/libdnet-1.11/libdnet-1.11.tar.gz
tar xvzr libdnet-1.11.tar.gz
cd libdnet-1.11
./configure
make
make install
```
