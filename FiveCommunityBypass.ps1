# =============================================================================
#  Five Community Bypass — Discord Voice Fix v2.0
#  Criador: bkvini.ofc
#  Descrição: Redireciona o Discord por um proxy residencial dedicado,
#             corrigindo problemas de voz no servidor FiveM.
# =============================================================================

$ErrorActionPreference = "Stop"

# -----------------------------------------------------------------------------
# Banner de boas-vindas
# -----------------------------------------------------------------------------
Clear-Host
Write-Host ""
Write-Host "  █████ ███ █   █ █████     ███   ███  █   █ █   █ █   █ █   █ ███ █████ █   █ " -ForegroundColor Cyan
Write-Host "  █      █  █   █ █        █     █   █ ██ ██ ██ ██ █   █ ██  █  █    █    █ █  " -ForegroundColor Cyan
Write-Host "  ████   █  █   █ ████     █     █   █ █ █ █ █ █ █ █   █ █ █ █  █    █     █   " -ForegroundColor Cyan
Write-Host "  █      █   █ █  █        █     █   █ █   █ █   █ █   █ █  ██  █    █     █   " -ForegroundColor Cyan
Write-Host "  █     ███   █   █████     ███   ███  █   █ █   █  ███  █   █ ███   █     █   " -ForegroundColor Cyan
Write-Host "                                   Discord Voice Fix v2.0" -ForegroundColor Cyan
Write-Host "                                     Criador: bkvini.ofc" -ForegroundColor Cyan
Write-Host "  ===============================================================================" -ForegroundColor Cyan
Write-Host ""

# -----------------------------------------------------------------------------
# Configuração do proxy
# -----------------------------------------------------------------------------
$proxy = @{
    Host = "p.webshare.io"
    Port = 10000
    User = "SEU_USUARIO_AQUI"
    Pass = "SUA_SENHA_AQUI"
}

# Porta local aleatória para o relay (evita conflitos entre execuções)
$relayPort = Get-Random -Minimum 49152 -Maximum 65535

Write-Host "  Conectando ao servidor $($proxy.Host):$($proxy.Port)..." -ForegroundColor Yellow

# -----------------------------------------------------------------------------
# Relay HTTP local (C# embutido)
# Injeta o cabeçalho Proxy-Authorization de forma invisível,
# pois o Discord (Electron/Chromium) não aceita credenciais no proxy diretamente.
# -----------------------------------------------------------------------------
$relayCsharp = @"
using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;

public class LocalRelay
{
    private static string      _upstreamHost;
    private static int         _upstreamPort;
    private static string      _authHeader;
    private static TcpListener _listener;

    // Inicia o servidor relay em uma thread de background
    public static void Start(int localPort, string upHost, int upPort, string user, string pass)
    {
        _upstreamHost = upHost;
        _upstreamPort = upPort;
        _authHeader   = "Proxy-Authorization: Basic " +
                        Convert.ToBase64String(Encoding.UTF8.GetBytes(user + ":" + pass));

        _listener = new TcpListener(IPAddress.Loopback, localPort);
        _listener.Start();

        Thread acceptThread = new Thread(AcceptLoop);
        acceptThread.IsBackground = true;
        acceptThread.Start();
    }

    // Aceita conexões do Discord em loop
    private static void AcceptLoop()
    {
        while (true)
        {
            try
            {
                TcpClient client = _listener.AcceptTcpClient();
                Thread handler   = new Thread(() => HandleClient(client));
                handler.IsBackground = true;
                handler.Start();
            }
            catch { }
        }
    }

