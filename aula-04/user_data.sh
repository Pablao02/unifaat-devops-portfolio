#!/bin/bash

set -e

# Atualiza o sistema
dnf update -y

# Instala Git e Curl
dnf install -y git

# Configura o repositorio NodeSource para Node.js 18
curl -fsSL https://rpm.nodesource.com/setup_18.x | bash -

# Instala Node.js 18
dnf install -y nodejs

# Verifica versões
node --version
npm --version
git --version

# Cria diretório da aplicação
mkdir -p /opt/technova-api
cd /opt/technova-api

# Clona a API
git clone https://github.com/Pablao02/technova-api.git .

# Instala dependências
npm install

# Cria serviço systemd para manter a API executando
cat > /etc/systemd/system/technova-api.service <<'EOF'
[Unit]
Description=TechNova Node.js API
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=root
WorkingDirectory=/opt/technova-api
ExecStart=/usr/bin/npm start
Restart=always
RestartSec=5
Environment=NODE_ENV=production
Environment=PORT=3000

[Install]
WantedBy=multi-user.target
EOF

# Ativa e inicia a API
systemctl daemon-reload
systemctl enable technova-api
systemctl start technova-api

# Aguarda a aplicação iniciar
sleep 10

# Testa a API localmente
curl http://localhost:3000 || true