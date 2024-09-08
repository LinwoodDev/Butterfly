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

> 当用户点击保存按钮时会释放“保存”事件。

参数：

- `data` (Type `list<int>`): 文档的数据。

### 退出

> 当用户点击退出按钮时，会释放“退出”事件。

参数：

- `data` (Type `list<int>`): 文档的数据。

### 更改

> 当用户更改文档时，"变更"事件将被发布。

参数：

- `data` (Type `list<int>`): 文档的数据。

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

> `getData` 方法返回文档的数据。

没有参数。
返回：`List<int>`

### 设置数据

> `setData`方法设置文档的数据。

参数：

- `data` (Type `list<int>`): 文档的数据。

### 渲染

> `render` 方法将文档渲染为 png 图像。

参数：

- `width` (Type `Number` )：图像的宽度。
- `height` (类型`Number`)：图像的高度
- `scale`(Type `Number`): 图像的尺度。
- `renderBackground` (Type `Boolean`)：如果为 true，背景将会渲染。

返回: `String` (Base64 编码的图像)

### 渲染SVG

> `renderSVG` 方法将文档渲染为 svg 图像。

参数：

- `width` (Type `Number` )：图像的宽度。
- `height` (类型`Number`)：图像的高度
- `renderBackground` (Type `Boolean`)：如果为 true，背景将会渲染。

返回： `String` (SVG)
