# 📜 Scripts du jeu

Chaque script est rangé dans le dossier de sa catégorie. En haut de chaque fichier, un commentaire indique ce qu'il fait, **où le placer dans Roblox Studio**, son statut et sa date.

| Dossier | Contenu | Responsable principal |
|---|---|---|
| [`gameplay/`](gameplay/) | Règles du jeu : dégâts, objets, missions… | Claude (complexe) · Lucas (simple) |
| [`interface/`](interface/) | Menus, boutons, écrans (GUI) | Lucas |
| [`systemes/`](systemes/) | Sauvegarde, effets, mécanismes du monde | Claude |
| [`outils/`](outils/) | Générateurs utilisés pour construire la map (pas lancés en jeu) | Claude |

## Liste actuelle

| Script | Catégorie | Emplacement dans Studio |
|---|---|---|
| [Lave mortelle](gameplay/lave-mortelle.lua) | Gameplay | `Workspace > Ile > Volcan > Lave` (Script) |
| [Bâtiments style SNK](outils/batiments-snk.lua) | Outils | `ServerStorage > Batiments` (ModuleScript) |
| [Générateur de terrain](outils/ile-generateur.lua) | Outils | `ServerStorage > IleGenerateur` (ModuleScript) |
| [Fusion anti-lag](outils/fusion-maison.lua) | Outils | `ServerStorage > FusionMaison` (ModuleScript) |

## ⚠️ Ne pas modifier les `.lua` directement

Les fichiers `.lua` sont **générés** à partir de [`scripts.json`](../scripts.json), le fichier que lit l'app Canva « Atelier Roblox ».
Pour ajouter ou changer un script :

1. Modifier `scripts.json`.
2. Lancer `powershell -File tools/sync-scripts.ps1`.
3. Ajouter une ligne dans le tableau ci-dessus et dans [`CHANGELOG.md`](../CHANGELOG.md).

Le plus simple : **ouvrir une issue « Demande pour Claude »** et Claude s'occupe de tout.
