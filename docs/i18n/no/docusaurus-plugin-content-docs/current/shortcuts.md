---
title: "Snarveier"
sidebar_position: 2
---


## Keyboard

Det er noen snarveier du kan benytte i editoren. Noen av dem er skrevet under knappene.

### Generelt

* `Ctrl` + `N`: Ny fil
* `Ctrl` + `Shift` + `N`: Ny fil fra mal
* `Ctrl` + `E`: Eksportfil
* `Ctrl` + `P`: Skriv ut fil
* `Ctrl` + `Shift` + `E`: Eksporter fil som bilde
* `Ctrl` + `Alt` + `E`: Eksporter filen som svg
* `Ctrl` + `Alt` + `Skift` + `E`: Eksporter filen som svg
* `Ctrl` + `Alt` + `P`: Åpne pakker
* `Ctrl` + `Alt` + `S`: Åpne innstillinger

### Prosjekt

* `Ctrl` + `Z`: Angre
* `Ctrl` + `Y`: Gjør om igjen
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Åpne bakgrunnsdialog
* `Ctrl` + `S`: Lagre
* `Alt` + `S`: Endre bane
* `Ctrl` + (`1` - `0`): Bytt til verktøy
* `Ctrl` + `+`: Zoom inn
* `Ctrl` + `-`: Zoom ut

## Penn

Som standard konfigureres pennen til å fungere som følgende:
* `penn`: konfigurert som penn.
* `Først` (Primærknapp, hvis støttet): Bytt til håndverktøy når det trykkes.
* `Second` (Secondary button, if supported): Change to second tool (see [configure](#configure) section below)  while pressed.



## Konfigurer {#configure}

Du kan tilpasse kontrollene ved å gi hver kontroll en verktøyindeks. Verktøyet som indekserer fra venstre for verktøylinjen, med `1` er den første indeksen. Se eksempelet nedenfor

![verktøylinje nummerert](toolbar_numbered.png)

Her viser 1 til lassoverktøyet 2, til panserverktøyet osv.

Konfigurere innstillingene du har er følgende:

* Tom - verktøyet er ubelastet.
* 0 - verktøyet fungerer som flytting (dvs. hånd) i denne moden.
* Positivt nummer - Verktøyet vil følge indekseringen som forklarer ovenfor. 


