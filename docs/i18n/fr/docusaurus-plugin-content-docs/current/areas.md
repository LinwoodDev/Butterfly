---
title: "Zones"
sidebar_position: 2
---

importer {Monitor} depuis "@phosphor-icons/react";


## Introduction

![Zone de stockage](area.png)

Les zones sont un moyen de limiter la taille de la toile. Vous pouvez créer des zones en utilisant l'outil [zone](tools/area.md). Si vous cliquez sur l'arrière-plan, vous pouvez ouvrir la boîte de dialogue de la liste des zones en utilisant le menu contextuel.

## Création et suppression des zones

Alors que vous pouvez directement modifier le contenu sur la toile, il est courant que vous vouliez restreindre la région dans laquelle vous pouvez modifier le contenu, ou que vous aimeriez pouvoir accéder rapidement à une partie du document. Pour cela, vous avez l'outil <Monitor/> Area . Comme expliqué dans la section [introduction](README.md), vous devrez peut-être ajouter le bouton <Monitor/> à votre barre d'outils. En utilisant l'outil [de zone](tools/area.md), vous pouvez dessiner un rectangle n'importe où sur la toile pour ensuite définir la zone.

## Plus de contrôle

Vous pouvez définir davantage l'outil zone en cliquant à nouveau sur le bouton <Monitor/>. Là, vous pouvez définir la largeur fixe, la hauteur ou le rapport d'aspect.

## Le menu contextuel de la zone

 Après avoir dessiné une zone, vous pouvez cliquer ou appuyer longuement sur la touche afficher la zone pour ouvrir un menu contextuel avec les options suivantes :

* `Name` - Donnez à la zone un nom qui vous convaincra d'utiliser. Ceci est utile, par exemple quand...
* `Entrez la zone` - Vous permettant de modifier du contenu uniquement emprunté par cette zone.
* `Supprimer` - Supprimer la zone. This *does not* delete the content within this area.
* `Exporter` - Exporter le contenu de la zone sélectionnée.
* `Ajouter au pack` - Ajouter la zone à un pack [](pack)

## Une autre option

Une autre option pour vous d'utiliser le navigateur de zone est dans le menu de gauche, ou sur le menu papillon si vous utilisez une plateforme mobile. 

