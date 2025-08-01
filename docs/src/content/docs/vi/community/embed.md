---
title: Embed
---

Embedding is a simple way to include the app in your website.
Add the following code to your website:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Options

| Option   | Loại                                                                                          | Default | Mô tả                                                                                                                                                                       |
| -------- | --------------------------------------------------------------------------------------------- | ------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| lưu      | Boolean (true, false)                                                      | true    | Enable save. If disabled, only an exit button will be shown                                                                                                 |
| editable | Boolean (true, false)                                                      | true    | Enable editing. If disabled, the document will be read-only                                                                                                 |
| language | String (..., system, user) | system  | Language of the document. If system, the language will be detected from the browser. If user, the language will set to the users preference |

## Events

Examples how to use it:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### lưu

> The `save` event is emitted when the user clicks the save button.

Parameters:

- `data` (Type `List<int>`): The data of the document.

### exit

> The `exit` event is emitted when the user clicks the exit button.

Parameters:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parameters:

- `data` (Type `List<int>`): The data of the document.

## Methods

Example how to use it:

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

No parameters.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Parameters:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parameters:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parameters:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
