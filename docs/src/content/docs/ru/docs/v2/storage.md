---
title: Хранилище
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Data directory {#data-directory}

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
На мобильном устройстве находится `getExternalFilesDir(null)/Linwood/Butterfly`.
Вы также можете изменить его в настройках в разделе «Данные».

В этом каталоге вы найдете папку `Documents`, `Templates` и `Packs`.

## Web {#web}

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

[Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (it should look like this: `https://nextcloud.example.com/remote.php/dav/files/username/`, replace `username` and `nextcloud.example.com` with the correct values)

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

### Автономная синхронизация {#offline}

Эта функция позволяет вам редактировать ваши файлы на удаленных серверах в автономном режиме.
Откройте всплывающее меню в файле или папке и нажмите на `Sync`. Это позволит загрузить файл или папку и сохранить его локально. Для синхронизации всего корневого каталога, установите флажок в диалоговом окне создания или нажмите на пульте дистанционного управления и нажмите на флажке в разделе Управление.

Существует несколько ограничений:

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
These included JSON files aren't optimized to be readable by a human in its raw form.

### Butterfly Raw Note (.tbfly)

This file is recommended for use with version control software like git.

This file is **not** a zip archive; instead it is a _JSON_ file.
It contains all the information about the note in a single JSON file that is optimized for being readable and nicely formatted. It is slower to load than the normal Butterfly Note.

### SVG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by Butterfly.
