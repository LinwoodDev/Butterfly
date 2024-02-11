---
title: iOS
sidebar_position: 6
---

![Version Nightly release](https\://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw\.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp %2F%2Fpubspec.yaml\&style=for-the badge)

:::warning

La version iOS de Butterfly est en aperçu et peut ne pas fonctionner comme prévu.
Cliquez sur [here](https://github.com/LinwoodDev/Butterfly/issues/244) pour visiter le problème sur GitHub pour trouver les bugs et mises à jour actuels. Veuillez signaler tout problème à cet endroit.

:::

## Liens

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">la nuit</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

En savoir plus sur la version nocturne de Butterfly [here](/nightly).

## Installation en cours

Le fichier IPA que nous distribuons n'est pas signé. Cela signifie que vous devrez le signer vous-même avant de pouvoir l'installer sur votre appareil iOS. \
Heureusement, il y a des projets comme [AltStore](https://altstore.io) (open source) ou [sideloadly](https://sideloadly.io) (source fermée). \
\
Vous avez besoin d'un ID Apple pour mettre de côté Butterfly. Nous vous recommandons d'en créer un nouveau, spécialement à cette fin. Veuillez vous connecter à [Développeur Apple](https://developer.apple.com) au moins une fois et accepter leurs termes.
\
Si votre appareil utilise iOS 16.0 ou une version plus récente, activez le mode développeur dans Paramètres/Confidentialité/Mode Développeur.

## Installing (AltStore)

1. Configurez AltStore en suivant les instructions fournies sur le site Web d’AltStore.
2. Obtenez une copie du fichier IPA sur votre appareil. Le meilleur moyen est de le télécharger à l'aide d'un navigateur Web ou de vous envoyer un fichier zip contenant l'IPA. Ne pas utiliser Airdrop. De plus, n'envoyez pas le fichier directement à vous-même. Il se peut que vous ne puissiez pas l'ouvrir.
3. Ouvrez le fichier IPA, utilisez le menu "partager" et appuyez sur "AltStore". Si votre appareil est connecté à votre PC qui exécute AltServer (filaire ou sans fil), il s'installera automatiquement.

## Installation (Sideloadly)

1. Configurez Sideloadly en utilisant les guides fournis sur sideloadly.io.
2. Ouvrez sur le côté de votre PC.
3. Ajoutez l'IPA dans le coin supérieur droit, sélectionnez votre appareil et l'identifiant Apple. Cliquez sur Démarrer. L'application sera installée sur votre appareil.
   Si vous obtenez une popup disant qu'un développeur n'est pas digne de confiance, allez dans Paramètres/Général/VPN et Gestion de Périphériques et modifiez cela.
