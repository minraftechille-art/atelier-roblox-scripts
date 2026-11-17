# 🗺️ Le monde du jeu

Carte de l'île telle qu'elle est construite dans Roblox Studio. Les coordonnées sont en **studs** (X, Z), le centre de la cité est en (0, 0).
**Nord = Z négatif**, **Sud = Z positif**.

## Vue d'ensemble

```
                         NORD (Z -)
                             │
   🌲🌲 Forêt géante         │                        🌋 Volcan
   (-1180, -760)             │                     (1150, -950)
                       ┌─── Porte N ───┐
                      ╱                 ╲
                     │    🏘️ CITÉ        │
   OUEST  ── Porte O │      ⛪ (0,0)     │ Porte E ──  EST
                     │                   │
                      ╲                 ╱
                       └─── Porte S ───┘
                             │
                    🌾 Champs et fermes
                  (X -650 → 650, Z 830 → 1450)
                             │
                         SUD (Z +)

   Bord de l'île : falaises rocheuses, rayon ≈ 1750 studs (pas de plage, pas d'eau)
```

## Les zones

| Zone | Où | Ce qu'il y a | Dossier dans Studio |
|---|---|---|---|
| 🏰 **Mur géant** | cercle de rayon 700 autour de (0, 0) | 160 studs de haut, 30 d'épaisseur, corniche + parapet, 4 portes (N, S, E, O) de 44 × 72 studs | `Workspace > Ile > MurGeant` |
| 🏘️ **Cité** | à l'intérieur du mur, sol à Y = 40 | 842 maisons à colombages en 13 anneaux, 8 avenues, rues pavées | `Workspace > Ile > Cite > Maisons` |
| ⛪ **Place centrale** | (0, 0) | Église avec grand clocher, point d'apparition en (0, 40, 85) | `Workspace > Ile > Cite` |
| 🌲 **Forêt géante** | centre (-1180, -760), rayon 420 | 85 arbres de 150 à 220 studs de haut | `Workspace > Ile > ForetGeante` |
| 🌳 **Arbres** | un peu partout hors de la cité | 350 arbres normaux | `Workspace > Ile > Arbres` |
| 🌾 **Champs** | X -650 → 650, Z 830 → 1450 | 96 champs (blé, terre labourée, prairie) peints dans le terrain | *(terrain)* |
| 🏡 **Fermes** | dans les champs | 14 fermes | `Workspace > Ile > Fermes` |
| 🌋 **Volcan** | (1150, -950) | Cratère avec lave mortelle | `Workspace > Ile > Volcan` |
| 🛣️ **Routes** | depuis chaque porte | Sud → champs (pavée), Ouest → forêt, Est → volcan, Nord → bord de l'île | *(terrain)* |

## Réglages du monde

- **Herbe 3D désactivée** (`Terrain.Decoration = false`), à garder comme ça.
- **Pas d'eau** pour l'instant.
- Lumière : après-midi (`ClockTime = 14`), avec brume légère.
- Les maisons et les arbres sont **fusionnés** pour éviter le lag. Pour modifier une maison, il vaut mieux la supprimer et en recréer une.

## Modules de construction (dans `ServerStorage`)

Ils servent à **générer** la map depuis Studio et ne tournent pas pendant le jeu.

| Module | Rôle |
|---|---|
| `IleGenerateur` | Relief et matériaux du terrain, positions des zones |
| `IleOutils` | Fonctions de base : créer une pièce, trouver le sol, arbres, rochers |
| `Batiments` | Maisons à colombages et église |
| `FusionMaison` | Fusionne les pièces d'un modèle pour réduire le lag |
