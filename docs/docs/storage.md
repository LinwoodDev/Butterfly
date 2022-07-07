---
title: "Storage"
sidebar_position: 2
---

## Web

The application data is stored in your browser. It is stored in a local storage.
Open the developer tools in your browser and you will see the data.

## Native platforms

As default the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save the first data. This folder can be changed in the settings.

## Remote storage {#remote}

:::note

This feature is not available on the web.

:::

The application can be saved in a remote server. This is useful if you want to share the data with other people or if you have multiple computers. Currently only the `WebDAV` protocol is supported.

To add a remote server, go to the settings and click on `Remotes`. Then click on `Add remote`.
Add the URL of the remote server and the username and password. After that you can specify the folder where the data is stored.

To get the webdav url, please visit the documentation:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (it should look like this: `https://nextcloud.example.com/remote.php/dav/files/username/`, replace `username` and `nextcloud.example.com` with the correct values)

### Offline sync {#offline}

This feature allows you to edit your files on remote servers while you are offline.
Open the popup menu on a file or folder and click on `Sync`. This will download the file or folder and save it locally. To sync the whole root directory, click on the checkmark in the create dialog or click on the remote in the setting and click on the checkmark in the manage section.

There are a few limitations:

* You can only sync the top level of a directory. For example if you have a directory `a/b/test.bfly`, this file will not be synced.
* You cannot delete a file or folder while you are offline.
* You cannot add, edit or delete templates while you are offline.
