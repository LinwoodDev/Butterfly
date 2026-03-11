---
title: Almacenamiento
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Directorio de datos

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
En móvil está en `getExternalFilesDir(null)/Linwood/Butterfly`.
También puedes cambiarlo en la configuración bajo `Data`.

En este directorio encontrarás una carpeta `Documents`, `Templates` y `Packs`.

## Web

Los datos de la aplicación se almacenan en su navegador. Se almacena en un almacenamiento local.
Abre las herramientas del desarrollador en tu navegador y verás los datos.

## Plataformas nativas

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Esta carpeta se puede cambiar en la configuración.

## Almacenamiento remoto {#remote}

:::note

Esta característica no está disponible en la web.

:::

The application data can be stored on a remote server. Esto es útil si desea compartir los datos con otras personas o si tiene varios equipos. Actualmente sólo el protocolo `WebDAV` es compatible.

Para añadir un servidor remoto, vaya a la configuración y haga clic en `Remotes`. Luego haga clic en `Agregar remoto`.
Añadir la URL del servidor remoto y el nombre de usuario y contraseña. Después, puede especificar la carpeta donde se almacenan los datos.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/es/files/access_webdav.html) (debería verse así: `https://nextcloud.example.com/remote.php/dav/files/username/`, reemplazar `username` y `nextcloud.example.com` con los valores correctos)

### Sincronización sin conexión {#offline}

Esta función le permite editar sus archivos en servidores remotos mientras esté fuera de línea.
Abre el menú emergente en un archivo o carpeta y haz clic en `Sync`. Esto descargará el archivo o carpeta y lo guardará localmente. Para sincronizar todo el directorio raíz, haga clic en la marca de verificación en el diálogo de crear o haga clic en el control remoto en la configuración y haga clic en la marca de verificación en la sección de administración.

Hay algunas limitaciones:

- Solo puedes sincronizar el nivel superior de un directorio. Por ejemplo, si tienes un directorio `a/b/test.bfly`, este archivo no será sincronizado.
- No puede eliminar un archivo o carpeta mientras esté desconectado.
- No puede añadir, editar o eliminar plantillas mientras esté desconectado.

## Otros métodos de almacenamiento

Si estás en un dispositivo nativo, también puedes sincronizar el directorio de aplicaciones con tu plataforma favorita.
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
