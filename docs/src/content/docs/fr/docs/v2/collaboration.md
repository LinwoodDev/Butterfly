---
title: Collaboration
---

:::caution[🧪 Experiment]

This feature is behind an experiment flag. Read more [here](/nightly#experiments).
Everything in this section is subject to change.

:::

## Introduction

Since the 2.0 beta version, Butterfly supports collaboration. Cela signifie que vous pouvez modifier le même fichier avec plusieurs personnes en même temps. C'est utile lorsque vous souhaitez travailler ensemble sur un document.

## Swamp

Swamp is a protocol that allows you to share your document with other people by using a remote server. This is useful if the other person is not in the same network as you. The server will just be a proxy for the connection and cannot read the data since it is all end-to-end encrypted.

### Setup Swamp

Create a swamp server by visiting the [swamp website](https://swamp.linwood.dev).
Now enter the URL of the server in the collaboration view. The URL should look like this: `wss://example.com` or `ws://example.com`. Please note that only secure connections are allowed on the web. Please also make sure that the server is reachable from the internet.

Now you can just click on `Start` to start the server. With the given link you can share the document with other people. They can just enter the link in the connect dialog and click on `Connect`. This will connect them to the server and they will be able to edit the document.

## WebSocket

Butterfly uses a WebSocket server that will be hosted on your computer. Ce serveur doit être accessible depuis internet ou depuis votre réseau local. Le client se connectera sur ce serveur. The server syncs all changes and events with all clients.

### Configuration du serveur

:::note

Cette fonctionnalité de serveur n'est pas disponible dans la version web.

:::

Tout d'abord, activez la collaboration expérimentale dans les paramètres. After that, open the document you want to share. Then click on the share button in the top-left corner, to the right of the title. Cela ouvrira une boîte de dialogue. Cliquez sur `Début`.

By default, the server will be hosted on all interfaces on port `28005`. Vous pouvez changer cela dans la boîte de dialogue. Vous devez vous assurer que ce serveur est accessible au client.
Dans le réseau local, cela devrait fonctionner sans problème. Si vous souhaitez accéder au serveur depuis internet, vous devez rediriger le port sur votre routeur. Vous pouvez trouver plus d'informations à ce sujet [ici](https://fr.wikipedia.org/wiki/Redirection_de_port).

Si vous ne pouvez pas rediriger le port, vous pouvez utiliser un service comme [ngrok](https://ngrok.com/). Cela va créer un tunnel vers votre serveur local. C'est utile si vous voulez partager le document avec d'autres personnes.

Pour ngrok, la commande ressemblerait à ceci :

```bash
ngrok http 28005
```

### Se connecter au serveur

Vous devez maintenant vous connecter au serveur. Pour ce faire, allez à la page d'accueil et cliquez sur le bouton "plus" comme si vous alliez créer un nouveau document. Là, vous verrez un nouvel élément de menu appelé `Connecter`.

Cliquez dessus et vous verrez une boîte de dialogue. Enter the connection URL here.
If you are in the same network, you can use the local IP address of the computer where the server is running.
The URL should look like this: `ws://{ip}:28005`. Replace `{ip}` with the IP address of the computer. You can find the IP address with the command `ipconfig` on Windows or `ifconfig` on Linux. On Android you can find the IP address in the Wi‑Fi settings.

If you are not in the same network, you need to use the public IP address of the computer. You can find this by searching for `what is my IP` in your favorite search engine. The URL should look like the one above, but with the public IP address.

If you use ngrok, the setup is a bit different. Replace the `https` with `wss` and add the port `:28005` at the end. The URL should look like this: `wss://{random}:28005`. Replace the random part with the part that ngrok gives you.
