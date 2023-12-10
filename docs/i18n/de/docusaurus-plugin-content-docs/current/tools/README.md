---
title: "Werkzeuge"
slug: /tools
sidebar_label: "Einführung"
sidebar_position: 1
---


Werkzeuge können das Papier bearbeiten.

Über die Sidebar erfahren Sie mehr über die Werkzeuge.

Erstellen Sie ein neues Werkzeug, indem Sie auf das Plus-Symbol klicken. Ändern Sie die Werkzeugreihenfolge durch Ziehen und Ändern des Werkzeugs durch Klicken. Wenn Sie auf ein ausgewähltes Werkzeug klicken, können Sie es konfigurieren.

Der Name des Werkzeugs wird als Tooltip beim Schweben des Werkzeugs angezeigt.

## Verfügbare Werkzeuge

```mdx-code-block
importiere DocCardList von '@theme/DocCardList';
importiere {useCurrentSidebarCategory} von '@docusaurus/theme-common';

<DocCardList items={useCurrentSidebarCategory().items}/>
```
