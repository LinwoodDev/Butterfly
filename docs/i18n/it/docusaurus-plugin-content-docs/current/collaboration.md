---
sidebar_label: Collaborazione
sidebar_position: 4
title: Collaborazione
---

:::warning 🧪 Esperimento

Questa caratteristica è dietro una bandiera di esperimento. Leggi di più [here](/nightly#experiments).
Tutto in questa sezione è soggetto a cambiamenti.

:::

## Introduzione

Con la versione beta 2.0, Butterfly supporta la collaborazione. Ciò significa che è possibile modificare lo stesso file con più persone allo stesso tempo. Questo è utile se si vuole lavorare insieme su un documento.

## Come funziona

Butterfly utilizza un server websocket che sarà ospitato sul tuo computer. Questo server deve essere accessibile da internet o dalla rete locale. Il client si connetterà a questo server. Il server sincronizza tutti i cambiamenti e gli eventi con tutti i client.

## Imposta il server

:::note

Questa funzione del server non è disponibile sul web.

:::

In primo luogo, abilitare l'esperimento di collaborazione nelle impostazioni. Dopo aver aperto il documento che vuoi condividere. Quindi fare clic sul pulsante di condivisione nell'angolo in alto a sinistra a destra del titolo. Questo aprirà una finestra. Clicca su `Start server`.

Il server predefinito sarà ospitato su tutte le interfacce sulla porta `28005`. Puoi cambiarlo nella finestra di dialogo. È necessario assicurarsi che questo server sia accessibile al client.
Nella rete locale questo dovrebbe funzionare fuori dalla scatola. Se si desidera accedere al server da Internet, è necessario inoltrare la porta nel router. Puoi trovare ulteriori informazioni su questa [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Se non puoi inoltrare la porta, puoi usare un servizio come [ngrok](https://ngrok.com/). Questo creerà un tunnel al tuo server locale. Questo è utile se vuoi condividere il documento con altre persone.

Per ngrok il comando assomiglia a questo:

```bash
ngrok http 28005
```

## Connetti al server

Ora è necessario connettersi al server. Per fare questo, vai alla home page e fai clic sul pulsante plus come crei un nuovo documento. Qui vedrai una nuova voce di menu chiamata `Connect`.

Fare clic su questo e vedrai una finestra di dialogo. Inserisci qui l'url della connessione.
Se si è nella stessa rete, è possibile utilizzare l'indirizzo IP locale del computer in cui il server è in esecuzione.
L'url dovrebbe assomigliare a questo: `ws://{ip}:28005`. Sostituisci `{ip}` con l'indirizzo ip del computer. Puoi trovare l'indirizzo ip con il comando `ipconfig` su windows o `ifconfig` su linux. Su Android puoi trovare l'indirizzo ip nelle impostazioni wifi.

Se non si è nella stessa rete, è necessario utilizzare l'indirizzo IP pubblico del computer. Puoi trovarlo cercando `qual è il mio ip` nel tuo browser di ricerca preferito. L'url dovrebbe assomigliare a quello sopra, ma con l'indirizzo IP pubblico.

Se usi ngrok, la configurazione è un po' diversa. Sostituisci il file `ж` con `wss` e aggiungi la porta `:28005` alla fine. L'url dovrebbe assomigliare a questo: `wss://{random}:28005`. Sostituisci la parte casuale con la parte che ngrok ti dà.
