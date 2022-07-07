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

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (it should look like this: `https://nextcloud.example.com/remote.php/dav/files/username/`, replace `username` and `nextcloud.example.com` with the correct values)

### Offline-Sync {#offline}

Mit dieser Funktion können Sie Ihre Dateien auf entfernten Servern bearbeiten, während Sie offline sind. Öffnen Sie das Popup-Menü in einer Datei oder einem Ordner und klicken Sie auf `Sync`. Dies wird die Datei oder den Ordner herunterladen und lokal speichern. Um das gesamte Stammverzeichnis zu synchronisieren, Klicken Sie auf das Häkchen im Erstellungsdialog oder klicken Sie in der Einstellung auf die Fernbedienung und klicken Sie auf das Häkchen im Bereich Verwalten.

Es gibt ein paar Einschränkungen:

* Sie können nur die obere Ebene eines Verzeichnisses synchronisieren. Wenn Sie beispielsweise ein Verzeichnis `a/b/test.bfly`haben, wird diese Datei nicht synchronisiert.
* Sie können keine Datei oder einen Ordner löschen, wenn Sie offline sind.
* Sie können Vorlagen nicht hinzufügen, bearbeiten oder löschen, solange Sie offline sind.
