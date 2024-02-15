---
title: Genvägar
sidebar_position: 2
---

## Keyboard

Det finns några genvägar som du kan använda i editorn.
Några av dem är skrivna under knapparna.

### Allmänt

- `Ctrl` + `N`: Ny fil
- `Ctrl` + `Shift` + `N`: Ny fil från mallen
- `Ctrl` + `E`: Exportera fil
- `Ctrl` + `P`: Skriv ut fil
- `Ctrl` + `Shift` + `E`: Exportera fil som bild
- `Ctrl` + `Alt` + `E`: Exportera fil som svg
- `Ctrl` + `Alt` + `Shift` + `E`: Exportera fil som svg
- `Ctrl` + `Alt` + `P`: Öppna paket
- `Ctrl` + `Alt` + `S`: Öppna inställningar

### Projekt

- `Ctrl` + `Z`: Ångra
- `Ctrl` + `Y`: Gör om
- `Ctrl` + `Shift` + `P`: Öppna waypoints dialogrutan
- `Ctrl` + `B`: Öppna bakgrundsdialogrutan
- `Ctrl` + `Shift` + `A`: dialogrutan Öppna områden
- `Ctrl` + `S`: Spara
- `Alt` + `S`: Ändra sökväg
- `Ctrl` + (`1` - `0`): Växla till verktyget
- `Ctrl` + `+`: Zooma in
- `Ctrl` + `-`: Zooma ut

## Penna

Som standard är pennan konfigurerad att fungera som följande:

- `Pen`: konfigurerad som penna.
- `First` (Primär knapp, om det stöds): Ändra till handverktyg medan du trycker.
- `Second` (Sekundär knapp, om det stöds): Ändra till andra verktyget (se avsnittet [configure](#configure) nedan) medan du tryckte på.

## Konfigurera {#configure}

Du kan anpassa kontrollerna genom att ge varje kontroll ett verktygsindex. Verktygsindexeringen börjar från vänster i verktygsfältet, med `1` som första index. Se exempel nedan

![toolbar numrerad](toolbar_numbered.png)

Här, 1 hänvisar till lasso verktyg, 2, till pan verktyg etc.

Konfigurera alternativ du har är följande:

- Tom - verktyget är unchaged.
- 0 - verktyget kommer att fungera som rörligt (dvs hand) i detta mod.
- Positivt tal - Verktyget kommer att följa indexeringen som förklarar ovan.
