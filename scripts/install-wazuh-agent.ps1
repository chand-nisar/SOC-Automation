# install-wazuh-agent.ps1
# SOC Automation Lab — SMALTER 2026
# Installs and starts Wazuh agent on Windows 10
# Usage: Run as Administrator in PowerShell

# Configuration
$WAZUH_MANAGER = "10.217.10.53"
$WAZUH_VERSION = "4.14.5-1"

Write-Host "[*] Downloading Wazuh agent..." -ForegroundColor Cyan

Invoke-WebRequest `
  -Uri "https://packages.wazuh.com/4.x/windows/wazuh-agent-$WAZUH_VERSION.msi" `
  -OutFile "$env:tmp\wazuh-agent.msi"

Write-Host "[*] Installing Wazuh agent..." -ForegroundColor Cyan

msiexec.exe /i "$env:tmp\wazuh-agent.msi" /q `
  WAZUH_MANAGER="$WAZUH_MANAGER" `
  WAZUH_AGENT_NAME="$env:COMPUTERNAME"

Write-Host "[*] Starting Wazuh service..." -ForegroundColor Cyan

NET START Wazuh

Write-Host "[+] Wazuh agent installed and running." -ForegroundColor Green
Write-Host "[+] Manager: $WAZUH_MANAGER" -ForegroundColor Green
