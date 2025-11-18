---
title: الاختصارات
---

## لوحة المفاتيح

هناك بعض الاختصارات التي يمكنك استخدامها في المحرر.
بعضها مكتوب أسفل الأزرار.

### عام

- `Ctrl` + `N`: ملف جديد
- 'Ctrl' + 'Shift' + 'N': ملف جديد من القالب
- `Ctrl` + `E`: تصدير الملف
- `Ctrl` + `Shift` + `E`: Export file (text based)
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as image
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Shift` + `P`: Export file as pdf
- `Ctrl` + `Alt` + `S`: فتح الإعدادات
- `Ctrl` + `Alt` + `P`: فتح الحزم

### مشروع

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: التراجع
- `Ctrl` + `Y`: إعادة
- 'Ctrl' + 'Shift' + 'P': فتح مربع حوار إحداثيات الطريق
- `Ctrl` + `B`: فتح مربع حوار الخلفية
- `Ctrl` + `S`: حفظ
- `Alt` + `S`: تغيير المسار
- `Ctrl` + (`1` - `0`): التبديل إلى أداة
- `Ctrl` + `+`: تكبير في
- `Ctrl` + `-`: تكبير خارجي

## القلم

بشكل افتراضي، يتم تكوين القلم ليعمل كالتالي:

- `القضية`: تم تكوينها كقلم.
- 'أولا\\` (الزر الأساسي، إذا كان مدعوماً): قم بتغيير الأداة اليدوية أثناء الضغط عليها.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## Configuring {#configure}

You can customize your controls by changing which tools your inputs map to.

**Note:** Input configurations will be ignored while certain tools are selected, such as the Lasso Select tool, the Rectangle Select tool, the Label tool, and the Area tool.

To begin, go to `Settings` → `Inputs` and then select the input method you want to configure, such as `Mouse`, `Touch`, or `Pen`. You will be presented with a list of configurable inputs and the tools they are currently mapped to.

After selecting an input, you will have 3 options:

- `Active Tool`: The input will act as the currently selected tool on the toolbar.
- `Hand Tool`: The input will temporarily switch to the hand tool, allowing you to move around the canvas.
- `Specific Tool on Toolbar`: The input will temporarily switch to a tool on your toolbar, based on the position number you specify. Positions are counted starting from the left, so if you specify position `1`, the first tool on the left will be selected. See the screenshot below for an example of how position numbers are counted. For information about how to reorder your tools, see [Customizing the Toolbar](../intro/#customizing-the-toolbar).

![شريط الأدوات] (toolbar_numbered.png)
