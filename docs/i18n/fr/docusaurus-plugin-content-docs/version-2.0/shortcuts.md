---
title: Raccourcis
sidebar_position: 2
---

## Keyboard

Il y a quelques raccourcis que vous pouvez utiliser dans l'éditeur.
Certaines d'entre elles sont écrites sous les boutons.

### Généraux

- `Ctrl` + `N` : Nouveau fichier
- `Ctrl` + `Shift` + `N` : Nouveau fichier du modèle
- `Ctrl` + `E` : Exporter le fichier
- `Ctrl` + `P` : Imprimer le fichier
- `Ctrl` + `Shift` + `E` : Exporter le fichier en tant qu'image
- `Ctrl` + `Alt` + `E` : Exporter le fichier en svg
- `Ctrl` + `Alt` + `Shift` + `E` : Exporter le fichier au format svg
- `Ctrl` + `Alt` + `P` : Ouvrir les packs
- `Ctrl` + `Alt` + `S` : Ouvrir les paramètres

### Projet

- `Ctrl` + `Z` : Annuler
- `Ctrl` + `Y` : Refaire
- `Ctrl` + `Shift` + `P` : Dialogue des waypoints ouverts
- `Ctrl` + `B` : Ouvrir la boîte de dialogue d'arrière-plan
- `Ctrl` + `Shift` + `A` : Ouvrir la boîte de dialogue des zones
- `Ctrl` + `S` : Enregistrer
- `Alt` + `S` : Changer le chemin d'accès
- `Ctrl` + (`1` - `0`) : Basculer vers l'outil
- `Ctrl` + `+`: Zoom avant
- `Ctrl` + `-`: Zoom arrière

## Stylo

Par défaut, le stylo est configuré pour fonctionner comme suit :

- `Stylo`: configuré comme stylo.
- `Premier` (Bouton primaire, si supporté) : Changer pour l'outil main pendant qu'il est pressé.
- `Second` (bouton secondaire, si supporté) : Changer en deuxième outil (voir [configure](#configure) section ci-dessous) pendant qu'il est pressé.

## Configurer {#configure}

Vous pouvez personnaliser les contrôles en donnant à chaque contrôle un index d'outil. L'indexation de l'outil commence à partir de la gauche de la barre d'outils, `1` étant le premier index. Voir l'exemple ci-dessous

![toolbar numbered](toolbar_numbered.png)

Ici, 1 fait référence à l'outil lasso, 2, à l'outil de poêle etc.

Les options de configuration que vous avez sont les suivantes :

- Vide - l'outil n'est pas chagé.
- 0 - l'outil fonctionnera comme se déplaçant (c.-à-d. la main) dans ce mod.
- Numéro positif - L'outil suivra l'indexation comme expliqué ci-dessus.
