<div align="center">

```
█████ ███ █   █ █████     ███   ███  █   █ █   █ █   █ █   █ ███ █████ █   █ 
█      █  █   █ █        █     █   █ ██ ██ ██ ██ █   █ ██  █  █    █    █ █  
████   █  █   █ ████     █     █   █ █ █ █ █ █ █ █   █ █ █ █  █    █     █   
█      █   █ █  █        █     █   █ █   █ █   █ █   █ █  ██  █    █     █   
█     ███   █   █████     ███   ███  █   █ █   █  ███  █   █ ███   █     █   
```

**Discord Voice Fix v2.0**  
*Criado por bkvini.ofc · Five Community*

![Windows](https://img.shields.io/badge/Windows-10%2F11-blue?logo=windows)
![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue?logo=powershell)
![.NET](https://img.shields.io/badge/.NET-Nativo-green)
![Sem dependências](https://img.shields.io/badge/Dependências-Nenhuma-brightgreen)

</div>

---

## 📋 O que é?

O **Five Community Bypass** é uma ferramenta que corrige problemas de voz no Discord para jogadores da **Five Community (FiveM)**. Ele redireciona o tráfego de voz do Discord por meio de um proxy dedicado, resolvendo problemas de conexão causados por bloqueios de ISP ou roteamento ruim.

---

## ⚙️ Como funciona?

```
[Usuário clica no .exe]
        ↓
[Sorteia 1 dos 10 proxies disponíveis]
        ↓
[Cria um Mini-Servidor (Relay) local invisível na memória]
        ↓
[Fecha e reabre o Discord apontando para o Relay local]
        ↓
[O Relay injeta as credenciais do proxy automaticamente]
        ↓
[Discord → Relay Local → Proxy → Internet ✅]
        ↓
[Janela some após 10 segundos, Relay fica em background]
        ↓
[Quando o Discord fecha → Relay encerra sozinho]
```

### Detalhes técnicos

| Componente | Tecnologia | Descrição |
|---|---|---|
| **Script principal** | PowerShell 5.1+ | Orquestra todo o processo |
| **Relay de proxy** | C# / .NET (embutido) | Mini servidor TCP local que injeta credenciais |
| **Autenticação** | HTTP Basic Auth (Base64) | Injetada no header `Proxy-Authorization` |
| **Proxy** | HTTP Residencial (Webshare) | 10 endpoints dedicados, sorteio aleatório a cada execução |

---

## 🖥️ Impacto no PC do usuário

> **Resumo: impacto praticamente zero.**

| Recurso | Consumo |
|---|---|
| **CPU** | ~0% em idle (relay só ativa quando o Discord faz requisição) |
| **RAM** | ~50–80 MB (processo PowerShell em background) |
| **Disco** | Nenhuma escrita em disco após abertura |
| **Rede** | Apenas o tráfego de voz do Discord passa pelo proxy |
| **Startup** | Não adiciona nada à inicialização do Windows |
| **Registro** | Não modifica o Registro do Windows |

O relay roda como um processo em **background invisível** e se encerra automaticamente quando você fechar o Discord. Não deixa rastros.

---

## 📦 O que é instalado?

Ao rodar o `FiveCommunityBypass_Setup.exe`:

- ✅ Copia o `FiveCommunityBypass.exe` para `C:\Program Files\FiveCommunityBypass\`
- ✅ Cria atalho na **Área de Trabalho**
- ✅ Cria atalho no **Menu Iniciar**
- ✅ Cria um **Desinstalador** completo
- ❌ **Não instala drivers**
- ❌ **Não modifica arquivos de sistema**
- ❌ **Não requer reinicialização**

---

## 🚀 Como usar

1. Baixe e execute o `FiveCommunityBypass_Setup.exe`
2. Clique em **Avançar** e instale normalmente
3. Use o atalho **"Five Community Bypass"** na Área de Trabalho antes de entrar no servidor
4. Aguarde a tela mostrar **"Tudo pronto!"** e o Discord abrir automaticamente
5. Entre no servidor e aproveite a voz funcionando ✅

> ⚠️ **Importante:** Sempre abra o Bypass **antes** de entrar no servidor FiveM.

---

## 🔧 Requisitos

| Requisito | Versão mínima |
|---|---|
| **Windows** | 10 ou 11 |
| **PowerShell** | 5.1 (já incluso no Windows 10/11) |
| **.NET Framework** | 4.5+ (já incluso no Windows 10/11) |
| **Discord** | Qualquer versão recente |
| **Node.js** | ❌ Não necessário |
| **Outros programas** | ❌ Nenhum |

---

## ❓ Perguntas Frequentes

**O Discord vai pedir senha do proxy?**  
Não. O relay injeta as credenciais automaticamente, de forma invisível.

**Precisa deixar alguma janela aberta?**  
Não. Após 10 segundos a janela some. O processo roda silenciosamente em background.

**Afeta outros programas além do Discord?**  
Não. O proxy é aplicado **somente** ao processo do Discord, e somente enquanto o Bypass estiver ativo.

**E se eu fechar o Discord e abrir de novo sem o Bypass?**  
O Discord vai abrir normalmente, sem proxy. Para usar a voz da Five Community, basta rodar o Bypass novamente.

**Funciona em qualquer provedor de internet?**  
Sim. Como o tráfego passa por um proxy residencial dedicado, funciona independentemente da operadora.

---

## 🛡️ Segurança

- O executável não contém vírus, spyware ou qualquer código malicioso
- O código-fonte está disponível neste repositório para inspeção
- Nenhum dado pessoal é coletado ou enviado
- As credenciais do proxy são usadas exclusivamente para roteamento de voz

---

## 👤 Créditos

Desenvolvido por **bkvini.ofc** para a **Five Community**  
Suporte: entre em contato pelos canais oficiais da Five Community
