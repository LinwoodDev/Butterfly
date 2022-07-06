---
title: "Stockage"
sidebar_position: 2
---

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

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html)

### Offline sync {#offline}

This feature allows you to edit your files on remote servers while you are offline. Open the popup menu on a file or folder and click on `Sync`. This will download the file or folder and save it locally. To sync the whole root directory, click on the checkmark in the create dialog or click on the remote in the setting and click on the checkmark in the manage section.

There are a few limitations:

* You can only sync the top level of a directory. For example if you have a directory `a/b/test.bfly`, this file will not be synced.
* You cannot delete a file or folder while you are offline.
* You cannot add, edit or delete templates while you are offline.
