#!/bin/bash

# Instalando EPEL (caso ainda não tenha sido instalado)
sudo yum install -y epel-release

# Atualizando pacotes
sudo yum update -y

# Pacotes essenciais
sudo yum install -y iftop htop psmisc telnet ntp awscli

# Configurando o profile
sudo bash -c "
cat <<\EOF > /etc/profile.d/custom.sh
alias la='ls -la --color'
alias ll='ls -larth --color'
PATH=\$PATH:~/.local/bin
EOF
"

# Desativando serviços
sudo service firewalld stop
sudo systemctl disable firewalld.service
sudo systemctl disable postfix.service
sudo systemctl disable cloud-config.service cloud-final.service cloud-init-local.service cloud-init.service

# Alterando Limits de arquivos abertos
sudo sed -i 's/4096/307200/g' /etc/security/limits.d/20-nproc.conf
sudo echo '* hard nofile 500000' >> /etc/security/limits.conf
sudo bash -c "echo '* soft nofile 500000' >> /etc/security/limits.conf"
sudo bash -c "echo 'root hard nofile 500000' >> /etc/security/limits.conf"
sudo bash -c "echo 'root soft nofile 500000' >> /etc/security/limits.conf"
sudo bash -c "echo 'fs.file-max = 2097152' >> /etc/sysctl.conf"
sudo sleep 1; sudo sysctl -p

# Timezone de Sao Paulo
sudo rm -f /etc/localtime
sudo ln -s /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
