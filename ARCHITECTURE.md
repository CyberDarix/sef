# ARCHITECTURE.md - CrustGame System Architecture

## 🎯 Vue d'ensemble

CrustGame est un utilitaire d'optimisation système pour jeux vidéo Windows, conçu avec une architecture modulaire hybrid multi-langage pour maximiser les performances et minimiser la latence.

## 📊 Architecture Générale

```
┌─────────────────────────────────────────────────────────────────┐
│                     CrustGame Ecosystem                         │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌───────────────────┐      ┌──────────────────────────────┐  │
│  │   CrustUI (C#)    │      │  CrustCore (C++ 50%)         │  │
│  │   WPF Interface   │◄────►│  • Service principal          │  │
│  │   • Monitoring    │      │  • Windows optimization       │  │
│  │   • Controls      │      │  • Driver communication       │  │
│  └───────────────────┘      └──────────────────────────────┘  │
│          ▲                            ▲                         │
│          │                            │                         │
│          └────────────┬───────────────┘                         │
│                       │                                         │
│           ┌───────────▼─────────────┐                          │
│           │  CrustWatchdog (Rust)   │                          │
│           │  • System monitoring    │                          │
│           │  • Auto-recovery        │                          │
│           │  • Memory safety        │                          │
│           └───────────┬─────────────┘                          │
│                       │                                         │
│          ┌────────────┼────────────┐                           │
│          ▼            ▼            ▼                           │
│    ┌─────────┐  ┌──────────┐  ┌──────────┐                    │
│    │Assembly │  │ Fortran  │  │PowerShell│                    │
│    │(2%)     │  │ (1%)     │  │(7%)      │                    │
│    │Hot Path │  │Predictor │  │Scripts   │                    │
│    └─────────┘  └──────────┘  └──────────┘                    │
│                                                                 │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │             Windows Kernel / System                       │  │
│  │  • CPU Scheduler  • Memory Manager  • Device Drivers     │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## 🏗️ Structure des Composants

### **1. CrustCore (C++ - 50%)**
**Localisation** : `src/CrustCore/cpp/`

**Responsabilités** :
- Service Windows principal (NT Service)
- Communication avec les drivers kernel
- Orchestration des optimisations
- Gestion CPU/RAM/GPU

**Modules clés** :
- `ServiceManager.cpp` : Gestion du service Windows
- `OptimizationEngine.cpp` : Logique d'optimisation
- `DriverInterface.cpp` : Communication driver
- `ConfigManager.cpp` : Gestion configuration

**Technologies** :
- Windows API (SetThreadAffinityMask, SetPriorityClass)
- Performance Monitor API
- WMI pour monitoring système

---

### **2. CrustUI (C# - 25%)**
**Localisation** : `src/CrustUI/csharp/`

**Responsabilités** :
- Interface utilisateur WPF minimaliste
- Monitoring temps réel (graphiques)
- Contrôle du service via IPC
- Affichage des métriques

**Modules clés** :
- `MainWindow.xaml` : UI principale
- `ServiceClient.cs` : Communication avec CrustCore
- `MetricsViewModel.cs` : Données métriques
- `SettingsWindow.xaml` : Configuration

**Design** :
- Consomme 0% CPU en veille
- Tray icon avec quick-toggle
- Logs en temps réel

---

### **3. CrustWatchdog (Rust - 15%)**
**Localisation** : `src/CrustWatchdog/rust/`

**Responsabilités** :
- Surveillance continue du système
- Détection d'anomalies
- Auto-recovery en cas d'instabilité
- Sécurité mémoire garantie

**Modules clés** :
- `main.rs` : Point d'entrée watchdog
- `monitor.rs` : Boucle de monitoring
- `recovery.rs` : Procédures de récupération
- `ipc_bridge.rs` : Communication inter-processus

**Garanties Rust** :
- Pas de null pointers
- Pas de buffer overflow
- Gestion sécurisée des ressources

---

### **4. CrustOptimizer (Assembly x64 - 2%)**
**Localisation** : `src/CrustOptimizer/assembly/`

**Responsabilités** :
- Routines ultra-critiques (hot paths)
- Mesures microseconde
- Optimisation cycle CPU

**Modules clés** :
- `Latency.asm` : Mesure latence DPC
- `CPUAffinity.asm` : Isolation CPU rapide
- `TimerInterrupt.asm` : Synchronisation timer

---

### **5. CrustPredictor (Fortran - 1%)**
**Localisation** : `src/CrustPredictor/fortran/`

**Responsabilités** :
- Moteur prédictif de charge
- Prévision CPU/RAM utilization
- Algorithmes calcul haute-perf

**Modules clés** :
- `predictor.f90` : Module de prédiction
- `memory_analyzer.f90` : Analyse mémoire
- `load_balancer.f90` : Équilibrage charge

**Compilation** :
- Intel Fortran Compiler ou Gfortran
- Liée en statique au CrustCore

---

### **6. CrustScripts (PowerShell - 7%)**
**Localisation** : `src/CrustScripts/powershell/`

**Responsabilités** :
- Optimisations Windows officielles
- Modification registry sécurisées
- Post-build events
- Installation/Uninstallation

**Scripts clés** :
- `Optimize-Gaming.ps1` : Optimization main
- `Enable-TestSigning.ps1` : Mode test signing
- `Reset-Defaults.ps1` : Restauration
- `Install-Service.ps1` : Installation service

---

## 🔄 Flux de Communication

```
User (CrustUI)
	 │
	 ▼
   IPC Named Pipe
	 │
	 ▼
