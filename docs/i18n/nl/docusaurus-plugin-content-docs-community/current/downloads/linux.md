---
title: "Linux"
sidebar_position: 3
---

![Stabiele versie van release](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Nachtelijke versie versie](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

::note

Gebruik indien mogelijk de flatpak versie. Anders moet je `libsecret-1-dev` en `libjsoncpp-dev` installeren.

:::

## Binairs

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabiel</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-linux.tar.gz">
        Draagbaar
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-linux.deb">
        VERWIJDER
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
  <button className="button button--outline button--danger button--lg">Nachtelijk</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-linux-x86_64.tar.gz">
        Draagbaar
      </DownloadButton>
    </li>
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-linux-x86_64.deb">
        VERWIJDER
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

Lees meer over de nachtelijke versie van Butterfly [hier](/nightly).

## Winkel(s)

<div className="row margin-bottom--lg padding--sm">
<Link className="button button--outline button--primary button--lg margin--sm" href="https://flathub.org/apps/details/dev.linwood.butterfly">
  Flathub
</Link>
<Link className="button button--outline button--primary button--lg margin--sm" href="https://snapcraft.io/butterfly">
  Snap
</Link>
</div>

De nightly versie is ook beschikbaar op de flathub bèta-repository. Lees meer over de flathub bèta repository [hier](https://discourse.flathub.org/t/how-to-use-flathub-beta/2111).
