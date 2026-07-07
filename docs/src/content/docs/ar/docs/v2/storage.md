---
title: التخزين
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## دليل البيانات

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
على الهاتف المحمول في `getExternalFilesDir(null)/Linwood/Butterfly`.
يمكنك أيضا تغييره في الإعدادات تحت `البيانات`.

في هذا الدليل سوف تجد مجلد 'Documents' و 'Templates' و 'Packs'.

## ويب

بيانات التطبيق مخزنة في المتصفح الخاص بك. يتم تخزينها في مخزن محلي.
افتح أدوات المطور في المتصفح الخاص بك وسوف ترى البيانات.

## المنصات الأصلية

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. يمكن تغيير هذا المجلد في الإعدادات.

## التخزين البعيد {#remote}

:::note

هذه الميزة غير متوفرة على الويب.

:::

The application data can be stored on a remote server. هذا مفيد إذا كنت تريد مشاركة البيانات مع أشخاص آخرين أو إذا كان لديك أجهزة كمبيوتر متعددة. حاليا لا يدعم سوى بروتوكول "WebDAV".

لإضافة خادم بعيد ، انتقل إلى الإعدادات وانقر على `بعيد`. ثم انقر على `إضافة جهاز التحكم عن بعد`. ثم انقر على `إضافة جهاز التحكم عن بعد`.
إضافة عنوان URL للخادم البعيد واسم المستخدم وكلمة المرور. بعد ذلك يمكنك تحديد المجلد حيث يتم تخزين البيانات.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (يجب أن يبدو مثل هذا: `https://nextcloud.example.com/remote.php/dav/files/username/`، استبدال `username' و `nextcloud.example.com\\` بالقيم الصحيحة)

### المزامنة دون اتصال {#offline}

هذه الميزة تسمح لك بتعديل الملفات الخاصة بك على الخوادم البعيدة عندما تكون غير متصل.
افتح القائمة المنبثقة على ملف أو مجلد وانقر على 'مزامنة\\`. سيؤدي هذا إلى تنزيل الملف أو المجلد وحفظه محلياً. لمزامنة الدليل الجذر بأكمله، انقر فوق علامة الاختيار في مربع حوار إنشاء أو انقر على جهاز التحكم في الإعداد وانقر على علامة الاختيار في قسم الإدارة.

وهناك بعض القيود:

- يمكنك فقط مزامنة المستوى الأعلى من الدليل. على سبيل المثال إذا كان لديك دليل 'a/b/test.bfly\`، لن يتم مزامنة هذا الملف.
- لا يمكنك حذف ملف أو مجلد عندما تكون غير متصل.
- لا يمكنك إضافة أو تحرير أو حذف قوالب عندما تكون غير متصل.

## طرق التخزين الأخرى

إذا كنت على جهاز أصلي يمكنك أيضا مزامنة دليل التطبيق مع المنصة المفضلة لديك.
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
