---
title: Сховище
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Каталог даних

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
На мобільному телефоні він (getExternalFilesDir(null)/Linwood/Butterfly\`.
Ви також можете змінити його в налаштуваннях в розділі "Data".

У цьому каталозі ви знайдете папку `Documents`, `Templates` і `Packs`.

## Веб

Дані додатку зберігаються в вашому браузері. Він зберігається у локальному сховищі.
Відкрийте інструменти розробника в браузері і ви побачите дані.

## Самородні платформи

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Цю папку можна змінити в налаштуваннях.

## Віддалене сховище {#remote}

:::note

Ця функція недоступна в Інтернеті.

:::

The application data can be stored on a remote server. Це корисно, якщо ви хочете поділитись даними з іншими людьми або якщо у вас є декілька комп'ютерів. На даний момент підтримується тільки протокол WebDAV.

Щоб додати віддалений сервер, перейдіть до налаштувань та натисніть `Remotes`. Потім натисніть "Додати пульт".
Додайте URL-адресу віддаленого сервера, ім'я користувача і пароль. Після цього ви можете вказати папку, де зберігаються дані.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (це має виглядати так: `https://nextcloud.example.com/remote.php/dav/files/username/`, замінити `username` і `nextcloud.example.com` з правильними значеннями)

### Оффлайн синхронізація {#offline}

Ця функція дозволяє редагувати файли на віддалених серверах у автономному режимі.
Відкрийте спливаюче меню для файлу чи папки та натисніть кнопку "Синхронізація". Це завантажить файл або папку і збереже їх локально. Щоб синхронізувати весь кореневий каталог, клікніть на галочку у діалоговому вікні «Створити» або клацніть на віддаленому екрані в розділі «Керувати».

Є кілька обмежень:

- Ви можете синхронізувати лише найвищий рівень каталогу. Наприклад, якщо у вас є каталог `a/b/test.bfly` , цей файл не буде синхронізований.
- Ви не можете видалити файл або папку поки ви не в мережі.
- Ви не можете додавати, редагувати або видаляти шаблони поки ви в автономному режимі.

## Інші методи зберігання

Якщо ви на рідному пристрої, ви також можете синхронізувати каталог програми з вашою улюбленою платформою.
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
