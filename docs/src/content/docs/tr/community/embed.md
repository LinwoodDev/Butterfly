---
title: Yerleştirme
---

Yerleştirme işlemi, uygulamayı web sitenize dahil etmenin basit bir yoludur.
Aşağıdaki kodu web sitenize ekleyin:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Şeçenekler

| Seçenek  | Tür                                                                                           | Varsayılan | Tanım                                                                                                                                                             |
| -------- | --------------------------------------------------------------------------------------------- | ---------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| kaydet   | Boolean (true, false)                                                      | true       | Kaydetmeyi etkinleştirin. Eğer devre dışı bırakılırsa, yalnızca bir çıkış düğmesi gösterilir                                                      |
| editable | Boolean (true, false)                                                      | true       | Düzenlemeyi etkinleştir. Eğer devre dışı bırakılırsa, belge salt okunur olur                                                                      |
| dil      | String (..., system, user) | system     | Belge dili. Eğer sistem ise, dil tarayıcıdan algılanacaktır. Eğer kullanıcı ise, dil kullanıcıların tercihine göre ayarlanacaktır |

## Etkinlikler

Nasıl kullanılacağına dair örnekler:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### kaydet

> The `save` event is emitted when the user clicks the save button.

Parametreler:

- `data` (Type `List<int>`): The data of the document.

### çıkış

> The `exit` event is emitted when the user clicks the exit button.

Parametreler:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parametreler:

- `data` (Type `List<int>`): The data of the document.

## Yöntemler

Nasıl kullanılacağına dair örnekler:

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

Tür
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Parametreler:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parametreler:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parametreler:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
