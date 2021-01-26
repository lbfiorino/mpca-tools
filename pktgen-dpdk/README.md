# Pktgen (Packet Gen-erator)
Instalação da ferramenta Pktgen e do framework DPDK.

**DPDK:** [Site](http://core.dpdk.org/doc/), [Git](http://git.dpdk.org/)  
**Pktgen:** [Site](https://pktgen-dpdk.readthedocs.io/en/latest/index.html), [GitHub](https://github.com/pktgen/Pktgen-DPDK/)

## Requisitos Ubuntu 20.04
 - gcc 4.9+
 - meson
 - ninja-build
 - libnuma-dev

```bash
apt install build-essential
apt install meson ninja-build libnuma-dev
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

## Install Pktgen
