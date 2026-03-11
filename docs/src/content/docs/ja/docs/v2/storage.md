---
title: ストレージ
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## データディレクトリ

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
モバイルでは、 `getExternalFilesDir(null)/Linwood/Butterfly` にあります。
`Data` の設定で変更することもできます。

このディレクトリには、`Documents`、`Templates`、`Packs`フォルダがあります。

## ウェブ

アプリケーションデータはブラウザに保存されます。 ローカルストレージに保存されます。
ブラウザで開発者ツールを開くと、データが表示されます。

## ネイティブプラットフォーム

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. このフォルダは設定で変更できます。

## リモートストレージ {#remote}

:::note

この機能はウェブ上では利用できません。

:::

The application data can be stored on a remote server. これは、データを他の人と共有したい場合や、複数のコンピュータをお持ちの場合に便利です。 現在 `WebDAV` プロトコルのみがサポートされています。

リモートサーバーを追加するには、設定に移動して `Remotes` をクリックします。 `Add remote` をクリックします。
リモートサーバーの URL とユーザー名とパスワードを追加します。 その後、データが格納されているフォルダを指定できます。

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) （`https://nextcloud.example.com/remote.php/dav/files/username/`、`username` と `nextcloud.example.com` は正しい値に置き換えてください）

### オフライン同期 {#offline}

この機能を使用すると、オフライン中にリモートサーバー上のファイルを編集できます。
ファイルまたはフォルダのポップアップメニューを開き、`Sync`をクリックします。 ファイルまたはフォルダをダウンロードし、ローカルに保存します。 ルートディレクトリ全体を同期する 作成ダイアログでチェックマークをクリックするか、設定内のリモコンをクリックし、管理セクションのチェックマークをクリックします。

いくつかの制限があります。

- ディレクトリのトップレベルのみ同期できます。 例えば、`a/b/test.bfly`ディレクトリがある場合、このファイルは同期されません。
- オフライン中はファイルやフォルダを削除できません。
- オフライン中はテンプレートの追加、編集、削除はできません。

## その他のストレージ方法

ネイティブデバイスを使用している場合は、お気に入りのプラットフォームとアプリケーションディレクトリを同期することもできます。
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
