
# Install Docker - Ubuntu 20.04

```bash
# Add Repository
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "deb [arch=$(dpkg --print-architecture)] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Requirements
apt update
apt install ca-certificates curl gnupg lsb-release

# Install docker-ce
apt install docker-ce
```
