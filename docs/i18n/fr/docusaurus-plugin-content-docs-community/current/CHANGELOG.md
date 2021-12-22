---
slug: /fr/changelog
---

# Historique des modifications

<!--ENTER CHANGELOG HERE-->

## 1.0.0-rc.6 (2021-12-18)

* Ajouter un menu contextuel
* Add zoom-dependent stroke width ([#31](https://github.com/LinwoodCloud/Butterfly/issues/31))
* Déplacer l'arrière-plan et les waypoints vers le menu contextuel d'arrière-plan
* Déplacer la palette de couleurs vers le menu en trois points
* Corriger le routeur interne, utiliser / au lieu de hachage
* Corriger les problèmes réactifs sur le sélecteur de couleurs, le système de fichiers et l'exportation d'images

## 1.0.0-rc.5 (2021-12-10)

* Ajouter la propriété gomme à exclure pour la main
* Ajouter une fonction de création de dossier au système de fichiers
* Ajouter la fonction de déplacement au système de fichiers
* Ajouter une recherche à la boîte de dialogue des points de passage
* Ajouter le chemin et le widget de recherche pour ouvrir la boîte de dialogue
* Ajouter des propriétés de la main
* Ajouter une icône nocturne
* Ajouter une documentation pwa
* Implémenter déplacer/dupliquer pour les éléments
* Empêcher les comportements du navigateur sur la version web
* Réparation du système de fichiers sur des plates-formes natives
* Corriger l'écran de démarrage sur les lecteurs d'écran
* Corriger certains thèmes de la boîte de dialogue pour avoir des coins arrondis

## 1.0.0-rc.4 (2021-11-27)

* Ajouter un système de fichiers avec des fichiers et des dossiers natifs et indexeddb sur le web ([#53](https://github.com/LinwoodCloud/butterfly/pull/53))
  * Emplacement de sauvegarde personnalisé
  * Noms de fichiers ajoutés
* Ajouter des options de comportement pour les gestes multiples ([#45](https://github.com/LinwoodCloud/butterfly/issues/45))
* Add version to information dialog ([#50](https://github.com/LinwoodCloud/butterfly/issues/50))
* La correction des boîtes de dialogue s'ouvrira plusieurs fois ([#47](https://github.com/LinwoodCloud/butterfly/issues/47))
* Améliore les performances des images ([#35](https://github.com/LinwoodCloud/butterfly/issues/35))

## 1.0.0-rc.3 (2021-11-14)

* Ajouter des raccourcis
* Ajouter le nom par défaut pour les documents
* Réimplémenter la fonction de remplissage
* Réparation du zoom
* Réparation de la version sur l'installateur Windows

## 1.0.0-rc.2 (2021-11-07)

* Changer la page d'accueil en page de dessin ([#17](https://github.com/LinwoodCloud/butterfly/issues/17))
* Réparer les problèmes de zoom ([#20](https://github.com/LinwoodCloud/butterfly/issues/20))
* Simplify selection ([#23](https://github.com/LinwoodCloud/butterfly/issues/23))
  * Ajouter plus d'espace à sélectionner
  * Ajouter un calcul pour voir si le curseur se situe entre deux points
  * Ajouter le calcul pour obtenir la largeur et la hauteur réelles du texte
  * Ajouter une boîte de dialogue de sélection s'il y a plus d'un élément sur la position
  * Ajouter une boîte qui met en surbrillance la sélection
* Changer l'ancienne page d'accueil pour ouvrir la boîte de dialogue
* Renommer l'ancienne boîte de dialogue ouverte pour importer
* Renommer l'ancienne boîte de dialogue de sauvegarde dans la boîte de dialogue d'exportation
* Ajouter un menu contextuel dans le coin supérieur droit de la vue principale

## 1.0.0-rc.1 (2021-10-30)

* Ajouter un nouveau moteur graphique pour permettre de se déplacer dans la direction négative
* Les gros problèmes de performance ont été résolus
* Nouvel écran de chargement sur le web
* Ajouter une classe de palette de couleurs distincte (nouveau format de fichier de palette de couleurs)
* Réparation des noms vides dans le nom du document ([#14](https://github.com/LinwoodCloud/butterfly/issues/14))
* Réparation de la boîte de dialogue Ouvrir/Enregistrer

## 1.0.0-rc.0 (2021-10-20)

* Ajouter un nouveau système de conception
* Ajouter un peintre et un calque d'image
  * Ajouter une propriété d'échelle
* Ajouter une boîte de dialogue Ouvrir/Enregistrer
* Ajouter un espacement de lettre au peintre de texte et à l'élément
* Ajouter une classe de propriété interne pour simplifier les variables égales sur le peintre et la couche
* Normaliser les clés json
* Corriger le retard lors du zoom hors de la fenêtre d'affichage
* Séparer le peintre personnalisé de la vue interne

## 1.0.0-beta.0 (2021-10-15)

* Ajouter un nouveau sélecteur de couleur
  * Multiple palettes
  * Ouvrir/enregistrer les palettes
  * Couleurs personnalisées
  * Edit palettes
* Ajouter de nouvelles propriétés d'étiquette (poids de la police, italique, décoration)
* Correction du bug des préférences partagées qui empêche le démarrage de l'application sur android

## 1.0.0-alpha.0 (2021-10-10)

Première version 🎉
