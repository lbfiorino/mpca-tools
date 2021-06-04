## Documentação da instalação das seguintes ferramentas:

- **[`/tcpreplay-netmap`](tcpreplay-netmap)** - Tcpreplay + netmap (com opção de fragroute)  
https://tcpreplay.appneta.com/  
http://info.iet.unipi.it/~luigi/netmap/  

- **[`/fragroute`](fragroute)** - Utilizado pelo Tcpreplay para fragmentar pacotes  
https://www.monkey.org/~dugsong/fragroute/

- **[`/gophercap`](gophercap)** - GopherCap  
https://www.stamus-networks.com/blog/gophercap  
https://github.com/StamusNetworks/gophercap

- **[`/pktgen-dpdk`](pktgen-dpdk)** - Pktgen-DPDK  
https://github.com/pktgen/Pktgen-DPDK  
http://core.dpdk.org/  

- **[`/MoonGen`](MoonGen)** - MoonGen (DPDK)  
https://github.com/emmericp/MoonGen/

- **[`/dpdk-burst-replay`](dpdk-burst-replay)** - dpdk-burst-replay  
https://github.com/FraudBuster/dpdk-burst-replay  
http://core.dpdk.org/  

**Arquivo** [`COMMANDS.md`](COMMANDS.md)  
Arquivo contendo comandos para utilização das ferramentas.

**Arquivo** [`requirements.txt`](requirements.txt)  
Arquivo contendo pacotes python.

```bash
# Install and Upgrade all packages in requirements.txt to the newest available version. 
python3 -m pip install -r requirements.txt --upgrade
```

**Tcpdump PCAP Timestamps**  
Packet time stamps in libpcap  
http://www.tcpdump.org/manpages/pcap-tstamp.7.html
```
PCAP_TSTAMP_HOST - host
    Time stamp provided by the host on which the capture is being done. The precision of this time stamp is unspecified; it might or might not be synchronized with the host operating system's clock. 
PCAP_TSTAMP_HOST_LOWPREC - host_lowprec
    Time stamp provided by the host on which the capture is being done. This is a low-precision time stamp, synchronized with the host operating system's clock. 
PCAP_TSTAMP_HOST_HIPREC - host_hiprec
    Time stamp provided by the host on which the capture is being done. This is a high-precision time stamp, synchronized with the host operating system's clock. It might be more expensive to fetch than PCAP_TSTAMP_HOST_LOWPREC. 
PCAP_TSTAMP_HOST_HIPREC_UNSYNCED - host_hiprec_unsynced
    Time stamp provided by the host on which the capture is being done. This is a high-precision time stamp, not synchronized with the host operating system's clock. It might be more expensive to fetch than PCAP_TSTAMP_HOST_LOWPREC. 
PCAP_TSTAMP_ADAPTER - adapter
    Time stamp provided by the network adapter on which the capture is being done. This is a high-precision time stamp, synchronized with the host operating system's clock. 
PCAP_TSTAMP_ADAPTER_UNSYNCED - adapter_unsynced
    Time stamp provided by the network adapter on which the capture is being done. This is a high-precision time stamp; it is not synchronized with the host operating system's clock. 

```
