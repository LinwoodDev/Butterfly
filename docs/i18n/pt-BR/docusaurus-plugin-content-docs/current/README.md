---
title: Introdução
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Estandarte](/img/banner.png)

---

> Bem-vindo à Borboleta, o aplicativo de notas de código-aberto.

A Borboleta é um aplicativo que grava anotações que busca uma experiência unificada em todas as plataformas. Ele fornece uma interface de usuário simples com personalização poderosa.

## Primeiros Passos

> Você pode usar a barra lateral para navegar rapidamente através da wiki.


Para começar a trabalhar no aplicativo, você tem duas opções:
1. [Downloads](/downloads) the app version that is appropriate for your platform (Butterfly can run on most mobile, desktop, and web platfroms).
2. Use a versão [web](https://butterfly.linwood.dev) se você não puder encontrar sua plataforma ou se você não quiser instalá-la nela. Veja [aqui](storage#web) sobre o armazenamento do arquivo na versão web.

> Assim que você abrir o aplicativo, continue lendo.



## Vista principal

![Vista principal](main.png)

A visão principal é composta de vários elementos
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![tela de boas-vindas](/img/welcome_screen_desktop.png)
        O topo da tela mantém o banner para atualizações, o link para esta documentação e o ícone de configuração <Gear/>. Finalmente, à direita do símbolo <Gear/> config você tem um menu suspenso para controlar quando este banner aparecerá (sempre/nunca/atualizações).
        A seção "Arquivos" na maior área da esquerda. Aí está, você pode fazer as operações típicas:
            - Selecione o tipo de exibição (grid ou lista)
            - Selecione o [armazenamento de origem](armazenamento) dos arquivos
            - Ordenar a ordem de exibição dos arquivos
            - Adicionar uma pasta, arquivo, modelo, ou importar arquivos clicando no sinal <Plus/> mais
            - Digite o caminho direto para o local desejado (o campo Local),
            - Busca por arquivos
        Finalmente, à direita, você tem a exibição de início rápido com os modelos disponíveis no local atual. Para uma nova instalação, isto inclui o modelo claro e escuro
    </TabItem>
    <TabItem value="mobile">
        When opening Butterfly on a mobile device you will be presented with a screen as this
        ![Welcome screen first part](/img/welcome_screen_mobile_1.png)   
        The top of the screen holds the banner for updates, and below it you can find the documnentation link, and next to it the <Gear/> config icon. Finalmente, à direita do símbolo <Gear/> config você tem um menu suspenso para controlar quando este banner aparecerá (sempre/nunca/atualizações).
        Abaixo deles, você pode encontrar a seção de início rápido segurando os modelos aviários para você. Por desfeito, os modelos são os modelos claros e escuros. 
        Rolar para baixo você verá a interface do arquivo:
        \
        ! Tela de boas-vindas segunda parte](/img/welcome_screen_mobile_2. ng)  
        A seção "Arquivos" na maior área da esquerda. Aí está, você pode fazer as operações típicas:
        - Selecione o tipo de exibição (grid ou lista)
        - Selecione o [armazenamento de origem](armazenamento) dos arquivos
        - Ordenar a ordem de exibição dos arquivos
        - Adicionar uma pasta, arquivo, modelo, ou importar arquivos clicando no sinal <Plus/> mais
        - Digite o caminho direto para o local desejado (o campo Local),
        - Procurar por arquivos
    </TabItem>
</Tabs>

Ao abrir um documento, selecionando um modelo ou um arquivo existente, você chegará à **Visualização de Documento**

## A visualização de documentos

Você pode retornar da visualização de documentos para a lista de documentos com a ação traseira do seu dispositivo. Como na visualização principal, as alterações do documento são exibidas com base no seu dispositivo. 

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        In the Desktop view, you'll have at the top left the file bar\
        ![file_bar](/img/document_view_file_bar.png)\
        This holds, from left to right, the 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo.png)
        butterfly button to open the menu. Ao lado dele há o campo nome que exibe o nome da nota. You can rename the note by typing a new name into that field and saving it using the <FloppyDisk/> save button. Finally you can <MagnifyingGlass/> search for elements within the note.
        \
        At the top right of the screen you have the toolbar\
        ![toolbar](/img/document_view_toolbar.png)\
        By default this bar has the <ScribbleLoop/> lasso tool; the <Pen/> pen tool; the <Path/> path erase tool; the <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, and the <Hand/> hand tool. Então você tem o botão <Plus/> para adicionar elementos para a barra de ferramenta, o botão <Wrench/> para configurar o documento, e, finalmente, a ferramenta <Lock/> para olhar o zoom e/ou a posição da tela. 
        ### Notas importantes
        1. Se algum dos elementos na barra de ferramentas não estiverem visíveis para você, clique e arraste (ou deslize) para esquerda e direita para revelar ferramentas adicionais. 
        2. Após selecionar a ferramenta, aparecerá um pequeno menu. Toque longo na ferramenta novamente lhe permitirá arrastá-la para uma nova posição
        3. Você pode adicionar mais ferramentas na barra de ferramentas clicando no símbolo <Plus/> mais. 
    </TabItem>
    <TabItem value="mobile">
        In the mobile view, you'll have at the top the file bar\
        ![file_bar](/img/document_view_file_bar.png)\
        This holds, from left to right, the 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo.png)
        butterfly button to open the menu. Ao lado dele há o campo nome que exibe o nome da nota. You can rename the note by typing a new name into that field and saving it using the <FloppyDisk/> save button. Finally you can <MagnifyingGlass/> search for elements within the note.
        \
        At the bottom of the screen you have the toolbar\
        ![toolbar](/img/document_view_toolbar.png)\
        By default this bar has the <ScribbleLoop/> lasso tool; the <Pen/> pen tool; the <Path/> path erase tool; the <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, and the <Hand/> hand tool. Então você tem o botão <Plus/> para adicionar elementos para a barra de ferramenta, o botão <Wrench/> para configurar o documento, e, finalmente, a ferramenta <Lock/> para olhar o zoom e/ou a posição da tela. 
        ### Notas importantes
        1. Se algum dos elementos na barra de ferramentas não estiver visível para você, ou deslize para a esquerda e direita para revelar mais elementos. 
        2. Depois de selecionar uma ferramenta, um pequeno menu irá aparecer para configurá-la. Toque longo na ferramenta novamente lhe permitirá arrastá-la para uma nova posição
        3. Você pode adicionar mais ferramentas na barra de ferramentas clicando no símbolo <Plus/> mais. 
    </TabItem>
</Tabs>
	

