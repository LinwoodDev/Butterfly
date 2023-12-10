---
title: "Strumenti"
slug: /tools
sidebar_label: "Introduzione"
sidebar_position: 1
---


Gli strumenti possono modificare la carta.

Usa la barra laterale per saperne di più sugli strumenti.

Crea un nuovo strumento facendo clic sull'icona plus. Cambia l'ordine dello strumento trascinando e cambiando lo strumento facendo clic. Se si fa clic su uno strumento selezionato è possibile configurarlo.

Il nome dello strumento verrà visualizzato come suggerimento al passaggio sullo strumento.

## Strumenti disponibili

```mdx-code-block
importa Doc CardList da '@theme/DocCardList';
importa {useCurrentSidebarCategory} da '@docusaurus/theme-common';

<DocCardList items={useCurrentSidebarCategory().items}/>
```
