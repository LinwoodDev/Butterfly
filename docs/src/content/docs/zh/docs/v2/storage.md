---
title: 存储
sidebar_position: 2
---

## 数据目录

数据目录是存储文档、模板和包的目录。
在桌面上你可以在 "~/Documents/Linwood/Butterfly" 中找到它。
移动时，它在 `getExternalFilesDir(null)/Linwood/Butterfly` 中。
您也可以在“数据”下的设置中更改它。

在这个目录中，你会找到一个文件夹 `Documents`, `Templates` 和 `Packs` 。

## Web

应用程序数据存储在您的浏览器。 它存储在本地存储中。
在您的浏览器中打开开发者工具，您将看到数据。

## 原生平台

默认情况下，应用程序在一个名为“Linwood/Butterfly”的子文件夹中保存您的文档文件夹中的数据。 保存第一个数据时创建此文件夹。 此文件夹可以在设置中更改。

## 远程存储 {#remote}

:::note

此功能在网络上不可用。

:::

应用程序可以保存到远程服务器。 如果您想要与其他人分享数据，或者如果您有多台计算机，这是有用的。 目前只支持 `WebDAV` 协议。

若要添加远程服务器，请前往设置并点击 "Remotes" 。 然后点击"添加远程"。
添加远程服务器的 URL 以及用户名和密码。 之后您可以指定存储数据的文件夹。

若要获取 webdav url，请访问文档：

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
Google 驱动器在窗口上有[官方应用](https://www.google.com/drive/download/)并且在游戏商店上有非官方应用。
在 Linux 上，您也可以使用本地远程存储系统并将您的数据目录更改为这个或者添加一个新的外部存储，如果您点击添加连接按钮。
