---
title: "Windows"
sidebar_position: 2
---

![Version de la version stable](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Version de la sortie nocturne](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Minimum system requirements

* Windows 10 or higher.

## Binaires

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stable</button>
  <ul className="dropdown__menu">
    <li>
      <a className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/Butterfly-Setup.exe">
        Configuration
      </a>
      <a className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/windows.zip">
        Portable
      </a>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nuit</button>
  <ul className="dropdown__menu">
    <li>
      <a className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/Butterfly-Setup.exe">
        Configuration
      </a>
      <a className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/windows.zip">
        Portable
      </a>
    </li>
  </ul>
</div>
</div>

En savoir plus sur la version nocturne de Butterfly [ici](/nightly).

## Install using winget

```powershell
winget install LinwoodCloud.Butterfly
```

To upgrade the winget package, run:

```powershell
winget upgrade LinwoodCloud.Butterfly
```

To uninstall the winget package, run:

```powershell
winget uninstall LinwoodCloud.Butterfly
```

### Version de nuit

```powershell
winget install LinwoodCloud.Butterfly.Nightly
```

To upgrade the winget package, run:

```powershell
winget upgrade LinwoodCloud.Butterfly.Nightly
```

To uninstall the winget package, run:

```powershell
winget uninstall LinwoodCloud.Butterfly.Nightly
```
