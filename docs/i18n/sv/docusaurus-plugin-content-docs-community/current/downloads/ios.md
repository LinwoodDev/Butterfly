---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Ffjärilen%2Fnattliga%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

## Länkar

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nattligt</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

Läs mer om den nattliga versionen av Butterfly [here](/nightly).

## Installerar

IPA-filen vi distribuerar är osignerad. Detta innebär att du måste underteckna det själv innan du kan installera det på din iOS-enhet. \
Lyckligtvis finns det projekt som [AltStore](https://altstore.io) (öppen källkod) eller [sideloadly](https://sideloadly.io) (stängd källkod). \
\
Du behöver ett Apple-ID för sideloading fjäril. Vi rekommenderar att du skapar en ny speciellt för detta ändamål. Logga in på [Apple Developer](https://developer.apple.com) minst en gång och acceptera deras villkor.
\
Om din enhet kör iOS 16.0 eller senare, aktivera utvecklarläge i Inställningar/Sekretess/Utvecklarläge.

## Installing (AltStore)

1. Ställ in AltStore med hjälp av instruktionerna på AltStore-webbplatsen.
2. Hämta en kopia av IPA-filen på din enhet. Det bästa sättet är att ladda ner den med en webbläsare eller skicka en zip-fil som innehåller IPA till dig själv. Använd inte Airdrop. Skicka inte heller filen direkt till dig själv. Du kanske inte kan öppna den.
3. Öppna IPA-filen, använd "share"-menyn och tryck på "AltStore". Om din enhet är ansluten till datorn som kör AltServer (trådbundet eller trådlöst) kommer den att installeras automatiskt.

## Installerar (sideloadly)

1. Ställ in Sideloadly med hjälp av guiderna på sideloadly.io.
2. Öppna i sidled på datorn.
3. Lägg till IPA i det övre högra hörnet, välj enheten och Apple-ID. Klicka på starta. Appen kommer att installeras på din enhet.
   Om du får en popup som säger att en utvecklare inte är betrodd gå till Inställningar/Allmän/VPN- och Enhetshantering och ändra det.
