---
title: "Vensters"
sidebar_position: 2
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.tsx';
```

![Stabiele versie van release](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Minimale systeemvereisten

* Windows 10 of hoger.

## Binairs

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabiel</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-windows-setup.exe">
        Instellen
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-windows.zip">
        Draagbaar
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nightly</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-windows-setup.exe">
        Instellen
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-windows.zip">
        Draagbaar
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Lees meer over de nachtelijke versie van Butterfly [hier](/nightly).

## Installeren met winget

```powershell
winget install LinwoodCloud.Butterfly
```

Om het vleugelpakket te upgraden, run:

```powershell
winget upgrade LinwoodCloud.Butterfly
```

Om het vleugelpakket te deïnstalleren, uitvoeren:

```powershell
winget uninstall LinwoodCloud.Butterfly
```

### Nachtelijke versie

```powershell
winget install LinwoodCloud.Butterfly.Nightly
```

Om het vleugelpakket te upgraden, run:

```powershell
winget upgrade LinwoodCloud.Butterfly.Nightly
```

Om het vleugelpakket te deïnstalleren, uitvoeren:

```powershell
winget uninstall LinwoodCloud.Butterfly.Nightly
```
