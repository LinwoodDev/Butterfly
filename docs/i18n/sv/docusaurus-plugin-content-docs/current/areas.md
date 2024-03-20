---
title: "Områden"
sidebar_position: 2
---

import {Monitor} från "@phosphor-icons/react";


## Introduktion

![Område](area.png)

Områden är ett sätt att begränsa storleken på duken. Du kan skapa områden genom att använda [-områdesverktyget](tools/area.md). Om du klickar på bakgrunden kan du öppna dialogrutan för områdeslistan med hjälp av den sammanhangsberoende menyn.

## Skapa och ta bort områden

Medan du direkt kan redigera innehållet på duken, Det är vanligt att du vill begränsa den region där du kan ändra innehållet, eller att du vill ha ot kan snabbt få tillgång till en del av dokumentet. För det har du verktyget <Monitor/> området. Som förklarats i [introduktionsavsnittet](README.md)kan du behöva lägga till <Monitor/> knappen i verktygsfältet. Med hjälp av [area-verktyget](tools/area.md)kan du rita rektangel var som helst på duken för att sedan definiera området.

## Mer kontroll

Du kan ytterligare definiera området verktyg genom att klicka igen på knappen <Monitor/> område. Där kan du definiera områdets fasta bredd, höjd eller bildförhållande.

## Områdets sammanhangsmeny

 Efter att du ritat ett område kan du klicka eller långtrycka på pekskärmen för att öppna en sammanhangsmeny med följande alternativ:

* `Namn` - Ge området ett namn som är övertygande för dig att använda. Detta är nyttigt, till exempel när...
* `Gå in i området` - så att du bara kan redigera innehåll som är uttråkat av detta område.
* `Ta bort` - Ta bort området. Denna *tar inte* bort innehållet inom detta område.
* `Export` - Exportera innehållet i det valda området.
* `Lägg till i pack` - Lägg till området i ett [pack](pack)

## Ett annat alternativ

Ett annat alternativ för dig att använda området navigator är på vänster meny, eller på fjärilsmenyn om du använder en mobil plattform. 

