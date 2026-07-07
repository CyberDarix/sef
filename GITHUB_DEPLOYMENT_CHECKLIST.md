# ✅ Checklist pour publier sur GitHub

## 📋 Avant de pusher le code

### Préparation du dépôt

- [ ] Créer un compte GitHub (https://github.com/signup)
- [ ] Créer un nouveau repository "CrustGame"
- [ ] Initialiser Git en local

```powershell
cd C:\Users\hbdvu\Desktop\CrustGame
git init
git config user.name "Ton Nom"
git config user.email "ton@email.com"
```

### Nettoyage avant push

```powershell
# IMPORTANT: Avant de pusher, nettoie ces dossiers!
Remove-Item "bin" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "obj" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item ".vs" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "src\CrustUI\csharp\obj" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "src\CrustUI\csharp\bin" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "src\CrustWatchdog\obj" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item "src\CrustWatchdog\bin" -Recurse -Force -ErrorAction SilentlyContinue
```

- [ ] Vérifier que .gitignore existe et est correct
- [ ] Vérifier que bin/, obj/, .vs/ ne sont PAS inclus

### Structure du repo - ✅ À inclure

```
✅ DO PUSH:
- src/                    (Code source)
- docs/                   (Documentation)
- .github/                (Workflows CI/CD)
- CrustGame.sln           (Solution Visual Studio)
- README.md               (Guide principal)
- README_FRANCAIS.md      (Guide en français)
- RELEASE_NOTES.txt       (Notes de version)
- .gitignore              (Fichiers ignorés)
- LICENSE                 (Licence MIT)
```

```
❌ DO NOT PUSH:
- bin/                    (Fichiers compilés)
- obj/                    (Fichiers temporaires)
- .vs/                    (Configuration IDE)
- *.exe (dans src/)       (Exécutables locaux)
- *.dll (dans src/)       (Librairies locales)
- *.o, *.obj              (Fichiers objets)
- .vscode/                (Configuration VS Code)
- CrustGame-v1.0.0-alpha.zip (Utilise Releases!)
```

---

## 🚀 Étapes pour publier

### 1️⃣ Initialiser et committer

```powershell
cd C:\Users\hbdvu\Desktop\CrustGame

# Ajouter tous les fichiers
git add .

# Vérifier ce qui va être ajouté
git status

# Commit initial
git commit -m "Initial CrustGame v1.0.0-alpha release - Gaming Performance Optimizer"
```

### 2️⃣ Connecter GitHub

```powershell
# Ajouter le repository distant
git remote add origin https://github.com/[TON_USERNAME]/CrustGame.git

# Renommer main branch si nécessaire
git branch -M main

# Vérifier la connection
git remote -v
```

### 3️⃣ Pusher le code

```powershell
# Premier push (créer main branch sur GitHub)
git push -u origin main

# À partir de là, tu peux faire:
git push
```

### 4️⃣ Créer une Release sur GitHub

1. **Va sur GitHub:** https://github.com/[TON_USERNAME]/CrustGame/releases
2. **Clique:** "Create a new release"
3. **Remplis:**
   - **Tag version:** `v1.0.0-alpha`
   - **Release title:** `CrustGame v1.0.0-alpha - Gaming Performance Optimizer`
   - **Description:** Copie le contenu de RELEASE_NOTES.txt
   - **Upload files:** `CrustGame-v1.0.0-alpha.zip`
   - **Cocher:** "This is a pre-release"
4. **Clique:** "Publish release"

### 5️⃣ Vérifier que tout est bon

- [ ] Repo accessible sur GitHub
- [ ] Code source visible
- [ ] Release téléchargeable
- [ ] ZIP contient: CrustUI.exe, CrustWatchdog.exe, README.txt, Logo
- [ ] README.md s'affiche bien
- [ ] License MIT visible

---

## 📁 Contenu final sur GitHub

```
CrustGame/
├── .github/
│   └── workflows/
│       └── build.yml           ← CI/CD automatique
├── docs/
│   └── ARCHITECTURE.md         ← Docs techniques
├── src/
│   ├── CrustUI/
│   │   ├── csharp/
│   │   │   ├── MainWindow.xaml
│   │   │   ├── MainWindow.xaml.cs
│   │   │   ├── App.xaml
│   │   │   ├── App.xaml.cs
│   │   │   ├── CrustUI.csproj
│   │   │   └── icon.png
│   │   └── ...
│   ├── CrustWatchdog/
│   │   ├── Program.cs
│   │   └── CrustWatchdog.csproj
│   ├── CrustCore/
│   │   ├── cpp/
│   │   │   └── CrustCore.cpp
│   │   └── CrustCore.vcxproj
│   └── ...
├── CrustGame.sln
├── README.md                   ← Guide principal
├── README_FRANCAIS.md          ← Guide en français
├── RELEASE_NOTES.txt           ← Notes de version
├── LICENSE                     ← MIT License
└── .gitignore                  ← Ignore bin/, obj/, etc.
```

---

## 🔒 Fichiers sensibles

| Fichier | Action |
|---------|--------|
| `.env` | ❌ Jamais push (ajouter à .gitignore) |
| `secrets.json` | ❌ Jamais push (ajouter à .gitignore) |
| `*.key` | ❌ Jamais push (ajouter à .gitignore) |
| `personal_config/` | ❌ Jamais push (ajouter à .gitignore) |

---

## 🔄 Workflow de mise à jour futur

```powershell
# Après modifications:
git add .
git commit -m "Feature: description du changement"
git push

# Pour une nouvelle version/release:
git tag v1.0.1
git push origin v1.0.1
# Créer Release sur GitHub
```

---

## 💡 Conseils

1. **Garde les chemins relatifs** dans la config (pas C:\Users\...)
2. **Pas de mot de passe** dans le code
3. **Pas d'accès API** en dur dans le code
4. **Teste git clone** avant de finir:
   ```powershell
   cd C:\temp
   git clone https://github.com/[TON_USERNAME]/CrustGame.git
   ```

---

## ✅ Vérification finale

```powershell
# Va à la racine du projet
cd C:\Users\hbdvu\Desktop\CrustGame

# Vérifi que bin/ et obj/ n'existent pas
Test-Path "bin"    # Doit être: False
Test-Path "obj"    # Doit être: False
Test-Path ".vs"    # Doit être: False

# Vérifi que src/ existe
Test-Path "src"    # Doit être: True

# Vérifi que les fichiers clés existent
Test-Path "CrustGame.sln"      # Doit être: True
Test-Path "README.md"          # Doit être: True
Test-Path ".gitignore"         # Doit être: True
```

---

## 🎉 C'est prêt!

Une fois que tu as fait tout ça, ton projet est publié sur GitHub! 🚀

**Lien:** https://github.com/[TON_USERNAME]/CrustGame
**Releases:** https://github.com/[TON_USERNAME]/CrustGame/releases

Les gens peuvent maintenant:
- ⭐ Star ton projet
- 🍴 Fork ton projet
- 📥 Télécharger les binaires
- 📖 Lire la documentation
- 🐛 Signaler des bugs (Issues)
