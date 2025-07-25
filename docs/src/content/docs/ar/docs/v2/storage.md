---
title: التخزين
sidebar_position: 2
---

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
