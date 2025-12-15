---
title: Lagerplads
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Data mappe

Datamappen er den mappe, hvor dokumenter, skabeloner og pakker gemmes.
På skrivebordet kan du finde det i `~/Documents/Linwood/Butterfly`.
På mobil det er i `getExternalFilesDir(null)/Linwood/Butterfly`.
Du kan også ændre det i indstillingerne under `Data`.

I denne mappe finder du en mappe `Documents`, `Templates` og `Packs`.

## Web

Applikationsdataene er gemt i din browser. Det opbevares på et lokalt lager.
Åbn udviklerværktøjerne i din browser, og du vil se data.

## Indfødte platforme

Som standard gemmer programmet data i dine dokumenter mappe i en undermappe kaldet "Linwood/Butterfly". Denne mappe oprettes, når du gemmer de første data. Denne mappe kan ændres i indstillingerne.

## Ekstern lagerplads {#remote}

:::note

Denne funktion er ikke tilgængelig på nettet.

:::

Programmet kan gemmes på en ekstern server. Dette er nyttigt, hvis du ønsker at dele data med andre mennesker, eller hvis du har flere computere. I øjeblikket er kun 'WebDAV'-protokollen understøttet.

For at tilføje en fjernserver, gå til indstillingerne og klik på `Remotes`. Klik derefter på `Tilføj fjern`.
Tilføj webadressen på den eksterne server og brugernavn og adgangskode. Derefter kan du angive mappen, hvor dataene er gemt.

For at få webdav url, besøg dokumentationen:

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
Google drev har [en officiel app] (https://www.google.com/drive/download/) på vinduer, og der er uofficielle onces i spillebutikken.
På linux kan du også bruge det indfødte fjernlagringssystem og ændre din datamappe til dette eller tilføje en ny ekstern lagring, hvis du klikker på knappen Tilføj forbindelse.

## Supported file types

Butterfly supports importing SVG, Butterfly Note (.bfly), Butterfly Raw Note (.tbfly).

### Butterfly Note (.bfly)

This file type is the recommended for saving notes.

It is a zip archive containing the information (mostly in JSON files) about the note.
These included JSON files aren't optimized for being human readable.

### Butterfly Raw Note (.tbfly)

This file is recommended for use with version control software like git.

This file is **not** a zip archive, instead it is a _JSON_ file.
It contains all the information about the note in a single JSON file that is optimized for being readable and nicely formatted. It is **slower** than the normal Butterfly Note in loading speed.

### SVG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by butterfly.
