# MoonGen

[MoonGen GitHub](https://github.com/emmericp/MoonGen)  
**Paper (IMC 2015)** [MoonGen: A Scriptable High-Speed Packet Generator](https://dl.acm.org/doi/abs/10.1145/2815675.2815692)

Guia pra placas Broadcom (driver BNXT): https://doc.dpdk.org/guides/nics/bnxt.html

## MTU Issues
https://github.com/emmericp/MoonGen/issues/165  
https://github.com/emmericp/MoonGen/issues/235 


### Patch
```diff
--- device.c 2017-03-29 14:27:18.657159902 -0300
+++ device.c 2017-03-22 14:49:13.263529000 -0300
@@ -118,8 +118,9 @@
.header_split = 0,
.hw_ip_checksum = !cfg->disable_offloads,
.hw_vlan_filter = 0,
- .jumbo_frame = 0,
+ .jumbo_frame = 1,
.hw_strip_crc = 1,
+ .max_rx_pkt_len= 9218,
.hw_vlan_strip = cfg->strip_vlan ? 1 : 0,
},
.txmode = {
```
:warning:
> Patch no arquivo device.c da branch master (dpdk 17.08) para habilitar jumbo frame e testar **não funcionou**.

## Requisitos
### Ubuntu 20.04
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
### Centos 8
```bash
 dnf upgrade libarchive 
 dnf group install -y "Development Tools"
 dnf install git elfutils-libelf-devel make cmake numactl-devel kernel-devel
```

## Instalação MoonGen - Ubuntu 20.04
:warning: Nota:
> Utilizada a branch master com dpdk 17.08 incluso.
```bash
cd /root
git clone https://github.com/emmericp/MoonGen
cd MoonGen
./build.sh
```
Criar link simbólico para a lib `libtbbmalloc.so.2` dentro do diretório `/usr/bin`. O MoonGen não encontrou automaticamente.
```bash
cd /usr/lib
ln -s /root/MoonGen/build/libmoon/tbb_cmake_build/tbb_cmake_build_subdir_release/libtbbmalloc.so.2 libtbbmalloc.so.2
```
Para verificar se encontrou todas as libs:
```bash
ldd /root/MoonGen/build/MoonGen
```

## DPDK Dev Bind

> :warning:  
Requires sudo.  
`insmod: ERROR: could not insert module ./x86_64-native-linuxapp-gcc/kmod/igb_uio.ko: Operation not permitted`

:warning: Notas:
> - O MoonGen inclui a versão 17.08 do DPDK na branch master do GitHub, porém o `dpdk-devbind.py` incluso não reconhece o driver `vfio-pci`, o qual é necessário para máquinas virtuais com driver `virtio`. Neste caso, fazer o Bind utilizando o `dpdk-devbind.py` do DPDK 19.11.
> - O `dpdk-devbind.py` incluso na branch `dkdk-19.05` do MoonGen reconheceu o driver `vfio-pci`.

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
