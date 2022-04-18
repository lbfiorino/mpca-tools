# GoReplay
https://github.com/buger/goreplay  
https://github.com/buger/goreplay/blob/master/docs/Saving-and-Replaying-from-file.md  

GoReplay is an open-source network monitoring tool which can record your live traffic, and use it for shadowing, load testing, monitoring and detailed analysis.

### GoReplay do not exit when -input-file is used
#### Workaround
```bash
#!/bin/bash

INPUTFILE="input.gor"
LOGFILE="/tmp/gor.log"
MATCH="FileInput: end of file"

gor --input-file "$filename" --output-http="http://www.test.com" 2>&1 | tee $LOGFILE &
while sleep 5
do
    if fgrep --quiet "$MATCH" "$LOGFILE"
    then
        exit 0
    fi
done
```

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

Há opções para gerar um único arquivo. Porém apresentou problemas.  
`-output-file-queue-limit 0` Não limita o tamanho da fila no arquivo, gerando um único arquivo.
```

  -output-file value
        Write incoming requests to file:
                gor --input-raw :80 --output-file ./requests.gor
  -output-file-append
        The flushed chunk is appended to existence file or not.
  -output-file-buffer string
        The path for temporary storing current buffer:
                gor --input-raw :80 --output-file s3://mybucket/logs/%Y-%m-%d.gz --output-file-buffer /mnt/logs (default "/tmp")
  -output-file-flush-interval duration
        Interval for forcing buffer flush to the file, default: 1s. (default 1s)
  -output-file-max-size-limit value
        Max size of output file, Default: 1TB
  -output-file-queue-limit int
        The length of the chunk queue. Default: 256 (default 256)
  -output-file-size-limit value
        Size of each chunk. Default: 32mb

```

### Replaying from multiple requests files (*.gor)

`--input-file` accepts file pattern, for example: `--input-file logs-2016-05-*`: it will replay all the files, sorting them in lexicographical order.

```
./gor1.2.0 --input-file "testbed-14jun_*" --output-http http://10.50.1.58
``` 

