---
title: 存储
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## 数据目录

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
移动时，它在 `getExternalFilesDir(null)/Linwood/Butterfly` 中。
您也可以在“数据”下的设置中更改它。

在这个目录中，你会找到一个文件夹 `Documents`, `Templates` 和 `Packs` 。

## Web

应用程序数据存储在您的浏览器。 它存储在本地存储中。
在您的浏览器中打开开发者工具，您将看到数据。

## 原生平台

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. 此文件夹可以在设置中更改。

## 远程存储 {#remote}

:::note

此功能在网络上不可用。

:::

The application data can be stored on a remote server. 如果您想要与其他人分享数据，或者如果您有多台计算机，这是有用的。 目前只支持 `WebDAV` 协议。

若要添加远程服务器，请前往设置并点击 "Remotes" 。 然后点击"添加远程"。
添加远程服务器的 URL 以及用户名和密码。 之后您可以指定存储数据的文件夹。

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/serverura/user_manual/en/files/access_webdav.html) (它看起来像这样：`https://nextcloud.example.com/remote.php/dav/files/username/`, 替换`username` 和 `nextcloud.example.com`

### 离线同步 {#offline}

此功能允许您在离线时在远程服务器上编辑文件。
在文件或文件夹中打开弹出菜单，然后点击“同步”。 这将下载文件或文件夹并在本地保存。 同步整个根目录， 点击创建对话框中的复选标记或点击设置中的远程，然后点击管理部分中的复选标记。

有一些限制：

- 您只能同步目录的顶级。 例如，如果您有一个目录 `a/b/test.bfly`，此文件将不会同步。
- 您不能在离线时删除文件或文件夹。
- 您不能在离线时添加、编辑或删除模板。

## 其他存储方法

如果您在本地设备上，您也可以将应用程序目录与您最喜欢的平台同步。
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
