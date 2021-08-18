# gdb - The GNU Debugger

Kernel stack trace to source code lines.  
With gdb, you can also use this command to find the line number quickly:  
Source: https://serverfault.com/questions/605946/kernel-stack-trace-to-source-code-lines  
`(gdb) list *(some_function+0x12c)` 

# Instalar gdb
```bash
apt install gdb
```

## Requisitos
### APT Debug Symbol Packages  
https://wiki.ubuntu.com/Debug%20Symbol%20Packages  
https://newbedev.com/where-is-vmlinux-on-my-ubuntu-installation

```bash
echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main restricted universe multiverse" | \
sudo tee /etc/apt/sources.list.d/ddebs.list

apt update
apt install ubuntu-dbgsym-keyring
```

### Instalar kernel debug symbols

```bash
apt-get install linux-image-$(uname -r)-dbgsym
```

Local do `vmlinux` para debug:
```bash
/usr/lib/debug/boot/vmlinux-$(uname -r)
```

## Utilização

Exemplo: dropwatch mostrando pacote sendo descartado em **drops at tcp_v4_rcv+4b (0xffffffff9358db8b)**

**tcp_v4_rcv+4b**: This is a standard notation. tcp_v4_rcv+48 means, within the binary kernel image, 0x48 bytes after the start of the tcp_v4_rcv function.  
You can use the addr2line tool to find the source code line. https://serverfault.com/questions/605946

Descobrindo arquivo e linha de código onde está ocorrendo o descarte:
```bash
$ gdb /usr/lib/debug/boot/vmlinux-$(uname -r)
(gdb) list *(tcp_v4_rcv+0x4b)
0xffffffff8198db8b is in tcp_v4_rcv (/build/linux-DGxSqz/linux-5.4.0/net/ipv4/tcp_ipv4.c:1989).
1984    /build/linux-DGxSqz/linux-5.4.0/net/ipv4/tcp_ipv4.c: No such file or directory.
(gdb)
```