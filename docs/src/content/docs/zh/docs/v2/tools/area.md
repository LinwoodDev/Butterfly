---
title: 区域工具
---

区域工具用来创建，编辑和删除区域。

For an overview of how areas work, see [Areas](../areas).

## 动作

|    鼠标   |   触控  |   动作  |
| :-----: | :---: | :---: |
| 左键单击并拖动 | 点击并拖动 | 创建新区域 |
|   中键点击  |  双手指  |  移动画布 |
|   右键点击  |   长按  |  编辑区域 |

## 配置

|  属性 | 默认值 | 描述                                                                                                                                                                                                                                                                                                                                                                                                                     |
| --: | :-: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  宽度 | `0` | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|  高度 | `0` | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| 宽高比 | `0` | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

三个宽高比预设如下：

- 正方形(1:1)
- 竖屏(sqrt(2)) - 这是竖屏模式下A4页面的默认宽高比。
- 横屏(1/sqrt(2)) - 这是横屏模式下A4页面的默认宽高比。
