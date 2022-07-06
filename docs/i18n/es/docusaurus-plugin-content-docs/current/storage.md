---
title: "Almacenamiento"
sidebar_position: 2
---

## Web

Los datos de la aplicación se almacenan en su navegador. Se almacena en un almacenamiento local. Abre las herramientas del desarrollador en tu navegador y verás los datos.

## Plataformas nativas

Por defecto, la aplicación guarda los datos en la carpeta de documentos en una subcarpeta llamada "Linwood/Butterfly". Esta carpeta se crea cuando guarda los primeros datos. Esta carpeta se puede cambiar en la configuración.

## Almacenamiento remoto {#remote}

:::note

Esta característica no está disponible en la web.

:::

La aplicación se puede guardar en un servidor remoto. Esto es útil si desea compartir los datos con otras personas o si tiene varios equipos. Actualmente sólo se admite el protocolo `WebDAV`.

Para añadir un servidor remoto, ve a la configuración y haz clic en `Remotas`. Luego haga clic en `Añadir remoto`. Añadir la URL del servidor remoto y el nombre de usuario y contraseña. Después, puede especificar la carpeta donde se almacenan los datos.

Para obtener la url webdav, por favor visite la documentación:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html)

### Offline sync {#offline}

This feature allows you to edit your files on remote servers while you are offline. Open the popup menu on a file or folder and click on `Sync`. This will download the file or folder and save it locally. To sync the whole root directory, click on the checkmark in the create dialog or click on the remote in the setting and click on the checkmark in the manage section.

There are a few limitations:

* You can only sync the top level of a directory. For example if you have a directory `a/b/test.bfly`, this file will not be synced.
* You cannot delete a file or folder while you are offline.
* You cannot add, edit or delete templates while you are offline.
