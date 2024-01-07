---
sidebar_label: Samarbeid
sidebar_position: 4
title: Samarbeid
---

:::warning 🧪 Eksperiment

Denne funksjonen ligger bak et eksperimentelt flagg. Les mer [here](/nightly#experiments).
Alt i denne delen er gjenstand for endring.

:::

## Introduksjon

Sinced the 2.0 beta version, Butterfly supports collaboration. Det betyr at du kan redigere den samme filen med flere personer samtidig. Dette er nyttig hvis du vil jobbe sammen på et dokument.

## Slik fungerer det

Sommerfugl bruker en WebSocket server som vil bli vert på din datamaskin. Denne serveren må være tilgjengelig fra Internett eller ditt lokale nettverk. Klienten vil koble til denne serveren. Serveren synkroniserer alle endringer og hendelser med alle klienter.

## Sett opp serveren

:::note

Denne serverfunksjonen er ikke tilgjengelig på nettet.

:::

For det første: Aktiver samarbeidseksperimentet på sidene. Etter det åpner du dokumentet ditt for å dele. Klikk deretter på delingsknappen i det øverste venstre hjørnet til høyre for tittelen. Dette vil åpne en dialog. Klikk på `Start server`.

Standard serveren vil bli brukt på alle grensesnitt på port `28005`. Du kan endre dette i dialogen. Du må sørge for at denne serveren er tilgjengelig for klienten.
I det lokale nettverket skal dette virke utenfor boksen. Hvis du vil ha tilgang til serveren fra Internett, må du videresende porten i ruteren din. Du finner mer informasjon om dette [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Hvis du ikke kan videresende porten, kan du bruke en tjeneste som [ngrok](https://ngrok.com/). Dette vil opprette en tunnel på din lokale server. Dette er nyttig hvis du vil dele dokumentet med andre.

For ngrok vil kommandoen se slik ut:

```bash
ngrok http 28005
```

## Koble til serveren

Nå må du koble til serveren. For å gjøre dette, gå til hjemmesiden og klikk på plussknappen som du ønsker å opprette et nytt dokument. Der vil du se et nytt menypunkt kalt `Connect`.

Klikk på dette og du vil se en dialog. Skriv inn tilkoblingsadressen her.
Hvis du er i samme nettverk, kan du bruke den lokale IP-adressen til datamaskinen der serveren kjører.
Nettadressen skal se slik ut: `ws://{ip}:28005`. Erstatt `{ip}` med IP-adressen til datamaskinen. Du kan finne ip-adressen med kommandoen `ipconfig` på vinduer eller `ifconfig` på linjux. På android finner du IP-adressen i wifi innstillingene.

Hvis du ikke er i samme nettverk, må du bruke offentlig ip-adresse for datamaskinen. Du finner dette ved å søke etter `hva som er min ip` i favoritt-søkeren. Nettadressen skal se ut som den ovenfor, men med offentlig ip-adresse.

Hvis du bruker ngrok, er oppsettet litt annerledes. Bytt ut `https` med `wss` og legg til port `:28005` til slutt. Nettadressen skal se slik ut: `ws://{random}:28005`. Bytt ut den tilfeldige delen med delen som gror gir deg.
