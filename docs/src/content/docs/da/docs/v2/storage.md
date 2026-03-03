---
title: Lagerplads
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Data mappe

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
På mobil det er i `getExternalFilesDir(null)/Linwood/Butterfly`.
Du kan også ændre det i indstillingerne under `Data`.

I denne mappe finder du en mappe `Documents`, `Templates` og `Packs`.

## Web

Applikationsdataene er gemt i din browser. Det opbevares på et lokalt lager.
Åbn udviklerværktøjerne i din browser, og du vil se data.

## Indfødte platforme

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Denne mappe kan ændres i indstillingerne.

## Ekstern lagerplads {#remote}

:::note

Denne funktion er ikke tilgængelig på nettet.

:::

The application data can be stored on a remote server. Dette er nyttigt, hvis du ønsker at dele data med andre mennesker, eller hvis du har flere computere. I øjeblikket er kun 'WebDAV'-protokollen understøttet.

For at tilføje en fjernserver, gå til indstillingerne og klik på `Remotes`. Klik derefter på `Tilføj fjern`.
Tilføj webadressen på den eksterne server og brugernavn og adgangskode. Derefter kan du angive mappen, hvor dataene er gemt.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (det skal se sådan ud: `https://nextcloud.example.com/remote.php/dav/files/username/`, erstat `username` og `nextcloud.example.com` med de korrekte værdier)

### Offline synkronisering {#offline}

Denne funktion giver dig mulighed for at redigere dine filer på eksterne servere, mens du er offline.
Åbn popup-menuen på en fil eller mappe og klik på `Sync`. Dette vil downloade filen eller mappen og gemme den lokalt. For at synkronisere hele rodmappen klik på afkrydsningsfeltet i dialogboksen Opretter eller klik på fjernbetjeningen i indstillingen og klik på afkrydsningsfeltet i afsnittet Håndtering.

Der er et par begrænsninger:

- Du kan kun synkronisere det øverste niveau i en mappe. For eksempel hvis du har en mappe `a/b/test.bfly`, vil denne fil ikke blive synkroniseret.
- Du kan ikke slette en fil eller mappe, mens du er offline.
- Du kan ikke tilføje, redigere eller slette skabeloner, mens du er offline.

## Andre oplagringsmetoder

Hvis du er på en indfødt enhed, kan du også synkronisere programmappen med din foretrukne platform.
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

### SVG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by Butterfly.
