---
title: "Okna"
sidebar_position: 2
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.tsx';
```

![Stabilní verze vydání](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release verze](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Minimální požadavky na systém

* Windows 10 nebo vyšší.

## Binární soubory

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabilní</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-windows-setup.exe">
        Nastavení
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-windows.zip">
        Přenosné
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nightly</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-windows-setup.exe">
        Nastavení
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-windows.zip">
        Přenosné
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Přečtěte si více o noční verzi Butterfly [zde](/nightly).

## Instalovat pomocí winget

```powershell
winget install LinwoodCloud.Butterfly
```

Chcete-li aktualizovat balíček winget, spusťte:

```powershell
winget upgrade LinwoodCloud.Butterfly
```

Chcete-li balíček winget odinstalovat, spusťte:

```powershell
winget uninstall LinwoodCloud.Butterfly
```

### Noční verze

```powershell
winget install LinwoodCloud.Butterfly.Nightly
```

Chcete-li aktualizovat balíček winget, spusťte:

```powershell
winget upgrade LinwoodCloud.Butterfly.Nightly
```

Chcete-li balíček winget odinstalovat, spusťte:

```powershell
winget uninstall LinwoodCloud.Butterfly.Nightly
```
