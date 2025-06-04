---
title: Archiviazione
sidebar_position: 2
---

## Cartella dati

Cartella dati
Sul desktop potete trovarlo in `~/Documents/Linwood/Butterfly`.
Sul cellulare è in `getExternalFilesDir(null)/Linwood/Butterfly`.
Puoi anche modificarlo nelle impostazioni in `Dati`.

In questa directory troverai una cartella `Documenti`, `Templates` e `Packs`.

## Web

I dati dell'applicazione sono memorizzati nel browser. È conservato in un deposito locale.
Apri gli strumenti di sviluppo nel tuo browser e vedrai i dati.

## Piattaforme native

Come impostazione predefinita, l'applicazione salva i dati nella cartella dei documenti in una sottocartella chiamata "Linwood/Butterfly". Questa cartella viene creata quando si salvano i primi dati. Questa cartella può essere cambiata nelle impostazioni.

## Archivio remoto {#remote}

:::note

Questa funzione non è disponibile sul web.

:::

L'applicazione può essere salvata in un server remoto. Questo è utile se si desidera condividere i dati con altre persone o se si dispone di più computer. Attualmente è supportato solo il protocollo `WebDAV`.

Per aggiungere un server remoto, vai alle impostazioni e clicca su `Remotes`. Quindi clicca su `Aggiungi remoto`.
Aggiunge l'URL del server remoto e il nome utente e la password. Dopo di che è possibile specificare la cartella in cui vengono memorizzati i dati.

Per ottenere l'url di webdav visita la documentazione:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (dovrebbe assomigliare a questo: `https://nextcloud.example.com/remote.php/dav/files/username/`, sostituisci `username` e `nextcloud.example.com` con i valori corretti)

### Sincronizzazione offline {#offline}

Questa funzione consente di modificare i file su server remoti mentre sei offline.
Aprire il menu a comparsa su un file o una cartella e fare clic su `Sync`. Questo scaricherà il file o la cartella e lo salverà localmente. Per sincronizzare l'intera directory root, fare clic sul segno di spunta nella finestra di dialogo di creazione o fare clic sul remoto nell'impostazione e fare clic sul segno di spunta nella sezione di gestione.

Ci sono alcune limitazioni:

- È possibile sincronizzare solo il livello superiore di una directory. Per esempio, se si dispone di una directory `a/b/test.bfly`, questo file non verrà sincronizzato.
- Non è possibile eliminare un file o una cartella mentre si è offline.
- Non puoi aggiungere, modificare o eliminare i modelli mentre sei offline.

## Altri metodi di stoccaggio

Se sei su un dispositivo nativo puoi anche sincronizzare la directory dell'applicazione con la tua piattaforma preferita.
Google drive ha [un'app ufficiale](https://www.google.com/drive/download/) su Windows e ci sono onces non ufficiali sul play store.
Su linux è anche possibile utilizzare il sistema di archiviazione remota nativo e modificare la directory dei dati in questo o aggiungere una nuova memoria esterna se si fa clic sul pulsante di connessione aggiunta.
