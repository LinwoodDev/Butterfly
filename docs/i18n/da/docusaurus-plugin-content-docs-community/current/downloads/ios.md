---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

:::warning

Den iOS-version af Butterfly er i forhåndsvisning og kan ikke fungere som forventet.
Klik på [here](https://github.com/LinwoodDev/Butterfly/issues/244) for at besøge problemet på GitHub for at finde aktuelle kendte fejl og opdateringer. Rapporter venligst eventuelle problemer der.

:::

## Links

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nightly</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

Læs mere om natteversionen af Butterfly [here](/nighly).

## Installerer

IPA filen vi distribuerer, er ikke underskrevet. Det betyder, at du selv skal underskrive den, før du kan installere den på din iOS-enhed. \
Heldigvis er der projekter som [AltStore](https://altstore.io) (open source) eller [sideloadly](https://sideloadly.io) (lukket kilde). \
\
Du har brug for et Apple-id til sideloading af Butterfly. Vi anbefaler, at der oprettes en ny specielt til dette formål. Log venligst ind på [Apple Developer] (https://developer.apple.com) mindst én gang og accepter deres vilkår.
\
Hvis din enhed kører iOS 16.0 eller nyere, skal du aktivere udviklertilstand i indstillinger/Privatliv/Udviklertilstand.

## Installing (AltStore)

1. Opsæt AltStore ved hjælp af instruktionerne på AltStore-hjemmesiden.
2. Få en kopi af IPA-filen på din enhed. Den bedste måde er at downloade det ved hjælp af en webbrowser eller sende en zip-fil, der indeholder IPA til dig selv. Brug ikke Airdrop. Send heller ikke filen direkte til dig selv. Du er måske ikke i stand til at åbne den.
3. Åbn IPA-filen, brug menuen "share" og tryk på "AltStore". Hvis din enhed er tilsluttet din pc, der kører AltServer (kabelforbundet eller trådløs), vil den installere automatisk.

## Installerer (Sideloadly)

1. Konfigurer Sideloadly ved hjælp af guider leveret på sideloadly.io.
2. Åbn sideloadly på din pc.
3. Tilføj IPA i øverste højre hjørne, vælg din enhed og Apple-ID. Klik På Start. Appen vil blive installeret på din enhed.
   Hvis du får en popup siger en udvikler er ikke betroet gå til Indstillinger / Generel / VPN og Enhedshåndtering og ændre det.
