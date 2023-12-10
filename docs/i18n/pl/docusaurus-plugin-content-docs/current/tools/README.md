---
title: "Narzędzia"
slug: /tools
sidebar_label: "Wprowadzanie"
sidebar_position: 1
---


Narzędzia mogą edytować arkusze.

Użyj paska bocznego, aby dowiedzieć się więcej o narzędziach.

Utwórz nowe narzędzie klikając ikonę plus. Zmień kolejność narzędzia poprzez przeciąganie i zmianę narzędzia kliknięciem. Jeśli klikniesz na wybrane narzędzie możesz go skonfigurować.

Nazwa narzędzia będzie wyświetlana jako podpowiedź po najechaniu na narzędziu.

## Dostępne narzędzia

```mdx-code-block
importuj DocCardList z '@theme/DocCardList';
importuj {useCurrentSidebarCategory} z '@docusaurus/theme-common';

<DocCardList items={useCurrentSidebarCategory().items}/>
```
