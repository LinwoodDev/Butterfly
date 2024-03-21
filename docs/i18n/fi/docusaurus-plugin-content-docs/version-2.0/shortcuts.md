---
title: Pikanäppäimet
sidebar_position: 2
---

## Keyboard

On olemassa muutamia pikakuvakkeita, joita voit käyttää editorissa.
Osa niistä on kirjoitettu painikkeiden alle.

### Yleiset

- `Ctrl` + `N`: Uusi tiedosto
- `Ctrl` + `Shift` + `N`: Uusi tiedosto mallista
- `Ctrl` + `E`: Vie tiedosto
- `Ctrl` + `P`: Tulosta tiedosto
- `Ctrl` + `Shift` + `E`: Vie kuva kuvaksi
- `Ctrl` + `Alt` + `E`: Vie tiedosto svg
- `Ctrl` + `Alt` + `Shift` + `E`: Vie tiedosto svg
- `Ctrl` + `Alt` + `P`: Avaa paketit
- `Ctrl` + `Alt` + `S`: Avaa asetukset

### Projekti

- `Ctrl` + `Z`: Kumoa
- `Ctrl` + `Y`: Redo
- `Ctrl` + `Shift` + `P`: Avoimet reittipisteet -valintaikkuna
- `Ctrl` + `B`: Avaa taustaikkuna
- `Ctrl` + `Shift` + `A`: Avoimet alueet -valintaikkuna
- `Ctrl` + `S`: Tallenna
- `Alt` + `S`: Muuta polkua
- `Ctrl` + (`1` - `0`): Vaihda työkaluun
- `Ctrl` + `+`: Lähennä
- `Ctrl` + `-`: Lähennä

## Kynä

Kynä on oletusarvoisesti määritetty toimimaan seuraavasti:

- `Pen`: määritetty kynäksi.
- `First` (Valinnainen painike, jos tuettu): Vaihda käsityökalua painettuna.
- `Second` (Toissijainen painike, jos sitä tuetaan): Vaihda toiseen työkaluun (katso [configure](#konfiguraatio) painettuna

## Määritä {#configure}

Voit muokata ohjaimia antamalla jokaiselle ohjaukselle työkalun indeksin. Työkalun indeksointi alkaa työkalupalkin vasemmalta ja `1` on ensimmäinen indeksi. Katso esimerkki alla

![toolbar numbered](toolbar_numbered.png)

Täällä, 1 viittaa lasso työkalu, 2, pan työkalu jne.

Määritä asetukset sinulla on ovat seuraavat:

- Tyhjä - työkalu on chaged.
- 0 - työkalu toimii liikkuvana (eli kädessä) tässä moodissa.
- Positiivinen numero - Työkalu seuraa indeksointi kuten selitetään edellä.
