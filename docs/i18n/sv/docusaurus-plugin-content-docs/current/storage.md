---
title: "Lagring"
sidebar_position: 2
---

## Data directory

The data directory is the directory where documents, templates and packs are stored. On the desktop you can found it in `~/Documents/Linwood/Butterfly`. On mobile it's in `getExternalFilesDir(null)/Linwood/Butterfly`. You can also change it in the settings under `Data`.

In this directory you will find a folder `Documents`, `Templates` and `Packs`.

## Webb

The application data is stored in your browser. It is stored in a local storage. Open the developer tools in your browser and you will see the data.

## Inhemska plattformar

As default the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save the first data. This folder can be changed in the settings.

## Fjärrlagring {#remote}

:::note

Denna funktion är inte tillgänglig på webben.

:::

The application can be saved in a remote server. This is useful if you want to share the data with other people or if you have multiple computers. Currently only the `WebDAV` protocol is supported.

To add a remote server, go to the settings and click on `Remotes`. Then click on `Add remote`. Add the URL of the remote server and the username and password. After that you can specify the folder where the data is stored.

Gå till dokumentationen för att få webbav-urlen:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (det ska se ut så här: `https://nextcloud.example.com/remote.php/dav/files/username/`, ersätt `användarnamn` och `nextcloud.example.com` med rätt värden)

### Synkronisering offline {#offline}

This feature allows you to edit your files on remote servers while you are offline. Open the popup menu on a file or folder and click on `Sync`. This will download the file or folder and save it locally. To sync the whole root directory, click on the checkmark in the create dialog or click on the remote in the setting and click on the checkmark in the manage section.

Det finns några begränsningar:

* Du kan bara synkronisera den översta nivån i en katalog. Till exempel om du har en katalog `a/b/test.bfly`kommer denna fil inte att synkroniseras.
* Du kan inte ta bort en fil eller mapp när du är offline.
* Du kan inte lägga till, redigera eller ta bort mallar medan du är offline.
