---
title: Embed
---

Embutir é uma maneira simples de incluir o aplicativo em seu site.
Adicione o seguinte código ao seu site:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opções

| Alternativa | tipo                                                                                              | Padrão | Descrição:                                                                                                                                                     |
| ----------- | ------------------------------------------------------------------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| guardar     | Boolean (true, false)                                                          | true   | Habilitar salvamento. Se desativado, somente um botão de saída será mostrado                                                                                   |
| editable    | Boolean (true, false)                                                          | true   | Habilitar edição. Se desativado, o documento será somente leitura                                                                                              |
| language    | String (..., sistema, usuário) | system | Idioma do documento. Se o sistema, o idioma será detectado do navegador. Se o usuário, o idioma será ajustado para as preferências de usuários |

## Eventos

Exemplo de como usá-lo:

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

Parâmetros:

- `data` (Type `List<int>`): The data of the document.

### sair

> The `exit` event is emitted when the user clicks the exit button.

Parâmetros:

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

Parâmetros:

- `data` (Type `List<int>`): The data of the document.

## Métodos

Exemplo de como usá-lo:

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

Nenhum parâmetro.
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

Parâmetros:

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

Parâmetros:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

Parâmetros:

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
