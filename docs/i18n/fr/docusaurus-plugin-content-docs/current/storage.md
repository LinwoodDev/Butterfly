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

### Synchronisation hors ligne {#offline}

Cette fonctionnalité vous permet de modifier vos fichiers sur des serveurs distants pendant que vous êtes hors ligne. Ouvrez le menu contextuel sur un fichier ou un dossier et cliquez sur `Synchroniser`. Cela téléchargera le fichier ou le dossier et l'enregistrera localement. Pour synchroniser l'ensemble du répertoire racine, cliquez sur la case à cocher dans la boîte de dialogue de création ou cliquez sur la télécommande dans le paramètre, puis cliquez sur la case à cocher dans la section Gérer .

Il y a quelques limitations :

* Vous ne pouvez synchroniser que le niveau supérieur d'un répertoire. Par exemple, si vous avez un répertoire `a/b/test.bfly`, ce fichier ne sera pas synchronisé.
* Vous ne pouvez pas supprimer un fichier ou un dossier lorsque vous êtes hors ligne.
* Vous ne pouvez pas ajouter, modifier ou supprimer des modèles lorsque vous êtes hors ligne.
