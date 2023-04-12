---
title: "Linux"
sidebar_position: 3
---

```mdx-code-block
import DownloadButton from '@site/src/components/DownloadButton.tsx';
```

![Stabilna wersja wydania](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodCloud%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

:::note

Użyj wersji flatpak, jeśli to możliwe. W przeciwnym razie musisz zainstalować `libsecret-1-dev` i `libjsoncpp-dev`.

:::

## Pliki binarne

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabilność</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-linux.tar.gz">
        Przenośne
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-linux.deb">
        DEB
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/stable/linwood-butterfly-linux.AppImage">
        AppImage
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nightly</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-linux.tar.gz">
        Przenośne
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-linux.deb">
        DEB
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodCloud/butterfly/releases/download/nightly/linwood-butterfly-linux.AppImage">
        AppImage
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Dowiedz się więcej o nocnej wersji Motylka [tutaj](/nightly).

## Sklepy

<div className="row margin-bottom--lg padding--sm">
<a className="button button--outline button--primary button--lg margin--sm" href="https://flathub.org/apps/details/dev.linwood.butterfly">
  Flathub
</a>
</div>
