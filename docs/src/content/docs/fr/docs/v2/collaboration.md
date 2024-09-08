---
title: Collaboration
---

:::caution[🧪 Expérimentation]

Cette fonctionnalité est derrière un drapeau d'expérience. En savoir plus [here](/nightly#experiments).
Tout ce qui se trouve dans cette section peut être modifié.

:::

## Introduction

Depuis la version bêta 2.0, Butterfly prend en charge la collaboration. Cela signifie que vous pouvez modifier le même fichier avec plusieurs personnes en même temps. C'est utile lorsque vous souhaitez travailler ensemble sur un document.

## Comment ça marche

Butterfly utilise un serveur Websocket qui sera hébergé sur votre ordinateur. Ce serveur doit être accessible depuis internet ou depuis votre réseau local. Le client se connectera sur ce serveur. Le serveur synchronise toutes les modifications et tous les événements avec tous les clients.

## Configuration du serveur

:::note

Cette fonctionnalité de serveur n'est pas disponible dans la version web.

:::

Tout d'abord, activez la collaboration expérimentale dans les paramètres. Ensuite, ouvrez le document que vous souhaitez partager. Puis cliquez sur le bouton de partage qui se situe dans l'angle supérieur gauche, à droite du titre. Cela ouvrira une boîte de dialogue. Cliquez sur `Début`.

Par défaut, le serveur sera hébergé sur toutes les interfaces sur le port `28005`. Vous pouvez changer cela dans la boîte de dialogue. Vous devez vous assurer que ce serveur est accessible au client.
Dans le réseau local, cela devrait fonctionner sans problème. Si vous souhaitez accéder au serveur depuis internet, vous devez rediriger le port sur votre routeur. Vous pouvez trouver plus d'informations à ce sujet [ici](https://fr.wikipedia.org/wiki/Redirection_de_port).

Si vous ne pouvez pas rediriger le port, vous pouvez utiliser un service comme [ngrok](https://ngrok.com/). Cela va créer un tunnel vers votre serveur local. C'est utile si vous voulez partager le document avec d'autres personnes.

Pour ngrok, la commande ressemblerait à ceci :

```bash
ngrok http 28005
```

## Se connecter au serveur

Vous devez maintenant vous connecter au serveur. Pour ce faire, allez à la page d'accueil et cliquez sur le bouton "plus" comme si vous alliez créer un nouveau document. Là, vous verrez un nouvel élément de menu appelé `Connecter`.

Cliquez dessus et vous verrez une boîte de dialogue. Entrez ici l'url de connexion.
Si vous êtes sur le même réseau, vous pouvez utiliser l'adresse IP locale de l'ordinateur où le serveur fonctionne.
L'URL devrait ressembler à ceci : `ws://{IP}:28005`. Remplacez `{ip}` par l'adresse IP de l'ordinateur. Vous pouvez trouver l'adresse IP avec la commande `ipconfig` sur windows ou `ifconfig` sur linux. Sur android vous pouvez trouver l'adresse IP dans les paramètres du wifi.

Si vous n'êtes pas dans le même réseau, vous devez utiliser l'adresse IP publique de l'ordinateur. Vous pouvez trouver cela en recherchant `ce qui est mon ip` dans votre navigateur de recherche favori. L'url devrait ressembler à celle ci-dessus, mais avec l'adresse IP publique.

Si vous utilisez ngrok, la configuration est un peu différente. Remplacez le `https` par `wss` et ajoutez le port `:28005` à la fin. L'url devrait ressembler à ceci: `wss://{random}:28005`. Remplacez la partie aléatoire par la partie que ngrok vous donne.
