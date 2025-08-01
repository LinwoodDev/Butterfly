---
title: Embed
---

Встраивание - это простой способ включить приложение на ваш сайт.
Добавьте следующий код на ваш сайт:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Варианты

| Вариант   | Тип                                                                                                    | По умолчанию | Описание                                                                                                                                                                 |
| --------- | ------------------------------------------------------------------------------------------------------ | ------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| сохранить | Boolean (true, false)                                                               | true         | Включить сохранение. Если отключено, будет показана только кнопка выхода                                                                                 |
| editable  | Boolean (true, false)                                                               | true         | Включить редактирование. Если отключено, документ будет доступен только для чтения                                                                       |
| язык      | Строка (..., система, пользователь) | system       | Язык документа. Если система, то язык будет обнаружен из браузера. Если пользователь, язык будет установлен в предпочтение пользователей |

## События

Примеры его использования:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### сохранить

> The `save` event is emitted when the user clicks the save button.

Параметры:

- `data` (Type `List<int>`): The data of the document.

### выход

> The `exit` event is emitted when the user clicks the exit button.

Параметры:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Параметры:

- `data` (Type `List<int>`): The data of the document.

## Методы

Пример его использования:

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

Нет параметров.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Параметры:

- `data` (Type `List<int>`): The data of the document.

### рендер

> The `render` method renders the document to a png image.

Параметры:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Параметры:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
