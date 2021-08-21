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

- gcc 
    - Debian-based: `apt install build-essential` 

- jq
    - Debian-based: `apt install jq` 

## Instalação no Ubuntu 20.04

### 1. Requisitos (libpcap, git, jq)
```
apt update
apt install libpcap-dev libpcap0.8 git jq
```

### 2. Linguagem Go
[GoLang Download Page](https://golang.org/dl/)
```bash
cd /root
wget https://golang.org/dl/go1.15.6.linux-amd64.tar.gz
tar -C /usr/local -xzf go1.15.6.linux-amd64.tar.gz
```

Adicionar `/usr/local/go/bin`no PATH:
```bash
export PATH=$PATH:/usr/local/go/bin
```
Nota:
> Para adicionar de forma permanente, editar o arquivo `/etc/environment` e adicionar `/usr/local/go/bin` no PATH.

Teste:
```bash
go version
```

### 3. GopherCap
#### Build from sources
```bash
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
#### Download binary
```bash
apt install jq

GOPHER_URL=$(curl --silent "https://api.github.com/repos/StamusNetworks/gophercap/releases/latest" | jq -r '.assets[] | select(.name|startswith("gopherCap-ubuntu-2004-")) | .browser_download_url')

wget $GOPHER_URL

# gopherCap-ubuntu-2004-0.1.1.gz
gunzip gopherCap-ubuntu-2004-<version>.gz
chmod +x gopherCap-ubuntu-2004-<version>

# Run
# ./gopherCap-ubuntu-2004-<version>
```


### Replay PCAP
Mapear os metadados do arquivo pcap.
```bash
# gopherCap map --dir-src <pcaps-dir> --file-suffix "pcap" --dump-json <file.meta.json>
# Exemplo:
gopherCap map --dir-src /mnt/pcap --file-suffix "pcap" --dump-json /mnt/pcap/meta.json
# Option --file-regexp to filter files.
# e.g. 
# --file-regexp ".test." (todos os arquivos com 'test' no nome)
# --file-regexp "test\.pcap" (apenas o arquivo test.pcap)
gopherCap map --dir-src /mnt/pcap --file-regexp "test\.pcap" --dump-json /mnt/pcap/teste.meta.json

```

Replay do pcap.
```bash
gopherCap replay --out-interface veth0 --dump-json /mnt/pcap/meta.json
```

A interface `veth0` utilizada acima é uma interface virtual criada conforme o código abaixo.  
O pacotes enviados pela interface `veth0` são recebidos pela interface `veth1`.
```bash
ip link add veth0 type veth peer name veth1
ip link set veth0 up
ip link set veth1 up
```

### Ajuste de MTU

Caso receba o erro `Message too long`. É necessário aumentar o MTU.
```bash
FATA[0005] send: Message too long
```
Aumentando o MTU para Jumbo Frames.
```bash
ip link set dev veth0 mtu 9000
ip link set dev veth1 mtu 9000
# OU
# ifconfig <interface> mtu 9000
```
