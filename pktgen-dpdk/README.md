# Pktgen (Packet Gen-erator)

Instalação da ferramenta Pktgen e do framework DPDK nos sistemas operacionais `Ubuntu 20.04` e `Ubuntu 18.04`.

**DPDK:** [Site](http://core.dpdk.org/doc/), [Git](http://git.dpdk.org/)  
**Pktgen:** [Site](https://pktgen-dpdk.readthedocs.io/en/latest/index.html), [GitHub](https://github.com/pktgen/Pktgen-DPDK/)

**Linux Drivers:** https://doc.dpdk.org/guides/linux_gsg/linux_drivers.html  
**Bind NIC drivers**: https://dpdk-guide.gitlab.io/dpdk-guide/setup/binding.html  
**IOMMU:** https://dpdk-guide.gitlab.io/dpdk-guide/setup/iommu.html  

## Requisitos
 - Sistema operacional: Ubuntu 20.04, Ubuntu 18.04
 - Linux Headers
 - gcc 4.9+
 - cmake
 - pkg-config
 - libpcap-dev
 - meson 0.47.1+
 - ninja-build
 - libnuma-dev
 - python pyelftools
 - python sphinx

### Atualizar o SO.
```bash
apt update
apt full-upgrade
reboot
```
### Instalar requisitos no Ubuntu 20.04
```bash
apt install build-essential cmake pkg-config libpcap-dev meson ninja-build libnuma-dev linux-headers-`uname -r`
apt install python3-pip
python3 -m pip install pyelftools sphinx
```

### Instalar requisitos no Ubuntu 18.04
No Ubuntu 18.04 o meson precisa ser instalado via Python Pip, pois a versão do repositório do Ubuntu é mais antiga.  
Caso o meson esteja instalado via apt, remover e reiniciar antes de instalar via Python Pip.
```bash
apt purge meson
reboot
```
Após reiniciar:
```bash
apt install python3-pip
python3 -m pip install meson --upgrade
python3 -m pip install pyelftools sphinx
apt install build-essential cmake pkg-config libpcap-dev ninja-build libnuma-dev linux-headers-`uname -r`
```

## Huge pages config 
[Documentação](https://doc.dpdk.org/guides/linux_gsg/sys_reqs.html#use-of-hugepages-in-the-linux-environment)

No arquivo `/etc/default/grub`, adicionar os parâmetros de hugepages no `GRUB_CMDLINE_LINUX` conforme abaixo.

```
GRUB_CMDLINE_LINUX="default_hugepagesz=1G hugepagesz=1G hugepages=4"
```
Atualizar o GRUB e reiniciar.
```bash
update-grub
reboot
```

## Install DPDK
**Versão:** 19.11 (Última versão no momento: 19.11.6)  
[DPDK Download](http://core.dpdk.org/download/)  

:warning: Nota:
> Versão 20.11 não gerou o RTE_TARGET: `make install T=x86_64-native-linux-gcc -j`

```bash
cd /root/
wget http://fast.dpdk.org/rel/dpdk-19.11.6.tar.xz
tar xvf dpdk-19.11.6.tar.xz

rm -fr /usr/local/lib/x86_64-linux-gnu # DPDK changed a number of lib names and need to clean up

cd dpdk-stable-19.11.6
meson build
cd build
ninja
ninja install
ldconfig  # make sure ld.so is pointing new DPDK libraries
```

### Criar RTE_TARGET
```bash
cd /root/dpdk-stable-19.11.6
make install T=x86_64-native-linux-gcc -j
```

### Exportar PKG_CONFIG_PATH
```bash
export PKG_CONFIG_PATH=/usr/local/lib/x86_64-linux-gnu/pkgconfig
```

## Install Pktgen

### Exportar variáveis RTE_SDK e RTE_TARGET
```bash
# RTE_SDK=<DPDKinstallDir>
# RTE_TARGET=x86_64-native-linux-gcc
export RTE_SDK=/root/dpdk-stable-19.11.6
export RTE_TARGET=x86_64-native-linux-gcc
```

Para persistir as variáveis, adicionar as linhas abaixo no arquivo `/etc/environment`:
```bash
RTE_SDK=/root/dpdk-stable-19.11.6
RTE_TARGET=x86_64-native-linux-gcc
```

### Build Pktgen:
```bash
git clone http://dpdk.org/git/apps/pktgen-dpdk

cd pktgen-dpdk
make -j
```

## DPDK Dev Bind

Em máquinas virtuais (driver `virtio`), utilizar o driver `vfio-pci` sem IOMMU para o bind da placa de rede.
```bash
# Se o módulo já estiver carregado (built-in module):
echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode

# Para carregar o módulo:
modprobe vfio enable_unsafe_noiommu_mode=1
```

### Persistir módulo no Ubuntu 20.04 (Kernel 5.4.0) com `buil-in module`:
Adicionar o parâmetro `vfio.enable_unsafe_noiommu_mode=1` no `GRUB_CMDLINE_LINUX` dentro do arquivo `/etc/default/grub`.
```bash
GRUB_CMDLINE_LINUX="default_hugepagesz=1G hugepagesz=1G hugepages=4 vfio.enable_unsafe_noiommu_mode=1"
```
Atualizar o GRUB e reiniciar.
```bash
update-grub
reboot
```

### Persistir módulo no Ubuntu 18.04 (Kernel 4.15):
Editar o arquivo `/etc/modules` e adicionar o módulo `vfio`.
```bash
echo vfio >> /etc/modules
```
Criar o arquivo `/etc/modprobe.d/vfio-noiommu.conf` com o parâmetro `enable_unsafe_noiommu_mode` e reiniciar.
```bash
echo "options vfio enable_unsafe_noiommu_mode=1" > /etc/modprobe.d/vfio-noiommu.conf
reboot
```

### DPDK Bind NIC:
```bash
# Listar as portas 
dpdk-devbind.py --status

# Bind Port
# Porta diferente da LAN para não perder conexão
dpdk-devbind.py -b vfio-pci 0000:00:07.0
```

## Replay PCAP

Iniciar o Pktgen:
```bash
# PARAMS
# -l 0-1 : Corelist - two lcores: core 0 monitoring, core 1 send packets
# -n 1 : One memory channel
# -T : Color output
# -P : Promiscuous mode
# -s 0:<pcapfile> : PCAP packet stream file, 'P' is the port number
# -j : Enable jumbo frames of 9600 bytes
pktgen-dpdk -l 0-1 -n 1 -- -m 1.0 -T -P -s 0:/root/pcaps/smallFlows.pcap -j
```
No console do Pktgen:
```bash
# Mostra informações do PCAP
pcap show

# Define o número de pacotes a enviar, neste caso o número de pacotes do arquivo PCAP.
set 0 count <pcap_total_packets>

# Start send packets
start 0
```
Se não for definido o número de pacotes `set <port_number> count <num_packets>`, o Pktgen fica em loop até a execução do comando `stop <port_number>`.
