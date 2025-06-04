---
title: Embed
---

Embutir é uma maneira simples de incluir o aplicativo em seu site.
Adicione o seguinte código ao seu site:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opções

| Alternativa | Tipo                                                                                              | Padrão | Descrição                                                                                                                                                                      |
| ----------- | ------------------------------------------------------------------------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| save        | Boolean (true, false)                                                          | true   | Habilitar salvamento. Se desativado, somente um botão de saída será mostrado                                                                                   |
| editable    |                                                                                                   | true   | Habilitar edição. Se desativado, o documento será somente leitura                                                                                              |
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

### save

> O evento `save` é emitido quando o usuário clica no botão salvar.

Parâmetros:

- `dados` (Tipo `List<int>`): Os dados do documento.

### exit

> O evento `exit` é emitido quando o usuário clica no botão de sair.

Parâmetros:

- `data` (Tipo `List<int>`): Os dados do documento.

### change

> O evento `change` é emitido quando o usuário altera o documento.

Parâmetros:

- `data` (Tipo `List<int>`): Os dados do documento.

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

> O método `getData` retorna os dados do documento.

Nenhum parâmetro.
Retorna: `List<int>`

### setData

> O método `setData` define os dados do documento.

Parâmetros:

- `data` (Tipo  `List<int>`): Os dados do documento.

### render

> O método `render` renderiza o documento em uma imagem png.

Parâmetros:

- `width` (Tipo `Number`): A largura da imagem.
- `height` (Tipo `Number`): A altura da imagem.
- `scale` (Tipo `Number`): A escala da imagem.
- `renderBackground` (Tipo `Boolean`): Se `true`, o fundo será renderizado.

Retorna: `String` (imagem codificada em Base64)

### renderSVG

> O método `renderSVG` renderiza o documento em uma imagem svg.

Parâmetros:

- `width` (Tipo  `Number`): A largura da imagem.
- `height` (Tipo `Number`): A altura da imagem.
- `renderBackground` (Tipo `Boolean`): Se `true`, o plano de fundo será renderizado.

Retorna: `String` (SVG)