CrustCore (C++ Service)
	 │
	 ├─► CrustWatchdog (Rust Monitor)
	 │     │
	 │     └─► System Metrics
	 │
	 ├─► Assembly Routines (Hot Path)
	 │
	 ├─► Fortran Predictor (Calculations)
	 │
	 └─► PowerShell Scripts (System Ops)
```

---

## 📦 Dépendances Externes

| Composant | Dépendances |
|-----------|------------|
| **C++** | Windows SDK, WDK (optionnel) |
| **C#** | .NET 6+, WPF |
| **Rust** | Cargo, tokio |
| **Fortran** | Intel Fortran / Gfortran |
| **Assembly** | MASM (ML64.exe) |
| **PowerShell** | Windows PowerShell 5.1+ |

---

## 🔐 Sécurité & Stabilité

### Principes appliqués :

1. **No-Cheat Philosophy**
   - Aucune injection mémoire dans les processus jeu
   - Zéro interaction avec les anti-cheat

2. **Watchdog Safety**
   - Surveillance < 500ms
   - Auto-rollback en cas d'anomalie
   - Pas de BSOD possible

3. **Code Integrity**
   - Tous les binaires vérifiés cryptographiquement
   - Versions trackées
   - Rollback automatique

4. **User-Mode Operations** (recommandé)
   - Privilèges administrateur seulement
   - Pas de driver kernel signé requis
   - Compliant avec Windows Secure Boot

---

## 🚀 Flux d'Utilisation

### Mode Gaming (One-Click)

```
1. User clicks "Gaming Mode ON" in CrustUI
   │
   ▼
2. CrustCore reçoit commande
   │
   ▼
3. Exécute PowerShell scripts (optimisations)
   │
   ├─► CPU Affinity Set
   ├─► RAM Standby Cleanup
   ├─► GPU Frequency Lock
   └─► DPC Latency Monitor
   │
   ▼
4. CrustWatchdog commence monitoring
   │
   ▼
5. CrustUI affiche métriques temps réel
   │
   ▼
6. Game launched - optimizations active
```

---

## 📊 Métriques Disponibles

- **CPU** : Température, Usage, Affinity Status
- **RAM** : Standby Size, Free Memory, Pressure
- **GPU** : VRAM Usage, Throttling Status, Frequency
- **Latency** : DPC Latency, Context Switches, IRQ Timing
- **Stability** : System Health Score, Crash Risk

---

## 🔧 Build Configuration

### Visual Studio 2026 Configuration :

```
Solution
├── CrustCore.vcxproj (C++)
│   ├── Platform: x64
│   ├── Configuration: Debug/Release
│   └── Dependencies: Assembly + Fortran libs
│
├── CrustUI.csproj (C#)
│   ├── Target Framework: .NET 6
│   └── Dependencies: CrustCore via IPC
│
└── CrustWatchdog.csproj (Rust via cargo)
	└── Dependencies: tokio, interprocess
```

---

## 📝 Version & Updates

**Current Version**: 1.0.0-alpha
**Status**: Active Development
**License**: Open Source (MIT/GPL - TBD)

---

## 🔗 References

- Windows Driver Kit (WDK) : https://docs.microsoft.com/en-us/windows-hardware/drivers/
- Rust Safety : https://doc.rust-lang.org/book/
- Performance Tuning : https://docs.microsoft.com/en-us/windows/win32/perfctrs/
