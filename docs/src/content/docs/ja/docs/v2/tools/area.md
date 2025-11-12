---
title: Area tool
---

The area tool allows you to create, edit and remove areas.

For an overview of how areas work, see [Areas](../areas).

## アクション

|     マウス     |    タッチ    |   アクション   |
| :---------: | :-------: | :-------: |
| 左クリックしてドラッグ | タップしてドラッグ | 新しいエリアを作成 |
|    中央クリック   |    2本の指   |  キャンバスを移動 |
|    右クリック    |   ロングタップ  |   エリアを編集  |

## 設定

|     属性 | デフォルト | 説明                                                                                                                                                                                                                                                                                                                                                                                                                     |
| -----: | :---: | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|  Width |  `0`  | The fixed width for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                            |
|     高さ |  `0`  | The fixed height for new areas. If set to `0`, this setting will be ignored.                                                                                                                                                                                                                                                                                                           |
| アスペクト比 |  `0`  | The fixed aspect ratio for new areas. Press the <DotsThreeVertical className="inline-icon"/> button to access some common presets. An aspect ratio is defined as width / height, so values less than `1` will be taller than they are wide, and values greater than `1` will be wider than they are tall. If set to `0`, this setting will be ignored. |

アスペクト比のプリセットは3つあります:

- 正方形（1:1）
- Page portrait (sqrt(2)) - 縦向きモードの A4 ページのデフォルトのアスペクト比です。
- 横画面(1/sqrt(2)) - 横画面モードのA4ページの縦横比です。
