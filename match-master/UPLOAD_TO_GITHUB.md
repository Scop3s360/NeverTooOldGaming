# How to Upload Match Master to GitHub

## Quick Start (Command Line)

Open PowerShell in the `match-master` folder and run:

```powershell
# Initialize git repository
git init

# Add all files (respecting .gitignore)
git add .

# Create first commit
git commit -m "Initial commit - Match Master game with shop system and theme support"

# Set main branch
git branch -M main

# Add your GitHub repository
git remote add origin https://github.com/Scop3s360/StartUp.git

# Push to GitHub
git push -u origin main
```

## If Repository Already Has Content

If the repo already has files, you might need to pull first:

```powershell
git init
git add .
git commit -m "Initial commit - Match Master game"
git branch -M main
git remote add origin https://github.com/Scop3s360/StartUp.git
git pull origin main --allow-unrelated-histories
git push -u origin main
```

## Using GitHub Desktop (Easier)

1. Download GitHub Desktop: https://desktop.github.com/
2. File → Add Local Repository → Select `match-master` folder
3. Click "Publish repository"
4. Choose "Scop3s360/StartUp" as the repository
5. Click "Publish"

## What Gets Uploaded

✅ **Included:**
- All source code (.gd files)
- All scenes (.tscn files)
- Assets (images, audio)
- Documentation (README, ASSETS_NEEDED, AI_PROMPTS)
- Project configuration

❌ **Excluded (via .gitignore):**
- `.godot/` folder (generated files)
- `builds/` folder (compiled executables)
- `.exe`, `.pck` files
- System files (.DS_Store, Thumbs.db)

## After Upload

Your repository will be available at:
https://github.com/Scop3s360/StartUp

Anyone can then:
1. Clone the repository
2. Open in Godot 4.5.1
3. Press F5 to play
