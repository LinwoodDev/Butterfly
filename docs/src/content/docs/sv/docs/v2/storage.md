---
title: Lagring
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Datakatalog

Datakatalogen är den katalog där dokument, mallar och paket lagras.
På skrivbordet hittar du den i `~/Documents/Linwood/Butterfly`.
På mobilen finns det i `getExternalFilesDir(null)/Linwood/Butterfly`.
Du kan också ändra det i inställningarna under `Data`.

I den här katalogen hittar du en mapp `Documents`, `Templates` och `Packs`.

## Webb

Applikationsdata lagras i din webbläsare. Den lagras i en lokal lagring.
Öppna utvecklarverktygen i din webbläsare och du kommer att se uppgifterna.

## Inhemska plattformar

Som standard sparar programmet data i din dokumentmapp i en undermapp som heter "Linwood/Butterfly". Den här mappen skapas när du sparar den första datan. Denna mapp kan ändras i inställningarna.

## Fjärrlagring {#remote}

:::note

Denna funktion är inte tillgänglig på webben.

:::

Applikationen kan sparas på en fjärrserver. Detta är användbart om du vill dela data med andra människor eller om du har flera datorer. För närvarande stöds endast `WebDAV`-protokollet.

För att lägga till en fjärrserver, gå till inställningarna och klicka på `Remotes`. Klicka sedan på `Add remote`.
Lägg till URL till fjärrservern och användarnamn och lösenord. Därefter kan du ange den mapp där data lagras.

Gå till dokumentationen för att få webbav-urlen:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (det ska se ut så här: `https://nextcloud.example.com/remote.php/dav/files/username/`, ersätt `username` och `nextcloud.example.com` med rätt värden)

### Offline-synkronisering {#offline}

Den här funktionen låter dig redigera dina filer på fjärrservrar medan du är offline.
Öppna popup-menyn på en fil eller mapp och klicka på `Sync`. Detta kommer att ladda ner filen eller mappen och spara den lokalt. Synkronisera hela rotkatalogen, Klicka på bocken i dialogrutan skapa eller klicka på fjärrkontrollen i inställningen och klicka på bocken i avsnittet hantering.

Det finns några begränsningar:

- Du kan bara synkronisera den översta nivån i en katalog. Till exempel om du har en katalog `a/b/test.bfly`, kommer denna fil inte att synkroniseras.
- Du kan inte ta bort en fil eller mapp när du är offline.
- Du kan inte lägga till, redigera eller ta bort mallar medan du är offline.

## Andra lagringsmetoder

Om du är på en infödd enhet kan du även synkronisera applikationskatalogen med din favoritplattform.
Google drive har [en officiell app](https://www.google.com/drive/download/) på windows och det finns inofficiella en gång i play store.
På Linux kan du också använda det inbyggda fjärrlagringssystemet och ändra datakatalogen till detta eller lägga till ett nytt externt lagringsutrymme om du klickar på knappen Lägg till anslutning.

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
