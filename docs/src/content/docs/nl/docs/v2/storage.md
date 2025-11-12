---
title: Opslagruimte
sidebar_position: 2
---

## Data map

De gegevensmap is de map waar documenten, sjablonen en pakketten worden opgeslagen.
Op het bureaublad kunt u het vinden in `~/Documenten/Linwood/Butterfly`.
Op mobiel is het in `getExternalFilesDir(null)/Linwood/Butterfly`.
U kunt het ook wijzigen in de instellingen onder `Data`.

In deze map vindt u de map `Documenten`, `Templates` en `Packs`.

## Internet

De applicatiegegevens worden opgeslagen in uw browser. Het wordt opgeslagen in een lokale opslag.
Open de ontwikkelaarshulpmiddelen in uw browser en u zult de gegevens zien.

## Oorspronkelijke platformen

De applicatie slaat de gegevens op in de map documenten in een submap met de naam "Linwood/Butterfly". Deze map wordt aangemaakt wanneer u de eerste gegevens opslaat. Deze map kan worden gewijzigd in de instellingen.

## Externe opslag {#remote}

:::note

Deze functie is niet beschikbaar op het web.

:::

De applicatie kan worden opgeslagen in een externe server. Dit is handig als je de gegevens wilt delen met andere mensen of als je meerdere computers hebt. Momenteel wordt alleen het `WebDAV` protocol ondersteund.

Om een externe server toe te voegen, ga naar instellingen en klik op `Remotes`. Klik vervolgens op `Voeg remote` toe. Klik vervolgens op `Voeg remote` toe.
Voeg de URL van de externe server en de gebruikersnaam en het wachtwoord toe. Daarna kunt u de map opgeven waar de gegevens worden opgeslagen.

Om de webdav url te krijgen, bezoek de documentatie:

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
Google drive heeft [een officiële app](https://www.google.com/drive/download/) op windows en er zijn onofficiële onces in de play store.
Op linux kun je ook het native externe opslagsysteem gebruiken en je gegevensmap hierin wijzigen of een nieuwe externe opslag toevoegen als je op de verbindingsknop klikt.
