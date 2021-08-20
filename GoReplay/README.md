# GoReplay
https://github.com/buger/goreplay  
GoReplay is an open-source network monitoring tool which can record your live traffic, and use it for shadowing, load testing, monitoring and detailed analysis.

### Replaying from pcap
Não respeitou os intervalos entre as requisições. Fez em rajada.
```
./gor --input-raw ./file.pcap:80 --input-raw-engine pcap_file --output-http http://<host>
```
  
### Extract requests from pcap to file
Cria arquivos \*.gor com as requisições.  
A versão 1.3.2 apresentou problemas. Utilizada a versão 1.2.0.
```
./gor1.2.0 -verbose 10 -input-raw testbed-14jun.pcap:80 -input-raw-engine pcap_file -output-file ./testbed-14jun.gor
```

### Replaying from multiple requests files (*.gor)

`--input-file` accepts file pattern, for example: `--input-file logs-2016-05-*`: it will replay all the files, sorting them in lexicographical order.

```
./gor1.2.0 --input-file "testbed-14jun_*" --output-http http://10.50.1.58
``` 

