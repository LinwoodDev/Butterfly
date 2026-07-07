---
title: Stockage
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Répertoire des données

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
Sur mobile, c'est dans `getExternalFilesDir(null)/Linwood/Butterfly`.
Vous pouvez également le modifier dans les paramètres sous `Data`.

Dans ce répertoire, vous trouverez un dossier `Documents`, `Templates` et `Packs`.

## Web

Les données de l'application sont stockées dans votre navigateur. Il est stocké dans un stockage local.
Ouvrez les outils de développement dans votre navigateur et vous verrez les données.

## Plateformes indigènes

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Ce dossier peut être modifié dans les paramètres.

## Stockage à distance {#remote}

:::note

Cette fonctionnalité n'est pas disponible sur le Web.

:::

The application data can be stored on a remote server. Ceci est utile si vous voulez partager les données avec d'autres personnes ou si vous avez plusieurs ordinateurs. Actuellement, seul le protocole `WebDAV` est pris en charge.

Pour ajouter un serveur distant, allez dans les paramètres et cliquez sur `Remotes`. Puis cliquez sur `Ajouter une télécommande`.
Ajoute l'URL du serveur distant et le nom d'utilisateur et le mot de passe. Ensuite, vous pouvez spécifier le dossier où les données sont stockées.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (il devrait ressembler à ceci: `https://nextcloud.example.com/remote.php/dav/files/username/`, remplacez `username` et `nextcloud.example.com` par les valeurs correctes)

### Synchronisation hors ligne {#offline}

Cette fonctionnalité vous permet de modifier vos fichiers sur des serveurs distants pendant que vous êtes hors ligne.
Ouvrez le menu contextuel sur un fichier ou un dossier et cliquez sur `Sync`. Cela téléchargera le fichier ou le dossier et l'enregistrera localement. Pour synchroniser l'ensemble du répertoire racine, cliquez sur la case à cocher dans la boîte de dialogue de création ou cliquez sur la télécommande dans le paramètre, puis cliquez sur la case à cocher dans la section Gérer .

Il y a quelques limitations :

- Vous ne pouvez synchroniser que le niveau supérieur d'un répertoire. Par exemple, si vous avez un répertoire `a/b/test.bfly`, ce fichier ne sera pas synchronisé.
- Vous ne pouvez pas supprimer un fichier ou un dossier lorsque vous êtes hors ligne.
- Vous ne pouvez pas ajouter, modifier ou supprimer des modèles lorsque vous êtes hors ligne.

## Autres méthodes de stockage

Si vous êtes sur un périphérique natif, vous pouvez également synchroniser le répertoire d'application avec votre plateforme préférée.
Google Drive has [an official app](https://www.google.com/drive/download/) on Windows and there are unofficial ones on the Play Store.
On Linux you can also use the native remote storage system and change your data directory to this or add a new external storage if you click on the add connection button.

## Supported file types

Butterfly supports importing SVG, Butterfly Note (.bfly), Butterfly Raw Note (.tbfly).

### Butterfly Note (.bfly)

This file type is the recommended format for saving notes.

It is a zip archive containing the information (mostly in JSON files) about the note.
These included JSON files aren't optimized for human readability.

### Butterfly Raw Note (.tbfly)

This file is recommended for use with version control software like git.

This file is **not** a zip archive; instead it is a _JSON_ file.
It contains all the information about the note in a single JSON file that is optimized for being readable and nicely formatted. It is slower to load than the normal Butterfly Note.

### SVG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by Butterfly.
