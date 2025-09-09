FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN echo "STEP 1 - Atualizando o sistema e instalando dependências básicas" && \
    apt-get update && apt-get upgrade -y && \
    apt-get install -y wget curl libstdc++6 libcd m0g libx11-6 libexpat1 libssl3 ca-certificates \
                       iproute2 iputils-ping net-tools software-properties-common apt-transport-https \
                       build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "STEP 2 - Instalando Java 11 via SDKMAN" && \
    curl -s "https://get.sdkman.io" | bash && \
    bash -c "source $HOME/.sdkman/bin/sdkman-init.sh && sdk install java 11.0.11-open"

RUN echo "STEP 3 - Instalando dependências adicionais (SSL)" && \
    apt-get update && \
    apt-get install -y xterm libnss3-tools && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN echo "STEP 4 - Instalando libs 32 bits" && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y multiarch-support libx11-6:i386 libc6:i386 libncurses5:i386 \
                       libstdc++6:i386 libstdc++5:i386 libpam0g:i386 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /opt/snx
RUN echo "STEP 5 - Realizando download dos scripts de instalação do SNX" && \
    wget https://dl.checkpoint.com/solutions/remote-access/src/snx_install_linux30.sh -O snx_install.sh && \
    chmod +x snx_install.sh && \
    wget https://dl.checkpoint.com/solutions/remote-access/src/cshell/cshell_install_linux.sh -O cshell_install.sh && \
    chmod +x cshell_install.sh

COPY setup_snx.sh /opt/snx/
COPY connect_vpn.sh /opt/snx/
RUN chmod +x setup_snx.sh && chmod +x connect_vpn.sh && ./setup_snx.sh

RUN echo "STEP 6 - Configurações finais" && \
    mkdir -p /etc/snx && \
    chmod 755 /etc/snx

EXPOSE 443 4500/udp 500/udp

ENTRYPOINT ["/bin/bash"]
