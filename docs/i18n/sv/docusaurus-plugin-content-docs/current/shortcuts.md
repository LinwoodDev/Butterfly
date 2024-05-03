---
title: "Genvägar"
sidebar_position: 2
---


## Keyboard

Det finns några genvägar som du kan använda i editorn. Några av dem är skrivna under knapparna.

### Allmänt

* `Ctrl` + `N`: Ny fil
* `Ctrl` + `Shift` + `N`: Ny fil från mall
* `Ctrl` + `E`: Exportera fil
* `Ctrl` + `P`: Skriv ut fil
* `Ctrl` + `Shift` + `E`: Exportera filen som bild
* `Ctrl` + `Alt` + `E`: Exportera filen som svg
* `Ctrl` + `Alt` + `Shift` + `E`: Exportera filen som svg
* `Ctrl` + `Alt` + `P`: Öppna paket
* `Ctrl` + `Alt` + `S`: Öppna inställningar

### Projekt

* `Ctrl` + `K`: Öppna sökningen
* `Ctrl` + `Z`: Ångra
* `Ctrl` + `Y`: Gör om
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Öppna bakgrundsdialogrutan
* `Ctrl` + `S`: Spara
* `Alt` + `S`: Ändra sökväg
* `Ctrl` + (`1` - `0`): Växla till verktyget
* `Ctrl` + `+`: Zooma in
* `Ctrl` + `-`: Zooma ut

## Penna

Som standard är pennan konfigurerad att fungera som följande:
* `Pen`: konfigurerad som penna.
* `Första` (Primär knapp, om det stöds): Ändra till handverktyg medan du trycker.
* `Second` (Sekundär knapp, om det stöds): Ändra till andra verktyget (se [konfigurera](#configure) avsnittet nedan) medan du tryckte på.



## Konfigurera {#configure}

Du kan anpassa kontrollerna genom att ge varje kontroll ett verktygsindex. Verktygets indexering börjar från vänster i verktygsfältet, med `1` som första index. Se exempel nedan

![verktygsfältet numrerat](toolbar_numbered.png)

Här, 1 hänvisar till lasso verktyg, 2, till pan verktyg etc.

Konfigurera alternativ du har är följande:

* Tom - verktyget är unchaged.
* 0 - verktyget kommer att fungera som rörligt (dvs hand) i detta mod.
* Positivt tal - Verktyget kommer att följa indexeringen som förklarar ovan. 


