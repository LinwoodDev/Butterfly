---
title: Хранилище
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Каталог данных

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
На мобильном устройстве находится `getExternalFilesDir(null)/Linwood/Butterfly`.
Вы также можете изменить его в настройках в разделе «Данные».

В этом каталоге вы найдете папку `Documents`, `Templates` и `Packs`.

## Веб

Данные приложения хранятся в Вашем браузере. Он хранится в локальном хранилище.
Откройте инструменты разработчика в вашем браузере, и вы увидите данные.

## Родной платформы

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Эта папка может быть изменена в настройках.

## Удаленное хранилище {#remote}

:::note

Эта функция недоступна в Интернете.

:::

The application data can be stored on a remote server. Это полезно, если вы хотите поделиться данными с другими людьми или у вас есть несколько компьютеров. В настоящее время поддерживается только протокол `WebDAV`.

Чтобы добавить удаленный сервер, перейдите в настройки и нажмите `Remotes`. Затем нажмите на `Add remote`.
Добавьте URL удаленного сервера и имя пользователя и пароль. После этого можно указать папку, в которой хранятся данные.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (это должно выглядеть так: `https://nextcloud.example.com/remote.php/dav/files/username/`, заменить `username` и `nextcloud.example.com` верными значениями)

### Автономная синхронизация {#offline}

Эта функция позволяет вам редактировать ваши файлы на удаленных серверах в автономном режиме.
Откройте всплывающее меню в файле или папке и нажмите на `Sync`. Это позволит загрузить файл или папку и сохранить его локально. Для синхронизации всего корневого каталога, установите флажок в диалоговом окне создания или нажмите на пульте дистанционного управления и нажмите на флажке в разделе Управление.

Существует несколько ограничений:

- Вы можете синхронизировать только верхний уровень каталога. Например, если у вас есть каталог `a/b/test.bfly`, этот файл не будет синхронизирован.
- Вы не можете удалить файл или папку, пока вы не в сети.
- Нельзя добавлять, редактировать или удалять шаблоны пока вы не в сети.

## Другие методы хранения

Если вы находитесь на родном устройстве, вы также можете синхронизировать папку приложения с вашей любимой платформой.
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
