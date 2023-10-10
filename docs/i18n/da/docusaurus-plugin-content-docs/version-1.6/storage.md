---
title: "Lagerplads"
sidebar_position: 2
---

## Web

The application data is stored in your browser. It is stored in a local storage. Open the developer tools in your browser and you will see the data.

## Indfødte platforme

As default the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save the first data. This folder can be changed in the settings.

## Ekstern lagerplads {#remote}

:::note

Denne funktion er ikke tilgængelig på nettet.

:::

The application can be saved in a remote server. This is useful if you want to share the data with other people or if you have multiple computers. Currently only the `WebDAV` protocol is supported.

To add a remote server, go to the settings and click on `Remotes`. Then click on `Add remote`. Add the URL of the remote server and the username and password. After that you can specify the folder where the data is stored.

For at få webdav url, besøg dokumentationen:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (det skal se sådan ud: `https://nextcloud.example.com/remote.php/dav/files/username/`, erstat `brugernavn` og `nextcloud.example.com` med de korrekte værdier)

### Offline synkronisering {#offline}

This feature allows you to edit your files on remote servers while you are offline. Open the popup menu on a file or folder and click on `Sync`. This will download the file or folder and save it locally. To sync the whole root directory, click on the checkmark in the create dialog or click on the remote in the setting and click on the checkmark in the manage section.

Der er et par begrænsninger:

* Du kan kun synkronisere det øverste niveau i en mappe. For eksempel hvis du har en mappe `a/b/test.bfly`, vil denne fil ikke blive synkroniseret.
* Du kan ikke slette en fil eller mappe, mens du er offline.
* Du kan ikke tilføje, redigere eller slette skabeloner, mens du er offline.
