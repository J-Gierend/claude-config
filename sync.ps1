# Auto-sync CLAUDE.md to GitHub
# Called by Claude hook after CLAUDE.md changes

$SourceFile = "$env:USERPROFILE\.claude\CLAUDE.md"
$RepoDir = "$env:USERPROFILE\Documents\claude-config"
$TargetFile = "$RepoDir\CLAUDE.md"

# Copy current CLAUDE.md to repo
Copy-Item $SourceFile $TargetFile -Force

Push-Location $RepoDir

# Check if there are changes
$status = git status --porcelain CLAUDE.md 2>$null

if ($status) {
    git add CLAUDE.md
    git commit -m "Auto-sync CLAUDE.md [$(Get-Date -Format 'yyyy-MM-dd HH:mm')]"
    git push origin master 2>$null
}

Pop-Location
