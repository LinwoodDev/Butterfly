---
title: "Fönster"
sidebar_position: 2
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.tsx';
```

![Stabil utgåva](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Minimala systemkrav

* Windows 10 eller senare.

## Binärer

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabil</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-windows-setup.exe">
        Konfiguration
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-windows.zip">
        Bärbar
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nattlig</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-windows-setup.exe">
        Konfiguration
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-windows.zip">
        Bärbar
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Läs mer om den nattliga versionen av Butterfly [här](/nightly).

## Installera med winget

```powershell
winget install LinwoodCloud.Butterfly
```

För att uppgradera winget paketet, kör:

```powershell
winget upgrade LinwoodCloud.Butterfly
```

För att avinstallera winget paketet, kör:

```powershell
winget uninstall LinwoodCloud.Butterfly
```

### Nattlig version

```powershell
winget install LinwoodCloud.Butterfly.Nightly
```

För att uppgradera winget paketet, kör:

```powershell
winget upgrade LinwoodCloud.Butterfly.Nightly
```

För att avinstallera winget paketet, kör:

```powershell
winget uninstall LinwoodCloud.Butterfly.Nightly
```
