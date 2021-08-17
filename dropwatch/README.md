# Utilitário dropwatch
https://github.com/nhorman/dropwatch

"Dropwatch is a project I started in an effort to improve the ability for developers and system administrators to diagnose problems in the Linux Networking stack, specifically in our ability to diagnose where packets are getting dropped."

## Requisitos Ubuntu 20.04
```bash
apt install libtool pkg-config libpcap-dev libreadline-dev binutils-dev libnl-3-dev libnl-genl-3-dev
```

## Instalação
```bash
./autogen.sh
./configure
make
make install
```

