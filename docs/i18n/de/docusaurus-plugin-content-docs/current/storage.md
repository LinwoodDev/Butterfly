---
title: "Speicher"
sidebar_position: 2
---

## Web

Die Anwendungsdaten werden in Ihrem Browser gespeichert. Es wird in einem lokalen Speicher gespeichert. Öffnen Sie die Entwicklerwerkzeuge in Ihrem Browser und Sie werden die Daten sehen.

## Native Plattformen

Standardmäßig speichert die Anwendung die Daten in Ihrem Dokumentenordner in einem Unterordner namens "Linwood/Butterfly". Dieser Ordner wird beim Speichern der ersten Daten erstellt. Dieser Ordner kann in den Einstellungen geändert werden.

## Remote storage

:::note

This feature is not available on the web.

:::

The application can be saved in a remote server. This is useful if you want to share the data with other people or if you have multiple computers. Currently only the `WebDAV` protocol is supported.

To add a remote server, go to the settings and click on `Remotes`. Then click on `Add remote`. Add the URL of the remote server and the username and password. After that you can specify the folder where the data is stored.

To get the webdav url, please visit the documentation:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html)
