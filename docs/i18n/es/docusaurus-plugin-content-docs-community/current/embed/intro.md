---
title: Incrustar
sidebar_label: Introducción
---

Incrustar es una forma sencilla de incluir la aplicación en tu sitio web. Añade el siguiente código a tu sitio web:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opciones

| Opción   | Tipo                           | Por defecto | Descripción                                                                                                                                             |
| -------- | ------------------------------ | ----------- | ------------------------------------------------------------------------------------------------------------------------------------------------------- |
| ahorra   | Booleano (verdadero, falso)    | verdad      | Activar guardar. Si está desactivado, sólo se mostrará un botón de salida                                                                               |
| editable | Booleano (verdadero, falso)    | verdad      | Activar la edición. Si está deshabilitado, el documento será de sólo lectura                                                                            |
| idioma   | Cadena (..., sistema, usuario) | sistema     | Idioma del documento. Si el sistema, el idioma se detectará desde el navegador. Si el usuario, el idioma se ajustará a las preferencias de los usuarios |

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

### ahorra

> El evento `guardar` se emite cuando el usuario hace clic en el botón guardar.

Parámetros:

* `data` (Escriba `Lista<int>`): Los datos del documento.

### salir

> El evento `salir` se emite cuando el usuario hace clic en el botón de salida.

Parámetros:

* `data` (Escriba `Lista<int>`): Los datos del documento.

### cambiar

> El evento `cambiar` se emite cuando el usuario cambia el documento.

Parámetros:

* `data` (Escriba `Lista<int>`): Los datos del documento.

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

> El método `getData` devuelve los datos del documento.

No hay parámetros. Devuelve: `Lista<int>`

### setData

> El método `setData` establece los datos del documento.

Parámetros:

* `data` (Escriba `Lista<int>`): Los datos del documento.

### renderizar

> El método `render` renderiza el documento a una imagen png.

Parámetros:

* `ancho` (Escriba `Número`): El ancho de la imagen.
* `altura` (Tipo `Número`): La altura de la imagen.
* `escala` (Escribe `Número`): La escala de la imagen.
* `renderBackground` (Escribe `Boolean`): Si es verdadero, el fondo será renderizado.

Devuelve: `String` (imagen codificada en Base64)

### renderizarSVG

> El método `renderSVG` renderiza el documento a una imagen svg.

Parámetros:

* `ancho` (Escriba `Número`): El ancho de la imagen.
* `altura` (Tipo `Número`): La altura de la imagen.
* `renderBackground` (Escribe `Boolean`): Si es verdadero, el fondo será renderizado.

Devuelve: `String` (SVG)
