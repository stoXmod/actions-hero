#!/bin/bash
set -e

# Install dependencies
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -qq update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -qq install curl wget git vim apt-transport-https ca-certificates nginx rsync

# Setup NodeJS 16.x
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo DEBIAN_FRONTEND=noninteractive apt-get -y -qq install nodejs
sudo npm install pm2@latest -g

# Setup sudo to allow no-password sudo for "metaroon" group and adding "stoxmod" user
sudo groupadd -r metaroon
sudo useradd -m -s /bin/bash stoxmod
sudo usermod -a -G metaroon stoxmod
sudo cp /etc/sudoers /etc/sudoers.orig
echo "stoxmod ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/stoxmod

# Change deployment directory path and permissions
sudo mkdir -p /var/app
sudo chown -R stoxmod:stoxmod /var/app

# Setup nginx
# Remove the default configuration
sudo sh -c '> /etc/nginx/sites-available/default' && \
sudo sh -c 'sudo cat <<EOF > /etc/nginx/sites-available/default
upstream app_upstream {
server 127.0.0.1:5000;
keepalive 64;
}

server {
listen 80 default_server;
listen [::]:80 default_server;
server_name _;

location / {
proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
proxy_set_header X-Real-IP \$remote_addr;
proxy_set_header Host \$http_host;

proxy_http_version 1.1;
proxy_set_header Upgrade \$http_upgrade;
proxy_set_header Connection "upgrade";

proxy_pass http://localhost:5000;
proxy_redirect off;
proxy_read_timeout 240s;
}
}
EOF'