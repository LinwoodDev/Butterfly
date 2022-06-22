---
title: "Storage"
sidebar_position: 2
---

## Web

The application data is stored in your browser. It is stored in a local storage.
Open the developer tools in your browser and you will see the data.

## Native platforms

As default the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save the first data. This folder can be changed in the settings.

## Remote storage

:::note

This feature is not available on the web.

:::

The application can be saved in a remote server. This is useful if you want to share the data with other people or if you have multiple computers. Currently only the `WebDAV` protocol is supported.

To add a remote server, go to the settings and click on `Remotes`. Then click on `Add remote`.
Add the URL of the remote server and the username and password. After that you can specify the folder where the data is stored.

To get the webdav url, please visit the documentation:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html)
