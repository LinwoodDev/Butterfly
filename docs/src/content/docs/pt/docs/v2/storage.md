---
title: Armazenamento
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Diretório de dados

O diretório de dados é o diretório onde documentos, modelos e pacotes são armazenados.
Na área de trabalho você pode encontrá-la em `~/Documents/Linwood/Butterfly`.
No dispositivo móvel está em `getExternalFilesDir(null)/Linwood/Butterfly`.
Você também pode alterá-lo nas configurações em `Data`.

Neste diretório você encontrará uma pasta `Documents`, `Templates` e `Packs`.

## Web

Os dados do aplicativo são armazenados no seu navegador. Ele é armazenado em um armazenamento local.
Abra as ferramentas de desenvolvedor no seu navegador e você verá os dados.

## Plataformas nativas

Como padrão, a aplicação salva os dados na pasta de documentos em uma subpasta chamada "Linwood/Butterfly". Esta pasta é criada quando você salva os primeiros dados. Esta pasta pode ser alterada nas configurações.

## Armazenamento remoto {#remote}

:::note

Este recurso não está disponível na web.

:::

O aplicativo pode ser salvo em um servidor remoto. Isso é útil se você quiser compartilhar os dados com outras pessoas ou se você tiver vários computadores. Atualmente, apenas o protocolo `WebDAV` é suportado.

Para adicionar um servidor remoto, vá para as configurações e clique em `Remotes`. Em seguida, clique em 'Adicionar remoto'.
Adicione a URL do servidor remoto e o nome de usuário e senha. Depois disso, você pode especificar a pasta onde os dados são armazenados.

Para obter o URL do webdav, por favor, visite a documentação:

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
O Google drive possui [um aplicativo oficial](https://www.google.com/drive/download/) nas janelas e há ondas não oficiais na Play Store.
No Linux, você também pode usar o sistema de armazenamento remoto nativo e alterar o diretório de dados para isto ou adicionar um novo armazenamento externo se você clicar no botão adicionar conexão.

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
