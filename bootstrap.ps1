# One-liner bootstrap for claude-config
# Usage: iwr -useb https://raw.githubusercontent.com/J-Gierend/claude-config/master/bootstrap.ps1 | iex

$ErrorActionPreference = "Stop"

$RepoDir = "$env:USERPROFILE\Documents\claude-config"

Write-Host "[BOOTSTRAP] Claude Config" -ForegroundColor Cyan

# Create Documents if not exists
if (-not (Test-Path "$env:USERPROFILE\Documents")) {
    New-Item -ItemType Directory -Path "$env:USERPROFILE\Documents" -Force | Out-Null
}

# Clone or update repo
if (Test-Path $RepoDir) {
    Write-Host "[OK] Updating existing installation..." -ForegroundColor Green
    Push-Location $RepoDir
    git pull
    Pop-Location
} else {
    Write-Host "[OK] Cloning claude-config..." -ForegroundColor Green
    git clone https://github.com/J-Gierend/claude-config.git $RepoDir
}

# Run installer
Push-Location $RepoDir
& .\install.ps1
Pop-Location
