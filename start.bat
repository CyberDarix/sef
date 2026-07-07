@echo off
REM ============================================================================
REM CrustGame - Gaming Performance Optimizer
REM Quick Start Script pour Windows
REM ============================================================================

title CrustGame v1.0.0-alpha Launcher
color 0A
cls

echo.
echo ╔═══════════════════════════════════════════════════════════════════════════╗
echo ║                                                                           ║
echo ║                    CrustGame v1.0.0-alpha Launcher                       ║
echo ║                  Extreme Gaming Performance Optimizer                     ║
echo ║                                                                           ║
echo ╚═══════════════════════════════════════════════════════════════════════════╝
echo.

REM Vérifier si CrustUI.exe existe
if not exist "CrustUI.exe" (
	color 0C
	echo.
	echo ✗ ERREUR: CrustUI.exe not found!
	echo.
	echo   Make sure you're in the correct directory where CrustUI.exe is located.
	echo.
	pause
	exit /b 1
)

REM Vérifier .NET Runtime
echo [*] Vérification du .NET Runtime...
dotnet --version > nul 2>&1

if errorlevel 1 (
	color 0C
	echo.
	echo ✗ ERREUR: .NET Runtime not found!
	echo.
	echo   CrustGame nécessite .NET 6.0 Runtime pour fonctionner.
	echo.
	echo   SOLUTION:
	echo   1. Ouvre: https://dotnet.microsoft.com/download/dotnet/6.0
	echo   2. Télécharge: "Run apps - .NET Desktop Runtime 6.0"
	echo   3. Installe-le
	echo   4. Redémarre ce script
	echo.
	echo   Appuie sur une touche pour ouvrir le navigateur...
	pause

	REM Ouvrir le lien dans le navigateur
	start https://dotnet.microsoft.com/download/dotnet/6.0
	exit /b 1
)

color 0A
echo [✓] .NET Runtime trouvé!
echo.
echo [*] Lancement de CrustUI.exe...
echo.

REM Lancer CrustUI.exe
start CrustUI.exe

REM Attendre un peu pour le lancement
timeout /t 2 /nobreak

echo.
echo ✓ CrustUI est en cours de lancement...
echo.
echo [?] Si rien ne s'affiche, vérifi que .NET 6.0 est installé.
echo.
pause
