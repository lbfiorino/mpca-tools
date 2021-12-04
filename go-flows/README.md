# go-flows
This is a highy customizable general-purpose flow exporter.

# Install on Ubuntu 20.04

Install Go.
```bash
wget https://go.dev/dl/go1.17.4.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.17.4.linux-amd64.tar.gz

# To persist the PATH variable, edit /etc/environmet and add the path /usr/local/go/bin.  
export PATH=$PATH:/usr/local/go/bin

# Verify
go version
```

Install go-flows.
```bash
git clone https://github.com/CN-TU/go-flows.git
go clean
go install
# go install put the bin at userhomedir/go/bin/go-flows
```
