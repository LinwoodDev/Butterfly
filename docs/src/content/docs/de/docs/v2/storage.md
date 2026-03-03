---
title: Speicher
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Datenverzeichnis

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
Auf dem Handy ist es in `getExternalFilesDir(null)/Linwood/Butterfly`.
Sie können es auch in den Einstellungen unter "Data" ändern.

In diesem Verzeichnis finden Sie einen Ordner `Documents`, `Templates` und `Packs`.

## Web

Die Anwendungsdaten werden in Ihrem Browser gespeichert. Es wird in einem lokalen Speicher gespeichert.
Öffnen Sie die Entwicklerwerkzeuge in Ihrem Browser und Sie werden die Daten sehen.

## Native Plattformen

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Dieser Ordner kann in den Einstellungen geändert werden.

## Entfernter Speicher {#remote}

:::note

Diese Funktion ist im Web nicht verfügbar.

:::

The application data can be stored on a remote server. Dies ist nützlich, wenn Sie die Daten mit anderen Personen teilen möchten oder wenn Sie mehrere Computer haben. Derzeit wird nur das `WebDAV` Protokoll unterstützt.

Um einen entfernten Server hinzuzufügen, gehen Sie zu den Einstellungen und klicken Sie auf `Remotes`. Dann klicken Sie auf `Add remote`.
Fügen Sie die URL des entfernten Servers und den Benutzernamen und das Passwort hinzu. Danach können Sie den Ordner angeben, in dem die Daten gespeichert werden.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (es sollte so aussehen: `https://nextcloud.example.com/remote.php/dav/files/username/`, ersetzen Sie `username` und `nextcloud.example.com` mit den korrekten Werten)

### Offline-Sync {#offline}

Mit dieser Funktion können Sie Ihre Dateien auf entfernten Servern bearbeiten, während Sie offline sind.
Öffnen Sie das Popup-Menü in einer Datei oder einem Ordner und klicken Sie auf `Sync`. Dies wird die Datei oder den Ordner herunterladen und lokal speichern. Um das gesamte Stammverzeichnis zu synchronisieren, Klicken Sie auf das Häkchen im Erstellungsdialog oder klicken Sie in der Einstellung auf die Fernbedienung und klicken Sie auf das Häkchen im Bereich Verwalten.

Es gibt ein paar Einschränkungen:

- Sie können nur die obere Ebene eines Verzeichnisses synchronisieren. Wenn Sie zum Beispiel ein Verzeichnis `a/b/test.bfly` haben, wird diese Datei nicht synchronisiert.
- Sie können keine Datei oder einen Ordner löschen, wenn Sie offline sind.
- Sie können Vorlagen nicht hinzufügen, bearbeiten oder löschen, solange Sie offline sind.

## Andere Speichermethoden

Wenn Sie auf einem nativen Gerät sind, können Sie auch das Anwendungsverzeichnis mit Ihrer Lieblingsplattform synchronisieren.
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
