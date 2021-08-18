# Utilitário dropwatch
https://github.com/nhorman/dropwatch

**dropwatch** - kernel dropped packet monitoring utility

"Dropwatch is a project I started in an effort to improve the ability for developers and system administrators to diagnose problems in the Linux Networking stack, specifically in our ability to diagnose where packets are getting dropped."

## Requisitos Ubuntu 20.04
```bash
apt install build-essential autogen automake libtool pkg-config libpcap-dev \
            libreadline-dev binutils-dev libnl-3-dev libnl-genl-3-dev
```

## Instalação
```bash
wget https://github.com/nhorman/dropwatch/archive/refs/tags/v1.5.3.tar.gz
tar xvzf v1.5.3.tar.gz
cd dropwatch-1.5.3 

./autogen.sh
./configure
make
make install
```

## Utilização

```bash
# Lista 
dropwatch -l list

# Abre dropwatch shell
dropwatch -l kas

# Inicia dropwatch
dropwatch> start
```
