# Five Community Bypass - Discord Voice Fix v2.0

[![Discord](https://img.shields.io/discord/4CuXf8Zd3m?color=7289da&logo=discord&logoColor=white&label=Suporte%20Five%20Community)](https://discord.gg/4CuXf8Zd3m)
![Windows](https://img.shields.io/badge/Windows-10%2F11-blue?logo=windows)

Bypass em PowerShell para redirecionar o tráfego do Discord através de um proxy SOCKS5 dedicado. 
Este projeto corrige problemas de bloqueios e falhas de conexão de voz/vídeo no próprio Discord.

## Por que SOCKS5?
Muitos proxies HTTP(s) falham ao rotear tráfego UDP (utilizado pelo WebRTC do Discord para chamadas de voz e compartilhamento de tela). Ao utilizar um proxy SOCKS5 (como o Dante), o Discord consegue rotear perfeitamente todo o tráfego de mídia, permitindo que vários usuários compartilhem tela e conversem simultaneamente sem "derrubar" a conexão um do outro.

## Como Usar (Template Open Source)

Este projeto foi disponibilizado de forma open source. Para utilizar na sua comunidade:

1. Instale um servidor SOCKS5 (ex: Dante) na sua VPS.
2. Certifique-se de liberar a porta padrão (ex: `1080` TCP e UDP) no painel de Firewall do seu servidor.
3. Abra o arquivo `FiveCommunityBypass.ps1`.
4. Altere a variável `$proxyHost` na linha 17 para o IP da sua VPS ou Domínio (ex: `proxy.suacomunidade.com`).
5. Execute o script ou compile em `.exe` utilizando o [ps2exe](https://github.com/MScholtes/PS2EXE).

## 📥 Como Instalar e Usar (Jogadores do PC)
A instalação é incrivelmente simples e não exige conhecimentos técnicos:
1. Faça o download do arquivo `FiveCommunityBypass_Setup.exe` na aba de [Releases](https://github.com/ViniModder/discord-bypass/releases/latest) deste repositório.
2. Dê dois cliques no arquivo baixado para abri-lo.
3. O Bypass abrirá um terminal e conectará automaticamente aos servidores oficiais de proxy da comunidade.
4. Em seguida, ele vai encontrar o seu Discord, fechar a versão atual e abrir uma versão limpa conectada ao bypass!

## 📱 Como Usar no Celular (iOS / Android)
Se você estiver jogando, ouvindo música ou fazendo call pelo celular e quiser remover as restrições, nós criamos um tutorial específico ensinando como conectar o seu dispositivo móvel ao Bypass usando aplicativos gratuitos!
👉 **[CLIQUE AQUI PARA LER O GUIA DE CELULAR COMPLETO](GUIA_MOBILE.md)**

## 🛡️ Como a ofuscação funciona?

## Funcionalidades
- Redirecionamento forçado do Discord via `--proxy-server=socks5://`.
- Ignora rotas locais com `--proxy-bypass-list`.
- Operação invisível no background enquanto o Discord estiver aberto.
- Fechamento automático de segurança (mata instâncias antigas para aplicar as novas rotas).

---
Criador: **bkvini.ofc**
