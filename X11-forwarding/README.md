# MobaXterm X11-forwarding

Source: https://blog.mobatek.net/post/how-to-keep-X11-display-after-su-or-sudo/  

## How to keep X11 display after `su` or `sudo`

Error: ***MoTTY X11 proxy: Authorisation not recognised***

### 1. Using `sudo`:
On the user terminal:
```bash
sudo xauth add $(xauth -f ~john/.Xauthority list|tail -1)
```

### 2. Using `su`:
On the root terminal after `su` command:
```bash
xauth add $(xauth -f ~john/.Xauthority list|tail -1)
```
