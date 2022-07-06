---
title: "Speicher"
sidebar_position: 2
---

## Web

Die Anwendungsdaten werden in Ihrem Browser gespeichert. Es wird in einem lokalen Speicher gespeichert. Öffnen Sie die Entwicklerwerkzeuge in Ihrem Browser und Sie werden die Daten sehen.

## Native Plattformen

Standardmäßig speichert die Anwendung die Daten in Ihrem Dokumentenordner in einem Unterordner namens "Linwood/Butterfly". Dieser Ordner wird beim Speichern der ersten Daten erstellt. Dieser Ordner kann in den Einstellungen geändert werden.

## Entfernter Speicher {#remote}

:::note

Diese Funktion ist im Web nicht verfügbar.

:::

Die Anwendung kann auf einem entfernten Server gespeichert werden. Dies ist nützlich, wenn Sie die Daten mit anderen Personen teilen möchten oder wenn Sie mehrere Computer haben. Derzeit wird nur das `WebDAV` Protokoll unterstützt.

Um einen entfernten Server hinzuzufügen, gehen Sie zu den Einstellungen und klicken Sie auf `Remotes`. Klicken Sie dann auf `Remote hinzufügen`. Fügen Sie die URL des entfernten Servers und den Benutzernamen und das Passwort hinzu. Danach können Sie den Ordner angeben, in dem die Daten gespeichert werden.

Um die webdav URL zu erhalten, besuchen Sie bitte die Dokumentation:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html)

### Offline sync {#offline}

This feature allows you to edit your files on remote servers while you are offline. Open the popup menu on a file or folder and click on `Sync`. This will download the file or folder and save it locally. To sync the whole root directory, click on the checkmark in the create dialog or click on the remote in the setting and click on the checkmark in the manage section.

There are a few limitations:

* You can only sync the top level of a directory. For example if you have a directory `a/b/test.bfly`, this file will not be synced.
* You cannot delete a file or folder while you are offline.
* You cannot add, edit or delete templates while you are offline.
