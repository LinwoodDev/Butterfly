---
title: Storage
sidebar_position: 2
---


There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV). 

## Data directory

The data directory is the directory where documents, templates and packs are stored.
On the desktop you can found it in `~/Documents/Linwood/Butterfly`.
On mobile it's in `getExternalFilesDir(null)/Linwood/Butterfly`.
You can also change it in the settings under `Data`.

In this directory you will find a folder `Documents`, `Templates` and `Packs`.

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

[Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (it should look like this: `https://nextcloud.example.com/remote.php/dav/files/username/`, replace `username` and `nextcloud.example.com` with the correct values)

#### How to get the URL
1. Go to 'Files'
2. Open the 'Files settings'
3. Choose the 'WebDAV' section in the sidebar
4. Copy the URL
5. Paste the URL in the URL input box in Butterfly
#### How to get the password and username
1. Go to your Nextcloud account info by pressing the profile picture on the corner
2. Press 'Settings'
3. In the security info tab, scroll down to 'Devices & sessions'
4. Enter any name for the app name input box
    - "Butterfly Connection" is a good name to use, as it is identifiable and clear.
5. Press the button called 'Create new app password'
6. Authenticate
7. Copy the email/login text and paste it in the username input box in Butterfly
8. Copy the password and paste it in the password input box in Butterfly
### Offline sync {#offline}

This feature allows you to edit your files on remote servers while you are offline.
Open the popup menu on a file or folder and click on `Sync`. This will download the file or folder and save it locally. To sync the whole root directory, click on the checkmark in the create dialog or click on the remote in the setting and click on the checkmark in the manage section.

There are a few limitations:

* You can only sync the top level of a directory. For example if you have a directory `a/b/test.bfly`, this file will not be synced.
* You cannot delete a file or folder while you are offline.
* You cannot add, edit or delete templates while you are offline.

## Other storage methods

If you are on a native device you can also sync the application directory with your favorite platform.
Google drive has [an official app](https://www.google.com/drive/download/) on windows and there are unofficial onces on the play store.
On linux you can also use the native remote storage system and change your data directory to this or add a new external storage if you click on the add connection button.

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
