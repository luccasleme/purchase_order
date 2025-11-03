# Git History Cleanup Script for Windows PowerShell
# Run this from your purchase_order directory

Write-Host "🧹 Git History Cleanup Script (Windows)" -ForegroundColor Cyan
Write-Host "=======================================" -ForegroundColor Cyan
Write-Host ""

# Check if we're in a git repo
if (-not (Test-Path ".git")) {
    Write-Host "❌ Error: Not in a git repository!" -ForegroundColor Red
    Write-Host "Please cd to your purchase_order directory first." -ForegroundColor Yellow
    exit 1
}

# Get current size
Write-Host "📊 Checking current repository size..." -ForegroundColor Yellow
$beforeSize = (Get-ChildItem .git -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
$beforeSizeMB = [math]::Round($beforeSize/1MB, 2)
Write-Host "Current .git size: $beforeSizeMB MB" -ForegroundColor White
Write-Host ""

# Create backup
Write-Host "📦 Creating backup..." -ForegroundColor Yellow
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$backupPath = "..\purchase_order_backup_$timestamp"

try {
    Set-Location ..
    Copy-Item -Recurse -Force purchase_order $backupPath -ErrorAction Stop
    Write-Host "✅ Backup created at: $backupPath" -ForegroundColor Green
    Set-Location purchase_order
} catch {
    Write-Host "❌ Failed to create backup: $_" -ForegroundColor Red
    exit 1
}
Write-Host ""

# Check git status
Write-Host "🔍 Checking git status..." -ForegroundColor Yellow
$gitStatus = git status --porcelain
if ($gitStatus) {
    Write-Host "⚠️  Warning: You have uncommitted changes!" -ForegroundColor Yellow
    Write-Host $gitStatus
    $response = Read-Host "Continue anyway? (y/N)"
    if ($response -ne "y") {
        Write-Host "Aborted." -ForegroundColor Red
        exit 1
    }
}
Write-Host ""

# Remove gradle cache
Write-Host "🗑️  Removing gradle cache from tracking..." -ForegroundColor Yellow
$gradleFiles = git ls-files android/.gradle/ 2>$null
if ($gradleFiles) {
    git rm -r --cached android/.gradle/ 2>$null
    if ($?) {
        Write-Host "✅ Removed gradle cache from git" -ForegroundColor Green
    }
} else {
    Write-Host "ℹ️  No gradle cache in git" -ForegroundColor Gray
}
Write-Host ""

# Remove .idea
Write-Host "🗑️  Removing .idea folder from tracking..." -ForegroundColor Yellow
$ideaFiles = git ls-files .idea/ 2>$null
if ($ideaFiles) {
    git rm -r --cached .idea/ 2>$null
    if ($?) {
        Write-Host "✅ Removed .idea from git" -ForegroundColor Green
    }
} else {
    Write-Host "ℹ️  No .idea folder in git" -ForegroundColor Gray
}
Write-Host ""

# Remove .DS_Store
Write-Host "🗑️  Removing .DS_Store files from tracking..." -ForegroundColor Yellow
$dsFiles = git ls-files | Select-String ".DS_Store"
if ($dsFiles) {
    $dsFiles | ForEach-Object { git rm --cached $_ 2>$null }
    Write-Host "✅ Removed .DS_Store files" -ForegroundColor Green
} else {
    Write-Host "ℹ️  No .DS_Store files in git" -ForegroundColor Gray
}
Write-Host ""

# Update .gitignore
Write-Host "📝 Updating .gitignore..." -ForegroundColor Yellow
$ignoreContent = Get-Content .gitignore -Raw

$needsUpdate = $false
if ($ignoreContent -notmatch "android/\.gradle/") {
    Add-Content -Path .gitignore -Value "`nandroid/.gradle/"
    $needsUpdate = $true
}
if ($ignoreContent -notmatch "^\.idea/") {
    Add-Content -Path .gitignore -Value ".idea/"
    $needsUpdate = $true
}

if ($needsUpdate) {
    Write-Host "✅ Updated .gitignore" -ForegroundColor Green
} else {
    Write-Host "ℹ️  .gitignore already up to date" -ForegroundColor Gray
}
Write-Host ""

# Commit changes
Write-Host "💾 Committing changes..." -ForegroundColor Yellow
$staged = git diff --cached --quiet
if (-not $?) {
    git add .gitignore
    git commit -m "chore: remove build artifacts and update gitignore"
    Write-Host "✅ Changes committed" -ForegroundColor Green
} else {
    Write-Host "ℹ️  No changes to commit" -ForegroundColor Gray
}
Write-Host ""

# Final size check
Write-Host "📊 Checking new size..." -ForegroundColor Yellow
$afterSize = (Get-ChildItem .git -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum).Sum
$afterSizeMB = [math]::Round($afterSize/1MB, 2)
$saved = [math]::Round(($beforeSize - $afterSize)/1MB, 2)
Write-Host "New .git size: $afterSizeMB MB (saved: $saved MB)" -ForegroundColor White
Write-Host ""

# Show large files in history
Write-Host "🔍 Top 10 largest files still in history:" -ForegroundColor Yellow
git rev-list --objects --all | `
    git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' | `
    Select-String "^blob" | `
    ForEach-Object {
        $parts = $_ -split '\s+', 4
        [PSCustomObject]@{
            Size = [math]::Round([int]$parts[2]/1MB, 2)
            File = $parts[3]
        }
    } | Sort-Object -Property Size -Descending | Select-Object -First 10 | Format-Table -AutoSize

Write-Host ""
Write-Host "✅ Basic cleanup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "⚠️  IMPORTANT: This only removed files from tracking." -ForegroundColor Yellow
Write-Host "   To fully clean history (reduce from $beforeSizeMB MB to ~5-10 MB):" -ForegroundColor Yellow
Write-Host ""
Write-Host "Next steps for full cleanup:" -ForegroundColor Cyan
Write-Host "1. Download BFG:" -ForegroundColor White
Write-Host "   Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/com/madgag/bfg/1.14.0/bfg-1.14.0.jar' -OutFile bfg.jar" -ForegroundColor Gray
Write-Host ""
Write-Host "2. Go to parent directory and run:" -ForegroundColor White
Write-Host "   cd .." -ForegroundColor Gray
Write-Host "   java -jar bfg.jar --delete-files '*.apk' purchase_order" -ForegroundColor Gray
Write-Host "   java -jar bfg.jar --delete-files '*.aab' purchase_order" -ForegroundColor Gray
Write-Host "   java -jar bfg.jar --delete-files '*.dill' purchase_order" -ForegroundColor Gray
Write-Host ""
Write-Host "3. Return and finalize:" -ForegroundColor White
Write-Host "   cd purchase_order" -ForegroundColor Gray
Write-Host "   git reflog expire --expire=now --all" -ForegroundColor Gray
Write-Host "   git gc --prune=now --aggressive" -ForegroundColor Gray
Write-Host ""
Write-Host "💾 Backup saved at: $backupPath" -ForegroundColor Cyan
Write-Host ""
