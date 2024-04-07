---
title: Introduzione
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Banner](/img/banner.png)

---

> Benvenuti su Butterfly, l'app opensource note.

Butterfly è una nota prendendo app che mira a un'esperienza unificata su tutte le piattaforme. Fornisce una semplice interfaccia utente con una potente personalizzazione.

## Per iniziare

> È possibile utilizzare la barra laterale per navigare rapidamente attraverso la wiki.

Per iniziare a lavorare sull'app hai due opzioni:

1. [Downloads](/downloads) la versione dell'app che è appropriata per la tua piattaforma (Butterfly può funzionare sulla maggior parte delle piattaforme mobili, desktop e web).
2. Usa [versione web](https://web.butterfly.linwood.dev) se non riesci a trovare la tua piattaforma o se non vuoi installarla su di essa. Vedi [qui](storage#web) sulla memorizzazione dei file nella versione web.

> Una volta aperta l'app, continua a leggere.

## Vista principale

![Vista principale](main.png)

La vista principale è composta da diversi elementi
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Schermata di benvenuto](/img/welcome_screen_desktop.png)
        La parte superiore dello schermo contiene il banner per gli aggiornamenti, il link a questa documentazione e l'icona di configurazione <Gear/>. Infine, a destra del simbolo di configurazione <Gear/> hai un menu a discesa per controllare quando apparirà questo banner (sempre/mai/sugli aggiornamenti).
        La sezione "File" nella zona principale della sinistra. Lì, è possibile eseguire le operazioni tipiche:
            - Selezionare il tipo di visualizzazione (griglia o lista)
            - Selezionare il [archivio sorgente](storage) dei file
            - Ordinare l'ordine di visualizzazione dei file
            - Aggiungere una cartella, file, modello, o importare i file facendo clic sul segno <Plus/> plus
            - Digitare il percorso diretto a una posizione desiderata (il campo Posizione),
            - Cerca i file
        Finalmente, a destra, hai la visualizzazione rapida con i modelli disponibili nella posizione corrente. Per una nuova installazione questo include la luce e modello scuro
    </TabItem>
    <TabItem value="mobile">
        Quando apri Butterfly su un dispositivo mobile ti verrà presentato uno schermo come questa
        ! Prima parte della schermata di benvenuto](/img/welcome_screen_mobile_1. ng)   
        La parte superiore dello schermo contiene il banner per gli aggiornamenti, e sotto di esso puoi trovare il link di documentazione, e accanto all'icona di configurazione <Gear/>. Infine, a destra del simbolo di configurazione <Gear/> hai un menu a discesa per controllare quando apparirà questo banner (sempre/mai/sugli aggiornamenti).
        Di seguito puoi trovare la sezione di avvio rapido tenendo in mano i modelli avialable per te. Per defaule, i modelli sono i modelli chiari e scuri. 
        Scorrimento in basso, vedrai l'interfaccia del file:
        \
        ! Seconda parte dello schermo di benvenuto](/img/welcome_screen_mobile_2. ng)  
        La sezione "File" nella zona principale della sinistra. Lì, è possibile eseguire le operazioni tipiche:
        - Selezionare il tipo di visualizzazione (griglia o lista)
        - Selezionare il [archivio sorgente](storage) dei file
        - Ordinare l'ordine di visualizzazione dei file
        - Aggiungere una cartella, file, modello, o importare i file facendo clic sul segno <Plus/> plus
        - Digitare il percorso diretto a una posizione desiderata (il campo Posizione),
        - Cerca file
    </TabItem>
</Tabs>

Una volta aperto un documento selezionando un modello o un file esistente, si arriva alla **Document View**

## La Vista Documento

È possibile tornare dalla vista documenti alla lista dei documenti con l'azione posteriore del dispositivo. Come per la vista principale, il display del documento cambia in base al dispositivo.

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        Nella vista Desktop, avrai in alto a sinistra la barra dei file\
        ![file_bar](/img/document_view_file_bar. ng)\
        Questo contiene, da sinistra a destra, l' 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        pulsante farfalla per aprire il menù. Accanto ad esso c'è il campo nome che mostra il nome della nota. È possibile rinominare la nota digitando un nuovo nome in quel campo e salvarla utilizzando il pulsante di salvataggio <FloppyDisk/>. Infine puoi cercare elementi <MagnifyingGlass/> all'interno della nota.
        \
        In alto a destra dello schermo hai la barra degli strumenti\
        ![toolbar](/img/document_view_toolbar. ng)\
        Per impostazione predefinita questa barra ha lo strumento Lasso <ScribbleLoop/> ; lo strumento penna <Pen/> , l' <Path/> strumento di cancellazione del percorso; l' <ArrowCounterClockwise/> annullano e <ArrowClockwise/> ripetono i buton, e lo strumento mano <Hand/>. Quindi hai il pulsante <Plus/> per aggiungere elementi alla barra degli strumenti, il pulsante <Wrench/> per configurare il documento, e infine lo strumento <Lock/> per guardare lo zoom e/o la posizione dello schermo. 
        ### Note importanti
        1. Se alcuni elementi della barra degli strumenti non sono visibili, fare clic e trascinare (o swipe) a sinistra e a destra per rivelare ulteriori strumenti. 
        2. Dopo aver selezionato uno strumento, apparirà un piccolo menu. Un clic prolungato sullo strumento ti permetterà di trascinarlo in una nuova posizione
        3. È possibile aggiungere altri strumenti alla barra degli strumenti facendo clic sul segno <Plus/> più . 
    </TabItem>
    <TabItem value="mobile">
        Nella vista mobile, avrai in cima la barra dei file\
        ![file_bar](/img/document_view_file_bar. ng)\
        Questo contiene, da sinistra a destra, l' 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        pulsante farfalla per aprire il menù. Accanto ad esso c'è il campo nome che mostra il nome della nota. È possibile rinominare la nota digitando un nuovo nome in quel campo e salvarla utilizzando il pulsante di salvataggio <FloppyDisk/>. Infine puoi cercare elementi <MagnifyingGlass/> all'interno della nota.
        \
        Nella parte inferiore dello schermo hai la barra degli strumenti\
        ![toolbar](/img/document_view_toolbar. ng)\
        Per impostazione predefinita questa barra ha lo strumento Lasso <ScribbleLoop/> ; lo strumento penna <Pen/> , l' <Path/> strumento di cancellazione del percorso; l' <ArrowCounterClockwise/> annullano e <ArrowClockwise/> ripetono i buton, e lo strumento mano <Hand/>. Quindi hai il pulsante <Plus/> per aggiungere elementi alla barra degli strumenti, il pulsante <Wrench/> per configurare il documento, e infine lo strumento <Lock/> per guardare lo zoom e/o la posizione dello schermo. 
        ### Note importanti
        1. Se alcuni elementi della barra degli strumenti non sono visibili, o scorri verso sinistra e destra per rivelare ulteriori elementi. 
        2. Dopo aver selezionato uno strumento, apparirà un piccolo menu per configurarlo. Un clic prolungato sullo strumento ti permetterà di trascinarlo in una nuova posizione
        3. È possibile aggiungere altri strumenti alla barra degli strumenti facendo clic sul segno <Plus/> più . 
    </TabItem>
</Tabs>
