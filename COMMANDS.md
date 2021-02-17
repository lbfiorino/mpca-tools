## Comandos

### Linux
#### Cria par de interfaces virtuais para testes (se enviar por veth0, veth1 recebe)
```bash
ip link add veth0 type veth peer name veth1
```

### Wireshark
#### Extrai pacotes do PCAP no intervalo de tempo
```bash
editcap -F pcap -A "2018-12-01 13:29:00" -B "2018-12-01 13:34:00" <PCAP_INFILE> <PCAP_OUTFILE>
```
#### Show frame number and frame size
```bash
tshark -T fields -e frame.number -e frame.len -r <PCAP_FILE>
```
####  Get Average packet rate from PCAP file
```bash
capinfos -x <PCAP_FILE> | grep 'Average packet rate' | awk '{print $4}' | tr -d ',.'
```
#### Exibe o tamanho do menor e do maior pacote dentro do PCAP (para definir o MTU)
```bash
tshark -T fields -e frame.len -r <PCAP_FILE> | awk 'BEGIN{min=1500; max=0}{if ($1<0+min) min=$1; else if($1>0+max) max=$1} END{print "Min packet: "min; print "Max packet: "max}'
```
#### Captura pacotes, mostra na tela (-P) e salva no arquivo (-w) no formato .pcap (-F pcap)
```bash
tshark -P -F pcap -i veth0 -w <PCAP_OUTFILE>
```
#### Ler um pacote específico do PCAP
```bash
# Parâmetro -V mostra detalhes do pacote na tela
tshark -r <pcap-file> -Y "frame.number==1" -V
```
#### Ler pacotes do PCAP com tamanhos específicos
```bash
# Frame length
tshark -r <pcap-file> -Y "frame.len>=1514"

# IP length
tshark -r <pcap-file> -Y "ip.len>=1500"
```

### Tcpreplay
#### Replay preservando o timestamp e com cache em memória do PCAP
Para melhor desempenho colocar o arquivo PCAP em um diretório TMPFS.  
Caso haja memória suficiente, fazer cache em memória do PCAP com o parâmetro `--preload-pcap`.  
As casas decimais no parâmetro `--multiplier` interferem no desempenho.
```bash
tcpreplay --intf1=veth0 --multiplier=1.000000 --preload-pcap <PCAP_FILE>
```

#### Fragmentar pacotes do PCAP (necesário tcpreplay com suporte a fragroute)
**Ex:** Fragmentar pacotes com IP Data 512 bytes.  

Criar arquivo `frag.cfg` com o seguinte conteúdo:
```
ip_frag 512
```
Utilizar a ferramenta `tcprewrite` para fragmentar.
```bash

```

### Pktgen-DPDK
```
##### A more typical commandline to start pktgen #####
# PARAMS
# -l 0-2 : Corelist - three lcores: core 0 monitoring, core 1 and 2 to send and receive packets
# -n 3 : Three memory channel
# --proc-type auto : Type of this process (primary|secondary|auto), auto = typical
# --socket-mem : Memory to allocate on CPU sockets (comma separated values)
# -v : Show dpdk version
# -- : Separate EAL parameters from Pktgen parameters
# -T : Color output
# -P : Promiscuous mode
# -s 0:<pcapfile> : PCAP packet stream file, 'P' is the port number
# -j : Enable jumbo frames of 9600 bytes
# -m "[1:2].0" : core 1 handles port 0 rx, core 2 handles port 0 tx

./pktgen -l 0-2 -n 3 --proc-type auto --socket-mem 2048 -v -- -T -P -s 0:/root/pcaps/smallFlows.pcap -j -m "[1:2].0"
```

### MoonGen
#### Replay PCAP - MonnGen com DPDK 17.08
```bash
./build/MoonGen ./examples/pcap/replay-pcap.lua -s 30 -r 1 0 <PCAP_FILE>
```
