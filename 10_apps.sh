# Install packages
## Ubuntu
echo "Installing Ubuntu packages"
sudo apt update
sudo apt install -y \
    python3-pip \
    python3.10-venv \
    vim \
    libffi-dev \
    dnsutils \
    clamav \
    clamtk \
    golang-1.21 \
    sshpass \
    whois \
    tmux

## Python
echo "Installing Python packages"
pip3 install \
    ansible \
    ansible-lint \
    molecule \
    'molecule-plugins[docker]' \
    docker

# Docker
## Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

## Add the repository to Apt sources:
echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

## Instal Docker + plugins
sudo apt-get install -y 
    docker-ce \
    docker-ce-cli\
    containerd.io\
    docker-buildx-plugin \
    docker-compose-plugin

# KVM
sudo apt -y install \
    bridge-utils \
    cpu-checker \
    libvirt-clients \
    libvirt-daemon \
    qemu \
    qemu-kvm \
    virt-manager

# Minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube

# Kind
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

# Kubectl
curl -LO https://dl.k8s.io/release/`curl -LS https://dl.k8s.io/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

#PgAdmin
curl -fsS https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo gpg --dearmor -o /usr/share/keyrings/packages-pgadmin-org.gpg
sudo sh -c 'echo "deb [signed-by=/usr/share/keyrings/packages-pgadmin-org.gpg] https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'
sudo apt install pgadmin4

# Create links
sudo ln -s /usr/lib/go-1.21/bin/go /usr/local/bin/go
sudo ln -s /usr/lib/go-1.21/bin/gofmt /usr/local/bin/gofmt

echo "💪 Finished"
