---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

:::warning

A versão iOS da Borboleta está na pré-visualização e pode não funcionar como esperado.
Clique [here](https://github.com/LinwoodDev/Butterfly/issues/244) para visitar a issue no GitHub para encontrar bugs e atualizações conhecidos. Por favor, reporte quaisquer problemas lá.

:::

## Links

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nightly</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

Leia mais sobre a versão noturna da Borboleta [here](/nightly).

## Instalando

O arquivo IPA que distribuímos não foi assinado. Isto significa que você terá que fazer o login você mesmo antes de poder instalá-lo no seu dispositivo iOS. \
Felizmente, existem projetos como [AltStore](https://altstore.io) (código aberto) ou [sideloadly](https://sideloadly.io) (fonte fechada). \
\
Precisa de uma ID Apple para deslizar a Borboleta. Recomendamos a criação de uma nova, especialmente para este fim. Por favor, acesse o [desenvolvedor da Apple](https://developer.apple.com) pelo menos uma vez e aceite os termos deles.
\
Se seu dispositivo estiver rodando o iOS 16 ou mais recente, habilite o modo de desenvolvedor em Configurações/Privacidade/Modo.

## Installing (AltStore)

1. Configure a AltStore usando as instruções fornecidas no site da AltStore.
2. Obtenha uma cópia do arquivo IPA para seu dispositivo. A melhor maneira é baixá-lo usando um navegador web ou enviando um arquivo zip que contém o IPA para si mesmo. Não use o Airdrop. Além disso, não envie o arquivo diretamente para você. Você pode não ser capaz de abri-lo.
3. Abra o arquivo IPA, use o menu "share" e toque em "AltStore". Se seu dispositivo estiver conectado ao seu PC executando o AltServer (com fio ou sem fio) ele será instalado automaticamente.

## Instalando (Sideloadly)

1. Configure Sideloadly usando os guias fornecidos em sideloadly.io.
2. Abra o sideloadly no seu PC.
3. Adicione o IPA no canto superior direito, selecione o dispositivo e o ID da Apple. Clique em Iniciar. O app será instalado em seu dispositivo.
   Se você receber um pop-up dizendo que um desenvolvedor não é confiável, vá para Configurações/Geral/VPN e Gerenciamento de dispositivo e mude isso.
