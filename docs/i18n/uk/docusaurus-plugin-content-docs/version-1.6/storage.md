---
title: "Сховище"
sidebar_position: 2
---

## Веб

The application data is stored in your browser. It is stored in a local storage. Open the developer tools in your browser and you will see the data.

## Самородні платформи

As default the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save the first data. This folder can be changed in the settings.

## Віддалене сховище {#remote}

:::note

Ця функція недоступна в Інтернеті.

:::

The application can be saved in a remote server. This is useful if you want to share the data with other people or if you have multiple computers. Currently only the `WebDAV` protocol is supported.

To add a remote server, go to the settings and click on `Remotes`. Then click on `Add remote`. Add the URL of the remote server and the username and password. After that you can specify the folder where the data is stored.

Щоб отримати адресу webdav url, будь ласка, відвідайте документацію:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (це має виглядати так: `https://nextcloud.example.com/remote.php/dav/files/username/`, замінити `ім'я користувача` і `nextcloud.example.com` правильними значеннями)

### Оффлайн синхронізація {#offline}

This feature allows you to edit your files on remote servers while you are offline. Open the popup menu on a file or folder and click on `Sync`. This will download the file or folder and save it locally. To sync the whole root directory, click on the checkmark in the create dialog or click on the remote in the setting and click on the checkmark in the manage section.

Є кілька обмежень:

* Ви можете синхронізувати лише найвищий рівень каталогу. Наприклад, якщо у вас є каталог `a/b/test.bfly`, цей файл не буде синхронізовано.
* Ви не можете видалити файл або папку поки ви не в мережі.
* Ви не можете додавати, редагувати або видаляти шаблони поки ви в автономному режимі.
