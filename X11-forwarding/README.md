# MobaXterm X11-forwarding

Source: https://blog.mobatek.net/post/how-to-keep-X11-display-after-su-or-sudo/  

## How to keep X11 display after `su` or `sudo`

Error: ***MoTTY X11 proxy: Authorisation not recognised***

Assuming that user "john" is connected to a remote server using SSH.

### 1. Using `sudo`:
On the john's terminal:
```bash
sudo xauth add $(xauth -f ~john/.Xauthority list|tail -1)
```

### 2. Using `su`:
After `su` command:
```bash
xauth add $(xauth -f ~john/.Xauthority list|tail -1)
```
