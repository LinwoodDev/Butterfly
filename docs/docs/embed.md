---
title: Embed
---

Embedding is a simple way to include the app in your website.
Add the following code to your website:

```html

<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Options

| Option   | Type                      | Default | Description                                                                           |
|----------|---------------------------|---------|---------------------------------------------------------------------------------------|
| save     | Boolean (true, false)     | true    | Enable save. If disabled, only an exit button will be shown                           |
| editable | Boolean (true, false)     | true    | Enable editing. If disabled, the document will be read-only                           |
| theme    | user, system, light, dark | user    | The theme to use. If user, the theme will be chosen by the user in the settings       |
| language | String                    | user    | The language to use. If user, the language will be chosen by the user in the settings |

## Events

### onSave

> The `onSave` event is emitted when the user clicks the save button.

Parameters:

* `data` (Type `String`): The data of the document.

```javascript
onSave: (data) => {
  // Do something
}
```

### onExit

> The `onExit` event is emitted when the user clicks the exit button.

Parameters:

* `data` (Type `String`): The data of the document.

```javascript
onExit: (data) => {
  // Do something
}
```

### onChange

> The `onChange` event is emitted when the user changes the document.

Parameters:

* `data` (Type `String`): The data of the document.

```javascript
onChange: (data) => {
  // Do something
}
```

## Methods

### getData

> The `getData` method returns the data of the document.

No parameters.
Returns: `String`

```javascript
const data = getData()
```

### setData

> The `setData` method sets the data of the document.

Parameters:

* `data` (Type `String`): The data of the document.

```javascript
setData(data)
 ```

### render

> The `render` method renders the document to a png image.

Parameters:

* `width` (Type `Number`): The width of the image.
* `height` (Type `Number`): The height of the image.
* `scale` (Type `Number`): The scale of the image.

Returns: `String` (Base64 encoded image)

```javascript
const image = render(width, height, scale)
 ```

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parameters:

* `width` (Type `Number`): The width of the image.
* `height` (Type `Number`): The height of the image.

Returns: `String` (SVG)

```javascript
const svg = renderSVG(width, height)
 ```
