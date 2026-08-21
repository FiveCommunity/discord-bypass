# Five Community Bypass - Discord Voice Fix v2.0

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

## Funcionalidades
- Redirecionamento forçado do Discord via `--proxy-server=socks5://`.
- Ignora rotas locais com `--proxy-bypass-list`.
- Operação invisível no background enquanto o Discord estiver aberto.
- Fechamento automático de segurança (mata instâncias antigas para aplicar as novas rotas).

---
Criador: **bkvini.ofc**
