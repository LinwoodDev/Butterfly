---
title: "Maler"
slug: /maler
sidebar_label: "Einführung"
sidebar_position: 1
---


Maler können das Papier bearbeiten.

Mit der Sidebar erfahren Sie mehr über die Maler.

Erstellen Sie einen neuen Maler, indem Sie auf das Plus-Symbol klicken. Ändern Sie die Reihenfolge des Malers durch Ziehen und Ändern des Malers durch Anklicken. Wenn Sie auf einen ausgewählten Maler klicken, können Sie ihn konfigurieren.

Der Name des Malers wird als Tooltipp beim Schweben auf dem Maler angezeigt.

## Verfügbare Maler

```mdx-code-block
importiere DocCardList von '@theme/DocCardList';
importiere {useCurrentSidebarCategory} von '@docusaurus/theme-common';

<DocCardList items={useCurrentSidebarCategory().items}/>
```
