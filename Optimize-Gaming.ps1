# Optimize-Gaming.ps1 - Main Gaming Optimization Script
# PowerShell 7% - System optimization automation

param(
	[Parameter(Mandatory=$false)]
	[ValidateSet("Enable", "Disable", "Status")]
	[string]$Action = "Status"
)

# Requires Administrator
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Write-Error "This script requires Administrator privileges"
	exit 1
}

Write-Host "CrustGame - Gaming Optimization Script" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Green

function Enable-GamingOptimization {
	Write-Host "`n[*] Enabling Gaming Optimization..." -ForegroundColor Yellow

	# 1. Disable Windows Update during gaming
	Write-Host "  → Suspending Windows Update Service..."
	Stop-Service -Name "wuauserv" -Force -ErrorAction SilentlyContinue

	# 2. Disable Visual Themes for performance
	Write-Host "  → Disabling Visual Themes..."
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 0 /f | Out-Null

	# 3. Maximize cache size
	Write-Host "  → Optimizing CPU Cache..."
	reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v "IoPageLockLimit" /t REG_DWORD /d 0x00400000 /f | Out-Null

	# 4. Disable unnecessary background services
	Write-Host "  → Disabling Background Services..."
	$servicesToDisable = @("DiagTrack", "dmwappushservice", "WSearch")
	foreach ($service in $servicesToDisable) {
		Stop-Service -Name $service -Force -ErrorAction SilentlyContinue
		Set-Service -Name $service -StartupType Disabled -ErrorAction SilentlyContinue
	}

	# 5. Set High Performance power plan
	Write-Host "  → Setting High Performance Power Plan..."
	$powerPlan = Get-WmiObject -Class Win32_PowerPlan -Namespace "root\cimv2\power" -Filter "ElementName='High performance'"
	if ($powerPlan) {
		Invoke-WmiMethod -Path $powerPlan.path -Name Activate | Out-Null
	}

	# 6. Enable Game Mode (Windows 10+)
	Write-Host "  → Enabling Game Mode..."
	reg add "HKCU\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 1 /f | Out-Null

	Write-Host "✅ Gaming Optimization Enabled!" -ForegroundColor Green
}

function Disable-GamingOptimization {
	Write-Host "`n[*] Disabling Gaming Optimization..." -ForegroundColor Yellow

	Write-Host "  → Restoring Windows Services..."
	Start-Service -Name "wuauserv" -ErrorAction SilentlyContinue

	Write-Host "  → Restoring Visual Themes..."
	reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v "AppsUseLightTheme" /t REG_DWORD /d 1 /f | Out-Null

	Write-Host "✅ Gaming Optimization Disabled!" -ForegroundColor Green
}

function Get-OptimizationStatus {
	Write-Host "`n[*] Gaming Optimization Status:" -ForegroundColor Yellow

	$wuStatus = (Get-Service -Name "wuauserv" -ErrorAction SilentlyContinue).Status
	Write-Host "  Windows Update: $wuStatus"

	$gameModeReg = (Get-ItemProperty -Path "HKCU\Software\Microsoft\GameBar" -Name "AllowAutoGameMode" -ErrorAction SilentlyContinue).AllowAutoGameMode
	Write-Host "  Game Mode: $(if ($gameModeReg -eq 1) { 'Enabled' } else { 'Disabled' })"

	$powerPlan = (Get-WmiObject -Class Win32_PowerPlan -Namespace "root\cimv2\power" -Filter "IsActive=true" -ErrorAction SilentlyContinue).ElementName
	Write-Host "  Power Plan: $powerPlan"
}

# Main execution
switch ($Action) {
	"Enable" { Enable-GamingOptimization }
	"Disable" { Disable-GamingOptimization }
	"Status" { Get-OptimizationStatus }
	default { Write-Host "Invalid action: $Action" -ForegroundColor Red }
}

Write-Host "`n[✓] Operation completed." -ForegroundColor Green
