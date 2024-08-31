---
title: Collaboration
---

:::caution[🧪 Experiment]

This feature is behind an experiment flag. Read more [here](/nightly#experiments).
Everything in this section is subject to change.

:::

## Introduction

Depuis la version bêta 2.0, Butterfly prend en charge la collaboration. Cela signifie que vous pouvez modifier le même fichier avec plusieurs personnes en même temps. C'est utile lorsque vous souhaitez travailler ensemble sur un document.

## Comment ça marche

Butterfly utilise un serveur Websocket qui sera hébergé sur votre ordinateur. Ce serveur doit être accessible depuis internet ou depuis votre réseau local. Le client se connectera sur ce serveur. Le serveur synchronise toutes les modifications et tous les événements avec tous les clients.

## Configuration du serveur

:::note

Cette fonctionnalité de serveur n'est pas disponible dans la version web.

:::

Firstly, enable the collaboration experiment in the settings. Ensuite, ouvrez le document que vous souhaitez partager. Then click on the share button in the top left corner right to the title. This will open a dialog. Click on `Start server`.

Par défaut, le serveur sera hébergé sur toutes les interfaces sur le port `28005`. You can change this in the dialog. Vous devez vous assurer que ce serveur est accessible au client.
Dans le réseau local, cela devrait fonctionner sans problème. Si vous souhaitez accéder au serveur depuis internet, vous devez rediriger le port sur votre routeur. Vous pouvez trouver plus d'informations à ce sujet [ici](https://fr.wikipedia.org/wiki/Redirection_de_port).

Si vous ne pouvez pas rediriger le port, vous pouvez utiliser un service comme [ngrok](https://ngrok.com/). Cela va créer un tunnel vers votre serveur local. C'est utile si vous voulez partager le document avec d'autres personnes.

Pour ngrok, la commande ressemblerait à ceci :

```bash
ngrok http 28005
```

## Se connecter au serveur

Now you need to connect to the server. To do this, go to the home page and click on the plus button like you would create a new document. There you will see a new menu item called `Connect`.

Click on this and you will see a dialog. Enter the connection url here.
If you are in the same network, you can use the local ip address of the computer where the server is running.
The url should look like this: `ws://{ip}:28005`. Replace `{ip}` with the ip address of the computer. You can find the ip address with the command `ipconfig` on windows or `ifconfig` on linux. On android you can find the ip address in the wifi settings.

If you are not in the same network, you need to use the public ip address of the computer. You can find this by searching for `what is my ip` in your favorite search browser. The url should look like the one above, but with the public ip address.

If you use ngrok, the setup is a bit different. Replace the `https` with `wss` and add the port `:28005` at the end. The url should look like this: `wss://{random}:28005`. Replace the random part with the part that ngrok gives you.
