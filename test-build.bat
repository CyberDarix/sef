@echo off
REM CrustGame Quick Test Script
REM Tests the compiled executables

color 0A
cls

echo.
echo ╔═══════════════════════════════════════════════════════════╗
echo ║          CrustGame v1.0.0-alpha - Test Suite             ║
echo ╚═══════════════════════════════════════════════════════════╝
echo.

echo [*] Checking executables...
echo.

if exist "bin\Release\CrustUI.exe" (
	echo [✓] CrustUI.exe found
	for %%A in (bin\Release\CrustUI.exe) do (
		echo     Size: %%~zA bytes
	)
) else (
	echo [✗] CrustUI.exe NOT FOUND
)

if exist "bin\Release\CrustWatchdog.exe" (
	echo [✓] CrustWatchdog.exe found
	for %%A in (bin\Release\CrustWatchdog.exe) do (
		echo     Size: %%~zA bytes
	)
) else (
	echo [✗] CrustWatchdog.exe NOT FOUND
)

echo.
echo [*] Testing CrustWatchdog (5 second sample)...
echo.
timeout /t 1 /nobreak

bin\Release\CrustWatchdog.exe > nul 2>&1 &
timeout /t 5 /nobreak
taskkill /IM CrustWatchdog.exe /F > nul 2>&1

echo.
echo [✓] Tests complete!
echo.
echo [*] To launch CrustUI GUI:
echo     bin\Release\CrustUI.exe
echo.
pause
