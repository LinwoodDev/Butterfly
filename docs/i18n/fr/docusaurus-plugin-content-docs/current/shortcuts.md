---
title: "Raccourcis"
sidebar_position: 2
---


## Keyboard

Il y a quelques raccourcis que vous pouvez utiliser dans l'éditeur. Certaines d'entre elles sont écrites sous les boutons.

### Généraux

* `Ctrl` + `N`: Nouveau fichier
* `Ctrl` + `Maj` + `N`: Nouveau fichier à partir du modèle
* `Ctrl` + `E`: Exporter le fichier
* `Ctrl` + `P`: Imprimer le fichier
* `Ctrl` + `Maj` + `E`: Exporter le fichier en tant qu'image
* `Ctrl` + `Alt` + `E`: Exporter le fichier en svg
* `Ctrl` + `Alt` + `Shift` + `E`: Exporter le fichier au format svg
* `Ctrl` + `Alt` + `P`: Packs ouverts
* `Ctrl` + `Alt` + `S`: Ouvrir les paramètres

### Projet

* `Ctrl` + `Z`: Annuler
* `Ctrl` + `Y`: Refaire
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Ouvrir la boîte de dialogue d'arrière-plan
* `Ctrl` + `Maj` + `A`: Ouvrir la boîte de dialogue des zones
* `Ctrl` + `S`: Enregistrer
* `Alt` + `S`: Changer le chemin
* `Ctrl` + (`1` - `0`) : Passer à l'outil
* `Ctrl` + `+`: Zoom avant
* `Ctrl` + `-`: Zoom arrière

## Stylo

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Configurer {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


