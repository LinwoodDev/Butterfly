---
title: "Linux"
sidebar_position: 3
---

![Stabilna wersja wydania](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Wersja Nightly](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

:::note

Użyj wersji flatpak, jeśli to możliwe. W przeciwnym razie musisz zainstalować `libsecret-1-dev` i `libjsoncpp-dev`.

:::

## Pliki binarne

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabilność</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-linux.tar.gz">
        Przenośne
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-linux.deb">
        PT
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-linux.rpm">
        RPM
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-linux.AppImage">
        AppImage
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nocny</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-linux-x86_64.tar.gz">
        Przenośne
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-linux-x86_64.deb">
        PT
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-linux-x86_64.rpm">
        RPM
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-linux-x86_64.AppImage">
        AppImage
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Dowiedz się więcej o nocnej wersji Motylka [tutaj](/nightly).

## Sklepy

<div className="row margin-bottom--lg padding--sm">
<Link className="button button--outline button--primary button--lg margin--sm" href="https://flathub.org/apps/details/dev.linwood.butterfly">
  Flathub
</Link>
<Link className="button button--outline button--primary button--lg margin--sm" href="https://snapcraft.io/butterfly">
  Przyciągnij
</Link>
</div>

Wersja nocna jest również dostępna w repozytorium flathub beta. Dowiedz się więcej o repozytorium beta flathub [tutaj](https://discourse.flathub.org/t/how-to-use-flathub-beta/2111).
