---
title: "Окна"
sidebar_position: 2
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.tsx';
```

![Стабильная версия релиза](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Минимальные системные требования

* Windows 10 или выше.

## Сборки

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Стабильная</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-windows-setup.exe">
        Настройка
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-windows.zip">
        Портативный
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Ночной</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-windows-setup.exe">
        Настройка
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-windows.zip">
        Портативный
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Подробнее о ночной версии Butterfly [здесь](/nightly).

## Установить с помощью Winget

```powershell
winget install LinwoodCloud.Butterfly
```

Для обновления пакета winget, запустите:

```powershell
winget upgrade LinwoodCloud.Butterfly
```

Чтобы удалить пакет winget, запустите:

```powershell
winget uninstall LinwoodCloud.Butterfly
```

### Ночная версия

```powershell
winget install LinwoodCloud.Butterfly.Nightly
```

Для обновления пакета winget, запустите:

```powershell
winget upgrade LinwoodCloud.Butterfly.Nightly
```

Чтобы удалить пакет winget, запустите:

```powershell
winget uninstall LinwoodCloud.Butterfly.Nightly
```
