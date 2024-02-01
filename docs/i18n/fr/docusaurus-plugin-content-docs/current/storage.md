---
title: "Stockage"
sidebar_position: 2
---

## Répertoire des données

Le répertoire des données est le répertoire où les documents, les modèles et les packs sont stockés. Sur le bureau, vous pouvez le trouver dans `~/Documents/Linwood/Butterfly`. Sur mobile, c'est en `getExternalFilesDir(null)/Linwood/Butterfly`. Vous pouvez également le modifier dans les paramètres sous `Données`.

Dans ce répertoire, vous trouverez un dossier `Documents`, `Modèles` et `Packs`.

## Web

Les données de l'application sont stockées dans votre navigateur. Il est stocké dans un stockage local. Ouvrez les outils de développement dans votre navigateur et vous verrez les données.

## Plateformes indigènes

Par défaut, l'application enregistre les données dans votre dossier de documents dans un sous-dossier appelé "Linwood/Butterfly". Ce dossier est créé lorsque vous enregistrez les premières données. Ce dossier peut être modifié dans les paramètres.

## Stockage à distance {#remote}

:::note

Cette fonctionnalité n'est pas disponible sur le Web.

:::

L'application peut être enregistrée sur un serveur distant. Ceci est utile si vous voulez partager les données avec d'autres personnes ou si vous avez plusieurs ordinateurs. Actuellement, seul le protocole `WebDAV` est pris en charge.

Pour ajouter un serveur distant, allez dans les paramètres et cliquez sur `Télécommandes`. Puis cliquez sur `Ajouter une télécommande`. Ajoute l'URL du serveur distant et le nom d'utilisateur et le mot de passe. Ensuite, vous pouvez spécifier le dossier où les données sont stockées.

Pour obtenir l'url webdav, veuillez visiter la documentation:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (il devrait ressembler à ceci : `https://nextcloud.example.com/remote.php/dav/files/username/`, remplacez `nom d'utilisateur` et `nextcloud.example.com` par les valeurs correctes)

### Synchronisation hors ligne {#offline}

Cette fonctionnalité vous permet de modifier vos fichiers sur des serveurs distants pendant que vous êtes hors ligne. Ouvrez le menu contextuel sur un fichier ou un dossier et cliquez sur `Synchroniser`. Cela téléchargera le fichier ou le dossier et l'enregistrera localement. Pour synchroniser l'ensemble du répertoire racine, cliquez sur la case à cocher dans la boîte de dialogue de création ou cliquez sur la télécommande dans le paramètre, puis cliquez sur la case à cocher dans la section Gérer .

Il y a quelques limitations :

* Vous ne pouvez synchroniser que le niveau supérieur d'un répertoire. Par exemple, si vous avez un répertoire `a/b/test.bfly`, ce fichier ne sera pas synchronisé.
* Vous ne pouvez pas supprimer un fichier ou un dossier lorsque vous êtes hors ligne.
* Vous ne pouvez pas ajouter, modifier ou supprimer des modèles lorsque vous êtes hors ligne.

## Autres méthodes de stockage

Si vous êtes sur un périphérique natif, vous pouvez également synchroniser le répertoire d'application avec votre plateforme préférée. Google drive a [une application officielle](https://www.google.com/drive/download/) sur les fenêtres et il y a des fois non officielles sur le Play Store. Sous Linux, vous pouvez également utiliser le système de stockage natif à distance et changer votre répertoire de données ou ajouter un nouveau stockage externe si vous cliquez sur le bouton d'ajout de connexion.
