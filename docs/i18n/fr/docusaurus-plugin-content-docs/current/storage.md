---
title: "Stockage"
sidebar_position: 2
---

## Web

Les données de l'application sont stockées dans votre navigateur. Il est stocké dans un stockage local. Ouvrez les outils de développement dans votre navigateur et vous verrez les données.

## Plateformes indigènes

Par défaut, l'application enregistre les données dans votre dossier de documents dans un sous-dossier appelé "Linwood/Butterfly". Ce dossier est créé lorsque vous enregistrez les premières données. Ce dossier peut être modifié dans les paramètres.

## Remote storage

:::note

This feature is not available on the web.

:::

The application can be saved in a remote server. This is useful if you want to share the data with other people or if you have multiple computers. Currently only the `WebDAV` protocol is supported.

To add a remote server, go to the settings and click on `Remotes`. Then click on `Add remote`. Add the URL of the remote server and the username and password. After that you can specify the folder where the data is stored.

To get the webdav url, please visit the documentation:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html)
