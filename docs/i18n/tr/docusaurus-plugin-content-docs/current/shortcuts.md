---
title: "Kısayollar"
sidebar_position: 2
---


## Klavye

Düzenleyicide kullanabileceğiniz birkaç kısayol vardır. Bazıları düğmelerin altında yazılmıştır.

### Genel

* `Ctrl` + `N`: Yeni dosya
* `Ctrl` + `Shift` + `N`: Şablondan yeni dosya
* `Ctrl` + `E`: Dosyayı dışa aktar
* `Ctrl` + `P`: Print file
* `Ctrl` + `Shift` + `E`: Resim olarak dışa aktar
* `Ctrl` + `Alt` + `E`: SVG olarak dışa aktar
* `Ctrl` + `Alt` + `Shift` + `E`: Export file as svg
* `Ctrl` + `Alt` + `P`: Open packs
* `Ctrl` + `Alt` + `S`: Ayarları aç

### Proje

* `Ctrl` + `Z`: Geri al
* `Ctrl` + `Y`: Yinele
* `Ctrl` + `Shift` + `P`: Yer imleri iletişim kutusunu aç
* `Ctrl` + `B`: Arkaplan iletişim kutusunu aç
* `Ctrl` + `Shift` + `A`: Alanlar iletişim kutusunu aç
* `Ctrl` + `S`: Kaydet
* `Alt` + `S`: Yolu değiştir
* `Ctrl` + (`1` - `0`): Switch to tool
* `Ctrl` + `+`: Zoom in
* `Ctrl` + `-`: Zoom out

## Kalem

By default, the the pen is configured to function as the following:
* `Pen`: configured as pen.
* `First` (Primary button, if supported): Change to hand tool while pressed.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Yapılandır {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

* Empty - the tool is unchaged.
* 0 - the tool will function as moving (i.e., hand) in this mod.
* Positive number - The tool will follow the indexing as explain above. 


