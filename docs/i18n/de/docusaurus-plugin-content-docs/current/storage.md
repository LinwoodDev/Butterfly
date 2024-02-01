---
title: "Speicher"
sidebar_position: 2
---

## Datenverzeichnis

Das Datenverzeichnis ist das Verzeichnis, in dem Dokumente, Vorlagen und Pakete gespeichert werden. Auf dem Desktop können Sie es in `~/Documents/Linwood/Butterfly` finden. Auf dem Handy ist es in `getExternalFilesDir(null)/Linwood/Butterfly`. Sie können es auch in den Einstellungen unter `Daten` ändern.

In diesem Verzeichnis finden Sie einen Ordner `Dokumente`, `Vorlagen` und `Pakete`.

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

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (es sollte so aussehen: `https://nextcloud.example.com/remote.php/dav/files/username/`, ersetze `Benutzername` und `nextcloud.example.com` mit den korrekten Werten)

### Offline-Sync {#offline}

Mit dieser Funktion können Sie Ihre Dateien auf entfernten Servern bearbeiten, während Sie offline sind. Öffnen Sie das Popup-Menü in einer Datei oder einem Ordner und klicken Sie auf `Sync`. Dies wird die Datei oder den Ordner herunterladen und lokal speichern. Um das gesamte Stammverzeichnis zu synchronisieren, Klicken Sie auf das Häkchen im Erstellungsdialog oder klicken Sie in der Einstellung auf die Fernbedienung und klicken Sie auf das Häkchen im Bereich Verwalten.

Es gibt ein paar Einschränkungen:

* Sie können nur die obere Ebene eines Verzeichnisses synchronisieren. Wenn Sie beispielsweise ein Verzeichnis `a/b/test.bfly`haben, wird diese Datei nicht synchronisiert.
* Sie können keine Datei oder einen Ordner löschen, wenn Sie offline sind.
* Sie können Vorlagen nicht hinzufügen, bearbeiten oder löschen, solange Sie offline sind.

## Other storage methods

If you are on a native device you can also sync the application directory with your favorite platform. Google drive has [an official app](https://www.google.com/drive/download/) on windows and there are unofficial onces on the play store. On linux you can also use the native remote storage system and change your data directory to this or add a new external storage if you click on the add connection button.
