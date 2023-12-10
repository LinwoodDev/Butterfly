---
title: "Pasty do malowania"
slug: /farby
sidebar_label: "Wprowadzanie"
sidebar_position: 1
---


Paintery mogą edytować arkusze.

Użyj paska bocznego, aby dowiedzieć się więcej o malarstwach.

Utwórz nowy malarz klikając ikonę plus. Zmień kolejność farby poprzez przeciąganie i zmianę farby kliknięciem. Jeśli klikniesz wybraną farbę, możesz ją skonfigurować.

Nazwa farby będzie wyświetlana jako podpowiedź po najechaniu na malarze.

## Dostępne malarstwa

```mdx-code-block
importuj DocCardList z '@theme/DocCardList';
importuj {useCurrentSidebarCategory} z '@docusaurus/theme-common';

<DocCardList items={useCurrentSidebarCategory().items}/>
```
