---
title: "Depolama"
sidebar_position: 2
---

## Ağ

Uygulama verileri tarayıcınızda saklanır. Yerel bir depoda saklanır. Tarayıcınızda geliştirici araçlarını açın, verileri göreceksiniz.

## Yerel Platformlar

Varsayılan olarak uygulama verileriö belgeler klasörünüzdeki "Linwood/Butterfly" adlı bir alt klasöre kaydeder. Bu klasör, ilk veri kaydınızda oluşturulur. Bu klasör ayarlardan değiştirilebilir.

## Uzak depolama {#remote}

:::note

Bu özellik web'de mevcut değildir.

:::

Uygulama uzak bir sunucuya kaydedilebilir. Bu, verileri başkalarıyla paylaşmak istiyorsanız veya birden fazla bilgisayarınız varsa kullanışlıdır. Şu anda yalnızca `WebDAV` protokolü desteklenmektedir.

Uzak sunucu eklemek için ayarlara gidin ve `Remotes`'a tıklayın. Ardından `Remote ekle`'yi tıklayın. Uzak sunucunun URL'sini, kullanıcı adını ve şifreyi ekleyin. Bundan sonra verilerin depolandığı klasörü belirleyebilirsiniz.

Webdav Url'sini almak için lütfen belgeleri ziyaret edin:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (şöyle görünmelidir: `https://nextcloud.example.com/remote.php/dav/files/username/` ,  adres satırındaki `username` ve `nextcloud.example.com` ifadelerini doğru değerler ile değiştirin)

### Çevrimdışı eşitleme {#offline}

Bu özellik, çevrimdışıyken uzak sunuculardaki dosyalarınızı düzenlemenize olanak tanır. Bir dosya veya klasörde açılır menüyü açın ve `Sync`'i tıklayın. Bu işlem, dosyayı veya klasörü indirecek ve yerel olarak kaydedecektir. Tüm kök dizini senkronize etmek için "oluştur iletişim kutusu"ndaki onay işaretine tıklayın veya ayarlarda remote'u ve yönet bölümündeki onay işaretine tıklayın.

Birkaç sınırlama vardır:

* Bir dizinin yalnızca en üst düzeyini eşitleyebilirsiniz. Örneğin, `a/b/test.bfly` dizininiz varsa, bu dosya senkronize edilmeyecektir.
* Çevrimdışıyken bir dosya veya klasörü silemezsiniz.
* Çevrimdışıyken şablon ekleyemez, düzenleyemez veya silemezsiniz.
