---
title: "Malířské tmely"
slug: /malíře
sidebar_label: "Úvod"
sidebar_position: 1
---


Tiskárny mohou dokument upravovat.

Pomocí postranního panelu se dozvíte více o malířích.

Vytvořte novou malbu kliknutím na ikonu plus. Změňte pořadí malování přetažením a změňte malbu kliknutím. Pokud klepnete na vybraný malíř, můžete jej nakonfigurovat.

Název malíře se zobrazí jako nápověda při najetí na malíři.

## Dostupné malby

```mdx-code-block
importovat DocCardList z '@theme/DocCardList';
import {useCurrentSidebarCategory} z '@docusaurus/theme-common';

<DocCardList items={useCurrentSidebarCategory().items}/>
```
