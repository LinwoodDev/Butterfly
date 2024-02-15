---
title: الاختصارات
sidebar_position: 2
---

## Keyboard

هناك بعض الاختصارات التي يمكنك استخدامها في المحرر.
بعضها مكتوب أسفل الأزرار.

### عام

- `Ctrl` + `N`: ملف جديد
- 'Ctrl' + 'Shift' + 'N': ملف جديد من القالب
- `Ctrl` + `E`: تصدير الملف
- `Ctrl` + `P`: طباعة الملف
- 'Ctrl' + 'Shift' + 'E': تصدير الملف كصورة
- `Ctrl` + `Alt` + `E`: تصدير الملف كـ svg
- `Ctrl` + `Alt` + `Shift` + `E`: تصدير الملف كـ svg
- `Ctrl` + `Alt` + `P`: فتح الحزم
- `Ctrl` + `Alt` + `S`: فتح الإعدادات

### مشروع

- `Ctrl` + `Z`: التراجع
- `Ctrl` + `Y`: إعادة
- 'Ctrl' + 'Shift' + 'P': فتح مربع حوار إحداثيات الطريق
- `Ctrl` + `B`: فتح مربع حوار الخلفية
- 'Ctrl' + 'Shift' + 'A': فتح مربع حوار المناطق
- `Ctrl` + `S`: حفظ
- `Alt` + `S`: تغيير المسار
- `Ctrl` + (`1` - `0`): التبديل إلى أداة
- `Ctrl` + `+`: تكبير في
- `Ctrl` + `-`: تكبير خارجي

## القلم

By default, the the pen is configured to function as the following:

- `Pen`: configured as pen.
- `First` (Primary button, if supported): Change to hand tool while pressed.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.

## تكوين {#configure}

You can customize the controls by giving every control a tool index. The tool indexing starts from the left of the toolbar, with `1` being the first index. See example below

![toolbar numbered](toolbar_numbered.png)

Here, 1 refers to the lasso tool, 2, to the pan tool etc.

The configure options you have are the following:

- Empty - the tool is unchaged.
- 0 - the tool will function as moving (i.e., hand) in this mod.
- Positive number - The tool will follow the indexing as explain above.
