# 🏰 Atelier Roblox

Projet de jeu Roblox à deux développeurs, construit avec l'aide de Claude Code.

Le jeu se passe sur une **île géante** dont le centre est une **cité fortifiée de style médiéval** (inspirée de l'univers SNK) : un mur colossal de 160 studs de haut, 842 maisons à colombages, une église, et autour une forêt d'arbres géants, des champs, des fermes et un volcan.

## 📂 Organisation du dépôt

```
atelier-roblox-scripts/
├── scripts.json          ← source de vérité, lue par l'app Canva "Atelier Roblox"
├── scripts/              ← les mêmes scripts en fichiers .lua, rangés par catégorie
│   ├── gameplay/
│   └── outils/
├── docs/
│   └── DEMANDES.md       ← comment demander une modification à Claude
├── tools/
│   └── sync-scripts.ps1  ← régénère scripts/ à partir de scripts.json
├── CHANGELOG.md          ← journal de toutes les étapes du projet
└── .github/              ← formulaire de demande (issues)
```

## 📜 Scripts

| Script | Catégorie | Où dans Roblox Studio |
|---|---|---|
| [Lave mortelle](scripts/gameplay/lave-mortelle.lua) | Gameplay | `Workspace > Ile > Volcan > Lave` |
| [Bâtiments style SNK](scripts/outils/batiments-snk.lua) | Outils | `ServerStorage > Batiments` |
| [Générateur de terrain](scripts/outils/ile-generateur.lua) | Outils | `ServerStorage > IleGenerateur` |
| [Fusion anti-lag](scripts/outils/fusion-maison.lua) | Outils | `ServerStorage > FusionMaison` |

## 💬 Demander quelque chose à Claude

Ouvre une issue avec le formulaire **Demande pour Claude**. Toutes les explications sont dans [docs/DEMANDES.md](docs/DEMANDES.md).

## 🔗 Liens

- **App Canva « Atelier Roblox »** : bibliothèque visuelle des scripts (lit `scripts.json` automatiquement).
- **Digipad** : [roblox game developer](https://digipad.app/p/1989334/a7651e525c4b48)

## 🛠️ Ajouter ou modifier un script

1. Modifier `scripts.json` (champs : `id`, `name`, `project`, `category`, `status`, `author`, `date`, `description`, `location`, `language`, `code`).
2. Lancer `powershell -File tools/sync-scripts.ps1` pour mettre à jour le dossier `scripts/`.
3. Noter le changement dans `CHANGELOG.md`, puis commit et push.

`category` vaut `Gameplay`, `Interface`, `Systèmes` ou `Outils`. `status` vaut `À faire`, `En cours` ou `Terminé`.
