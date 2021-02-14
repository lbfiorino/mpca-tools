# MoonGen
```diff
- EM CONSTRUÇÃO
```

## Requisitos
- DPDK ([Link Instalação versão 19.11](https://github.com/lbfiorino/pcap-replay-tools/tree/main/pktgen-dpdk))
- gcc >= 4.8
- make
- cmake
- libnuma-dev
- kernel headers (for the DPDK igb-uio driver)
- lspci (for dpdk-devbind.py)
```bash
apt-get install -y build-essential cmake linux-headers-`uname -r` pciutils libnuma-dev
```

## Instalação
```bash
cd /root
git clone https://github.com/emmericp/MoonGen
cd MoonGen
./build.sh
./bind-interfaces.sh
./setup-hugetlbfs.sh
```
