---
title: "Tallennustila"
sidebar_position: 2
---

## Verkko

Sovelluksen tiedot on tallennettu selaimeesi. Se on tallennettu paikalliseen tallennustilaan. Avaa kehittäjän työkalut selaimessasi ja näet niiden tiedot.

## Natiivi alustat

Oletuksena sovellus tallentaa asiakirjojesi kansiossa olevat tiedot "Linwood/Butterfly" -kansion alikansioon. Tämä kansio on luotu, kun tallennat ensimmäiset tiedot. Tätä kansiota voidaan muuttaa asetuksissa.

## Etätallennus {#remote}

:::note

Tämä ominaisuus ei ole käytettävissä verkossa.

:::

Sovellus voidaan tallentaa myös etäpalvelimelle. Tämä on hyödyllistä, jos haluat jakaa tietoja muiden ihmisten kanssa tai jos sinulla on useita tietokoneita. Tällä hetkellä tuetaan vain `WebDAV` -protokollaa.

Jos haluat lisätä etäpalvelimen, mene asetuksiin ja napsauta `Remotes`. Klikkaa sitten `Lisää kaukosäädin`. Lisää etäpalvelimen URL ja käyttäjätunnus ja salasana. Sen jälkeen voit määrittää kansion, jossa tiedot tallennetaan.

Jos haluat saada webdav url, käy dokumentaatio:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (tämän pitäisi näyttää: `https://nextcloud.example.com/remote.php/dav/files/username/`, korvaa `käyttäjänimi` ja `nextcloud.example.com` oikeilla arvoilla)

### Offline-synkronointi {#offline}

Tämän ominaisuuden avulla voit muokata tiedostoja etäpalvelimilla ollessasi offline-tilassa. Avaa ponnahdusikkunavalikko tiedostossa tai kansiossa ja napsauta `Synkronoi`. Tämä lataa tiedoston tai kansion ja tallentaa sen paikallisesti. Synkronoidaksesi koko juurihakemiston, klikkaa valintaruutua luomalla valintaikkunassa tai klikkaa kaukosäätimen asetusta ja klikkaa valintaruutua sen hallinta-osiossa. @ info: whatsthis

On olemassa muutamia rajoituksia:

* Voit synkronoida vain hakemiston ylätason arvon. Jos sinulla on esimerkiksi kansio `a/b/test.bfly`, tätä tiedostoa ei synkronoida.
* Et voi poistaa tiedostoa tai kansiota offline-tilassa.
* Et voi lisätä, muokata tai poistaa malleja ollessasi offline-tilassa.
