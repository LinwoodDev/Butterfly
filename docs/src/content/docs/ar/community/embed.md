---
title: Embed
---

التضمين طريقة بسيطة لإدراج التطبيق في موقع الويب الخاص بك.
أضف التعليمة البرمجية التالية إلى موقع الويب الخاص بك:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## خيارات

| خيار     | نوع                                                                                              | الافتراضي | الوصف                                                                                                                                                                    |
| -------- | ------------------------------------------------------------------------------------------------ | --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| حفظ      | Boolean (true, false)                                                         | true      | تمكين الحفظ. في حالة التعطيل، سيتم عرض زر الخروج فقط                                                                                                     |
| editable | Boolean (true, false)                                                         | true      | تمكين التحرير. في حالة التعطيل، سيكون المستند للقراءة فقط                                                                                                |
| language | سلسلة (...، النظام، المستخدم) | system    | () لغة الوثيقة. إذا كان النظام، سيتم اكتشاف اللغة من المتصفح. إذا كان المستخدم، سيتم تعيين اللغة إلى تفضيل المستخدمين |

## الأحداث

أمثلة على كيفية استخدامها:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### حفظ

> The `save` event is emitted when the user clicks the save button.

البارامترات:

- `data` (Type `List<int>`): The data of the document.

### الخروج

> The `exit` event is emitted when the user clicks the exit button.

البارامترات:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

البارامترات:

- `data` (Type `List<int>`): The data of the document.

## الأساليب

مثال على كيفية استخدامها:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.pushMessage('getData', {});
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'getData') {
    console.log(data.detail.message);
  }
});
```

### getData

> The `getData` method returns the data of the document.

لا توجد معلمات.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

البارامترات:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

البارامترات:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

البارامترات:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
