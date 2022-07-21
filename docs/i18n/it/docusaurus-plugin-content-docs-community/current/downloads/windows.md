---
title: "Windows"
sidebar_position: 2
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.js';
```

![Release versione stabile](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Release versione nightly](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Requisiti minimi di sistema

* Windows 10 o superiore.

## Binari

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabile</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/Butterfly-Setup.exe">
        Configurazione
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/windows.zip">
        Portable
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nightly</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-windows-setup.exe">
        Configurazione
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-windows.zip">
        Portable
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Per saperne di più sulla versione notturna di Butterfly [qui](/nightly).

## Installa usando winget

```powershell
winget install LinwoodCloud.Butterfly
```

Per aggiornare il pacchetto winget, esegui:

```powershell
winget upgrade LinwoodCloud.Butterfly
```

Per disinstallare il pacchetto winget, esegui:

```powershell
winget uninstall LinwoodCloud.Butterfly
```

### Versione nightly

```powershell
winget install LinwoodCloud.Butterfly.Nightly
```

Per aggiornare il pacchetto winget, esegui:

```powershell
winget upgrade LinwoodCloud.Butterfly.Nightly
```

Per disinstallare il pacchetto winget, esegui:

```powershell
winget uninstall LinwoodCloud.Butterfly.Nightly
```
