# Pktgen (Packet Gen-erator)
Instalação da ferramenta Pktgen e do framework DPDK.

**DPDK:** [Site](http://core.dpdk.org/doc/), [Git](http://git.dpdk.org/)  
**Pktgen:** [Site](https://pktgen-dpdk.readthedocs.io/en/latest/index.html), [GitHub](https://github.com/pktgen/Pktgen-DPDK/)

## Requisitos Ubuntu 20.04
 - Sistema operacional atualizado
 - gcc 4.9+
 - cmake
 - pkg-config
 - libpcap-dev
 - meson
 - ninja-build
 - libnuma-dev
 - python pyelftools

```bash
apt update
apt full-upgrade
reboot
```
```bash
apt install build-essential cmake pkg-config libpcap-dev meson ninja-build libnuma-dev
apt install python3-pip
python3 -m pip install pyelftools
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

```bash
git clone https://dpdk.org/git/dpdk
sudo rm -fr /usr/local/lib/x86_64-linux-gnu # DPDK changed a number of lib names and need to clean up
cd dpdk
meson build
ninja -C build
sudo ninja -C build install
sudo ldconfig  # make sure ld.so is pointing new DPDK libraries
```

On Ubuntu 20.04
```bash
export PKG_CONFIG_PATH=/usr/local/lib/x86_64-linux-gnu/pkgconfig
```

## Install Pktgen

```bash
git clone http://dpdk.org/git/apps/pktgen-dpdk

cd pktgen-dpdk
make
```

## DPDK Bind NIC Drivers
[Doc DPDK](http://dpdk-guide.gitlab.io/dpdk-guide/setup/binding.html)  
[Doc IOMMU](http://dpdk-guide.gitlab.io/dpdk-guide/setup/iommu.html)

Para habilitar o IOMMU (input-output memory management unit), deve-se habilitar o recurso `VT-d/Virtualization Technology for Directed I/O` do processador na BIOS.
Em seguida, `no arquivo /etc/default/grub`, adicionar o parâmetro `intel_iommu=on` (processador Intel) OU `amd_iommu=on` (processador AMD) no GRUB_CMDLINE_LINUX.


```bash
GRUB_CMDLINE_LINUX="default_hugepagesz=1G hugepagesz=1G hugepages=4 intel_iommu=on"
```


