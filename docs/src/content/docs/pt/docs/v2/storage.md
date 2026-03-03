---
title: Armazenamento
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Diretório de dados

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
No dispositivo móvel está em `getExternalFilesDir(null)/Linwood/Butterfly`.
Você também pode alterá-lo nas configurações em `Data`.

Neste diretório você encontrará uma pasta `Documents`, `Templates` e `Packs`.

## Web

Os dados do aplicativo são armazenados no seu navegador. Ele é armazenado em um armazenamento local.
Abra as ferramentas de desenvolvedor no seu navegador e você verá os dados.

## Plataformas nativas

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Esta pasta pode ser alterada nas configurações.

## Armazenamento remoto {#remote}

:::note

Este recurso não está disponível na web.

:::

The application data can be stored on a remote server. Isso é útil se você quiser compartilhar os dados com outras pessoas ou se você tiver vários computadores. Atualmente, apenas o protocolo `WebDAV` é suportado.

Para adicionar um servidor remoto, vá para as configurações e clique em `Remotes`. Em seguida, clique em 'Adicionar remoto'.
Adicione a URL do servidor remoto e o nome de usuário e senha. Depois disso, você pode especificar a pasta onde os dados são armazenados.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (deve se parecer com isto: `https://nextcloud.example.com/remote.php/dav/files/username/`, substitua `username` e `nextcloud.example.com` com os valores corretos)

### Sincronização off-line {#offline}

Este recurso permite que você edite seus arquivos em servidores remotos enquanto estiver offline.
Abra o menu pop-up em um arquivo ou pasta e clique em `Sincronizar`. Isto irá baixar o arquivo ou pasta e salvá-lo localmente. Para sincronizar todo o diretório raiz, clique na marca de seleção na caixa de diálogo Criar ou clique no controle remoto na configuração e clique na marca de seleção na seção Gerenciar.

Existem algumas limitações:

- Você só pode sincronizar o nível superior de um diretório. Por exemplo, se você tiver um diretório `a/b/test.bfly`, esse arquivo não será sincronizado.
- Não é possível excluir um arquivo ou pasta enquanto você está offline.
- Você não pode adicionar, editar ou excluir modelos enquanto estiver offline.

## Outros métodos de armazenamento

Se você está em um dispositivo nativo, também pode sincronizar o diretório do aplicativo com a sua plataforma favorita.
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
