# 📱 Guia de Uso: Discord Voice Fix no Celular

Como a tecnologia que usamos no PC para corrigir as vozes é o **SOCKS5** (um protocolo de altíssima performance para jogos e voz), os sistemas Android e iOS não possuem suporte nativo para ele nas configurações normais de Wi-Fi. 

Porém, existe um jeito **muito mais eficiente** e rápido! Usaremos um aplicativo gratuito de tunelamento que força a conexão a passar pelo nosso servidor oficial. 

Abaixo estão os tutoriais passo a passo para iOS e Android.

---

## 🍎 Tutorial para iOS (iPhone / iPad)

No iPhone, usaremos o aplicativo gratuito **Potatso** para conectar no servidor da Five Community.

### Passo 1: Instalação
1. Abra a **App Store** no seu iPhone.
2. Pesquise e baixe o aplicativo gratuito **Potatso** (ou *Shadowrocket* se você já o possuir).

### Passo 2: Configuração (Automática)
Para não precisar digitar nada, você pode adicionar o proxy automaticamente de duas formas:

**Opção A: Pelo Link Direto (Se já estiver no celular)**
1. [CLIQUE AQUI PARA INSTALAR AUTOMATICAMENTE](socks5://discord.fivenetwork.dev:1080)
2. O seu iPhone vai perguntar se você deseja abrir o Potatso. Confirme!

**Opção B: Pelo QR Code (Se estiver vendo pelo PC)**
1. Abra o aplicativo Potatso.
2. Clique no ícone de "Escanear QR Code" (ou "Scan QR Code") na tela principal.
3. Aponte a câmera do celular para o código abaixo:

![QR Code de Instalação](https://api.qrserver.com/v1/create-qr-code/?size=300x300&data=socks5://discord.fivenetwork.dev:1080)

*(Caso dê algum erro, você pode clicar em "Add a Proxy" e colocar os dados manualmente: Tipo `SOCKS5`, Host `discord.fivenetwork.dev`, Porta `1080`)*

### Passo 3: Conectar e Usar
1. Na tela inicial do Potatso, clique no botão azul redondo gigante de Play (▶️).
2. O iOS vai perguntar se você permite que o app crie uma configuração de VPN. Clique em **Permitir** (Allow) e coloque sua senha/Face ID.
3. Pronto! Quando aparecer o ícone "VPN" na barra superior do iPhone, o seu celular já está usando o bypass! 
4. Pode abrir o aplicativo do Discord e entrar nas calls de voz. Tudo vai rodar perfeitamente.

---

## 🤖 Tutorial para Android

No Android, como o aplicativo antigo sumiu da loja, usaremos o aplicativo oficial **Super Proxy**, que é focado em tunelar a rede via SOCKS5 e é extremamente fácil de usar.

### Passo 1: Instalação
1. Abra a **Google Play Store**.
2. Pesquise e baixe o aplicativo **Super Proxy** (O desenvolvedor é *EugenePopov*).

### Passo 2: Configuração
1. Abra o aplicativo Super Proxy.
2. Clique no botão **Add proxy** (Adicionar proxy).
3. Preencha as informações:
   - **Protocol:** `SOCKS5`
   - **Server:** `discord.fivenetwork.dev`
   - **Port:** `1080`
4. Role a tela para baixo e clique no botão **Save** (Salvar).

### Passo 3: Forçar Proxy apenas no Discord (Recomendado)
Para evitar que a internet inteira do celular passe pelo proxy:
1. Na tela principal, clique no botão **Proxied Apps** (Aplicativos com Proxy).
2. Marque a opção **Only selected apps** (Apenas aplicativos selecionados).
3. Procure pelo **Discord** na lista e marque a caixinha dele.
4. Volte para a tela anterior.

### Passo 4: Conectar e Usar
1. Na tela inicial, clique no botão azul gigante **Start** (Iniciar).
2. O Android vai pedir permissão para criar uma conexão de VPN. Clique em **OK**.
3. Pronto! Abra o seu Discord e as vozes vão funcionar perfeitamente.

---
💡 *Dúvidas ou problemas? Abra um ticket com o suporte da Five Community.*
