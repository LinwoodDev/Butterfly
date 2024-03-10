---
title: Introduction
id: intro
slug: /intro
sidebar_position: 1
---

importer des onglets depuis '@theme/Tabs'; importer un tabItem depuis '@theme/TabItem'; importer { Gear, Plus, Disquette MagnifyingGlass, ScribbleLoop, Pen, Path, Flèche dans le sens horloger, dans le sens horaire Clé à clef, Lock} de "@phosphor-icons/react";

![Bannière](/img/banner.png)

---

> Bienvenue sur Butterfly, l'application de note opensource.

Butterfly est une application de prise de notes qui vise à une expérience unifiée sur toutes les plateformes. Il fournit une interface utilisateur simple avec une personnalisation puissante.

## Commencer

> Vous pouvez utiliser la barre latérale pour naviguer rapidement à travers le wiki.


Pour commencer à travailler sur l'application, vous avez deux options :
1. [Télécharge](/downloads) la version de l'application qui convient à votre plateforme (Butterfly peut fonctionner sur la plupart des plateformes mobile, bureau et web).
2. Use [web version](https://butterfly.linwood.dev) if you cannot find your platform or if you don't want to install it on it. Voir [ici](storage#web) sur le stockage de fichiers sur la version web.

> Une fois que vous avez ouvert l'application, continuez à lire.



## Vue principale

![Vue principale](main.png)

La vue principale est composée de plusieurs éléments
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Écran de bienvenue](/img/welcome_screen_desktop.png)
        Le haut de l'écran contient la bannière pour les mises à jour, le lien vers ces documentations, et l'icone de configuration <Gear/>. Enfin, à droite du symbole de configuration <Gear/> vous avez un menu déroulant pour contrôler quand cette bannière apparaîtra (toujours/jamais/sur les mises à jour).
        La section "Fichiers" dans la zone principale de gauche. Là, vous pouvez faire les opérations typiques :
            - Sélectionnez le type d'affichage (grille ou liste)
            - Sélectionnez le [stockage source](stockage) des fichiers
            - Trier l'ordre d'affichage des fichiers
            - Ajouter un dossier, fichier, modèle, ou importez des fichiers en cliquant sur le signe <Plus/> plus
            - Tapez le chemin d'accès direct à l'emplacement souhaité (le champ Emplacement),
            - Rechercher des fichiers
        Enfin, à droite, vous avez l'affichage de démarrage rapide avec les modèles disponibles à l'emplacement actuel. Pour une nouvelle installation, cela inclut le modèle clair et sombre
    </TabItem>
    <TabItem value="mobile">
        Lorsque vous ouvrez Butterfly sur un appareil mobile, vous serez présenté avec un écran comme ceci
        ! Écran de bienvenue première partie](/img/welcome_screen_mobile_1. ng)   
        Le haut de l'écran contient la bannière pour les mises à jour, et au-dessous, vous pouvez trouver le lien documentation, et à côté de l'icone de configuration <Gear/>. Enfin, à droite du symbole de configuration <Gear/> vous avez un menu déroulant pour contrôler quand cette bannière apparaîtra (toujours/jamais/sur les mises à jour).
        Ci-dessous, vous pouvez trouver la section de démarrage rapide tenant les modèles avialable à vous. Par défaut, les modèles sont les modèles clairs et sombres. 
        Défilement vers le bas vous verrez l'interface de fichier :
        \
        ! Écran d'accueil deuxième partie](/img/welcome_screen_mobile_2. ng)  
        La section "Fichiers" dans la zone principale de la gauche. Là, vous pouvez faire les opérations typiques :
        - Sélectionnez le type d'affichage (grille ou liste)
        - Sélectionnez le [stockage source](stockage) des fichiers
        - Trier l'ordre d'affichage des fichiers
        - Ajouter un dossier, fichier, modèle, ou importez des fichiers en cliquant sur le signe <Plus/> plus
        - Tapez le chemin d'accès direct à l'emplacement souhaité (le champ Emplacement),
        - Rechercher des fichiers
    </TabItem>
