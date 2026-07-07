# Reset-Defaults.ps1 - Restore System to Default State

param()

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Write-Error "This script requires Administrator privileges"
	exit 1
}

Write-Host "CrustGame - System Reset to Defaults" -ForegroundColor Yellow
Write-Host "====================================`n" -ForegroundColor Yellow

$confirm = Read-Host "Are you sure you want to reset all settings? (yes/no)"
if ($confirm -ne "yes") {
	Write-Host "Operation cancelled." -ForegroundColor Gray
	exit 0
}

Write-Host "`n[*] Restoring system defaults..." -ForegroundColor Yellow

# 1. Re-enable Windows Update
Write-Host "  → Re-enabling Windows Update..."
Start-Service -Name "wuauserv" -ErrorAction SilentlyContinue
Set-Service -Name "wuauserv" -StartupType Automatic -ErrorAction SilentlyContinue

# 2. Restore Visual Themes
Write-Host "  → Restoring Visual Themes..."
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f | Out-Null

# 3. Re-enable background services
Write-Host "  → Re-enabling Background Services..."
$servicesToEnable = @("DiagTrack", "WSearch")
foreach ($service in $servicesToEnable) {
	Set-Service -Name $service -StartupType Automatic -ErrorAction SilentlyContinue
	Start-Service -Name $service -ErrorAction SilentlyContinue
}

# 4. Reset power plan to Balanced
Write-Host "  → Resetting Power Plan to Balanced..."
$balancedPlan = Get-WmiObject -Class Win32_PowerPlan -Namespace "root\cimv2\power" -Filter "ElementName='Balanced'"
if ($balancedPlan) {
	Invoke-WmiMethod -Path $balancedPlan.path -Name Activate | Out-Null
}

Write-Host "`n✅ System reset to defaults successfully!" -ForegroundColor Green
