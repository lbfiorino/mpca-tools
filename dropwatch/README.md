# dropwatch - kernel dropped packet monitoring utility  
https://github.com/nhorman/dropwatch

Dropwatch is an interactive utility for monitoring and recording packets that are dropped by the kernel.

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

dropwatch [-l method | list]

```bash
# Lista 
dropwatch -l list

# Abre dropwatch shell
dropwatch -l kas

# Inicia dropwatch
dropwatch> start
```
