# Claude Config Installer - Windows PowerShell
# Usage: .\install.ps1

$ErrorActionPreference = "Stop"

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ClaudeDir = "$env:USERPROFILE\.claude"
$BootstrapDir = "$env:USERPROFILE\.claude-bootstrap"

Write-Host "[INSTALL] Claude Config Installer" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan

# Create .claude directory if not exists
if (-not (Test-Path $ClaudeDir)) {
    Write-Host "[OK] Creating $ClaudeDir" -ForegroundColor Green
    New-Item -ItemType Directory -Path $ClaudeDir -Force | Out-Null
}

# Backup existing CLAUDE.md if present
if (Test-Path "$ClaudeDir\CLAUDE.md") {
    $Backup = "$ClaudeDir\CLAUDE.md.backup.$(Get-Date -Format 'yyyyMMdd_HHmmss')"
    Write-Host "[WARN] Existing CLAUDE.md found, backing up to $Backup" -ForegroundColor Yellow
    Copy-Item "$ClaudeDir\CLAUDE.md" $Backup
}

# Copy CLAUDE.md
Write-Host "[OK] Installing CLAUDE.md to $ClaudeDir" -ForegroundColor Green
Copy-Item "$ScriptDir\CLAUDE.md" "$ClaudeDir\CLAUDE.md" -Force

# Clone claude-bootstrap if not exists
if (-not (Test-Path $BootstrapDir)) {
    Write-Host "[OK] Cloning claude-bootstrap framework..." -ForegroundColor Green
    git clone https://github.com/alinaqi/claude-bootstrap.git $BootstrapDir
} else {
    Write-Host "[OK] claude-bootstrap already installed, updating..." -ForegroundColor Green
    Push-Location $BootstrapDir
    git pull
    Pop-Location
}

# Create .env template if not exists
if (-not (Test-Path "$ClaudeDir\.env")) {
    Write-Host "[OK] Creating .env template" -ForegroundColor Green
    @"
# Email Configuration (optional)
EMAIL_ADDRESS=your-email@example.com
EMAIL_APP_PASSWORD=your-app-password
"@ | Out-File -FilePath "$ClaudeDir\.env" -Encoding UTF8
    Write-Host "[WARN] Edit $ClaudeDir\.env with your credentials" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[DONE] Installation complete!" -ForegroundColor Green
Write-Host "  - CLAUDE.md: $ClaudeDir\CLAUDE.md"
Write-Host "  - Bootstrap: $BootstrapDir"
Write-Host ""
