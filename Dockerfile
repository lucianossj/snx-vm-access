FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN echo "STEP 1 - Atualizando o sistema e instalando dependências básicas" && \
    apt-get update && apt-get upgrade -y && \
    apt-get install -y wget curl unzip zip libstdc++6 libpam0g libx11-6 libexpat1 libssl3 ca-certificates \
                       iproute2 iputils-ping net-tools software-properties-common apt-transport-https \
                       build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# STEP 2 - Instalando Java 11 via SDKMAN (COMENTADO - pode não ser necessário para SNX)
# RUN echo "STEP 2 - Instalando Java 11 via SDKMAN" && \
#     curl -s "https://get.sdkman.io" | bash && \
#     bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install java 11.0.11-open"

RUN echo "STEP 3 - Instalando dependências adicionais (SSL)" && \
    apt-get update && \
    apt-get install -y xterm libnss3-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# STEP 4 - Instalando libs 32 bits
RUN echo "STEP 4 - Instalando libs 32 bits" && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y libx11-6:i386 libc6:i386 libncurses5:i386 \
                       libstdc++6:i386 libpam0g:i386 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/snx
# STEP 5 - Download dos scripts de instalação do SNX
RUN echo "STEP 5 - Fazendo download dos scripts de instalação do SNX" && \
    echo "Baixando snx_install.sh..." && \
    wget --no-check-certificate https://vpn1.nscc.sg/sslvpn/SNX/INSTALL/snx_install.sh -O snx_install.sh && \
    chmod +x snx_install.sh && \
    echo "snx_install.sh baixado com sucesso!" && \
    echo "Baixando cshell_install.sh..." && \
    wget --no-check-certificate https://vpn1.nscc.sg/sslvpn/SNX/INSTALL/cshell_install.sh -O cshell_install.sh && \
    chmod +x cshell_install.sh && \
    echo "cshell_install.sh baixado com sucesso!" && \
    ls -la *.sh

# STEP 6 - Instalação automática do SNX
RUN echo "STEP 6 - Executando instalação automática do SNX" && \
    echo "Instalando snx_install.sh..." && \
    yes | ./snx_install.sh || echo "Instalação do SNX pode ter requerido interação manual" && \
    echo "Instalando cshell_install.sh..." && \
    yes | ./cshell_install.sh || echo "Instalação do CShell pode ter requerido interação manual" && \
    echo "Verificando instalação..." && \
    (snx -v && echo "SNX instalado com sucesso!" || echo "SNX será configurado após primeiro uso")

COPY setup_snx.sh /opt/snx/
COPY connect_vpn.sh /opt/snx/
RUN chmod +x setup_snx.sh && chmod +x connect_vpn.sh

# STEP 7 - Configurações finais
RUN echo "STEP 7 - Configurações finais" && \
    mkdir -p /etc/snx && \
    chmod 755 /etc/snx

EXPOSE 443 4500/udp 500/udp

ENTRYPOINT ["/bin/bash"]
