---
title: Scorciatoie
sidebar_position: 2
---

## Keyboard

Ci sono alcune scorciatoie che puoi usare nell'editor.
Alcuni di loro sono scritti sotto i pulsanti.

### Generale

- `Ctrl` + `N`: Nuovo file
- `Ctrl` + `Shift` + `N`: Nuovo file dal modello
- `Ctrl` + `E`: Esporta file
- `Ctrl` + `P`: Stampa file
- `Ctrl` + `Shift` + `E`: Esporta file come immagine
- `Ctrl` + `Alt` + `E`: Esporta file come svg
- `Ctrl` + `Alt` + `Shift` + `E`: Esporta file come svg
- `Ctrl` + `Alt` + `P`: Apri pacchetti
- `Ctrl` + `Alt` + `S`: Apri le impostazioni

### Progetto

- `Ctrl` + `Z`: Annulla
- `Ctrl` + `Y`: Ripeti
- `Ctrl` + `Shift` + `P`: Apri waypoints finestra
- `Ctrl` + `B`: Apri finestra di sfondo
- `Ctrl` + `Shift` + `A`: Apri le aree finestra
- `Ctrl` + `S`: Salva
- `Alt` + `S`: Cambia percorso
- `Ctrl` + (`1` - `0`): Passa allo strumento
- `Ctrl` + `+`: Zoom avanti
- `Ctrl` + `-`: Zoom indietro

## Penna

Per impostazione predefinita, la penna è configurata per funzionare come segue:

- `Penna`: configurato come penna.
- `First` (pulsante primario, se supportato): Cambia a mano mentre premuto lo strumento.
- `Second` (Pulsante secondario, se supportato): Passa al secondo strumento (vedi sezione [configure](#configure) qui sotto) mentre premi.

## Configura {#configure}

È possibile personalizzare i controlli dando ad ogni controllo un indice degli strumenti. L'indicizzazione dello strumento inizia dalla sinistra della barra degli strumenti, con `1` che è il primo indice. Vedi esempio qui sotto

![toolbar numbered](toolbar_numbered.png)

Qui, 1 si riferisce allo strumento del lao, 2, allo strumento della padella ecc.

Le opzioni di configurazione che hai sono le seguenti:

- Vuoto - lo strumento è incatenato.
- 0 - lo strumento funzionerà come muoversi (cioè mano) in questa mod.
- Numero positivo - Lo strumento seguirà l'indicizzazione come spiegato sopra.
