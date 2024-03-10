---
title: "Okna"
sidebar_position: 2
---

![Stabilna wersja wydania](https://img.shields.io/badge/dynamic/yaml?color=c4840d&label=Stable&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fstable%2Fapp%2Fpubspec.yaml&style=for-the-badge) ![Wersja Nightly](https://img.shields.io/badge/dynamic/yaml?color=f7d28c&label=Nightly&query=%24.version&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml&style=for-the-badge)

## Minimalne wymagania systemowe

* Okna 10 lub wyższe.

## Pliki binarne

<div className="row margin-bottom--lg padding--sm">
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--info button--lg">Stabilność</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-windows-setup.exe">
        Ustawienia
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/stable/linwood-butterfly-windows.zip">
        Przenośne
      </DownloadButton>
    </li>
  </ul>
</div>
<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nocny</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-windows-setup-x86_64.exe">
        Ustawienia
      </DownloadButton>
    </li>
    <li>
      <DownloadButton after="/downloads/post-windows" className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-windows-x86_64.zip">
        Przenośne
      </DownloadButton>
    </li>
  </ul>
</div>
</div>

Dowiedz się więcej o nocnej wersji Motylka [tutaj](/nightly).

## Zainstaluj używając winget

```powershell
winget zainstalował LinwoodCloud.Butterfly
```

Aby ulepszyć pakiet skrzydeł, uruchom:

```powershell
ulepszenie skrzydeł LinwoodCloud.Butterfly
```

Aby odinstalować pakiet skrzydeł, uruchom w:

```powershell
odinstalowanie winget LinwoodCloud.Butterfly
```

### Wersja nocna

```powershell
winget zainstalował LinwoodCloud.Butterfly.Nightly
```

Aby ulepszyć pakiet skrzydeł, uruchom:

```powershell
ulepszenie skrzydeł LinwoodCloud.Butterfly.Nightly
```

Aby odinstalować pakiet skrzydeł, uruchom w:

```powershell
odinstaluj LinwoodCloud.Butterfly.Nightly
```
