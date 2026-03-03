---
title: Lagring
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Datamaskin katalog

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
På mobilen er den i `getExternalFilesDir(null)/Linwood/Butterfly`.
Du kan også endre det i innstillingene under "Data".

I denne mappen finner du en mappe `Documents`, `Templates` og `Stillehavs`.

## Nett

Applikasjonsdata er lagret i nettleseren din. Det oppbevares i lokal lagring.
Åpne utviklerverktøyene i nettleseren din og du vil se dataene.

## Native plattformer

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Denne mappen kan endres i innstillingene.

## Ekstern lagring {#remote}

:::note

Denne funksjonen er ikke tilgjengelig på nettet.

:::

The application data can be stored on a remote server. Dette er nyttig hvis du vil dele dataene med andre personer, eller hvis du har flere datamaskiner. For øyeblikket støttes bare `WebDAV`-protokollen.

For å legge til en ekstern server, gå til innstillingene og klikk på `fjernkontroller`. Klikk deretter på `Legg til fjernkontroll`.
Legg til URL-adressen for den eksterne serveren og brukernavnet og passordet. Deretter kan du spesifisere mappen hvor dataene er lagret.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (det skal se ut slik: `https://nextcloud.example.com/remote.php/dav/files/username/`, erstatt `username` og `nextcloud.example.com` med de riktige verdiene)

### Offline synkronisering {#offline}

Denne funksjonen lar deg redigere dine filer på eksterne servere mens du er frakoblet.
Åpne popup-menyen på en fil eller mappe og klikk på `Sync`. Dette laster ned fil eller mappe og lagrer det lokalt. Å synkronisere hele rotmappen, klikk på haken i dialogboksen for opprette eller klikk på fjernkontrollen i innstillingen og klikk på haken i administrasjonen

Det finnes noen begrensninger:

- Du kan bare synkronisere den øverste nivået i en mappe. Hvis du for eksempel har en mappe `a/b/test.bfly`, blir ikke denne filen synkronisert.
- Du kan ikke slette en fil eller mappe mens du er frakoblet.
- Du kan ikke legge til, redigere eller slette maler mens du er frakoblet.

## Andre lagringsmetoder

Hvis du er på en innebygd enhet, kan du også synkronisere programkatalogen med favorittplattformen din.
Google Drive has [an official app](https://www.google.com/drive/download/) on Windows and there are unofficial ones on the Play Store.
On Linux you can also use the native remote storage system and change your data directory to this or add a new external storage if you click on the add connection button.

## Supported file types

Butterfly supports importing SVG, Butterfly Note (.bfly), Butterfly Raw Note (.tbfly).

### Butterfly Note (.bfly)

This file type is the recommended format for saving notes.

It is a zip archive containing the information (mostly in JSON files) about the note.
These included JSON files aren't optimized for human readability.

### Butterfly Raw Note (.tbfly)

This file is recommended for use with version control software like git.

This file is **not** a zip archive; instead it is a _JSON_ file.
It contains all the information about the note in a single JSON file that is optimized for being readable and nicely formatted. It is slower to load than the normal Butterfly Note.

### Svg

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by Butterfly.
