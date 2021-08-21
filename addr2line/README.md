# addr2line tool

**addr2line** - convert addresses into file names and line numbers  
https://news.ycombinator.com/item?id=23238104  
https://serverfault.com/questions/605946/kernel-stack-trace-to-source-code-lines

O código precisa ser compilado com suporte a `debug`.

```bash
apt install binutils
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
Verificar a linha de código no endereço `0xffffffff811a8c50` do executável.
```bash
$ addr2line -e /tmp/vmlinux ffffffff811a8c50
/tmp/linux-3.15-rc8/fs/select.c:209
```
