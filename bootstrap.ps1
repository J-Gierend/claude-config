# One-liner bootstrap for claude-config
# Usage: iwr -useb https://raw.githubusercontent.com/J-Gierend/claude-config/master/bootstrap.ps1 | iex

$ErrorActionPreference = "Stop"

$RepoDir = "$env:USERPROFILE\Documents\claude-config"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "[BOOTSTRAP] Claude Code + Config" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Step 1: Install Claude Code CLI if not present
$claudeCmd = Get-Command claude -ErrorAction SilentlyContinue
if ($claudeCmd) {
    $version = & claude --version 2>$null
    Write-Host "[OK] Claude Code CLI already installed: $version" -ForegroundColor Green
} else {
    Write-Host "[INSTALL] Installing Claude Code CLI..." -ForegroundColor Yellow
    irm https://claude.ai/install.ps1 | iex
    Write-Host "[OK] Claude Code CLI installed" -ForegroundColor Green

    # Refresh PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
}

# Step 2: Check git
$gitCmd = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitCmd) {
    Write-Host "[FAIL] Git is not installed. Please install Git from https://git-scm.com/download/win" -ForegroundColor Red
    exit 1
}

# Step 3: Clone or update config repo
if (-not (Test-Path "$env:USERPROFILE\Documents")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\Documents" -Force | Out-Null
}

if (Test-Path $RepoDir) {
    Write-Host "[OK] Updating existing config..." -ForegroundColor Green
    Push-Location $RepoDir
    git pull
    Pop-Location
} else {
    Write-Host "[OK] Cloning claude-config..." -ForegroundColor Green
    git clone https://github.com/J-Gierend/claude-config.git $RepoDir
}

# Step 4: Run installer
Push-Location $RepoDir
& .\install.ps1
Pop-Location

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "[DONE] Claude Code ready to use!" -ForegroundColor Green
Write-Host "  Run: claude" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
