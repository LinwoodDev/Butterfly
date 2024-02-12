---
title: iOS
sidebar_position: 6
---

![Versione di rilascio notturno](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnotte%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

:::warning

La versione iOS di Butterfly è in anteprima e potrebbe non funzionare come previsto.
Fare clic su [here](https://github.com/LinwoodDev/Butterfly/issues/244) per visitare il problema su GitHub per trovare gli attuali bug e aggiornamenti noti. Vi prego di segnalare eventuali problemi.

:::

## Collegamenti

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Notturna</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

Per saperne di più sulla versione notturna di Butterfly [here](/notte).

## Installazione

Il file IPA che distribuiamo non è firmato. Questo significa che dovrai firmarlo tu stesso prima di poterlo installare sul tuo dispositivo iOS. \
Fortunatamente, ci sono progetti come [AltStore](https://altstore.io) (open source) o [sideloadly](https://sideloadly.io) (closed source). \
\
Hai bisogno di un ID Apple per il sideloading Butterfly. Si consiglia di crearne uno nuovo specialmente a questo scopo. Per favore accedi a [Apple Developer](https://developer.apple.com) almeno una volta e accetta i loro termini.
\
Se il dispositivo è in esecuzione iOS 16.0 o più recente, abilita la modalità sviluppatore in Impostazioni/Privacy/Developer Mode.

## Installing (AltStore)

1. Impostare AltStore utilizzando le istruzioni fornite sul sito AltStore.
2. Ottieni una copia del file IPA sul tuo dispositivo. Il modo migliore è quello di scaricarlo tramite un browser web o di inviare un file zip contenente l'IPA a te stesso. Non usi Airdrop. Inoltre, non inviare il file direttamente a te stesso. Potresti non essere in grado di aprirlo.
3. Aprire il file IPA, utilizzare il menu "condividi" e toccare "AltStore". Se il dispositivo è collegato al PC che esegue AltServer (cablato o wireless) verrà installato automaticamente.

## Installazione (Sideloadly)

1. Impostare Sideloadly utilizzando le guide fornite su sideloadly.io.
2. Apri lateralmente sul tuo PC.
3. Aggiungi l'IPA nell'angolo in alto a destra, seleziona il tuo dispositivo e l'ID Apple. Fare Clic Su Start. L'app verrà installata sul tuo dispositivo.
   Se ottieni un popup che dice che uno sviluppatore non è fidato vai a Impostazioni/Generale/VPN e Gestione del Dispositivo e cambialo.
