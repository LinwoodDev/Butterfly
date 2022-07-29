---
title: "Painters"
slug: araçlar
sidebar_label: "Introduction"
sidebar_position: 1
---


Araçlar kağıdı düzenleyebilir.

Araçlar hakkında daha fazla bilgi edinmek için kenar çubuğunu kullanın.

Artı simgesine tıklayarak yeni bir araç oluşturun. Sürükleyerek araçların sırasını, tıklayarak ise araçları değiştirin. Seçili bir araca tıklarsanız, onu yapılandırabilirsiniz.

Aracın adı, aracın üzerine gelindiğinde araç ipucu olarak görüntülenecektir.

## Kullanılabilir araçlar

```mdx-code-block
import DocCardList from '@theme/DocCardList';
import {useCurrentSidebarCategory} from '@docusaurus/theme-common';

<DocCardList items={useCurrentSidebarCategory().items}/>
```
