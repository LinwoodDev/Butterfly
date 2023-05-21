---
title: "Windows"
sidebar_position: 2
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.tsx';
```

![Stable release version](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## 最低系統要求

* Windows 10 or higher.

## 二進制檔

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">穩定版</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-windows-setup.exe">
        Setup
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-windows.zip">
        Portable
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nightly</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-windows-setup.exe">
        Setup
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-windows.zip">
        Portable
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

到[這裏](/nightly)閱讀更多關於《Butterfly》夜間版的資訊。

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

### Nightly version

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