    // Processa cada requisição: injeta auth e repassa ao proxy real
    private static void HandleClient(TcpClient client)
    {
        try
        {
            using (client)
            using (NetworkStream clientStream = client.GetStream())
            {
                // Lê a requisição original do Discord
                byte[] buffer    = new byte[65536];
                int    bytesRead = clientStream.Read(buffer, 0, buffer.Length);
                if (bytesRead == 0) return;

                string request = Encoding.UTF8.GetString(buffer, 0, bytesRead);

                // Injeta o cabeçalho de autenticação antes do corpo da requisição
                int    headerEnd   = request.IndexOf("\r\n\r\n");
                string authRequest = headerEnd >= 0
                    ? request.Substring(0, headerEnd + 2) + _authHeader + "\r\n" + request.Substring(headerEnd + 2)
                    : request;

                // Encaminha para o proxy real
                using (TcpClient   upstream       = new TcpClient(_upstreamHost, _upstreamPort))
                using (NetworkStream upstreamStream = upstream.GetStream())
                {
                    byte[] outBytes = Encoding.UTF8.GetBytes(authRequest);
                    upstreamStream.Write(outBytes, 0, outBytes.Length);

                    // Transferência bidirecional de dados
                    Thread upToDown = new Thread(() => PumpData(upstreamStream, clientStream));
                    upToDown.IsBackground = true;
                    upToDown.Start();

                    PumpData(clientStream, upstreamStream);
                    upToDown.Join(5000);
                }
            }
        }
        catch { }
    }

    // Copia dados de uma stream para outra
    private static void PumpData(NetworkStream source, NetworkStream destination)
    {
        try
        {
            byte[] buffer = new byte[8192];
            int    bytesRead;
            while ((bytesRead = source.Read(buffer, 0, buffer.Length)) > 0)
                destination.Write(buffer, 0, bytesRead);
        }
        catch { }
    }
}
"@

# Compila o relay em memória (não instala nada no disco)
Add-Type -TypeDefinition $relayCsharp -Language CSharp

# Sobe o relay local na porta escolhida
[LocalRelay]::Start($relayPort, $proxy.Host, $proxy.Port, $proxy.User, $proxy.Pass)
Start-Sleep -Milliseconds 400

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

    # Inicia o Discord apontando para o relay local
    # O bypass da lista garante que CDN e mídia carregam direto (sem proxy)
    $logOut = Join-Path $env:TEMP "discord_stdout.log"
    $logErr = Join-Path $env:TEMP "discord_stderr.log"

    Start-Process -FilePath $discordExe -ArgumentList @(
        "--proxy-server=http://127.0.0.1:$relayPort",
        "--proxy-bypass-list=cdn.discordapp.com;*.discordapp.net;*.discord.media;<local>"
    ) -RedirectStandardOutput $logOut -RedirectStandardError $logErr

    Start-Sleep -Seconds 1

    Write-Host ""
    Write-Host "  Tudo pronto! Aproveite a Five Community." -ForegroundColor Green
    Write-Host ""

    # Contagem regressiva antes de ocultar a janela
    for ($i = 10; $i -gt 0; $i--) {
        Write-Host "`r  Minimizando em $i segundos...   " -NoNewline -ForegroundColor DarkGray
        Start-Sleep -Seconds 1
    }
    Write-Host ""

    # Oculta a janela do console (o relay continua rodando em background)
    Add-Type -Name Win32 -Namespace Native -MemberDefinition @'
        [System.Runtime.InteropServices.DllImport("user32.dll")]
        public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
        [System.Runtime.InteropServices.DllImport("kernel32.dll")]
        public static extern IntPtr GetConsoleWindow();
'@

    $consoleWindow = [Native.Win32]::GetConsoleWindow()
    [Native.Win32]::ShowWindow($consoleWindow, 0) | Out-Null  # 0 = SW_HIDE

    # Mantém o script (e o relay) vivo enquanto o Discord estiver aberto
    while ($true) {
        $discordRunning = Get-Process -Name Discord -ErrorAction SilentlyContinue
        if (-not $discordRunning) { break }
        Start-Sleep -Seconds 5
    }

    # Discord foi fechado — relay encerra junto com este processo
}
catch
{
    Write-Host ""
    Write-Host "  Erro: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "  Entre em contato com o suporte da Five Community." -ForegroundColor Red
    Write-Host ""
    Read-Host "  Pressione Enter para fechar"
}
