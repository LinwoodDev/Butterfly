---
title: 嵌入
---

嵌入是一种简单的方式，可以在您的网站中包含应用程序。
添加以下代码到您的网站：

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## 备选方案

| 选项  | 类型                                                                                   | 默认设置 | 描述                                        |
| --- | ------------------------------------------------------------------------------------ | ---- | ----------------------------------------- |
| 保存  | 布尔值(true，false)                                                   | true | 启用保存。 如果禁用，只显示退出按钮                        |
| 可编辑 | 布尔值(true，false)                                                   | true | 启用编辑。 如果禁用，文档将只读                          |
| 语言  | 字符串 (..., 系统, 用户) | 系统   | 文件所用语文。 如果系统从浏览器中检测到该语言。 如果用户，语言将设置为用户首选项 |

## 事件

如何使用的示例：

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### 保存

> The `save` event is emitted when the user clicks the save button.

参数：

- `data` (Type `List<int>`): The data of the document.

### 退出

> The `exit` event is emitted when the user clicks the exit button.

参数：

- `data` (Type `List<int>`): The data of the document.

### change

> The `change` event is emitted when the user changes the document.

参数：

- `data` (Type `List<int>`): The data of the document.

## 方法

如何使用它的示例：

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

没有参数。
Returns: `List<int>`

### setData

> The `setData` method sets the data of the document.

参数：

- `data` (Type `List<int>`): The data of the document.

### render

> The `render` method renders the document to a png image.

参数：

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `scale` (Type `Number`): The scale of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (Base64 encoded image)

### renderSVG

> The `renderSVG` method renders the document to a svg image.

参数：

- `width` (Type `Number`): The width of the image.
- `height` (Type `Number`): The height of the image.
- `renderBackground` (Type `Boolean`): If true, the background will be rendered.

Returns: `String` (SVG)
