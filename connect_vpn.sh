#!/bin/bash

# Script para conectar à VPN usando SNX
# Uso: ./connect_vpn.sh <SERVIDOR_VPN> <USUARIO>

if [ $# -lt 2 ]; then
    echo "Uso: $0 <SERVIDOR_VPN> <USUARIO>"
    echo "Exemplo: $0 vpn.empresa.com usuario"
    exit 1
fi

VPN_SERVER=$1
USERNAME=$2

echo "Conectando à VPN..."
echo "Servidor: $VPN_SERVER"
echo "Usuário: $USERNAME"

# Conecta à VPN
snx -s $VPN_SERVER -u $USERNAME

# Verifica se a conexão foi bem-sucedida
if [ $? -eq 0 ]; then
    echo "Conexão VPN estabelecida com sucesso!"
    echo "Para verificar status: snx -l"
    echo "Para desconectar: snx -d"
else
    echo "Falha na conexão VPN"
    exit 1
fi
