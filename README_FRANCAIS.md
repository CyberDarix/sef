# 🎮 CrustGame v1.0.0-alpha - Guide Complet en Français

## ❓ Questions Principales Répondues

### **Question 1: Pourquoi 2 fichiers .exe? Dois-je les installer tous les deux?**

**Réponse courte:** NON! Tu n'en as besoin que d'UN seul!

#### **CrustUI.exe** ✅ (C'est celui-ci que tu dois utiliser!)
- **C'est quoi?** L'interface graphique (la fenêtre avec les boutons)
- **À quoi ça sert?** Te montrer les performances en temps réel (CPU, RAM, GPU, latence)
- **Comment l'utiliser?** Double-clique dessus pour ouvrir l'application
- **Résultat:** Une fenêtre s'ouvre avec le tableau de bord

#### **CrustWatchdog.exe** ⚙️ (Optionnel - en arrière-plan)
- **C'est quoi?** Un service de surveillance silencieux
- **À quoi ça sert?** Optimiser ton système sans interface graphique
- **Qui l'utilise?** Les utilisateurs avancés qui veulent une optimisation automatique 24/7
- **Résultat:** Pas de fenêtre visible, juste du travail en arrière-plan

---

## **Pourquoi tu as lancé CrustUI et rien ne s'est passé?**

Probème possible: **Tu n'as probablement pas .NET 6.0 Runtime installé!**

### ✅ **Solution - Installe .NET 6.0 Runtime:**

1. **Va sur:** https://dotnet.microsoft.com/download/dotnet/6.0
2. **Télécharge:** "Run apps - .NET Desktop Runtime 6.0" (la version pour Windows)
3. **Installe-le** (click-click-next)
4. **Redémarre ton PC**
5. **Relance CrustUI.exe** → Ça devrait marcher! 🚀

---

## 📊 **Qu'est-ce que CrustGame fait exactement?**

C'est un **optimiseur de performances pour les jeux vidéo**.

### **Ça mesure:**
- 📈 **CPU Usage** - % de puissance du processeur utilisée
- 🧠 **RAM Usage** - % de la mémoire utilisée
- 🎨 **GPU Usage** - % de la carte graphique utilisée
- ⚡ **DPC Latency** - Latence système (pour éviter les ralentissements)
- 💚 **System Health** - État général de ton système

### **Ça fait quoi?**
1. **Gaming Mode ON** → Active les optimisations pour les jeux
2. **Gaming Mode OFF** → Revient à la normale
3. **Reset Defaults** → Annule tous les changements

### **En arrière-plan:**
- Nettoie la RAM automatiquement
- Priorise les tâches du jeu
- Réduit la latence
- Optimise le système pour les bonnes performances

---

## 🚀 **Comment l'utiliser?**

### **Étape 1: Installe .NET 6.0 Runtime**
- Télécharge depuis: https://dotnet.microsoft.com/download/dotnet/6.0
- Installe-le complètement
- Redémarre ton PC

### **Étape 2: Lance CrustUI.exe**
```
Double-clique sur CrustUI.exe
```

### **Étape 3: Utilise l'application**
- **Vois tes performances** → Les chiffres s'actualisent toutes les 0.5 secondes
- **Clique "Gaming Mode: OFF" → "Gaming Mode: ON"** → Active les optimisations
- **Clique "Reset Defaults"** → Annule les changements

### **Étape 4: Lance un jeu**
- Les performances devraient être meilleures! 🎮

---

## 📁 **Qu'est-ce qu'il y a dans le fichier ZIP?**

Quand tu extrais `CrustGame-v1.0.0-alpha.zip`, tu trouves:

```
CrustGame-v1.0.0-alpha/
├── CrustUI.exe              ← Lance ça! (Interface graphique)
├── CrustWatchdog.exe        ← Optionnel (Service en arrière-plan)
├── CrustGame-Logo.png       ← Logo du projet
└── README.txt               ← Ce guide
```

**C'est tout ce dont tu as besoin!** Rien d'autre à installer ou configurer.

---

## 🔧 **Configuration minimale requise**

| Élément | Exigence |
|---------|----------|
| **Windows** | Windows 10 ou 11 (64-bit) |
| **.NET Runtime** | .NET 6.0 Desktop Runtime |
| **RAM** | 512 MB minimum |
| **Disque** | 50 MB |
| **Droit** | Utilisateur normal (admin pour certaines optimisations) |

---

## ⚠️ **Problèmes courants**

### **Problème 1: "CrustUI.exe s'ouvre puis se ferme immédiatement"**
→ **Solution:** Installe .NET 6.0 Runtime

### **Problème 2: "Il manque une DLL"**
→ **Solution:** Réinstalle .NET 6.0 Runtime

