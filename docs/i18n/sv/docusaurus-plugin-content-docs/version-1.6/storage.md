---
title: "Lagring"
sidebar_position: 2
---

## Webb

Applikationsdata lagras i din webbläsare. Den lagras i en lokal lagring. Öppna utvecklarverktygen i din webbläsare och du kommer att se uppgifterna.

## Inhemska plattformar

Som standard sparar programmet data i din dokumentmapp i en undermapp som heter "Linwood/Butterfly". Den här mappen skapas när du sparar den första datan. Denna mapp kan ändras i inställningarna.

## Fjärrlagring {#remote}

:::note

Denna funktion är inte tillgänglig på webben.

:::

Applikationen kan sparas på en fjärrserver. Detta är användbart om du vill dela data med andra människor eller om du har flera datorer. För närvarande stöds endast `WebDAV` -protokollet.

För att lägga till en fjärrserver, gå till inställningarna och klicka på `Remotes`. Klicka sedan på `Add remote`. Lägg till URL till fjärrservern och användarnamn och lösenord. Därefter kan du ange den mapp där data lagras.

Gå till dokumentationen för att få webbav-urlen:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (det ska se ut så här: `https://nextcloud.example.com/remote.php/dav/files/username/`, ersätt `användarnamn` och `nextcloud.example.com` med rätt värden)

### Synkronisering offline {#offline}

Den här funktionen låter dig redigera dina filer på fjärrservrar medan du är offline. Öppna popup-menyn på en fil eller mapp och klicka på `Sync`. Detta kommer att ladda ner filen eller mappen och spara den lokalt. Synkronisera hela rotkatalogen, Klicka på bocken i dialogrutan skapa eller klicka på fjärrkontrollen i inställningen och klicka på bocken i avsnittet hantering.

Det finns några begränsningar:

* Du kan bara synkronisera den översta nivån i en katalog. Till exempel om du har en katalog `a/b/test.bfly`kommer denna fil inte att synkroniseras.
* Du kan inte ta bort en fil eller mapp när du är offline.
* Du kan inte lägga till, redigera eller ta bort mallar medan du är offline.
