---
title: Speicher
sidebar_position: 2
---

Es gibt mehrere Möglichkeiten, Notizen in Butterfly zu speichern.
Entweder über den Speicher Ihres Geräts oder über Cloud-Speicher (WebDAV).

## Data directory {#data-directory}

Das Datenverzeichnis ist das Verzeichnis, in dem Dokumente, Vorlagen und Packs gespeichert werden.
Auf dem Desktop finden Sie es unter `~/Documents/Linwood/Butterfly`.
Auf dem Handy ist es in `getExternalFilesDir(null)/Linwood/Butterfly`.
Sie können es auch in den Einstellungen unter "Data" ändern.

In diesem Verzeichnis finden Sie einen Ordner `Documents`, `Templates` und `Packs`.

## Web {#web}

Die Anwendungsdaten werden in Ihrem Browser gespeichert. Es wird in einem lokalen Speicher gespeichert.
Öffnen Sie die Entwicklerwerkzeuge in Ihrem Browser und Sie werden die Daten sehen.

## Native Plattformen

Standardmäßig speichert die Anwendung die Daten in Ihrem Dokumente-Ordner in einem Unterordner namens „Linwood/Butterfly“. Dieser Ordner wird erstellt, wenn Sie zum ersten Mal Daten speichern. Dieser Ordner kann in den Einstellungen geändert werden.

## Entfernter Speicher {#remote}

:::note

Diese Funktion ist im Web nicht verfügbar.

:::

Die Anwendungsdaten können auf einem Remote-Server gespeichert werden. Dies ist nützlich, wenn Sie die Daten mit anderen Personen teilen möchten oder wenn Sie mehrere Computer haben. Derzeit wird nur das `WebDAV` Protokoll unterstützt.

Um einen entfernten Server hinzuzufügen, gehen Sie zu den Einstellungen und klicken Sie auf `Remotes`. Dann klicken Sie auf `Add remote`.
Fügen Sie die URL des entfernten Servers und den Benutzernamen und das Passwort hinzu. Danach können Sie den Ordner angeben, in dem die Daten gespeichert werden.

Um die WebDAV-URL zu erhalten, besuche bitte die Dokumentation:

[Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (es sollte so aussehen: `https://nextcloud.example.com/remote.php/dav/files/username/`, ersetzen Sie `username` und `nextcloud.example.com` mit den korrekten Werten)

### Instructions for NextCloud

#### How to get the URL

1. Go to `Files`
   ![](@assets/img/webDAV/URLstep1.png)
2. Press the button on the bottom of the sidebar `Files settings`
   ![](@assets/img/webDAV/URLstep2.png)
3. Scroll down to the `WebDAV` section, then copy the full URL shown inside
   ![](@assets/img/webDAV/URLstep3and4.png)
4. Switch to Butterfly, and paste the URL in the URL input box in Butterfly
   ![](@assets/img/webDAV/URLstep5.png)

#### How to get the password and username

1. Go to your Nextcloud account info by pressing the profile picture on the corner
2. Then, press `Settings`
   ![](@assets/img/webDAV/Name1.png)
3. In the Security tab, scroll down to `Devices & sessions`
4. Enter any name for the app name input box
   - "Butterfly Connection" is a good name to use, as it is identifiable and clear.
5. Press the button called `Create new app password`
   ![](@assets/img/webDAV/Name2.png)
6. After authenticating, copy the app password username shown on the page, and paste it in the username input box in Butterfly
   ![](@assets/img/webDAV/Name3.png)
7. Finally, copy the password and paste it in the password input box in Butterfly
   ![](@assets/img/webDAV/Name4.png)

#### Finalizing the connection setup

After doing the above, press the `Connect` button.

If you have done everything correctly, there will be some new stuff down the popup.
![2 new input boxes appear down the list in the popup](@assets/img/webDAV/Directory1.jpg)

Type the name of this connection in the `Name` inputbox, you can name it anything.

Then, for the `Directory` inputbox, you need to type where should Butterfly store stuff inside this cloud storage.

For example:
if you type `ButterflyDocs` for `Directory`, Butterfly will store all your files inside the `ButterflyDocs` folder in your cloud storage.

:::note

- Avoid symbols in folder names (to be safe)
- Butterfly will create the folder if it doesnt exist
  :::

Lastly, after typing the name of the folder you want Butterfly to store your notes in, press `Create`.

That's it. Syncing to the cloud should work now. 🎉

### Offline-Sync {#offline}

Mit dieser Funktion können Sie Ihre Dateien auf entfernten Servern bearbeiten, während Sie offline sind.
Öffnen Sie das Popup-Menü in einer Datei oder einem Ordner und klicken Sie auf `Sync`. Dies wird die Datei oder den Ordner herunterladen und lokal speichern. Um das gesamte Stammverzeichnis zu synchronisieren, Klicken Sie auf das Häkchen im Erstellungsdialog oder klicken Sie in der Einstellung auf die Fernbedienung und klicken Sie auf das Häkchen im Bereich Verwalten.

Es gibt ein paar Einschränkungen:

- Sie können keine Datei oder einen Ordner löschen, wenn Sie offline sind.
- Sie können Vorlagen nicht hinzufügen, bearbeiten oder löschen, solange Sie offline sind.

## Andere Speichermethoden

Wenn Sie auf einem nativen Gerät sind, können Sie auch das Anwendungsverzeichnis mit Ihrer Lieblingsplattform synchronisieren.
Google Drive hat unter Windows [eine offizielle App](https://www.google.com/drive/download/), und im Play Store gibt es inoffizielle Apps.
Unter Linux können Sie auch das native Remote-Speichersystem verwenden und Ihr Datenverzeichnis dorthin ändern oder über die Schaltfläche zum Hinzufügen einer Verbindung einen neuen externen Speicher hinzufügen.

## Unterstützte Dateitypen

Butterfly unterstützt den Import von SVG, Butterfly-Notiz (.bfly) und Butterfly-Rohnotiz (.tbfly).

### Butterfly-Notiz (.bfly)

Dieser Dateityp ist das empfohlene Format zum Speichern von Notizen.

Es ist ein ZIP-Archiv, das Informationen über die Notiz enthält, größtenteils in JSON-Dateien.
These included JSON files aren't optimized to be readable by a human in its raw form.

### Butterfly-Rohnotiz (.tbfly)

Diese Datei wird für die Verwendung mit Versionsverwaltungssoftware wie Git empfohlen.

Diese Datei ist **kein** ZIP-Archiv, sondern eine _JSON_-Datei.
Sie enthält alle Informationen zur Notiz in einer einzelnen JSON-Datei, die für Lesbarkeit und saubere Formatierung optimiert ist. Sie lädt langsamer als die normale Butterfly-Notiz.

### SVG

Dieser Dateityp speichert keine Informationen über die Notiz!
Wenn diese Datei in Butterfly importiert wird, wird sie als einzelnes Bild behandelt.

Verwende dies _NUR_, wenn die Notiz nicht von Butterfly verändert werden soll.
