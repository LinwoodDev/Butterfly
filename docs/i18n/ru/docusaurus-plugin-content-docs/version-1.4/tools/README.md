---
slug: /tools
title: "Инструменты"
sidebar_label: "Введение"
sidebar_position: 0
---


Инструменты могут изменять камеру или выбирать объекты.

Используйте боковую панель, чтобы узнать больше о инструментах.

Если вы нажмете на выбранный инструмент, вы можете настроить его.

## Доступные инструменты

```mdx-code-block
импортировать список DocCardList из '@theme/DocCardList';
импортировать {useCurrentSidebarCategory} из '@docusaurus/theme-common';

<DocCardList items={useCurrentSidebarCategory().items}/>
```
