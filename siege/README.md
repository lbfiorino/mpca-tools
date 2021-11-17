# SIEGE - A HTTP/FTP load tester and benchmarking utility
https://www.joedog.org/  
https://github.com/JoeDog/siege  

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
