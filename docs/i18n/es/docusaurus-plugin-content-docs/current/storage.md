---
title: "Almacenamiento"
sidebar_position: 2
---

## Web

Los datos de la aplicación se almacenan en su navegador. Se almacena en un almacenamiento local. Abre las herramientas del desarrollador en tu navegador y verás los datos.

## Plataformas nativas

Por defecto, la aplicación guarda los datos en la carpeta de documentos en una subcarpeta llamada "Linwood/Butterfly". Esta carpeta se crea cuando guarda los primeros datos. Esta carpeta se puede cambiar en la configuración.

## Remote storage

:::note

This feature is not available on the web.

:::

The application can be saved in a remote server. This is useful if you want to share the data with other people or if you have multiple computers. Currently only the `WebDAV` protocol is supported.

To add a remote server, go to the settings and click on `Remotes`. Then click on `Add remote`. Add the URL of the remote server and the username and password. After that you can specify the folder where the data is stored.

To get the webdav url, please visit the documentation:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html)
