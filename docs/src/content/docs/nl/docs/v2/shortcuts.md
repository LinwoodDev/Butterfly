---
title: Snelkoppelingen
---

## Keyboard

Er zijn een paar snelkoppelingen die je in de editor kunt gebruiken.
Sommige ervan worden onder de knoppen geschreven.

### Algemeen

- `Ctrl` + `N`: Nieuw bestand
- `Ctrl` + `Shift` + `N`: Nieuw bestand van template
- `Ctrl` + `E`: Bestand exporteren
- `Ctrl` + `P`: bestand afdrukken
- `Ctrl` + `Shift` + `E`: Exporteer bestand als afbeelding
- `Ctrl` + `Alt` + `E`: Exporteer bestand als svg
- `Ctrl` + `Alt` + `Shift` + `E`: Export file as pdf
- `Ctrl` + `Alt` + `P`: Open pakketjes
- `Ctrl` + `Alt` + `S`: Instellingen openen

### Project

- `Ctrl` + `K`: Open search
- `Ctrl` + `Z`: Herstel
- `Ctrl` + `Y`: Opnieuw
- `Ctrl` + `Shift` + `P`: Open waypoints dialoogvenster
- `Ctrl` + `B`: Open achtergrondvenster
- `Ctrl` + `S`: Opslaan
- `Alt` + `S`: verander pad
- `Ctrl` + (`1` - `0`): Wissel naar tool
- `Ctrl` + `+`: Zoom in
- `Ctrl` + `-`: Zoom uit

## pennen

Standaard is de pen geconfigureerd om als volgt te functioneren:

- `Pen`: geconfigureerd als pen.
- `Eer` (Primaire knop, indien ondersteund): Verander naar handgereedschap terwijl je wordt ingedrukt.
- `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below) while pressed.

## {#configure} configureren

U kunt de besturingselementen aanpassen door elke bediening een tool index te geven. Het indexeren van de tool begint vanaf de linkerkant van de werkbalk, waarbij '1' de eerste index is. Zie voorbeeld hieronder

![werkbalk nummerd](toolbar_numbered.png)

Hier verwijst 1 naar de lasso tool, 2, naar de pan tool etc.

De configuratie-opties die u heeft zijn de volgende:

- Leeg - de tool is unchaged.
- 0 - het gereedschap zal functioneren als bewegend (d.w.z. hand) in deze mod.
- Positief nummer - De tool zal de indexering volgen zoals hierboven uitgelegd.
