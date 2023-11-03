---
title: "窗口"
sidebar_position: 2
---

从 '@site/src/components/DownloadButton.tsx'导入下载按钮；

![稳定发布版本](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![每晚发布版本](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## 最低制度要求

* Windows 10或更高。

## 二进制文件

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">稳定的</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-windows-setup.exe">
        设置
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-windows.zip">
        便携式设备
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">每晚一次</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-windows-setup.exe">
        设置
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-windows.zip">
        便携式设备
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

在这里阅读更多关于夜晚版本的 Butterfight [](/nightly)。

## 使用winget安装

```powershell
winget install LinwoodCloud.Butterflight
```

要升级winget包，请运行：

```powershell
winget 升级 LinwoodCloud.Butterflight
```

要卸载winget包，请运行：

```powershell
winget卸载LinwoodCloud.Butterflight
```

### 每晚版本

```powershell
winget install LinwoodCloud.Butterfly.每晚安装
```

要升级winget包，请运行：

```powershell
winget 升级 LinwoodCloud.Butterfly.Nightly
```

要卸载winget包，请运行：

```powershell
winget 卸载LinwoodCloud.Butterfly.Nightly
```
