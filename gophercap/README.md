# GopherCap
[GitHub Link](https://github.com/StamusNetworks/gophercap)  
Instalação da ferramenta GoperCap.  
A instalação foi realizada com o usuário `root`.

## Requisitos
- libpcap-dev e libpcap0.8: 
    - Debian-based: `apt install libpcap-dev libpcap0.8` 

- [Go](https://golang.org/dl/) >=1.15

- Git
    - Debian-based: `apt install git` 

## Instalação no Ubuntu 20.04

### 1. Libpcap
```
apt update
apt install libpcap-dev libpcap0.8 git
```

### 2. Linguagem Go

```
cd /root
wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz
```

Adicionar `/usr/local/go/bin`no PATH:
```
export PATH=$PATH:/usr/local/go/bin
```
Nota:
> Para adicionar de forma permanente, editar o arquivo `/etc/environment` e adicionar `/usr/local/go/bin` no PATH.

Teste:
```
go version
```

### 3. GopherCap

```
cd /root
git clone https://github.com/StamusNetworks/gophercap.git

cd /root/gophercap

# Get project dependencies
go get -u ./

# Build the binary
go build -o ./gopherCap ./

# Install and Add to PATH
go install
export PATH=$PATH:/root/go/bin/
```
