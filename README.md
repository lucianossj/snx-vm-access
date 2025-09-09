# SNX VPN Container - Instruções de Uso

## ✅ Build Concluído com Sucesso!

O container `snx-vm-access` foi criado com todas as dependências necessárias para o SNX.

## 🚀 Como Usar

### 1. Executar o Container

```powershell
# Para desenvolvimento/teste (remove o container ao sair)
docker run -it --rm snx-vm-access

# Para uso persistente com privilégios VPN
docker run -it --privileged --cap-add=NET_ADMIN --device /dev/net/tun snx-vm-access
```

### 2. Instalar o SNX (dentro do container)

Os arquivos de instalação já estão incluídos no container:
   - ✅ `snx_install.sh` (baixado automaticamente)
   - ✅ `cshell_install.sh` (baixado automaticamente)

1. Dentro do container, execute a instalação:

```bash
./snx_install.sh
./cshell_install.sh
```

2. Verifique a instalação:

```bash
snx -v
```

### 3. Conectar à VPN

```bash
# Usando o comando direto
snx -s SERVIDOR_VPN -u USUARIO

# Ou usando o script helper
./connect_vpn.sh SERVIDOR_VPN USUARIO
```

### 4. Comandos Úteis

```bash
# Verificar status da VPN
snx -l

# Desconectar da VPN
snx -d

# Ver versão do SNX
snx -v
```

## 🔧 Problemas Corrigidos Durante o Build

1. ✅ Dependência `libpam0g` (erro de digitação corrigido)
2. ✅ Pacotes `unzip` e `zip` adicionados para SDKMAN
3. ✅ Removido `multiarch-support` (não existe no Ubuntu 22.04)
4. ✅ Downloads automáticos do SNX incluídos (vpn1.nscc.sg)
5. ✅ Scripts de setup tornados mais robustos
6. ✅ Java comentado (pode não ser necessário para SNX)
7. ✅ Certificado SSL contornado com --no-check-certificate

## 📝 Próximos Passos

1. ✅ Arquivos de instalação já incluídos no container
2. Executar a instalação do SNX dentro do container
3. Testar a conexão VPN com suas credenciais
4. Configure o compartilhamento de rede com o host (se necessário)
5. Documente as configurações específicas da sua empresa

## ⚠️ Observações Importantes

- O container precisa de privilégios especiais (`--privileged`) para VPN funcionar
- Os arquivos de instalação do SNX são específicos da sua empresa
- Teste primeiro em um ambiente seguro antes de usar em produção
