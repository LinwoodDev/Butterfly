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
