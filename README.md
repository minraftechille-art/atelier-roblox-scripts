# 🏰 Atelier Roblox

> **🌐 Le site du projet est ici : https://claude.ai/artifact/KrK8tNvMBfhzWVieRz8o5H**
> (carte interactive, équipe, tâches, votes de publication, scripts, journal).
> Ce dépôt GitHub sert en coulisses : il stocke les scripts lus par l'app Canva et reçoit les demandes.

Jeu Roblox créé par **Lucas**, **Joris** et **Claude (IA)**.

Une **île géante** bordée de falaises, avec en son centre une **cité fortifiée de style médiéval** inspirée de l'univers SNK : un mur colossal de 160 studs de haut, 842 maisons à colombages, une église, et autour une forêt d'arbres géants, des champs, des fermes et un volcan.

## 🧭 Par où commencer ?

| Je veux… | Aller ici |
|---|---|
| Savoir **qui fait quoi** | [👥 L'équipe](docs/EQUIPE.md) · [feuille de route interactive](https://claude.ai/artifact/KrK8tNvMBfhzWVieRz8o5H) |
| Voir **la carte du jeu** | [🗺️ Le monde](docs/MONDE.md) |
| Demander **quelque chose à Claude** | [💬 Nouvelle demande](../../issues/new?template=demande.md) · [comment ça marche](docs/DEMANDES.md) |
| Signaler **un bug** | [🐞 Nouveau bug](../../issues/new?template=bug.md) |
| Proposer **une idée** | [💡 Nouvelle idée](../../issues/new?template=idee.md) |
| Lire **les scripts** | [📜 Scripts](scripts/README.md) |
| Voir **ce qui a été fait** | [📅 Journal](CHANGELOG.md) |

## 👥 L'équipe

| 🤖 Claude (IA) | 🎮 Lucas | 🏰 Joris |
|---|---|---|
| Code complexe · 3D sur Blender | Code plus simple · GUI | Décors |

**En commun :** lieux, missions et scènes, animation.
**🚀 Publier le jeu = accord de toute l'équipe.** Claude ne publie jamais seul.

## 📂 Organisation du dépôt

```
atelier-roblox-scripts/
├── README.md             ← tu es ici
├── CHANGELOG.md          ← journal du projet
├── scripts.json          ← scripts lus par l'app Canva "Atelier Roblox" (ne pas déplacer)
├── scripts/              ← les scripts en .lua, par catégorie
│   ├── gameplay/
│   ├── interface/
│   ├── systemes/
│   └── outils/
├── docs/                 ← documentation (équipe, monde, demandes)
├── tools/                ← outil de synchronisation scripts.json → scripts/
└── .github/              ← formulaires : demande, bug, idée
```

## 🏷️ Étiquettes des issues

| Étiquette | Sens |
|---|---|
| `demande` | Demande à Claude |
| `bug` | Quelque chose ne marche pas |
| `idée` | Idée à discuter en équipe |
| `claude` · `lucas` · `joris` | Qui s'en occupe |
| `en attente` | Attend l'accord de l'équipe |
| `à reformuler` | Hors sujet, à reformuler |

## 🔗 Liens

- **App Canva « Atelier Roblox »** : bibliothèque visuelle des scripts (lit `scripts.json` automatiquement)
- **Feuille de route interactive** : https://claude.ai/artifact/KrK8tNvMBfhzWVieRz8o5H
- **Digipad** : [roblox game developer](https://digipad.app/p/1989334/a7651e525c4b48)
