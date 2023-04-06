---
title: "ويندوز"
sidebar_position: 2
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.tsx';
```

![إصدار الإصدار المستقر](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## متطلبات النظام الدنيا

* ويندوز 10 أو أعلى.

## ثنائيات

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">اسطبل</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-windows-setup.exe">
        الإعداد
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-windows.zip">
        محمول
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">ليلي</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-windows-setup.exe">
        الإعداد
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-windows.zip">
        محمول
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

اقرأ المزيد عن الإصدار الليلي من الفراشة [هنا](/nightly).

## تثبيت باستخدام الجناح

```powershell
winget install LinwoodCloud.Butterfly
```

لترقية حزمة الأجنحة، قم بتشغيل:

```powershell
winget upgrade LinwoodCloud.Butterfly
```

لإلغاء تثبيت حزمة الأجنحة، قم بتشغيل:

```powershell
winget uninstall LinwoodCloud.Butterfly
```

### الإصدار الليلي

```powershell
winget install LinwoodCloud.Butterfly.Nightly
```

لترقية حزمة الأجنحة، قم بتشغيل:

```powershell
winget upgrade LinwoodCloud.Butterfly.Nightly
```

لإلغاء تثبيت حزمة الأجنحة، قم بتشغيل:

```powershell
winget uninstall LinwoodCloud.Butterfly.Nightly
```
