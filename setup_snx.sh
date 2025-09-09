#!/bin/bash

echo "=== Setup SNX VPN Client ==="

# Verifica se os instaladores existem
if [ ! -f "snx_install.sh" ]; then
    echo "AVISO: snx_install.sh não encontrado. Pule esta etapa por enquanto."
else
    echo "Instalando SNX..."
    ./snx_install.sh
fi

if [ ! -f "cshell_install.sh" ]; then
    echo "AVISO: cshell_install.sh não encontrado. Pule esta etapa por enquanto."
else
    echo "Instalando CShell..."
    ./cshell_install.sh
fi

# Verifica se o SNX foi instalado corretamente
if command -v snx &> /dev/null; then
    echo "SNX instalado com sucesso!"
    snx -v
else
    echo "SNX não foi instalado ainda. Adicione os arquivos de instalação e execute manualmente."
fi

# Cria diretórios necessários
mkdir -p ~/.snx
mkdir -p /tmp/snx

echo "=== Setup concluído ==="
echo "Para instalar o SNX:"
echo "1. Obtenha snx_install.sh e cshell_install.sh do administrador da VPN"
echo "2. Copie os arquivos para /opt/snx/"
echo "3. Execute: chmod +x snx_install.sh cshell_install.sh"
echo "4. Execute: ./snx_install.sh && ./cshell_install.sh"
echo "5. Para conectar à VPN, use: snx -s <SERVIDOR_VPN> -u <USUARIO>"