</Tabs>

Une fois un document ouvert en sélectionnant un modèle ou un fichier existant, vous accéderez à la **Vue Document**

## La vue du document

Vous pouvez retourner de la vue du document à la liste des documents avec l'action de retour de votre appareil. Comme pour la vue principale, l'affichage du document est basé sur votre appareil. 

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        Dans la vue Bureau, vous aurez en haut à gauche la barre de fichiers\
        ![file_bar](/img/document_view_file_bar. ng)\
        Ceci est conservé, de gauche à droite, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        bouton papillon pour ouvrir le menu. À côté de cela, il y a le champ nom qui affiche le nom de la note. Vous pouvez renommer la note en tapant un nouveau nom dans ce champ et en l'enregistrant en utilisant le bouton <FloppyDisk/> Enregistrer. Enfin vous pouvez <MagnifyingGlass/> rechercher des éléments dans la note.
        \
        En haut à droite de l’écran, vous avez la barre d’outils\
        ![toolbar](/img/document_view_toolbar. ng)\
        Par défaut, cette barre a l'outilformat@@4 de lasso <ScribbleLoop/> ; l'outil de stylo <Pen/> ; l'outil d'effacement du chemin <Path/> ; les butons <ArrowCounterClockwise/> d'annulation et <ArrowClockwise/> et l'outil à la main <Hand/>. Ensuite, vous avez le bouton <Plus/> pour ajouter des éléments à la barre d'outils, le bouton <Wrench/> pour configurer le document, et enfin l'outil <Lock/> pour regarder le zoom et/ou la position de l'écran. 
        ### Notes importantes
        1. Si certains des éléments de la barre d'outils ne sont pas visibles pour vous, cliquez et faites glisser (ou glisser) vers la gauche et la droite pour révéler d'autres outils. 
        2. Après avoir sélectionné un outil, un petit menu apparaît. Un clic long sur l'outil vous permettra de le déplacer vers une nouvelle position
        3. Vous pouvez ajouter plus d'outils à la barre d'outils en cliquant sur le signe <Plus/> plus . 
    </TabItem>
    <TabItem value="mobile">
        Dans la vue mobile, vous aurez en haut la barre de fichiers\
        ![file_bar](/img/document_view_file_bar. ng)\
        Ceci est conservé, de gauche à droite, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        bouton papillon pour ouvrir le menu. À côté de cela, il y a le champ nom qui affiche le nom de la note. Vous pouvez renommer la note en tapant un nouveau nom dans ce champ et en l'enregistrant en utilisant le bouton <FloppyDisk/> Enregistrer. Enfin vous pouvez <MagnifyingGlass/> rechercher des éléments dans la note.
        \
        En bas de l'écran, vous avez la barre d'outils\
        ![toolbar](/img/document_view_toolbar. ng)\
        Par défaut, cette barre a l'outilformat@@4 de lasso <ScribbleLoop/> ; l'outil de stylo <Pen/> ; l'outil d'effacement du chemin <Path/> ; les butons <ArrowCounterClockwise/> d'annulation et <ArrowClockwise/> et l'outil à la main <Hand/>. Ensuite, vous avez le bouton <Plus/> pour ajouter des éléments à la barre d'outils, le bouton <Wrench/> pour configurer le document, et enfin l'outil <Lock/> pour regarder le zoom et/ou la position de l'écran. 
        ### Notes importantes
        1. Si certains éléments de la barre d'outils ne sont pas visibles pour vous, ou glissez vers la gauche et la droite pour révéler d'autres éléments. 
        2. Après avoir sélectionné un outil, un petit menu apparaîtra pour le configurer. Un clic long sur l'outil vous permettra de le déplacer vers une nouvelle position
        3. Vous pouvez ajouter plus d'outils à la barre d'outils en cliquant sur le signe <Plus/> plus . 
    </TabItem>
</Tabs>
	

