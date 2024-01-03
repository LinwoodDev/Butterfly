---
sidebar_label: Yhteistyö
sidebar_position: 4
title: Yhteistyö
---

:::warning 🧪 Kokeilu

Tämä ominaisuus on kokeellisen lipun takana. Lue lisää [here](/nightly#experiments).
Kaikkea tässä osiossa voidaan muuttaa.

:::

## Johdanto

Butterfly tukee yhteistyötä 2.0-beta-version avulla. Tämä tarkoittaa, että voit muokata samaa tiedostoa, jossa on useita henkilöitä. Tästä on hyötyä, jos haluat työskennellä yhdessä asiakirjan parissa.

## Miten se toimii

Butterfly käyttää websocket palvelin, joka isännöi tietokoneellasi. Tämän palvelimen on oltava käytettävissä internetissä tai paikallisessa verkossa. Asiakas muodostaa yhteyden tähän palvelimeen. Palvelin synkronoi kaikki muutokset ja tapahtumat kaikkien asiakkaiden kanssa.

## Aseta palvelin

:::note

Tämä palvelin ominaisuus ei ole käytettävissä verkossa.

:::

Ensiksikin mahdollistaa yhteistyön kokeilu asetuksissa. Sen jälkeen kun olet avannut asiakirjasi, haluat jakaa. Tämän jälkeen klikkaa vasemmassa yläkulmassa olevaa jako-painiketta oikeaan otsikkoon. Tämä avaa ikkunan. Klikkaa `Käynnistä palvelin`.

Oletuksena palvelin toimii kaikilla rajapintoilla portin `28005`. Voit muuttaa tätä ikkunassa. Sinun täytyy varmistaa, että tämä palvelin on käytettävissä asiakkaalle.
Paikallisessa verkossa tämän pitäisi toimia ulos laatikosta. Jos haluat käyttää palvelinta internetistä, sinun täytyy lähettää portti eteenpäin reitittimessäsi. Lisätietoa tästä [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Jos et voi välittää satamaa, voit käyttää [ngrok]kaltaista palvelua (https\://ngrok.com/). Tämä luo tunnelin paikalliselle palvelimellesi. Tämä on hyödyllistä, jos haluat jakaa asiakirjan muiden ihmisten kanssa.

Ngrok komento näyttäisi tältä:

```bash
ngrok http 28005
```

## Yhdistä palvelimeen

Nyt sinun täytyy muodostaa yhteys palvelimelle. Voit tehdä tämän, mene etusivulle ja klikkaa plus painiketta kuten voit luoda uuden asiakirjan. Siellä näet uuden valikkonimikkeen nimeltä `Connect`.

Klikkaa tätä ja näet ikkunan. Syötä yhteysosoite tähän.
Jos olet samassa verkossa, voit käyttää sen tietokoneen paikallista ip -osoitetta, jossa palvelin on käynnissä.
Urlin pitäisi näyttää tältä: `ws://{ip}:28005`. Korvaa `{ip}` tietokoneen ip -osoitteella. Voit löytää ip osoitteen, jossa komento `ipconfig` on ikkunoista tai `ifconfig` linubista. Android voit löytää ip osoite wifi asetuksista.

Jos et ole samassa verkossa, sinun täytyy käyttää tietokoneen julkista ip -osoitetta. Voit löytää tämän etsimällä `mikä on minun ip` suosikki hakuselaimessasi. URL-osoitteen pitäisi näyttää ylhäältä, mutta julkisella ip -osoitteella.

Jos käytät ngrokia, asetukset ovat hieman erilaiset. Korvaa `℃` merkillä `wss` ja lisää portti `:28005` loppuun. Urlin pitäisi näyttää tältä: `wss://{random}:28005`. Korvaa satunnainen osa osa, että ngrok antaa sinulle.
