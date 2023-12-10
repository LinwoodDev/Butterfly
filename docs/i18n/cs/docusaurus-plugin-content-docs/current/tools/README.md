---
title: "Nástroje a nářadí"
slug: /tools
sidebar_label: "Úvod"
sidebar_position: 1
---


Nástroje mohou dokument upravovat.

Pomocí postranního panelu se dozvíte více o nástrojích.

Vytvořte nový nástroj kliknutím na ikonu plus. Změňte pořadí nástrojů přetažením a změnou nástroje kliknutím. Pokud klepnete na vybraný nástroj, můžete jej nakonfigurovat.

Název nástroje se zobrazí jako nápověda na nástěnce.

## Dostupné nástroje

```mdx-code-block
importovat DocCardList z '@theme/DocCardList';
import {useCurrentSidebarCategory} z '@docusaurus/theme-common';

<DocCardList items={useCurrentSidebarCategory().items}/>
```
