---
sidebar_label: Samarbete
sidebar_position: 4
title: Samarbete
---

:::warning 🧪 Experiment

Den här funktionen ligger bakom en experimentflagga. Läs mer [here](/nightly#experiments).
Allt i detta avsnitt kan komma att ändras.

:::

## Introduktion

Sinced den 2.0 beta-versionen, fjäril stöder samarbete. Det innebär att du kan redigera samma fil med flera personer samtidigt. Detta är användbart om du vill arbeta tillsammans på ett dokument.

## Så här fungerar det

Fjärilen använder en websocket-server som kommer att vara värd på din dator. Denna server måste vara tillgänglig från internet eller ditt lokala nätverk. Klienten kommer att ansluta till denna server. Servern synkroniserar alla ändringar och händelser med alla klienter.

## Ställ in servern

:::note

Denna serverfunktion är inte tillgänglig på webben.

:::

För det första möjliggör samverkansexperiment i inställningarna. Därefter öppnar du ditt dokument som du vill dela. Klicka sedan på dela-knappen i det övre vänstra hörnet höger till titeln. Detta kommer att öppna en dialog. Klicka på `Start server`.

Standard servern kommer att vara värd på alla gränssnitt på port `28005`. Du kan ändra detta i dialogrutan. Du måste se till att denna server är tillgänglig för klienten.
I det lokala nätverket bör detta fungera ur lådan. Om du vill komma åt servern från internet måste du vidarebefordra porten i din router. Du hittar mer information om detta [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Om du inte kan vidarebefordra porten kan du använda en tjänst som [ngrok](https://ngrok.com/). Detta kommer att skapa en tunnel till din lokala server. Detta är användbart om du vill dela dokumentet med andra människor.

För ngrok skulle kommandot se ut så här:

```bash
ngrok http 28005
```

## Anslut till servern

Nu måste du ansluta till servern. För att göra detta, gå till hemsidan och klicka på plusknappen som du skulle skapa ett nytt dokument. Där ser du ett nytt menyobjekt som heter `Connect`.

Klicka på detta och du kommer att se en dialog. Ange anslutnings-URL:en här.
Om du är i samma nätverk kan du använda den lokala ip-adressen till datorn där servern körs.
URL-adressen ska se ut så här: `ws://{ip}:28005`. Ersätt `{ip}` med datorns ip-adress. Du kan hitta ip-adressen med kommandot `ipconfig` på fönster eller `ifconfig` på linux. På Android hittar du ip-adressen i WiFi-inställningarna.

Om du inte är i samma nätverk måste du använda datorns publika ip-adress. Du kan hitta detta genom att söka efter `vad är min ip` i din favorit sökwebbläsare. URL-adressen ska se ut som den ovan, men med den publika IP-adressen.

Om du använder ngrok, är installationen lite annorlunda. Ersätt `https` med `wss` och addera porten `:28005` i slutet. URL-adressen ska se ut så här: `wss://{random}:28005`. Ersätt den slumpmässiga delen med den del som ngrok ger dig.
