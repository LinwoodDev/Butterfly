---
sidebar_label: Samarbejde
sidebar_position: 4
title: Samarbejde
---

:::warning 🧪 Eksperiment

Denne funktion er bag et eksperiment flag. Læs mere [here](/nighly#experiments).
Alt i dette afsnit er genstand for forandring.

:::

## Indledning

På grund af 2.0 beta version, Butterfly understøtter samarbejde. Det betyder, at du kan redigere den samme fil med flere personer på samme tid. Dette er nyttigt, hvis du vil arbejde sammen om et dokument.

## Sådan fungerer det

Butterfly bruger en websocket server, der vil blive hostet på din computer. Denne server skal være tilgængelig fra internettet eller dit lokale netværk. Klienten vil forbinde til denne server. Serveren synkroniserer alle ændringer og begivenheder med alle klienter.

## Indstil serveren

:::note

Denne serverfunktion er ikke tilgængelig på nettet.

:::

For det første muliggør samarbejdseksperimentet i indstillingerne. Efter at åbne dit dokument, du vil dele. Klik derefter på aktieknappen i øverste venstre hjørne til højre på titlen. Dette vil åbne en dialog. Klik på `Start server`.

Standard serveren vil blive hostet på alle grænseflader på port `28005`. Du kan ændre dette i dialogen. Du skal sørge for, at denne server er tilgængelig for klienten.
I det lokale netværk bør dette arbejde ud af boksen. Hvis du ønsker at få adgang til serveren fra internettet, skal du videresende porten i din router. Du kan finde mere information om dette [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Hvis du ikke kan videresende porten, kan du bruge en tjeneste som [ngrok](https://ngrok.com/). Dette vil oprette en tunnel til din lokale server. Dette er nyttigt, hvis du vil dele dokumentet med andre mennesker.

For ngrok kommandoen ville se sådan ud:

```bash
ngrok http 28005
```

## Opret forbindelse til serveren

Nu skal du oprette forbindelse til serveren. For at gøre dette, gå til startsiden og klik på plus-knappen, som du vil oprette et nyt dokument. Der vil du se et nyt menupunkt kaldet `Connect`.

Klik på dette og du vil se en dialog. Indtast forbindelses url her.
Hvis du er i det samme netværk, kan du bruge den lokale IP-adresse på den computer, hvor serveren kører.
Url skal se sådan ud: `ws://{ip}:28005`. Erstat `{ip}` med IP-adressen på computeren. Du kan finde IP-adressen med kommandoen `ipconfig` på vinduer eller `ifconfig` på linux. På android kan du finde IP-adressen i Wi-Fi-indstillinger.

Hvis du ikke er i det samme netværk, skal du bruge computerens offentlige IP-adresse. Du kan finde dette ved at søge efter `hvad er min ip` i din foretrukne søgebrowser. Webadressen skal se ud som den ovenstående, men med den offentlige IP-adresse.

Hvis du bruger ngrok, opsætningen er en smule anderledes. Erstat `https` med `wss` og tilføj porten `:28005` i slutningen. URL'en skal se sådan ud: `wss://{random}:28005`. Erstat den tilfældige del med den del, ngrok giver dig.
