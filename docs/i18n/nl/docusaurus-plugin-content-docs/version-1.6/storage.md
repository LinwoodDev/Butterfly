---
title: "Opslagruimte"
sidebar_position: 2
---

## Internet

De applicatiegegevens worden opgeslagen in uw browser. Het wordt opgeslagen in een lokale opslag. Open de ontwikkelaarshulpmiddelen in uw browser en u zult de gegevens zien.

## Oorspronkelijke platformen

De applicatie slaat de gegevens op in de map documenten in een submap met de naam "Linwood/Butterfly". Deze map wordt aangemaakt wanneer u de eerste gegevens opslaat. Deze map kan worden gewijzigd in de instellingen.

## Externe opslag {#remote}

:::note

Deze functie is niet beschikbaar op het web.

:::

De applicatie kan worden opgeslagen in een externe server. Dit is handig als je de gegevens wilt delen met andere mensen of als je meerdere computers hebt. Momenteel wordt alleen het `WebDAV` protocol ondersteund.

Om een externe server toe te voegen, ga naar instellingen en klik op `Remotes`. Klik vervolgens op `Voeg afstandsbediening` toe. Voeg de URL van de externe server en de gebruikersnaam en het wachtwoord toe. Daarna kunt u de map opgeven waar de gegevens worden opgeslagen.

Om de webdav url te krijgen, bezoek de documentatie:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (het zou er zo uit moeten zien: `https://nextcloud.example.com/remote.php/dav/files/username/`, vervang `username` en `nextcloud.example.com` door de juiste waarden)

### Offline synchronisatie {#offline}

Met deze functie kunt u uw bestanden op externe servers bewerken terwijl u offline bent. Open het pop-upmenu van een bestand of map en klik op `Sync`. Dit zal het bestand of de map downloaden en lokaal opslaan. Om de hele hoofdmap te synchroniseren, klik op het vinkje in het dialoogvenster aanmaken of klik op de afstandsbediening in de instelling en klik op het vinkje in het beheer menu.

Er zijn enkele beperkingen:

* Je kunt alleen het hoogste niveau van een map synchroniseren. Als je bijvoorbeeld een map `a/b/test.bfly`hebt, wordt dit bestand niet gesynchroniseerd.
* U kunt geen bestand of map verwijderen terwijl u offline bent.
* U kunt templates niet toevoegen, bewerken of verwijderen terwijl u offline bent.
