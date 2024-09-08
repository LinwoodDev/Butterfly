---
title: Upota
---

Upottaminen on yksinkertainen tapa sisällyttää sovellus sivustoosi.
Lisää seuraava koodi sivustollesi:

```html
<iframe src="https://web.butterfly.linwood.dev/embed" width="100%" height="500px" allowtransparency="true"></iframe>
```

## Valinnat

| Valinta       | Tyyppi                                                                                                     | Oletus      | Kuvaus                                                                                                                                                    |
| ------------- | ---------------------------------------------------------------------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------- |
| tallenna      | Totuus (tosi, epäto)                                                                    | tosi        | Ota tallennus käyttöön. Jos poistettu käytöstä, näytetään vain poistumispainike                                                           |
| muokattavissa | Totuus (tosi, epäto)                                                                    | tosi        | Ota muokkaus käyttöön. Jos poistettu käytöstä, asiakirja on vain luku                                                                     |
| kieli         | Merkkijono (..., järjestelmä, käyttäjä) | järjestelmä | Asiakirjan kieli. Jos järjestelmä, kieli havaitaan selaimesta käsin. Jos käyttäjä, kieli asetetaan käyttäjien asetukseksi |

## Tapahtumat

Esimerkkejä siitä, miten sitä käytetään:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'save') {
    console.log('Saving...', data.detail.message);
  }
});
```

### tallenna

> Tapahtuma `save` vapautetaan, kun käyttäjä klikkaa tallennuspainiketta.

Parametrit:

- `data` (Kirjoita `List<int>`): Asiakirjan tiedot.

### poistu

> Tapahtuma `exit` vapautetaan, kun käyttäjä klikkaa poistumispainiketta.

Parametrit:

- `data` (Kirjoita `List<int>`): Asiakirjan tiedot.

### muuta

> Tapahtuma `change` on lähetetty, kun käyttäjä muuttaa asiakirjaa.

Parametrit:

- `data` (Kirjoita `List<int>`): Asiakirjan tiedot.

## Menetelmät

Esimerkki siitä, miten sitä käytetään:

```javascript
const embedElement = document.querySelector('#butterfly');
embedElement.pushMessage('getData', {});
embedElement.addEventListener('message', (data) => {
  if(data.detail.type === 'getData') {
    console.log(data.detail.message);
  }
});
```

### getData

> The `getData` method palauttaa asiakirjan tiedot.

Ei parametreja.
Palautukset: `Luettelo<int>`

### setData

> The `setData` method set the data of the document.

Parametrit:

- `data` (Kirjoita `List<int>`): Asiakirjan tiedot.

### renderöi

> The `render` method render\` makes the document to a png image.

Parametrit:

- `width` (Kirjoita `Numero`): Kuvan leveys.
- `height` (Kirjoita `Numero`): Kuvan korkeus.
- `scale` (Kirjoita `Numero`): Kuvan skaala.
- `renderBackground` (Kirjoita `Boolean`): Jos tosi, tausta renderöidään.

Palautukset: `String` (64 koodattu kuva)

### renderSVG

> The `renderSVG` method makes the document to a svg image.

Parametrit:

- `width` (Kirjoita `Numero`): Kuvan leveys.
- `height` (Kirjoita `Numero`): Kuvan korkeus.
- `renderBackground` (Kirjoita `Boolean`): Jos tosi, tausta renderöidään.

Palautukset: `String` (SVG)
