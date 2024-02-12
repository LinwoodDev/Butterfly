---
title: iOS
sidebar_position: 6
---

httNightly release version](https\://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw\.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-badge)

:::warning

iOS versjonen av Butterfly er i forhåndsvisning, og fungerer kanskje ikke som forventet.
Klikk [here](https://github.com/LinwoodDev/Butterfly/issues/244) for å besøke problemet på GitHub for å finne gjeldende kjente feil og oppdateringer. Vennligst rapporter problemer der.

:::

## Lenker

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nattlig</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

Les mer om den nattlige versjonen av Butterfly [here](/nightly).

## Installerer

IPA-filen vi distribuerer er ikke signert. Dette betyr at du må logge deg på før du kan installere det på iOS-enheten din. \
Heldigvis finnes det prosjekter som [AltStore](https://altstore.io) (åpen kildekode) eller [sideloadly](https://sideloadly.io) (lukket kilde). \
\
Du trenger en Apple ID for sideloading Butterfly. Vi anbefaler å lage en ny spesielt til dette formålet. Logg inn på [Apple Developer](https://developer.apple.com) minst én gang og godta sine vilkår.
\
Hvis enheten din kjører iOS 16.0 eller nyere, aktiver utviklermodus i Innstillinger/Personvern/Utviklermodus.

## Installing (AltStore)

1. Opprett AltStore ved hjelp av instruksene gitt på Altbug-nettsiden.
2. Kopiér IPA-filen til enheten din. Den beste måten å laste ned ved hjelp av en nettleser eller å sende en zip-fil med IPA selv. Ikke bruk Airdrop. I tillegg sender du ikke filen direkte til deg selv. Du kan kanskje ikke åpne den.
3. Åpne IPA-filen, bruk "share"-menyen og trykk på "AltStore". Dersom enheten er koblet til din PC som kjører AltServer (kablet eller trådløst) installeres automatisk.

## Installering (Sideloadly)

1. Sett opp Sideloadly ved hjelp av veiledningene som er gitt på sideloadly.io.
2. Åpne sideloadly på PC-en din.
3. Legg til IPA øverst til høyre, velg din enhet og Apple ID. Klikk på starten. Appen vil bli installert på enheten din.
   Hvis du får en popup som sier at en utvikler ikke er klarert, gå til Innstillinger/Generell/VPN og Enhetsstyring og endre det.
