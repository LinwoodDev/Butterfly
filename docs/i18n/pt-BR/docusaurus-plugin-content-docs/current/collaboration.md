---
sidebar_label: Colaboração
sidebar_position: 4
title: Colaboração
---

:::warning 🧪 Experimento

Esse recurso está atrás de uma bandeira de experimento. Leia mais [here](/nightly#experiments).
Tudo nesta seção está sujeito a mudanças.

:::

## Introdução

Sinceramente a versão beta 2.0, a Borterfly suporta colaboração. Isso significa que você pode editar o mesmo arquivo com várias pessoas ao mesmo tempo. Isso é útil se você quiser trabalhar juntos em um documento.

## Como funciona

A Butterfly usa um servidor de websocket que será hospedado no seu computador. Este servidor precisa ser acessível pela internet ou pela sua rede local. O cliente irá se conectar a este servidor. O servidor sincroniza todas as alterações e eventos com todos os clientes.

## Configurar o servidor

:::note

Esta funcionalidade de servidor não está disponível na web.

:::

Em primeiro lugar, habilite a experiência de colaboração nas configurações. Depois disso, abra o seu documento que deseja compartilhar. Em seguida, clique no botão compartilhar no canto superior esquerdo direito para o título. Isto irá abrir um diálogo. Clique em `Servidor Início`.

O servidor padrão será hospedado em todas as interfaces na porta `28005`. Você pode mudar isso na caixa de diálogo. Você precisa se certificar de que esse servidor é acessível ao cliente.
Na rede local, isto deve funcionar fora da caixa. Se você quiser acessar o servidor a partir da internet, você precisa encaminhar a porta do seu roteador. Você poderá encontrar mais informações sobre este [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Se você não pode encaminhar a porta, você pode usar um serviço como [ngrok](https://ngrok.com/). Isto irá criar um túnel para o seu servidor local. Isso é útil se você deseja compartilhar o documento com outras pessoas.

Para o ngrok, o comando deve ficar assim:

```bash
ngrok http 28005
```

## Conecte-se ao servidor

Agora você precisa se conectar ao servidor. Para fazer isso, vá para a página inicial e clique no botão "mais" como se você criaria um novo documento. Aí você verá um novo item de menu chamado `Conectar`.

Clique aqui e você verá um diálogo. Digite a URL de conexão aqui.
Se você estiver na mesma rede, você pode usar o endereço IP local do computador onde o servidor está rodando.
A url deve ficar assim: `ws://{ip}:28005`. Substitua `{ip}` pelo endereço IP do computador. Você pode encontrar o endereço IP com o comando `ipconfig` nas windows ou `ifconfig` no linux. No android você pode encontrar o endereço IP nas configurações de wifi.

Se você não está na mesma rede, você precisa usar o endereço de IP público do computador. Você pode encontrar isso procurando por `aquele que é meu ip` no seu navegador de pesquisa favorito. A url deve se parecer com a anterior, mas com o endereço IP público.

Se você usa ngrok, a configuração é um pouco diferente. Substitua o `https` por `wss` e adicione a porta `:28005` no final. A url deve ficar assim: `wss://{random}:28005`. Substitua a parte aleatória pela parte que o ngrok lhe dá.
