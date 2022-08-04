---
title: "Fenêtres"
sidebar_position: 2
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.js';
```

![Version de la version stable](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Version de la sortie nocturne](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Configuration minimale requise

* Windows 10 ou supérieur.

## Binaires

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stable</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-windows-setup.exe">
        Configuration
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-windows.zip">
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
        Configuration
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

En savoir plus sur la version nocturne de Butterfly [ici](/nightly).

## Installer à l'aide de winget

```powershell
winget installez LinwoodCloud.Butterfly
```

Pour améliorer le paquet winget, exécutez :

```powershell
aile améliorant LinwoodCloud.Butterfly
```

Pour désinstaller le paquet winget, exécutez :

```powershell
winget désinstalle LinwoodCloud.Butterfly
```

### Version de nuit

```powershell
winget installez LinwoodCloud.Butterfly.Nightly
```

Pour améliorer le paquet winget, exécutez :

```powershell
Winget améliore LinwoodCloud.Butterfly.Nightly
```

Pour désinstaller le paquet winget, exécutez :

```powershell
winget désinstalle LinwoodCloud.Butterfly.Nightly
```
