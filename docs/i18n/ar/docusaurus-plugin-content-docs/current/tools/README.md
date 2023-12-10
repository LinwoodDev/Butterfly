---
title: "أدوات"
slug: /tools
sidebar_label: "مقدمة"
sidebar_position: 1
---


يمكن للأدوات تعديل الورقة.

استخدم الشريط الجانبي لمعرفة المزيد عن الأدوات.

إنشاء أداة جديدة عن طريق النقر على أيقونة زائد. تغيير ترتيب الأداة عن طريق سحب وتغيير الأداة بالنقر. إذا قمت بالنقر على أداة محددة يمكنك تكوينها.

سيتم عرض اسم الأداة كتلميح على الوصلة على الأداة.

## الأدوات المتاحة

```mdx-code-block
استيراد DocCardList من '@theme/DocCardList';
استيراد {useCurrentSidebarCategory} من '@docusaurus/theme-common';

<DocCardList items={useCurrentSidebarCategory().items}/>
```
