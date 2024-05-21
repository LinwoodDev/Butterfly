---
title: Embed
---

Incrustar es una forma sencilla de incluir la aplicación en tu sitio web.
Añade el siguiente código a tu sitio web:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opciones

| Opción   | Tipo                                                                                              | Por defecto | Descripción                                                                                                                                                                             |
| -------- | ------------------------------------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| guardar  | Boolean (true, false)                                                          | true        | Activar guardar. Si está desactivado, sólo se mostrará un botón de salida                                                                                               |
| editable | Boolean (true, false)                                                          | true        | Activar la edición. Si está deshabilitado, el documento será de sólo lectura                                                                                            |
| language | Cadena (..., sistema, usuario) | system      | Idioma del documento. Si el sistema, el idioma se detectará desde el navegador. Si el usuario, el idioma se ajustará a las preferencias de los usuarios |

## Eventos

Ejemplos de cómo usarlo:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### guardar

> The `save` event is emitted when the user clicks the save button.

Parámetros:

- `data` (Type `List<int>`): The data of the document.

### salir

> The `exit` event is emitted when the user clicks the exit button.

Parámetros:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parámetros:

- `data` (Type `List<int>`): The data of the document.

## Métodos

Ejemplo de cómo usarlo:

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

No hay parámetros.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Parámetros:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parámetros:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parámetros:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
