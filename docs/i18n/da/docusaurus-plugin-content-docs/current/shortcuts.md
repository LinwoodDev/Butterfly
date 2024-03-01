---
title: "Genveje"
sidebar_position: 2
---


## Keyboard

Der er et par genveje, som du kan bruge i editoren. Nogle af dem er skrevet under knapperne.

### Generelt

* `Ctrl` + `N`: Ny fil
* `Ctrl` + `Shift` + `N`: Ny fil fra skabelon
* `Ctrl` + `E`: Eksporter fil
* `Ctrl` + `P`: Udskriv fil
* `Ctrl` + `Shift` + `E`: Eksporter fil som billede
* `Ctrl` + `Alt` + `E`: Eksporter fil som svg
* `Ctrl` + `Alt` + `Shift` + `E`: Eksporter fil som svg
* `Ctrl` + `Alt` + `P`: Åbn pakker
* `Ctrl` + `Alt` + `S`: Åbn indstillinger

### Projekt

* `Ctrl` + `Z`: Fortryd
* `Ctrl` + `Y`: Fortryd
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Åbn baggrundsdialog
* `Ctrl` + `S`: Gem
* `Alt` + `S`: Skift sti
* `Ctrl` + (`1` - `0`): Skift til værktøj
* `Ctrl` + `+`: Zoom ind
* `Ctrl` + `-`: Zoom ud

## Pen

Som standard er pennen konfigureret til at fungere som følgende:
* `Pen`: konfigureret som pen.
* `First` (Primær knap, hvis understøttet): Skift til håndværktøj under tryk.
* `Second` (sekundær knap, hvis understøttet): Skift til andet værktøj (se [konfigurere](#configure) sektionen nedenfor) under tryk.



## Konfigurer {#configure}

Du kan tilpasse kontrolelementerne ved at give hver control et værktøjs indeks. Værktøjet indeksering starter fra venstre side af værktøjslinjen, hvor `1` er det første indeks. Se eksempel nedenfor

![værktøjslinje nummereret](toolbar_numbered.png)

Her refererer 1 til lassoværktøjet, 2, til pandeværktøjet osv.

Indstillingsmulighederne du har er følgende:

* Tom - værktøjet er unchaged.
* 0 - værktøjet vil fungere som bevægende (dvs. hånd) i dette mod.
* Positivt nummer - Værktøjet vil følge indekseringen som forklaret ovenfor. 


