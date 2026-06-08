---
title: Embed
---

Embutir é uma maneira simples de incluir o aplicativo em seu site.
Adicione o seguinte código ao seu site:

```html
<iframe
  id="butterfly"
  src="https://web.butterfly.linwood.dev/embed"
  width="100%"
  height="500px"
  allowtransparency="true"
></iframe>
```

## Opções

| Alternativa | Tipo                                                                                              | Padrão | Descrição                                                                                                                                                                      |
| ----------- | ------------------------------------------------------------------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| save        | Boolean (true, false)                                                          | true   | Habilitar salvamento. Se desativado, somente um botão de saída será mostrado                                                                                   |
| editable    |                                                                                                   | true   | Habilitar edição. Se desativado, o documento será somente leitura                                                                                              |
| language    | String (..., sistema, usuário) | user   | Idioma do documento. Se o sistema, o idioma será detectado do navegador. Se o usuário, o idioma será ajustado para as preferências de usuários |

## Messaging

The embed uses browser `postMessage` events. Send messages to the iframe with
`iframe.contentWindow.postMessage({ type, message }, origin)`. Butterfly sends
messages back to the parent window with the same shape:
`{ type: string, message?: unknown }`.

See the [embedding example](/community/embed-example/) for a live page that sends
messages to the iframe and listens for messages from it.

```html
<iframe
  id="butterfly"
  src="https://web.butterfly.linwood.dev/embed?save=true&editable=true"
  width="100%"
  height="500"
></iframe>

<script>
  const butterflyOrigin = 'https://web.butterfly.linwood.dev';
  const butterfly = document.querySelector('#butterfly');

  function sendToButterfly(type, message) {
    butterfly.contentWindow.postMessage({ type, message }, butterflyOrigin);
  }

  window.addEventListener('message', (event) => {
    if (
      event.origin !== butterflyOrigin ||
      event.source !== butterfly.contentWindow
    ) {
      return;
    }

    const { type, message } = event.data ?? {};

    if (type === 'save') {
      const documentBytes = Array.from(message);
      console.log('Save requested by the embed', documentBytes);
    }

    if (type === 'change') {
      console.log('Document changed', message);
    }

    if (type === 'getData') {
      console.log('Current document bytes', message);
    }

    if (type === 'render') {
      const image = new Image();
      image.src = `data:image/png;base64,${message}`;
      document.body.append(image);
    }
  });

  butterfly.addEventListener('load', () => {
    sendToButterfly('getData');

    sendToButterfly('render', {
      x: 0,
      y: 0,
      width: 600,
      height: 400,
      scale: 1,
      renderBackground: true,
    });
  });
</script>
```

To load document bytes into the embed, send an array of byte values:

```javascript
sendToButterfly('setData', documentBytes);
```

## Eventos

Listen for events with `window.addEventListener('message', ...)`.

### save

> O evento `save` é emitido quando o usuário clica no botão salvar.

Parâmetros:

- `message` (Type `List<int>`): The data of the document.

### exit

> O evento `exit` é emitido quando o usuário clica no botão de sair.

Parâmetros:

- `message` (Type `List<int>`): The data of the document.

### change

> O evento `change` é emitido quando o usuário altera o documento.

Parâmetros:

- `message` (Type `List<int>`): The data of the document.

## Métodos

Call methods with `iframe.contentWindow.postMessage(...)`. Methods that return
data send another message back with the same `type`.

### getData

> O método `getData` retorna os dados do documento.

Nenhum parâmetro.
Retorna: `List<int>`

### setData

> O método `setData` define os dados do documento.

Parâmetros:

- `dados` (Tipo `List<int>`): Os dados do documento.

### render

> O método `render` renderiza o documento em uma imagem png.

Parâmetros:

- `x` (Type `Number`): The x position of the exported area.
- `y` (Type `Number`): The y position of the exported area.
- `width` (Tipo `Number`): A largura da imagem.
- `height` (Tipo `Number`): A altura da imagem.
- `scale` (Tipo `Number`): A escala da imagem.
- `renderBackground` (Tipo `Boolean`): Se `true`, o fundo será renderizado.

Retorna: `String` (imagem codificada em Base64)

### renderSVG

> O método `renderSVG` renderiza o documento em uma imagem svg.

Parâmetros:

- `x` (Type `Number`): The x position of the exported area.
- `y` (Type `Number`): The y position of the exported area.
- `width` (Tipo  `Number`): A largura da imagem.
- `height` (Tipo `Number`): A altura da imagem.
- `renderBackground` (Tipo `Boolean`): Se `true`, o plano de fundo será renderizado.

Retorna: `String` (SVG)
