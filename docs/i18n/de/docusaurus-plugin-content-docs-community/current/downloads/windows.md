---
title: "Windows"
sidebar_position: 2
---

![Stable Release-Version](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nachts Release Version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Binärdateien

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabil</button>
  <ul className="dropdown__menu">
    <li>
      <a className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/Butterfly-Setup.exe">
        Setup
      </a>
      <a className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/windows.zip">
        tragbare
      </a>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nachts</button>
  <ul className="dropdown__menu">
    <li>
      <a className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/Butterfly-Setup.exe">
        Setup
      </a>
      <a className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/windows.zip">
        tragbare
      </a>
    </li>
  </ul>
</div>
</div>

Lesen Sie mehr über die nächtliche Version von Butterfly [hier](/nightly).

## Mit winget installieren

```powershell
winget install LinwoodCloud.Butterfly
```

### Nachtversion

```powershell
winget install LinwoodCloud.Butterfly.Nightly
```
