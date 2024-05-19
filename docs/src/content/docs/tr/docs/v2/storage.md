---
title: Depolama
sidebar_position: 2
---

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
