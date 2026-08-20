!include "MUI2.nsh"

!define APPNAME "FiveCommunityBypass"
!define EXE_FILE "FiveCommunityBypass.exe"

Name "Five Community Bypass"
OutFile "FiveCommunityBypass_Setup.exe"
InstallDir "$PROGRAMFILES\FiveCommunityBypass"

; Pede privilégios de administrador para instalar
RequestExecutionLevel admin

; Configurações da Interface
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install-blue.ico"

; Páginas do Instalador (As telas que vão aparecer)
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_LANGUAGE "PortugueseBR"

; Seção de Instalação
Section "Instalar"
    SetOutPath "$INSTDIR"
    
    ; Inclui o arquivo EXE que compilamos
    File "${EXE_FILE}"
    
    ; Cria atalho na Área de Trabalho
    CreateShortcut "$DESKTOP\Five Community Bypass.lnk" "$INSTDIR\${EXE_FILE}"
    
    ; Cria atalho no Menu Iniciar
    CreateDirectory "$SMPROGRAMS\Five Community Bypass"
    CreateShortcut "$SMPROGRAMS\Five Community Bypass\Five Community Bypass.lnk" "$INSTDIR\${EXE_FILE}"
    CreateShortcut "$SMPROGRAMS\Five Community Bypass\Desinstalar.lnk" "$INSTDIR\Uninstall.exe"
    
    ; Cria o desinstalador
    WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

; Seção de Desinstalação
Section "Uninstall"
    Delete "$INSTDIR\${EXE_FILE}"
    Delete "$INSTDIR\Uninstall.exe"
    RMDir "$INSTDIR"
    
    Delete "$DESKTOP\Five Community Bypass.lnk"
    Delete "$SMPROGRAMS\Five Community Bypass\Five Community Bypass.lnk"
    Delete "$SMPROGRAMS\Five Community Bypass\Desinstalar.lnk"
    RMDir "$SMPROGRAMS\Five Community Bypass"
SectionEnd
