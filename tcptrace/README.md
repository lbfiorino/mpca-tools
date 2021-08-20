# tcptrace

Tcptrace is a tool for analysis of TCP dump files.  
http://tcptrace.org/

### Install

```
apt install tcptrace
```

### Extract HTTP requests from pcap
```
# PARMS
#    -l   long output format
#    -e   extract contents of each TCP stream into file

mkdir tcprequests
tcptrace --output_dir="tcprequests/" -l -e file.pcap 
```

```
$ ls tcprequests/
a2b_contents.dat  c2d_contents.dat  e2f_contents.dat  g2h_contents.dat  i2j_contents.dat  k2l_contents.dat
```

```
$ cat tcprequests/a2b_contents.dat
GET /DVWA HTTP/1.1
Accept: application/x-ms-application, image/jpeg, application/xaml+xml, image/gif, image/pjpeg, application/x-ms-xbap, */*
Accept-Language: en-US
User-Agent: Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.1; WOW64; Trident/7.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; Media Center PC 6.0; .NET4.0C; .NET4.0E; GWX:MANAGED)
Accept-Encoding: gzip, deflate
Host: dt-extern-ddos
Connection: Keep-Alive
```


### Resending captured requests to HTTP server using Netcat

```
cat tcprequests/a2b_contents.dat | nc <HTTP_SERVER> 80
```

