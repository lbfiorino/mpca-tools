# Fragroute

**Sources:** [fragroute](https://www.monkey.org/~dugsong/fragroute/), [libdnet](http://libdnet.sourceforge.net/).

Por ser antigo, gerou erros de compilação em sistemas operacionais recentes.  
Para a instalação, foi utilizado um pacote já compilado do Kali Linux.

## Pacotes compliados:
- fragroute_1.2-8kali1_amd64.deb - [Kali Linux (Debian 10)](http://kalirepo.pxinfra.net/kali-rolling/pool/main/f/fragroute/)
- fragroute_1.2-7.1_amd64.deb - [Ubuntu 8.04 LTS (Hardy)](https://launchpad.net/ubuntu/hardy/amd64/fragroute/1.2-7.1)
- fragroute_1.2-8Ubuntu20.04_amd64.deb - Pacote adaptado para o Ubuntu 20.04

## Instalação do pacote compilado do Kali Linux no Debian 10
:warning: Nota:
> No Ubuntu 20.04 instalar `libevent-2.1-7` e utilizar o pacote [`fragroute_1.2-8Ubuntu20.04_amd64.deb`](fragroute_1.2-8Ubuntu20.04_amd64.deb).  

### Requisitos
- Debian 10
- libc6 (>= 2.14)
- libdumbnet1 (>= 1.8)
- libevent-2.1-6 (>= 2.1.8-stable)
- libpcap0.8 (>= 0.9.8)
- [libdnet 1.11](http://libdnet.sourceforge.net/)

```bash
apt install build-essential libc6 libdumbnet1 libevent-2.1-6 libpcap0.8
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

### Instalar fragroute_1.2-8kali1_amd64.deb
```
wget http://kalirepo.pxinfra.net/kali-rolling/pool/main/f/fragroute/fragroute_1.2-8kali1_amd64.deb
dpkg -i fragroute_1.2-8kali1_amd64.deb
```

Verificar se encontrou todas as libs:
```bash
ldd /usr/sbin/fragroute
```
