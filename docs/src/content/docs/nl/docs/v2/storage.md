---
title: Opslagruimte
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Data map

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
Op mobiel is het in `getExternalFilesDir(null)/Linwood/Butterfly`.
U kunt het ook wijzigen in de instellingen onder `Data`.

In deze map vindt u de map `Documenten`, `Templates` en `Packs`.

## Internet

De applicatiegegevens worden opgeslagen in uw browser. Het wordt opgeslagen in een lokale opslag.
Open de ontwikkelaarshulpmiddelen in uw browser en u zult de gegevens zien.

## Oorspronkelijke platformen

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Deze map kan worden gewijzigd in de instellingen.

## Externe opslag {#remote}

:::note

Deze functie is niet beschikbaar op het web.

:::

The application data can be stored on a remote server. Dit is handig als je de gegevens wilt delen met andere mensen of als je meerdere computers hebt. Momenteel wordt alleen het `WebDAV` protocol ondersteund.

Om een externe server toe te voegen, ga naar instellingen en klik op `Remotes`. Klik vervolgens op `Voeg remote` toe. Klik vervolgens op `Voeg remote` toe.
Voeg de URL van de externe server en de gebruikersnaam en het wachtwoord toe. Daarna kunt u de map opgeven waar de gegevens worden opgeslagen.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (het zou er zo uit moeten zien: `https://nextcloud.example.com/remote.php/dav/files/username/`, vervang `username` en `nextcloud.example.com` door de juiste waarden)

### Offline synchronisatie {#offline}

Met deze functie kunt u uw bestanden op externe servers bewerken terwijl u offline bent.
Open het pop-upmenu in een bestand of map en klik op `Sync`. Dit zal het bestand of de map downloaden en lokaal opslaan. Om de hele hoofdmap te synchroniseren, klik op het vinkje in het dialoogvenster aanmaken of klik op de afstandsbediening in de instelling en klik op het vinkje in het beheer menu.

Er zijn enkele beperkingen:

- Je kunt alleen het hoogste niveau van een map synchroniseren. Als u bijvoorbeeld een map `a/b/test.bfly` heeft, zal dit bestand niet worden gesynchroniseerd.
- U kunt geen bestand of map verwijderen terwijl u offline bent.
- U kunt templates niet toevoegen, bewerken of verwijderen terwijl u offline bent.

## Andere opslagmethoden

Als je op een native apparaat bent, kun je ook de applicatiemap synchroniseren met je favoriete platform.
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
