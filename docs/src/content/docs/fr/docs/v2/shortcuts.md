---
title: Raccourcis
---

## Keyboard

Il y a quelques raccourcis que vous pouvez utiliser dans l'éditeur.
Certaines d'entre elles sont écrites sous les boutons.

### Généraux

- `Ctrl` + `N` : Nouveau fichier
- `Ctrl` + `Shift` + `N` : Nouveau fichier du modèle
- `Ctrl` + `E` : Exporter le fichier
- Nightly (2.4): `Ctrl` + `Shift` + `E`: Export file (text based)
- `Ctrl` + `Shift` + `E` : Exporter le fichier en tant qu'image
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Alt` + `Shift` + `E` (Nightly (2.4): `Ctrl` + `Shift` + `P`): Export file as pdf
- `Ctrl` + `Alt` + `S` : Ouvrir les paramètres
- `Ctrl` + `Alt` + `P` : Ouvrir les packs

### Projet

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z` : Annuler
- `Ctrl` + `Y` : Refaire
- `Ctrl` + `Shift` + `P` : Dialogue des waypoints ouverts
- `Ctrl` + `B` : Ouvrir la boîte de dialogue d'arrière-plan
- `Ctrl` + `S` : Enregistrer
- `Alt` + `S` : Changer le chemin d'accès
- `Ctrl` + (`1` - `0`) : Basculer vers l'outil
- `Ctrl` + `+`: Zoom avant
- `Ctrl` + `-`: Zoom arrière

## Stylo

Par défaut, le stylo est configuré pour fonctionner comme suit :

- `Stylo`: configuré comme stylo.
- `Premier` (Bouton primaire, si supporté) : Changer pour l'outil main pendant qu'il est pressé.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to reorder your tools, see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

![toolbar numbered](toolbar_numbered.png)