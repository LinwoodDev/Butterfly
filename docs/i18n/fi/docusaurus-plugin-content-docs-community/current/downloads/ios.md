---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fperuke%2F%2Fsovellus%2Fpubspec.yaml\&style=for-the-badge)

:::warning

Butterfly iOS-versio on esikatselu eikä se välttämättä toimi odotetulla tavalla.
Klikkaa [here](https://github.com/LinwoodDev/Butterfly/issues/244) vieraillaksesi asiassa GitHubissa löytääksesi tunnettuja vikoja ja päivityksiä. Olkaa hyvä ja ilmoittakaa kaikista asioista täällä.

:::

## Linkit

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

Read more about the nightly version of Butterfly [here](/nightly).

## Asennetaan

Jakamamme IPA-tiedosto on allekirjoittamaton. Tämä tarkoittaa, että sinun täytyy allekirjoittaa se itse ennen kuin voit asentaa sen iOS-laitteeseen. \
Onneksi on projekteja kuten [AltStore](https://altstore.io) (open source) tai [sideloadly](https://sideloadly.io) (closed source). \
\
Tarvitset Apple-tunnuksen Butterfly sivuttaisiin. Suosittelemme luomaan uuden erityisesti tätä tarkoitusta varten. Kirjaudu sisään [Apple Developer](https://developer.apple.com) vähintään kerran ja hyväksy niiden ehdot.
\
Jos laitteesi on käynnissä iOS 16.0 tai uudempi, ota kehittäjätila asetuksista/Privacy/Developer -tilassa.

## Installing (AltStore)

1. Määritä AltStore käyttäen AltStoren verkkosivustolla annettuja ohjeita.
2. Hanki kopio IPA tiedostosta laitteellesi. Paras tapa on ladata se verkkoselaimella tai lähettää zip-tiedostoa, joka sisältää IPA itse. Älä käytä Airdropia. Älä myöskään lähetä tiedostoa suoraan itseesi. Et ehkä pysty avaamaan sitä.
3. Avaa IPA-tiedosto, käytä "share" -valikkoa ja napauta "AltStore". Jos laitteesi on kytketty tietokoneeseen, jossa on AltServer (langallinen tai langaton) asennetaan automaattisesti.

## Asennetaan (Sideloidaan)

1. Määritä Sideloadly käyttäen oppaita annetaan sideloadly.io.
2. Avaa sideloadly PC.
3. Lisää IPA oikeassa yläkulmassa, valitse laite ja Apple ID. Valitse Aloitus. Sovellus on asennettu laitteeseesi.
   Jos saat ponnahdusikkunan, jossa sanotaan, että kehittäjä ei ole luotettu, mene Asetukset / Yleinen/VPN ja laitehallinta ja muuta sitä.
