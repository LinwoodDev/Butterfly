---
title: Tallennustila
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Datakansio

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
Mobiilissa se on muodossa `getExternalFilesDir(null)/Linwood/Butterfly`.
Voit myös muuttaa sitä asetuksissa kohdassa `Data`.

Tästä hakemistosta löydät kansion `Dokumentit`, `Templates` ja `Packs`.

## Verkko

Sovelluksen tiedot on tallennettu selaimeesi. Se on tallennettu paikalliseen tallennustilaan.
Avaa kehittäjän työkalut selaimessasi ja näet niiden tiedot.

## Natiivi alustat

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Tätä kansiota voidaan muuttaa asetuksissa.

## Etätallennustila {#remote}

:::note

Tämä ominaisuus ei ole käytettävissä verkossa.

:::

The application data can be stored on a remote server. Tämä on hyödyllistä, jos haluat jakaa tietoja muiden ihmisten kanssa tai jos sinulla on useita tietokoneita. Tällä hetkellä vain `WebDAV`-protokolla on tuettu.

Jos haluat lisätä etäpalvelimen, siirry asetuksiin ja napsauta `Remotes`. Klikkaa sitten `Add remote`.
Lisää etäpalvelimen URL ja käyttäjätunnus ja salasana. Sen jälkeen voit määrittää kansion, jossa tiedot tallennetaan.

To get the WebDAV URL, please visit the documentation:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (sen pitäisi näyttää tältä: `https://nextcloud.example.com/remote.php/dav/files/username/`, korvaa `username` ja `nextcloud.example.com` oikeilla arvoilla)

### Offline sync {#offline}

Tämän ominaisuuden avulla voit muokata tiedostoja etäpalvelimilla ollessasi offline-tilassa.
Avaa ponnahdusikkunavalikko tiedostossa tai kansiossa ja napsauta `Sync`. Tämä lataa tiedoston tai kansion ja tallentaa sen paikallisesti. Synkronoidaksesi koko juurihakemiston, klikkaa valintaruutua luomalla valintaikkunassa tai klikkaa kaukosäätimen asetusta ja klikkaa valintaruutua sen hallinta-osiossa. @ info: whatsthis

On olemassa muutamia rajoituksia:

- Voit synkronoida vain hakemiston ylätason arvon. Jos sinulla on esimerkiksi hakemisto `a/b/test.bfly`, tätä tiedostoa ei synkronoida.
- Et voi poistaa tiedostoa tai kansiota offline-tilassa.
- Et voi lisätä, muokata tai poistaa malleja ollessasi offline-tilassa.

## Muut varastointimenetelmät

Jos olet kotoperäisellä laitteella, voit myös synkronoida sovelluksen hakemiston suosikki alustan.
Google Drive has [an official app](https://www.google.com/drive/download/) on Windows and there are unofficial ones on the Play Store.
On Linux you can also use the native remote storage system and change your data directory to this or add a new external storage if you click on the add connection button.

## Supported file types

Butterfly supports importing SVG, Butterfly Note (.bfly), Butterfly Raw Note (.tbfly).

### Butterfly Note (.bfly)

This file type is the recommended format for saving notes.

It is a zip archive containing the information (mostly in JSON files) about the note.
These included JSON files aren't optimized for human readability.

### Butterfly Raw Note (.tbfly)

This file is recommended for use with version control software like git.

This file is **not** a zip archive; instead it is a _JSON_ file.
It contains all the information about the note in a single JSON file that is optimized for being readable and nicely formatted. It is slower to load than the normal Butterfly Note.

### SVG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by Butterfly.
