---
title: Embed
sidebar_label: Intro
---

Embedding is a simple way to include the app in your website. Add the following code to your website:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Options

| Option   | Type                      | Standard | Beschreibung                                                                          |
| -------- | ------------------------- | -------- | ------------------------------------------------------------------------------------- |
| save     | Boolean (true, false)     | true     | Enable save. If disabled, only an exit button will be shown                           |
| editable | Boolean (true, false)     | true     | Enable editing. If disabled, the document will be read-only                           |
| theme    | user, system, light, dark | user     | The theme to use. If user, the theme will be chosen by the user in the settings       |
| language | String                    | user     | The language to use. If user, the language will be chosen by the user in the settings |

## Events

Examples how to use it:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('save', (data) => {
  console.log('Saving...');
});
```

### save

> The `save` event is emitted when the user clicks the save button.

Parameters:

* `data` (Type `String`): The data of the document.

### exit

> The `exit` event is emitted when the user clicks the exit button.

Parameters:

* `data` (Type `String`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parameters:

* `data` (Type `String`): The data of the document.

## Methods

Example how to use it:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.dispatchEvent(new CustomEvent('getData', {}));
embedElement.addEventListener('message', (data) => {
  if(data.type === 'getData') {
    console.log(data.message);
  }
});
```

### getData

> The `getData` method returns the data of the document.

No parameters. Returns: `String`

### setData

> The `setData` method sets the data of the document.

Parameters:

* `data` (Type `String`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parameters:

* `width` (Type `Number`): The width of the image.
* `height` (Type `Number`): The height of the image.
* `scale` (Type `Number`): The scale of the image.
* `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parameters:

* `width` (Type `Number`): The width of the image.
* `height` (Type `Number`): The height of the image.
* `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