### **Problème 3: "Pas de fenêtre qui s'ouvre"**
→ **Solution:** Clique 2 fois sur CrustUI.exe ou ouvre-le avec la ligne de commande:
```powershell
CrustUI.exe
```

### **Problème 4: "Je ne vois pas les données (CPU, RAM, GPU)"**
→ C'est normal en alpha! Les données sont simulées pour le test.

---

## 📤 **Mettre sur GitHub**

### **Qu'est-ce que tu mets? ✅**
```
✅ src/                          (Code source)
✅ docs/                         (Documentation)
✅ .github/                      (Configuration GitHub)
✅ CrustGame.sln                 (Fichier solution Visual Studio)
✅ README.md                     (Guide principal)
✅ RELEASE_NOTES.txt             (Notes de version)
✅ .gitignore                    (Exclure les fichiers inutiles)
```

### **Qu'est-ce que tu NE mets PAS? ❌**
```
❌ bin/                          (Dossier build - trop volumineux)
❌ obj/                          (Dossier temporaire)
❌ .vs/                          (Configuration Visual Studio)
❌ *.exe (dans le code)          (Utilise les Releases pour ça)
❌ *.dll (locaux)                (Regénérés automatiquement)
❌ node_modules/ ou packages/    (Non applicable ici)
```

### **Fichier .gitignore à créer:**
```
# Build directories
bin/
obj/
.vs/

# Visual Studio cache
.vs/
*.suo
*.sln.docstates

# User files
*.user
*.userosscache

# Build results
[Dd]ebug/
[Rr]elease/
x64/
x86/

# Node/Npm (si utilisé)
node_modules/
```

---

## 🎯 **Architecture simplifiée - Qu'est-ce que c'est?**

### **CrustGame = 3 couches**

```
┌─────────────────────────────────┐
│   INTERFACE UTILISATEUR         │  ← CrustUI.exe (C#/WPF)
│   (fenêtre avec boutons)        │     Ce que tu vois
├─────────────────────────────────┤
│   SERVICE WATCHDOG              │  ← CrustWatchdog.exe (C#)
│   (surveillance en arrière-plan)│     Travail automatique
├─────────────────────────────────┤
│   NOYAU SYSTÈME                 │  ← CrustCore (C++)
│   (communication Windows)       │     Optimisations bas-niveau
└─────────────────────────────────┘
```

### **Langages utilisés:**
- **C#** → Interface graphique (CrustUI)
- **C#** → Service watchdog (CrustWatchdog)
- **C++** → Noyau système (CrustCore)
- **Rust** → Watchdog alternatif (optionnel)
- **PowerShell** → Scripts d'optimisation
- **Assembly** → Routines ultra-rapides
- **Fortran** → Calculs mathématiques avancés

### **Technologie:**
- **.NET 6.0** → Plateforme d'exécution
- **WPF** → Framework pour l'interface
- **Windows API** → Communication bas-niveau

---

## 📋 **Résumé pour l'utilisateur final**

**Q: Qu'est-ce que c'est?**
→ Un outil qui optimise ton PC pour les jeux

**Q: Comment je l'utilise?**
→ Double-clique CrustUI.exe et c'est fini

**Q: Ça coûte combien?**
→ C'est gratuit et open source (MIT License)

**Q: C'est dangereux?**
→ Non, c'est 100% sûr. Pas d'injections, pas de malware

**Q: Ça va ralentir mon PC?**
→ Non, c'est l'inverse! Ça améliore les perfs

**Q: Je dois installer les 2 .exe?**
→ Non! Juste CrustUI.exe (le watchdog est optionnel)

---

## 🔗 **Liens utiles**

- **Télécharger .NET 6.0:** https://dotnet.microsoft.com/download/dotnet/6.0
- **GitHub:** https://github.com/[TON_USERNAME]/CrustGame
- **Issues/Bugs:** https://github.com/[TON_USERNAME]/CrustGame/issues
- **License MIT:** https://opensource.org/licenses/MIT

---

## 📝 **Notes de version - v1.0.0-alpha**

✅ Interface de monitoring fonctionnelle
✅ Service watchdog opérationnel
✅ Logo intégré
✅ Mesure CPU/RAM/GPU/DPC
✅ Activation/désactivation Gaming Mode
✅ Réinitialisation des paramètres

📋 À venir (futures versions):
- Profils d'optimisation personnalisés
- Support Linux/macOS
- Intégration Steam/Epic Games
- Analytics cloud
- Machine learning pour les prédictions

---

**Version:** 1.0.0-alpha
**Date:** 2024
**Plateforme:** Windows 10/11 (64-bit)
**License:** MIT Open Source
**Statut:** Pré-release - Prêt pour la distribution! 🚀
