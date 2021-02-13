# DPDK burst replay tool
```diff
- Erro ao tentar rodar a aplicação:

dpdk-replay pcaps/smallFlows.pcap 00:04.0

Erro:
DPDK: RTE ETH Ethernet device configuration failed

- Testar em versões anteriores do Ubuntu (18.04, 16.04)
```

Instalação da ferramenta pdk-burst-replay e do framework DPDK.

**pdk-burst-replay:** [GitHub](https://github.com/FraudBuster/dpdk-burst-replay), [Documentação](https://doc.dpdk.org/burst-replay/index.html)  
**DPDK:** [Site](http://core.dpdk.org/doc/), [Git](http://git.dpdk.org/) 

A instalação foi realizada com o usuário `root`.

## Requisitos na Documentação dpdk-burst-replay
- Tested with DPDK versions: 16.11.9/17.11.5/18.11.1
- dpdk-dev
- libnuma-dev (Debian-based)

## Principais [Limitações](https://github.com/FraudBuster/dpdk-burst-replay#todo)  
`TODO` na documentação:  
- Option to configure maximum bitrate.
- Option to send the pcap with the good pcap timers.

Código no arquivo [`main.c`](https://github.com/FraudBuster/dpdk-burst-replay/blob/master/src/main.c) 
```c
/* TODO: */
/* "[--maxbitrate bitrate]|[--normalspeed] : bitrate not to be exceeded (default: no limit) in ko/s.\n" */
/* "  specify --normalspeed to replay the trace with the good timings." */
```
## Instalação no Ubuntu 20.04

### Huge pages config 
[Documentação](https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#use-of-hugepages-in-the-linux-environment)

No arquivo `/etc/default/grub`, adicionar os parâmetros de hugepages no GRUB_CMDLINE_LINUX conforme abaixo.

```
GRUB_CMDLINE_LINUX="default_hugepagesz=1G hugepagesz=1G hugepages=4"
```
Atualizar o GRUB e reiniciar.
```bash
update-grub
reboot
```

### Install DPDK
**DPDK Version:** 18.11.11 [Guide for Linux](https://fast.dpdk.org/doc/pdf-guides-18.11/linux_gsg-18.11.pdf)  
[Installing custom DPDK version](https://doc.dpdk.org/burst-replay/user-guide.html#installing-custom-dpdk-version)  

:warning: Nota:
> Versão 18.11.1 não compilou. Erro na compilação do driber igb.

Atualizar o SO.
```bash
apt update
apt full-upgrade
reboot
```
Instalar requisitos.
```bash
apt install build-essential cmake pkg-config libpcap-dev meson ninja-build libnuma-dev linux-headers-`uname -r`
apt install python3-pip
python3 -m pip install pyelftools sphinx
```

Instalar DPDK.
```bash
cd /root
wget http://fast.dpdk.org/rel/dpdk-18.11.11.tar.xz
tar xvf http://fast.dpdk.org/rel/dpdk-18.11.11.tar.xz

cd dpdk-stable-18.11.11
make install T=x86_64-native-linuxapp-gcc
cd x86_64-native-linuxapp-gcc
make install
 ```

Criar link simbólico `python` para `python3.8`.
```bash
cd /bin
ln -s python3.8 python
```

### Install dpdk-burst-replay

```
wget https://git.dpdk.org/apps/dpdk-burst-replay/snapshot/dpdk-burst-replay-1.1.1.tar.xz
tar xvf dpdk-burst-replay-1.1.1.tar.xz

cd dpdk-burst-replay-1.1.1
RTE_SDK=/root/dpdk-stable-18.11.11/ make -f DPDK_Makefile && sudo cp build/dpdk-replay /usr/bin
```

### DPDK Dev Bind

Em máquinas virtuais utilizar o driver `vfio-pci` sem IOMMU.
```bash
modprobe vfio enable_unsafe_noiommu_mode=1
echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
```
Bind Nic:
```bash
#Listar as portas 
dpdk-devbind.py --status

# Bind Port
# Porta diferente da LAN para não perder conexão
dpdk-devbind.py -b vfio-pci 0000:00:07.0
```
