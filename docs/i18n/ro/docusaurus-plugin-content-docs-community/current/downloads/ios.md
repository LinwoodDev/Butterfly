---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

:::warning

Versiunea iOS a Butterfly este previzualizată și este posibil să nu funcționeze conform așteptărilor.
Faceți clic pe [here](https://github.com/LinwoodDev/Butterfly/issues/244) pentru a vizita problema pe GitHub pentru a găsi erori și actualizări cunoscute în prezent. Vă rugăm să raportați orice problemă aici.

:::

## Link-uri

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

Citește mai multe despre versiunea nocturnă a Butterfly [here](/nightly).

## Instalare

Fișierul IPA pe care îl distribuim nu este semnat. Acest lucru înseamnă că va trebui să vă semnați înainte de a-l putea instala pe dispozitivul dvs. iOS. \
Din fericire, există proiecte ca [AltStore](https://altstore.io) (open source) sau [sideloadly](https://sideloadly.io) (sursă închisă). \
\
Aveți nevoie de un ID Apple pentru sideloading Butterfly. Recomandăm crearea unui nou scop, în special în acest scop. Vă rugăm să vă autentificați în [dezvoltatorul Apple](https://developer.apple.com) cel puțin o dată și să acceptați termenii lor.
\
Dacă dispozitivul dvs rulează iOS 16.0 sau mai nou, activați modul dezvoltator în modul Setări/Confidențialitate/Dezvoltator.

## Installing (AltStore)

1. Configurați AltStore folosind instrucțiunile furnizate pe site-ul internet AltStore.
2. Obțineți o copie a fișierului IPA pe dispozitivul dvs. Cea mai bună metodă este să o descarci folosind un browser web sau să îți trimiți singur un fișier zip care conține IPA. Nu utilizaţi Airdrop. De asemenea, nu vă trimiteţi fişierul direct dvs. S-ar putea să nu îl puteți deschide.
3. Deschide fișierul IPA, folosește meniul "share" și apasă "AltStore". Dacă dispozitivul este conectat la calculatorul care rulează AltServer (cablat sau wireless) se va instala automat.

## Instalare (Sideloadly)

1. Configurați Sideload folosind ghidurile furnizate pe sideloadly.io.
2. Deschideți sideload pe calculatorul dvs.
3. Adăugați IPA în colțul din dreapta sus, selectați dispozitivul dvs. și ID-ul Apple. Click Start. Aplicația va fi instalată pe dispozitivul dvs.
   Dacă primești un pop-up spunând că un dezvoltator nu are încredere să meargă la Setări/Generale/VPN și să schimbe asta.
