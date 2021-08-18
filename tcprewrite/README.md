# TCPReplay/TCPRewrite/TCPPrep/TCPDump Cheatsheet
Source:https://gist.github.com/niranjan-nagaraju/4532037  
Author: Niranjan Nagaraju

# tcprewrite
### Rewrite IP/Mac addresses, -C optionally to fix checksums
1. tcpprep, first:C2S, Second S2C, Generate cache file
``bash
tcpprep --auto=first --pcap=icmp.pcap --cachefile=icmp_in.cache
```
2. Rewrite end points to 172.16.0.1/172.16.0.2 [ping 2->1, reply, 1->2]
```bash
tcprewrite --endpoints=172.16.0.1:172.16.0.2 -i out.pcap -o out2.pcap --cachefile=icmp_in.cache
```
3. Rewrite macs too [ping (172.16.0.2)00:01:02:03:04:05 -> (172.16.0.1)06:07:08:09:10:11, reply: vice-versa]
```bash
tcprewrite --endpoints=172.16.0.1:172.16.0.2 --enet-smac=00:01:02:03:04:05,06:07:08:09:10:11 --enet-dmac=06:07:08:09:10:11,00:01:02:03:04:05 -i icmp.pcap -o out2_macs.pcap --cachefile=icmp_in.cache
```
### Rewrite Dest and Src IPs
```bash
tcprewrite --dstipmap=0.0.0.0/0:172.16.0.2 --srcipmap=0.0.0.0/0:172.16.0.1 --infile=out.pcap --outfile=out2.pcap 
```
### Rewrite Dest and source macs
```bash
tcprewrite --enet-dmac=00:01:02:03:04:05 --enet-smac=06:07:08:09:10:11 --infile=icmp_ping_noerrors.pcap --outfile=out.pcap
```

# tcpdump
### Print a pcap
```
tcpdump -r file.pcap
```
### Listen to an interface (-e display ethernet, -nn dont resolve hosts, -i interface, -vvv:verbose, -w write to a file)
``
tcpdump -e -nn -vvv -i eth0 -w outfile.pcap
```
