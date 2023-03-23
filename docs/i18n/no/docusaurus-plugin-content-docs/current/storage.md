---
title: "Lagring"
sidebar_position: 2
---

## Nett

Applikasjonsdata er lagret i nettleseren din. Det oppbevares i lokal lagring. Åpne utviklerverktøyene i nettleseren din og du vil se dataene.

## Native plattformer

Som standard lagrer programmet data i dokumentmappen i en undermappe kalt "Linwood/Butterfly". Denne mappen blir opprettet når du lagrer de første dataene. Denne mappen kan endres i innstillingene.

## Ekstern lagring {#remote}

:::note

Denne funksjonen er ikke tilgjengelig på nettet.

:::

Programmet kan lagres på en ekstern server. Dette er nyttig hvis du vil dele dataene med andre personer, eller hvis du har flere datamaskiner. For tiden er bare `WebDAV` -protokollen støttet.

For å legge til en ekstern server, gå til innstillingene og klikk på `Remotes`. Klikk deretter `Legg til fjernkontroll`. Legg til URL-adressen for den eksterne serveren og brukernavnet og passordet. Deretter kan du spesifisere mappen hvor dataene er lagret.

For å få nettadressen, vennligst besøk dokumentasjonen:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (det skal se slik ut: `https://nextcloud.example.com/remote.php/dav/files/username/`, erstatt `brukernavn` og `nextover.example.com` med riktige verdier)

### Frakoblet synkronisering {#offline}

Denne funksjonen lar deg redigere dine filer på eksterne servere mens du er frakoblet. Åpne popup-menyen på en fil eller mappe og klikk på `Synkroniser`. Dette laster ned fil eller mappe og lagrer det lokalt. Å synkronisere hele rotmappen, klikk på haken i dialogboksen for opprette eller klikk på fjernkontrollen i innstillingen og klikk på haken i administrasjonen

Det finnes noen begrensninger:

* Du kan bare synkronisere den øverste nivået i en mappe. Hvis du for eksempel har en mappe `a/b/test.bfly`, blir ikke denne filen synkronisert.
* Du kan ikke slette en fil eller mappe mens du er frakoblet.
* Du kan ikke legge til, redigere eller slette maler mens du er frakoblet.
