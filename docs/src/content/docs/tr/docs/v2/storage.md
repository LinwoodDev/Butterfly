---
title: Depolama
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Veri dizini

The data directory is the directory where documents, templates and packs are stored.
On the desktop you can found it in `~/Documents/Linwood/Butterfly`.
On mobile it's in `getExternalFilesDir(null)/Linwood/Butterfly`.
You can also change it in the settings under `Data`.

In this directory you will find a folder `Documents`, `Templates` and `Packs`.

## Ağ

Uygulama verileri tarayıcınızda saklanır. Yerel bir depoda saklanır.
Tarayıcınızda geliştirici araçlarını açın, verileri göreceksiniz.

## Yerel Platformlar

Varsayılan olarak uygulama verileriö belgeler klasörünüzdeki "Linwood/Butterfly" adlı bir alt klasöre kaydeder. Bu klasör, ilk veri kaydınızda oluşturulur. Bu klasör ayarlardan değiştirilebilir.

## Remote storage {#remote}

:::note

Bu özellik web'de mevcut değildir.

:::

Uygulama uzak bir sunucuya kaydedilebilir. Bu, verileri başkalarıyla paylaşmak istiyorsanız veya birden fazla bilgisayarınız varsa kullanışlıdır. Currently only the `WebDAV` protocol is supported.

To add a remote server, go to the settings and click on `Remotes`. Then click on `Add remote`.
Uzak sunucunun URL'sini, kullanıcı adını ve şifreyi ekleyin. Bundan sonra verilerin depolandığı klasörü belirleyebilirsiniz.

Webdav Url'sini almak için lütfen belgeleri ziyaret edin:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (it should look like this: `https://nextcloud.example.com/remote.php/dav/files/username/`, replace `username` and `nextcloud.example.com` with the correct values)

### Offline sync {#offline}

Bu özellik, çevrimdışıyken uzak sunuculardaki dosyalarınızı düzenlemenize olanak tanır.
Open the popup menu on a file or folder and click on `Sync`. Bu işlem, dosyayı veya klasörü indirecek ve yerel olarak kaydedecektir. Tüm kök dizini senkronize etmek için "oluştur iletişim kutusu"ndaki onay işaretine tıklayın veya ayarlarda remote'u ve yönet bölümündeki onay işaretine tıklayın.

Birkaç sınırlama vardır:

- Bir dizinin yalnızca en üst düzeyini eşitleyebilirsiniz. For example if you have a directory `a/b/test.bfly`, this file will not be synced.
- Çevrimdışıyken bir dosya veya klasörü silemezsiniz.
- Çevrimdışıyken şablon ekleyemez, düzenleyemez veya silemezsiniz.

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
