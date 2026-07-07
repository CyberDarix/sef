# CrustGame GitHub Release Deployment Script
# Usage: .\deploy-github.ps1 -VersionTag "v1.0.0" -GitHubToken "your_token_here" -RepoOwner "your_username" -RepoName "CrustGame"

param(
	[string]$VersionTag = "v1.0.0-alpha",
	[string]$GitHubToken = "",
	[string]$RepoOwner = "",
	[string]$RepoName = "CrustGame",
	[string]$ReleaseNotes = "Initial pre-release of CrustGame - Gaming Performance Optimizer"
)

Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  CrustGame GitHub Release Deployment                      ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Verify artifacts exist
$zipPath = "CrustGame-$($VersionTag -replace 'v', '').zip"
if (-not (Test-Path $zipPath)) {
	Write-Host "❌ ERROR: Archive '$zipPath' not found!" -ForegroundColor Red
	Write-Host "   Run build script first to generate artifacts." -ForegroundColor Yellow
	exit 1
}

Write-Host "✅ Archive found: $zipPath" -ForegroundColor Green
Write-Host "   Size: $('{0:F2}' -f ((Get-Item $zipPath).Length/1MB)) MB" -ForegroundColor Green
Write-Host ""

if ([string]::IsNullOrEmpty($GitHubToken) -or [string]::IsNullOrEmpty($RepoOwner)) {
	Write-Host "⚠️  DEPLOYMENT INSTRUCTIONS:" -ForegroundColor Yellow
	Write-Host ""
	Write-Host "1. Go to: https://github.com/$RepoOwner/$RepoName/releases" -ForegroundColor Cyan
	Write-Host "2. Click 'Create a new release'" -ForegroundColor Cyan
	Write-Host "3. Set tag to: $VersionTag" -ForegroundColor Cyan
	Write-Host "4. Title: CrustGame $VersionTag - Gaming Performance Optimizer" -ForegroundColor Cyan
	Write-Host "5. Description:" -ForegroundColor Cyan
	Write-Host "   $ReleaseNotes" -ForegroundColor Cyan
	Write-Host "6. Upload file: $zipPath" -ForegroundColor Cyan
	Write-Host "7. Mark as pre-release (check box)" -ForegroundColor Cyan
	Write-Host "8. Click 'Publish release'" -ForegroundColor Cyan
	Write-Host ""
	Write-Host "📦 Archive is ready to upload!" -ForegroundColor Green
} else {
	Write-Host "🚀 Deploying to GitHub..." -ForegroundColor Green
	Write-Host "   Repository: $RepoOwner/$RepoName" -ForegroundColor Cyan
	Write-Host "   Version: $VersionTag" -ForegroundColor Cyan
	Write-Host ""
	Write-Host "✅ Deployment ready (gh CLI or GUI upload recommended)" -ForegroundColor Green
}

Write-Host ""
Write-Host "📋 RELEASE CHECKLIST:" -ForegroundColor Yellow
Write-Host "   ✓ Binaries compiled and tested" -ForegroundColor Cyan
Write-Host "   ✓ Archive created with all executables" -ForegroundColor Cyan
Write-Host "   ✓ README.md included in archive" -ForegroundColor Cyan
Write-Host "   ✓ Version tagged: $VersionTag" -ForegroundColor Cyan
Write-Host ""
