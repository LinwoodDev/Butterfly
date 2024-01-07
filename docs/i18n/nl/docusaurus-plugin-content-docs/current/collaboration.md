---
sidebar_label: Samenwerken
sidebar_position: 4
title: Samenwerken
---

:::warning :test_buis: Experimenteer

Deze functie zit achter een experimentele vlag. Lees meer [here](/nightly#experimenten).
Alles in dit deel is onderworpen aan verandering.

:::

## Introductie

Butterfly ondersteunt samenwerking met de betaversie van 2.0. Dit betekent dat je hetzelfde bestand met meerdere mensen tegelijkertijd kunt bewerken. Dit is handig als je samen aan een document wilt werken.

## Hoe het werkt

Butterfly gebruikt een websocket-server die op jouw computer zal worden gehost. Deze server moet via internet of uw lokale netwerk toegankelijk zijn. De client zal verbinding maken met deze server. De server synchroniseert alle wijzigingen en events met alle clients.

## Server instellen

:::note

Deze serverfunctie is niet beschikbaar op het web.

:::

Ten eerste schakel het samenwerkingexperiment in in bij de instellingen. Na dat open uw document dat u wilt delen. Klik vervolgens op de knop Delen in de linker bovenhoek rechts van de titel. Dit zal een dialoogvenster openen. Klik op `Start server`.

Standaard zal de server worden gehost op alle interfaces op poort `28005`. U kunt dit wijzigen in de dialoogvenster. U moet ervoor zorgen dat deze server toegankelijk is voor de client.
In het lokale netwerk werkt dit niet meer. Als u toegang wilt tot de server vanaf het internet, moet u de poort op uw router doorsturen. Meer informatie over deze [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Als u de poort niet doorstuurt, kunt u gebruik maken van een service zoals [ngrok](https://ngrok.com/). Dit maakt een tunnel naar uw lokale server. Dit is handig als u het document wilt delen met andere mensen.

Voor ngrok ziet het commando er zo uit:

```bash
ngrok http 28005
```

## Verbinding maken met de server

Nu moet je verbinding maken met de server. Om dit te doen, ga naar de startpagina en klik op de plus-knop zoals u een nieuw document zou maken. Daar ziet u een nieuw menu-item genaamd `Connect`.

Klik hier op en je zult een dialoogvenster zien. Vul hier de verbindings url in.
Als u in hetzelfde netwerk bent, kunt u het lokale ip-adres van de computer gebruiken waar de server draait.
De url zou er als volgt uit moeten zien: `ws://{ip}:28005`. Vervang `{ip}` door het IP-adres van de computer. Je kunt het IP adres vinden met het commando `ipconfig` op vensters of `ifconfig` op linux. Op android vind je het IP-adres in de wifi-instellingen.

Als u niet in hetzelfde netwerk zit, moet u het openbare ip-adres van de computer gebruiken. Je kunt dit vinden door te zoeken naar 'wat is mijn ip' in je favoriete zoekbrowser. De url zou eruit moeten zien als bovenstaande maar met het publieke ip-adres.

Als je ngrok gebruikt, is de setup een beetje anders. Vervang de `https` door `wss` en voeg de poort `:28005` toe aan het einde. De url zou er als volgt uit moeten zien: `wss://{random}:28005`. Vervang het willekeurige deel door het deel dat je ngrok geeft.
