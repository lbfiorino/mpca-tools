# addr2line tool

**addr2line** - convert addresses into file names and line numbers

```bash
apt install binutils
```

## Requisitos
Debug Symbol Packages  
https://wiki.ubuntu.com/Debug%20Symbol%20Packages

```bash
echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main restricted universe multiverse" | \
sudo tee /etc/apt/sources.list.d/ddebs.list

apt update
apt install ubuntu-dbgsym-keyring
```

## Instalar kernel debug symbols

```bash
apt-get install linux-image-$(uname -r)-dbgsym
```

Local do `vmlinux` para debug:
```bash
/usr/lib/debug/boot/vmlinux-$(uname -r)
```
