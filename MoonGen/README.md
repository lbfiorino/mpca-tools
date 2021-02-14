# MoonGen
```diff
- EM CONSTRUÇÃO

TODO
- Verificar MTU
```
[GitHub Link](https://github.com/emmericp/MoonGen)  
[Paper](https://www.net.in.tum.de/fileadmin/bibtex/publications/papers/MoonGen_IMC2015.pdf)

## Requisitos
- DPDK ([Link Instalação versão 19.11](https://github.com/lbfiorino/pcap-replay-tools/tree/main/pktgen-dpdk#instalar-dpdk))
- gcc >= 4.8
- make
- cmake
- libnuma-dev
- kernel headers (for the DPDK igb-uio driver)
- lspci (for dpdk-devbind.py)
```bash
apt-get install -y build-essential cmake linux-headers-`uname -r` pciutils libnuma-dev
```

## Instalação MoonGen
```bash
cd /root
git clone https://github.com/emmericp/MoonGen
cd MoonGen
./build.sh
```

## DPDK Dev Bind
:warning: Nota:
> O MoonGen já inclui a versão 19.08 do DPDK, porém o `dpdk-devbind.py` incluso não reconhece o driver `vfio-pci`, necessário para máquinas virtuais.
> Fazer o Bind com o DPDK 19.11.

```bash
# Listar as portas 
dpdk-devbind.py --status

# Bind Port
# Porta diferente da LAN para não perder conexão
dpdk-devbind.py -b vfio-pci 0000:00:07.0
```

## Replay PCAP
O MoonGen tem um código de exemplo para replay de pcap: [`examples/pcap/replay-pcap.lua`](https://github.com/emmericp/MoonGen/blob/master/examples/pcap/replay-pcap.lua).
```bash
cd /root/MoonGen

# ./build/MoonGen ./examples/pcap/replay-pcap.lua -s 30 -r 1 <PORT_NUMBER> <PCAP_FILE
# PARAMS
# -s 30 : Time to wait before stopping MoonGen after enqueuing all packets. Increase for pcaps with a very low rate. Default = 10 seconds. 
# -r 1 : Speed up or slow down replay, 1 = use intervals from file, default = replay as fast as possible. Default = 0.
./build/MoonGen ./examples/pcap/replay-pcap.lua -s 30 -r 1 0 /root/pcaps/smallFlows.pcap
```
