# DPDK burst replay tool
```diff
- EM CONSTRUÇÃO
```
Instalação da ferramenta pdk-burst-replay e do framework DPDK.

**pdk-burst-replay:** [GitHub](https://github.com/FraudBuster/dpdk-burst-replay), [Documentation](https://doc.dpdk.org/burst-replay/index.html)  
**DPDK:** [Site](http://core.dpdk.org/doc/), [Git](http://git.dpdk.org/) 

A instalação foi realizada com o usuário `root`.

## Requisitos na Documentação
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
**DPDK Version:** 18.11.11  
[Installing custom DPDK version](https://doc.dpdk.org/burst-replay/user-guide.html#installing-custom-dpdk-version)  

