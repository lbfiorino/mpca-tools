## Comandos

### Cria par de interfaces virtuais para testes (se enviar por veth0, veth1 recebe)
```bash
ip link add veth0 type veth peer name veth1
```

### Extrai pacotes do PCAP no intervalo de tempo
```bash
editcap -F pcap -A "2018-12-01 13:29:00" -B "2018-12-01 13:34:00" <PCAP_INFILE> <PCAP_OUTFILE>
```

### Show frame number and frame size
```bash
tshark -T fields frame.number -e frame.len -r <PCAP_FILE>
```

###  Get Average packet rate from PCAP file
```bash
capinfos -x <PCAP_FILE> | grep 'Average packet rate' | awk '{print $4}' | tr -d ',.'
```

### Exibe o tamanho do menor e do maior pacote dentro do PCAP (para definir o MTU)
```bash
tshark -T fields -e frame.len -r <PCAP_FILE> | awk 'BEGIN{min=1500; max=0}{if ($1<0+min) min=$1; else if($1>0+max) max=$1} END{print "Min packet: "min; print "Max packet: "max}'
```

### Tcpreplay preservando o timestamp e com cache em memória do PCAP
Para melhor desempenho colocar o arquivo PCAP em um diretório TMPFS.  
Caso haja memória suficiente, fazer cache em memória do PCAP com o parâmetro `--preload-pcap`.  
As casas decimais no parâmetro `--multiplier` interferem no desempenho.
```bash
tcpreplay --intf1=veth0 --multiplier=1.000000 --preload-pcap <PCAP_FILE>
```

### Captura pacotes, mostra na tela (-P) e salva no arquivo (-w) no formato .pcap (-F pcap)
```bash
tshark -P -F pcap -i veth0 -w <PCAP_OUTFILE>
```
