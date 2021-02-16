# Tcpreplay+netmap
Instalação da ferramenta Tcpreplay com o framework netmap para replicar arquivos pcap. Há a opção de fragmentar os pacotes com a ferramenta [fragroute](https://github.com/lbfiorino/pcap-replay-tools/tree/main/fragroute).

**Tcpreplay:** [Site](https://tcpreplay.appneta.com/), [GitHub](https://github.com/appneta/tcpreplay)  
**netmap:** [Site](http://info.iet.unipi.it/~luigi/netmap/), [GitHub](https://github.com/luigirizzo/netmap)

[Tcpreplay FAQ](https://tcpreplay.appneta.com/wiki/faq.html)  
[How can I make tcpreplay run even faster?](https://tcpreplay.appneta.com/wiki/faq.html#how-can-i-make-tcpreplay-run-even-faster)

:warning: Tcpreplay FAQ:
> - Since tcpreplay is not multi-threaded, SMP or dual-core processors won’t help very much. However, other processes can run on the other CPU(s).
> - Turn off hyperthreading (HT) if your CPU supports it.

**Fragroute (option --fragroute=conf.cfg):** Permite fragmentar os pacotes. Precisa ser instalado antes do Tcpreplay. [[Link da instalação](https://github.com/lbfiorino/pcap-replay-tools/tree/main/fragroute), [Como utilizar](tcpreplay_fragroute.pdf), [Issue GitHub](https://github.com/appneta/tcpreplay/issues/180)].  
:warning: Nota:
> O fragroute foi instalado inicialmente no Debian 10.  
> O pacote fragroute foi adaptado para o Ubuntu 20.04.

## Requisitos

- Kernel headers (normalmente instalado por padrão)
    - Debian-based: `apt install linux-headers-<kernel-version>`  
    - CentOS 7: `yum install kernel-devel`

- Kernel sources (necessário para os drivers e1000 e r8169.c)
    - Debian-based: `apt source linux-source-<kernel-version>`  
    - CentOS 7: [HowTo get kernel sources CentOS](https://wiki.centos.org/HowTos/I_need_the_Kernel_Source)

- libpcap-dev: 
    - Debian-based: `apt install libpcap-dev`  
    - CentOS 7:  `yum install libpcap-devel`

- Developmento tools:  
    - Debian-based: `apt install build-essential`  
    - CentOS 7: `yum group install "Development Tools"`

- Autogen:
    - - Debian-based: `apt install autogen`  

- Git
    - Debian-based: `apt install git`  
    - CentOS 7: `yum install git`

## Sistemas Operacionais Testados:
- Ubuntu 16.04.7 Desktop
- Ubuntu 18.04.5 Desktop
- Ubuntu 20.04.1 Desktop
- Debian 10.7
- CentOS 7.9.2009
- FreeBSD 12.2

:warning: Notas: 
> - O FreeBSD já inclui o netmap e o tcpreplay no seu repositório, bastando apenas instalar via `pkg`.
>   ```bash
>   pkg update
>   pgk install tcpreplay
>   ```
> - O Ubuntu tem o pacote tcpreplay no repositório, mas sem suporte ao netmap.

A instalação se difere apenas no processo de instalação do Kernel Sources em cada distribuição, e do parâmetro `--kernel-sources`do tcpreplay para informar o diretório do Kernel Sources.

## Instalação no Ubuntu 20.04.1


A instalação foi realizada em uma máquina virutal no VirtualBox com emulação da placa de rede Intel PRO/1000 (`driver e1000`)

### 1. Habilitar os repositórios dos fontes `deb-src`
Editar o arquivo no arquivo `/etc/apt/sources.list` e descomentar as linhas iniciadas em `deb-src` para cada repositório habilitado.

Atualizar a lista de pacotes dos repostitórios como comando `apt update`

### 2. Instalar o Kernel Headers
Por padrão o Ubuntu já instala o kernel headers. Mas caso seja necessário:
```bash
apt install linux-headers-`uname -r`
```

### 3. Instalar o Kernel Sources

Verificar a versão do kernel instalada:
```bash
uname -a

#Resultado
... 5.4.0-58-generic #64-Ubuntu ...
```

Para listar os fontes disponíveis:
```bash
apt search linux-source

# Resultado
linux-source-5.4.0/focal-updates,focal-updates,focal-security,focal-security 5.4.0-58.64 all
```
Baixar o kernel source correspondente ao kernel no diretório `/lib/modules` (por padrão):
```bash
cd /lib/modules
apt source linux-source-5.4.0
```

Após o comando acima os fontes do kernel estarão no diretório `/lib/modules/linux-5.4.0/`.

### 4. Instalar o netmap

Deve-se executar a instalação dentro do diretório `LINUX` do netmap.

O netmap pode utilizar o driver de rede sem modificações, porém a performance será reduzida. Para o netmap aplicar o patch e compilar o driver de rede, deve-se informar o parâmentro `--kernel-sources` com o diretório dos fontes baixados no passo anterior.

Caso o driver de rede seja `e1000` ou `r8169.c`, pode-se utilizar o parâmetro `--no-ext-drivers`. Pois será utilizado o método 1 do netmap, onde é aplicado um patch no driver fornecido com o kernel, sem a necessidade de baixar e compilar os demais drivers.

Para outras placas verificar a documentação do netmnap: [NIC Drivers](https://github.com/luigirizzo/netmap/blob/master/LINUX/README.md#nic-drivers)

```bash
cd /root
# Clone do repositório
git clone https://github.com/luigirizzo/netmap.git

# Fontes para Linux
cd /root/netmap/LINUX

# Neste caso o driver é Intel e1000 e foi utilizado o parâmentro --no-ext-drivers
# para não precisar baixar os demais drivers e compilar (método 1 da documentação).
./configure --kernel-sources=/lib/modules/linux-5.4.0 --no-ext-drivers
make 
make install
```
:warning: Ajustar o tamanho do Buffer do netmap de acordo com o MTU.
No caso abaixo, o buffer foi ajustado para Jumbo Frames.
```bash
echo 9000 > /sys/module/netmap/parameters/buf_size
```
### 5. Instalar o Tcpreplay

[Wiki Tcpreplay](https://tcpreplay.appneta.com/wiki/installation.html)

Para habilitar o suporte ao netmap, deve-se utilizar o parâmetro `--with-netmap` informando o diretório da instalação do netmap feita no passo anterior.

```bash
apt install build-essential libpcap-dev
cd /root
wget https://github.com/appneta/tcpreplay/releases/download/v4.3.3/tcpreplay-4.3.3.tar.xz
tar xvf tcpreplay-4.3.3.tar.xz
cd tcpreplay-4.3.3

# Passar o parâmetro --with-netmap com o diretório dos fontes do netmap
./configure --with-netmap=/root/netmap
make
make install 
```

### 5. Carregar os módulos para utilizar a ferramenta

Por padrão o módulo do netmap e do driver modificado não é carregado na inicialização do sistema.

Dessa forma, deve-se remover o módulo original fornecido pelo kernel e carrager os módulos manualmente.

```bash
# Remove o módulo do driver original
rmmod e1000

# Carrega o módulo do netmap
insmod /root/netmap/LINUX/netmap.ko

# Carrega o módulo do driver modificado
insmod /root/netmap/LINUX/e1000/e1000.ko
```

Para verificar se os módulos foram carregados:
```bash
lsmod

# Resultado
Module                  Size  Used by
e1000                 151552  0
netmap                204800  1 e1000
```

Para retornar ao driver original:
```bash
rmmod e1000
rmmod netmap
modprobe e1000
```

### Ajuste de MTU

Caso receba o erro `Message too long (errno = 90)`. É necessário aumentar o MTU.
```bash
Warning: Unable to send packet: Error with PF_PACKET send() [128338]: Message too long (errno = 90)
```
Aumentando o MTU para Jumbo Frames.
```bash
ip link set dev <interface> mtu 9000
# OU
# ifconfig <interface> mtu 9000
```
