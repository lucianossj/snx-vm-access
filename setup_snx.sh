#!/bin/bash

echo "=== Setup SNX VPN Client ==="

# Executa os instaladores
echo "Instalando SNX..."
./snx_install.sh

echo "Instalando CShell..."
./cshell_install.sh

# Verifica se o SNX foi instalado corretamente
if command -v snx &> /dev/null; then
    echo "SNX instalado com sucesso!"
    snx -v
else
    echo "Erro na instalação do SNX"
    exit 1
fi

# Cria diretórios necessários
mkdir -p ~/.snx
mkdir -p /tmp/snx

echo "=== Setup concluído ==="
echo "Para conectar à VPN, use: snx -s <SERVIDOR_VPN> -u <USUARIO>"
