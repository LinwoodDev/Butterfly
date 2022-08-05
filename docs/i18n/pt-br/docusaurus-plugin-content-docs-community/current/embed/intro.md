---
title: Incorporar
sidebar_label: Introdução
---

Embutir é uma maneira simples de incluir o aplicativo em seu site. Adicione o seguinte código ao seu site:

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Opções

| Alternativa | tipo                           | Padrão  | Descrição:                                                                                                                                     |
| ----------- | ------------------------------ | ------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| save        | Boolean (true, false)          | true    | Habilitar salvamento. Se desativado, somente um botão de saída será mostrado                                                                   |
| editable    | Boolean (true, false)          | true    | Habilitar edição. Se desativado, o documento será somente leitura                                                                              |
| language    | String (..., sistema, usuário) | Sistema | Idioma do documento. Se o sistema, o idioma será detectado do navegador. Se o usuário, o idioma será ajustado para as preferências de usuários |

## Eventos

Exemplo de como usá-lo:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Salvar...', data.detail.message);

});
```

### save

> O evento `salvar` é emitido quando o usuário clica no botão salvar.

Parâmetros:

* `data` (Tipo `String`): Os dados do documento.

### exit

> O evento `exit` é emitido quando o usuário clica no botão de sair.

Parâmetros:

* `data` (Tipo `String`): Os dados do documento.

### change

> O evento `alterar` é emitido quando o usuário altera o documento.

Parâmetros:

* `data` (Tipo `String`): Os dados do documento.

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

Nenhum parâmetro. Retorna: `String`

### setData

> O método `setData` define os dados do documento.

Parâmetros:

* `data` (Tipo `String`): Os dados do documento.

### render

> O método `render` renderiza o documento em uma imagem png

Parâmetros:

* `largura` (Tipo `Número`): A largura da imagem.
* `height` (Tipo `Number`): A altura da imagem.
* `scale` (Type `Number`): A escala da imagem.
* `renderBackground` (Tipo `Boolean`): Se verdadeiro, o fundo será renderizado.

Retorna: `String` (imagem codificada em Base64)

### renderSVG

> O método `renderSVG` renderiza o documento a uma imagem svg.

Parâmetros:

* `largura` (Tipo `Número`): A largura da imagem.
* `height` (Tipo `Number`): A altura da imagem.
* `renderBackground` (Tipo `Boolean`): Se verdadeiro, o fundo será renderizado.

Retorna: `String` (SVG)
