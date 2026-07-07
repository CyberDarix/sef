# Enable-TestSigning.ps1 - Enable Windows Test Signing Mode
# Required for unsigned driver loading during development

param(
	[Parameter(Mandatory=$false)]
	[ValidateSet("Enable", "Disable")]
	[string]$Action = "Enable"
)

if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Write-Error "This script requires Administrator privileges"
	exit 1
}

function Enable-TestSigning {
	Write-Host "Enabling Windows Test Signing Mode..." -ForegroundColor Yellow
	Write-Host "⚠️  Warning: This is for development only!" -ForegroundColor Red

	& bcdedit /set testsigning on

	if ($LASTEXITCODE -eq 0) {
		Write-Host "✅ Test Signing enabled. System will restart to apply changes." -ForegroundColor Green
		Write-Host "Restarting in 30 seconds... (Press Ctrl+C to cancel)" -ForegroundColor Yellow
		Start-Sleep -Seconds 30
		Restart-Computer
	} else {
		Write-Host "❌ Failed to enable Test Signing" -ForegroundColor Red
	}
}

function Disable-TestSigning {
	Write-Host "Disabling Windows Test Signing Mode..." -ForegroundColor Yellow

	& bcdedit /set testsigning off

	if ($LASTEXITCODE -eq 0) {
		Write-Host "✅ Test Signing disabled. System will restart to apply changes." -ForegroundColor Green
		Write-Host "Restarting in 30 seconds... (Press Ctrl+C to cancel)" -ForegroundColor Yellow
		Start-Sleep -Seconds 30
		Restart-Computer
	} else {
		Write-Host "❌ Failed to disable Test Signing" -ForegroundColor Red
	}
}

switch ($Action) {
	"Enable" { Enable-TestSigning }
	"Disable" { Disable-TestSigning }
}
