# =============================================================================
#  Five Community Bypass — Discord Voice Fix v2.0
#  Criador: bkvini.ofc
#  Descrição: Redireciona o Discord por um proxy dedicado na Oracle Cloud,
#             corrigindo problemas de voz no servidor FiveM.
# =============================================================================

$ErrorActionPreference = "Stop"

# -----------------------------------------------------------------------------
# Inicialização do Script Principal
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Configuração do proxy (Coloque o IP ou Domínio da sua VPS aqui)
# -----------------------------------------------------------------------------
$proxyHost = "SEU_DOMINIO_OU_IP_AQUI"
$proxyPort = 8080

Write-Host "  Conectando ao servidor Proxy Oficial ($($proxyHost):$($proxyPort))..." -ForegroundColor Yellow

# -----------------------------------------------------------------------------
# Inicialização do Discord
# -----------------------------------------------------------------------------
try
{
    Write-Host "  Conectado com sucesso!" -ForegroundColor Green
    Start-Sleep -Milliseconds 400

    Write-Host "  Preparando o Discord..." -ForegroundColor Yellow

    # Fecha o Discord se já estiver aberto para aplicar o proxy corretamente
    Get-Process -Name Discord -ErrorAction SilentlyContinue | Stop-Process -Force
    Start-Sleep -Seconds 2

    # Localiza a pasta do Discord instalado
    $discordRoot = "$env:LOCALAPPDATA\Discord"
    $discordApp  = Get-ChildItem $discordRoot -Directory -Filter "app-*" -ErrorAction SilentlyContinue |
                   Sort-Object Name -Descending |
                   Select-Object -First 1

    if (-not $discordApp) {
        throw "Discord não encontrado. Verifique se ele está instalado."
    }

    $discordExe = Join-Path $discordApp.FullName "Discord.exe"

    Write-Host "  Iniciando Discord..." -ForegroundColor Yellow

    # Inicia o Discord apontando para o proxy VPS
    # O bypass da lista garante que CDN e mídia carregam direto (sem proxy)
    $logOut = Join-Path $env:TEMP "discord_stdout.log"
    $logErr = Join-Path $env:TEMP "discord_stderr.log"

    Start-Process -FilePath $discordExe -ArgumentList @(
        "--proxy-server=http://$($proxyHost):$($proxyPort)",
        "--proxy-bypass-list=cdn.discordapp.com;*.discordapp.net;*.discord.media;<local>"
    ) -RedirectStandardOutput $logOut -RedirectStandardError $logErr

    Start-Sleep -Seconds 1

    Write-Host ""
    Write-Host "  Tudo pronto! Aproveite a Five Community." -ForegroundColor Green
    Write-Host ""

    # Contagem regressiva antes de fechar a janela
    for ($i = 5; $i -gt 0; $i--) {
        Write-Host "`r  Fechando em $i segundos...   " -NoNewline -ForegroundColor DarkGray
        Start-Sleep -Seconds 1
    }
    Write-Host ""
}
catch
{
    Write-Host ""
    Write-Host "  Erro: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "  Entre em contato com o suporte da Five Community." -ForegroundColor Red
    Write-Host ""
    Read-Host "  Pressione Enter para fechar"
}
