---
title: Хранилище
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Каталог данных

Каталог данных - это каталог, в котором хранятся документы, шаблоны и пакеты.
На рабочем столе вы можете найти его в `~/Documents/Linwood/Butterfly`.
На мобильном устройстве находится `getExternalFilesDir(null)/Linwood/Butterfly`.
Вы также можете изменить его в настройках в разделе «Данные».

В этом каталоге вы найдете папку `Documents`, `Templates` и `Packs`.

## Веб

Данные приложения хранятся в Вашем браузере. Он хранится в локальном хранилище.
Откройте инструменты разработчика в вашем браузере, и вы увидите данные.

## Родной платформы

По умолчанию приложение сохраняет данные в папке документов в подпапке под названием "Linwood/Butterfly". Эта папка создается при сохранении первых данных. Эта папка может быть изменена в настройках.

## Удаленное хранилище {#remote}

:::note

Эта функция недоступна в Интернете.

:::

Приложение может быть сохранено на удаленном сервере. Это полезно, если вы хотите поделиться данными с другими людьми или у вас есть несколько компьютеров. В настоящее время поддерживается только протокол `WebDAV`.

Чтобы добавить удаленный сервер, перейдите в настройки и нажмите `Remotes`. Затем нажмите на `Add remote`.
Добавьте URL удаленного сервера и имя пользователя и пароль. После этого можно указать папку, в которой хранятся данные.

Для получения адреса webdav посетите документацию:

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
В Google диске есть [официальное приложение](https://www.google.com/drive/download/) в Windows, и в Play Store есть неофициальные приложения.
На linux вы также можете использовать родную систему удаленного хранения и изменить папку с данными в эту папку или добавить новое внешнее хранилище, если вы нажмете на кнопку Добавить соединение.

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
