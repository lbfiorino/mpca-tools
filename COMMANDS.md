# Comandos

# Cria par de interfaces virtuais (se enviar por veth0, veth1 recebe)
ip link add veth0 type veth peer name veth1

# Extrai pacotes do PCAP no intervalo de tempo
editcap -F pcap -A "2018-12-01 13:29:00" -B "2018-12-01 13:34:00" <PCAP_INFILE> <PCAP_OUTFILE>

# Show frame number and frame size
tshark -T fields frame.number -e frame.len -r <PCAP_FILE>

# Exibe o tamanho do menor e do maior pacote dentro do PCAP (para definir o MTU)
tshark -T fields -e frame.len -r <PCAP_FILE> | awk 'BEGIN{min=1500; max=0}{if ($1<0+min) min=$1; else if($1>0+max) max=$1} END{print "Min packet: "min; print "Max packet: "max}'

# Tcpreplay preservando o timestamp e com cache em memória do PCAP
tcpreplay --intf1=veth0 --multiplier=1.000000 --preload-pcap <PCAP_FILE>

# Captura pacotes, mostra na tela (-P) e salva no arquivo (-w) no formato .pcap (-F pcap)
tshark -P -F pcap -i veth0 -w <PCAP_OUTFILE>
