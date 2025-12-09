---
title: التخزين
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## دليل البيانات

دليل البيانات هو الدليل الذي يتم فيه تخزين الوثائق والقوالب والحزم.
على سطح المكتب يمكنك العثور عليه في `~/Documents/Linwood/Butterfly`.
على الهاتف المحمول في `getExternalFilesDir(null)/Linwood/Butterfly`.
يمكنك أيضا تغييره في الإعدادات تحت `البيانات`.

في هذا الدليل سوف تجد مجلد 'Documents' و 'Templates' و 'Packs'.

## ويب

بيانات التطبيق مخزنة في المتصفح الخاص بك. يتم تخزينها في مخزن محلي.
افتح أدوات المطور في المتصفح الخاص بك وسوف ترى البيانات.

## المنصات الأصلية

بشكل افتراضي يحفظ التطبيق البيانات في مجلد المستندات الخاص بك في مجلد فرعي يسمى "لينود/الفراغة". يتم إنشاء هذا المجلد عند حفظ البيانات الأولى. يمكن تغيير هذا المجلد في الإعدادات.

## التخزين البعيد {#remote}

:::note

هذه الميزة غير متوفرة على الويب.

:::

يمكن حفظ التطبيق في خادم بعيد. هذا مفيد إذا كنت تريد مشاركة البيانات مع أشخاص آخرين أو إذا كان لديك أجهزة كمبيوتر متعددة. حاليا لا يدعم سوى بروتوكول "WebDAV".

لإضافة خادم بعيد ، انتقل إلى الإعدادات وانقر على `بعيد`. ثم انقر على `إضافة جهاز التحكم عن بعد`. ثم انقر على `إضافة جهاز التحكم عن بعد`.
إضافة عنوان URL للخادم البعيد واسم المستخدم وكلمة المرور. بعد ذلك يمكنك تحديد المجلد حيث يتم تخزين البيانات.

للحصول على عنوان ويب داف، يرجى زيارة الوثائق:

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
يحتوي محرك الأقراص Google على [تطبيق رسمي](https://www.google.com/drive/download/) على النوافذ وهناك حالات غير رسمية على متجر اللعب.
على Linux يمكنك أيضًا استخدام نظام التخزين المحلي البعيد وتغيير دليل البيانات الخاص بك إلى هذا أو إضافة وحدة تخزين خارجية جديدة إذا قمت بالنقر على زر إضافة الاتصال.

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
