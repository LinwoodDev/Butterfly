---
title: Speicher
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Datenverzeichnis

Das Datenverzeichnis ist das Verzeichnis, in dem Dokumente, Vorlagen und Pakete gespeichert werden.
Auf dem Desktop können Sie es in `~/Documents/Linwood/Butterfly` finden.
Auf dem Handy ist es in `getExternalFilesDir(null)/Linwood/Butterfly`.
Sie können es auch in den Einstellungen unter "Data" ändern.

In diesem Verzeichnis finden Sie einen Ordner `Documents`, `Templates` und `Packs`.

## Web

Die Anwendungsdaten werden in Ihrem Browser gespeichert. Es wird in einem lokalen Speicher gespeichert.
Öffnen Sie die Entwicklerwerkzeuge in Ihrem Browser und Sie werden die Daten sehen.

## Native Plattformen

Standardmäßig speichert die Anwendung die Daten in Ihrem Dokumentenordner in einem Unterordner namens "Linwood/Butterfly". Dieser Ordner wird beim Speichern der ersten Daten erstellt. Dieser Ordner kann in den Einstellungen geändert werden.

## Entfernter Speicher {#remote}

:::note

Diese Funktion ist im Web nicht verfügbar.

:::

Die Anwendung kann auf einem entfernten Server gespeichert werden. Dies ist nützlich, wenn Sie die Daten mit anderen Personen teilen möchten oder wenn Sie mehrere Computer haben. Derzeit wird nur das `WebDAV` Protokoll unterstützt.

Um einen entfernten Server hinzuzufügen, gehen Sie zu den Einstellungen und klicken Sie auf `Remotes`. Dann klicken Sie auf `Add remote`.
Fügen Sie die URL des entfernten Servers und den Benutzernamen und das Passwort hinzu. Danach können Sie den Ordner angeben, in dem die Daten gespeichert werden.

Um die webdav URL zu erhalten, besuchen Sie bitte die Dokumentation:

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
Google Drive hat [eine offizielle App](https://www.google.com/drive/download/) auf Windows und es gibt inoffizielle Einsendungen im Play Store.
Auf Linux können Sie auch das native Remotespeicher System verwenden und Ihr Datenverzeichnis ändern oder einen neuen externen Speicher hinzufügen, wenn Sie auf die Schaltfläche Verbindung hinzufügen klicken.

## Supported file types

Butterfly supports importing SVG, Butterfly Note (.bfly), Butterfly Raw Note (.tbfly).

### Butterfly Note (.bfly)

This file type is the recommended for saving notes.

It is a zip archive containing the information (mostly in JSON files) about the note.
These included JSON files aren't optimized for being human readable.

### Butterfly Raw Note (.tbfly)

This file is recommended for use with version control software like git.

This file is **not** a zip archive, instead it is a _JSON_ file.
It contains all the information about the note in a single JSON file that is optimized for being readable and nicely formatted. It is **slower** than the normal Butterfly Note in loading speed.

### SVG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by butterfly.
