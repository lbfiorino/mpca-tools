# Pktgen (Packet Gen-erator)

Instalação da ferramenta Pktgen e do framework DPDK.

**DPDK:** [Site](http://core.dpdk.org/doc/), [Git](http://git.dpdk.org/)  
**Pktgen:** [Site](https://pktgen-dpdk.readthedocs.io/en/latest/index.html), [GitHub](https://github.com/pktgen/Pktgen-DPDK/)

**Linux Drivers:**  
https://doc.dpdk.org/guides/linux_gsg/linux_drivers.html  
https://dpdk-guide.gitlab.io/dpdk-guide/setup/binding.html

**IOMMU:** https://dpdk-guide.gitlab.io/dpdk-guide/setup/iommu.html

## Requisitos Ubuntu 20.04
 - Sistema operacional atualizado
 - Linux Headers
 - gcc 4.9+
 - cmake
 - pkg-config
 - libpcap-dev
 - meson
 - ninja-build
 - libnuma-dev
 - python pyelftools
 - python sphinx

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

## Huge pages config 
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

## Install DPDK
**Versão:** 19.11 (Última versão no momento: 19.11.6)  
[DPDK Download](http://core.dpdk.org/download/)  

:warning: Nota:
> Versão 20.11 não gerou o RTE_TARGET: `make install T=x86_64-native-linux-gcc`

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

Criar RTE_TARGET:
```bash
cd /root/dpdk-stable-19.11.6
make install T=x86_64-native-linux-gcc
```

No Ubuntu 20.04, exportart `PKG_CONFIG_PATH`:
```bash
export PKG_CONFIG_PATH=/usr/local/lib/x86_64-linux-gnu/pkgconfig
```

## Install Pktgen

Exportar variáveis RTE_SDK e RTE_TARGET:
```bash
# RTE_SDK=<DPDKinstallDir>
# RTE_TARGET=x86_64-native-linux-gcc
export RTE_SDK=/root/dpdk-stable-19.11.6
export RTE_TARGET=x86_64-native-linux-gcc
```

Build Pktgen:
```bash
git clone http://dpdk.org/git/apps/pktgen-dpdk

cd pktgen-dpdk
make
```

## DPDK Dev Bind

Em máquinas virtuais utilizar o driver `vfio-pci` sem IOMMU.
```bash
modprobe vfio enable_unsafe_noiommu_mode=1
echo 1 > /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
```

Bind Nic:
```bash
# Listar as portas 
dpdk-devbind.py --status

# Bind Port
# Porta diferente da LAN para não perder conexão
dpdk-devbind.py -b vfio-pci 0000:00:07.0
```
