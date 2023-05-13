---
title: 嵌入
sidebar_label: 简介
---

嵌入是一种简单的方式，可以在您的网站中包含应用程序。 添加以下代码到您的网站：

```html
<iframe src="https://butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## 备选方案

| 选项       | 类型                    | 默认设置   | 描述                                        |
| -------- | --------------------- | ------ | ----------------------------------------- |
| save     | Boolean (true, false) | true   | 启用保存。 如果禁用，只显示退出按钮                        |
| editable | Boolean (true, false) | true   | 启用编辑。 如果禁用，文档将只读                          |
| language | 字符串 (..., 系统, 用户)     | system | 文件所用语文。 如果系统从浏览器中检测到该语言。 如果用户，语言将设置为用户首选项 |

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

### save

> 当用户点击保存按钮时， `保存` 事件将被发出。

参数：

* `数据` (键盘 `列表<int>`): 文档的数据。

### exit

> 当用户点击退出按钮时， `退出` 事件将被发出。

参数：

* `数据` (键盘 `列表<int>`): 文档的数据。

### change

> 当用户更改文档时， `更改` 事件将被发布。

参数：

* `数据` (键盘 `列表<int>`): 文档的数据。

## 方法

如何使用它的示例：

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.pusMessage('getData', {});
Element.addEventListener('message', (data) => }
  if(data.detail.type === 'getData') }
    console.log(data.detail.message);
  }
});
```

### getData

> `getData` 方法返回文档的数据。

没有参数。 返回： `列表<int>`

### setData

> `setData` 方法设置文档的数据。

参数：

* `数据` (键盘 `列表<int>`): 文档的数据。

### render

> `渲染` 方法将文档渲染为 png 图像。

参数：

* `宽度` (类型 `编号`)：图像的宽度。
* `高度` (类型 `数字`)：图像的高度
* `缩放` (类型 `编号`)：图像的尺寸。
* `渲染背景` (类型 `布尔值`)：如果为 true，背景将会被渲染。

返回： `字符串` (Base64 编码的图像)

### renderSVG

> `渲染SVG` 方法将文档渲染为 svg 图像。

参数：

* `宽度` (类型 `编号`)：图像的宽度。
* `高度` (类型 `数字`)：图像的高度
* `渲染背景` (类型 `布尔值`)：如果为 true，背景将会被渲染。

返回： `字符串` (SVG)
