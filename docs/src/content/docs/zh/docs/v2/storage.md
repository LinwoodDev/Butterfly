---
title: 存储
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Data directory {#data-directory}

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
移动时，它在 `getExternalFilesDir(null)/Linwood/Butterfly` 中。
您也可以在“数据”下的设置中更改它。

在这个目录中，你会找到一个文件夹 `Documents`, `Templates` 和 `Packs` 。

## Web {#web}

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

### 离线同步 {#offline}

此功能允许您在离线时在远程服务器上编辑文件。
在文件或文件夹中打开弹出菜单，然后点击“同步”。 这将下载文件或文件夹并在本地保存。 同步整个根目录， 点击创建对话框中的复选标记或点击设置中的远程，然后点击管理部分中的复选标记。

有一些限制：

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
These included JSON files aren't optimized to be readable by a human in its raw form.

### Butterfly Raw Note (.tbfly)

This file is recommended for use with version control software like git.

This file is **not** a zip archive; instead it is a _JSON_ file.
It contains all the information about the note in a single JSON file that is optimized for being readable and nicely formatted. It is slower to load than the normal Butterfly Note.

### SVG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by Butterfly.
