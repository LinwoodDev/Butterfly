---
title: Introductie
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Spandoek](/img/banner.png)

---

> Welkom bij Butterfly, de opensource notitie app.

Butterfly is een aantekening bij het nemen van de app die gericht is op uniforme ervaring op alle platformen. Het biedt eenvoudige UI met krachtige aanpassingen.

## Aan de slag

> Je kunt de zijbalk gebruiken om snel door de wiki te navigeren.


Om te beginnen met werken aan de app heb je twee opties:
1. [Downloads](/downloads) de app versie die geschikt is voor uw platform (Butterfly kan op de meeste mobiele, desktop- en webplatfrom) worden uitgevoerd.
2. Gebruik [webversie](https://butterfly.linwood.dev) als u uw platform niet kunt vinden of als u het niet op wilt installeren. Zie [hier](storage#web) over bestandsopslag op de webversie.

> Zodra je de app opent, ga verder met lezen.



## Hoofd weergave

![Hoofd weergave](main.png)

De hoofdweergave bestaat uit verschillende elementen
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Welkom scherm](/img/welcome_screen_desktop.png)
        De bovenkant van het scherm bevat de banner voor updates, de link naar deze documenten en het configuratiepictogram van <Gear/>. Tot slot, rechts van het <Gear/> config symbool heb je een dropdown menu voor controle wanneer deze banner verschijnt (altijd/nooit/bij updates).
        Het "Bestanden" gedeelte in het grote gebied van links. Daar je kan de gebruikelijke bewerkingen doen:
            - Selecteer het weergavetype (raster of lijst)
            - Selecteer de [bron opslag](opslag) van de bestanden
            - Sorteer de weergavevolgorde van de bestanden
            - Voeg een map toe, bestand, sjabloon, of importeer bestanden door te klikken op de <Plus/> plus teken
            - Typ het directe pad naar een gewenste locatie (de locatie veld),
            - Zoeken naar bestanden
        tot slot naar rechts, U heeft het snelle startscherm met de templates die beschikbaar zijn op de huidige locatie. Voor een nieuwe installatie bevat dit het lichte en donkere sjabloon
    </TabItem>
    <TabItem value="mobile">
        Bij het openen van de Butterfly op een mobiel apparaat wordt u een scherm gepresenteerd als deze
        ! Welkom scherm eerste deel](/img/welcome_screen_mobile_1. ng)   
        Het bovenste scherm houdt de banner ingedrukt voor updates, en hieronder kunt u de documnentatie link en erna het <Gear/> config icoon vinden. Tot slot, rechts van het <Gear/> config symbool heb je een dropdown menu voor controle wanneer deze banner verschijnt (altijd/nooit/bij updates).
        Hieronder vindt u de snelle startsectie waar u de sjablonen kunt onderhouden. Door defaule, de sjablonen zijn de lichte en donkere sjablonen. 
        Scrollen naar beneden. Je ziet de bestandsinterface:
        \
        ! Welkom scherm tweede deel](/img/welcome_screen_mobile_2. ng)  
        De "Bestanden" sectie in het grote gedeelte van links. Daar je kan de gebruikelijke bewerkingen doen:
        - Selecteer het weergavetype (raster of lijst)
        - Selecteer de [bron opslag](opslag) van de bestanden
        - Sorteer de weergavevolgorde van de bestanden
        - Voeg een map toe, bestand, sjabloon, of importeer bestanden door te klikken op de <Plus/> plus teken
        - Typ het directe pad naar een gewenste locatie (de locatie veld),
        - Zoeken naar bestanden
    </TabItem>
</Tabs>

Eenmaal een document openen door een sjabloon of een bestaand bestand te selecteren, zult u naar de **Document View** gaan

## De Document Weergave

U kunt terugkeren van de documentweergave naar de documentenlijst met de back-actie van uw apparaat. Net als bij de hoofdweergave, wordt het document gewijzigd op basis van uw apparaat. 

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        In de desktopweergave heb je de bestands balk linksboven in de bestands balk \
        ![file_bar](/img/document_view_file_bar. ng)\
        Deze vasthoudingen, van links naar rechts. de 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        vlinder knop om het menu te openen. Hierna is het naam veld dat de naam van de notitie weergeeft. U kunt de notitie hernoemen door een nieuwe naam in dat veld in te typen en deze op te slaan met de <FloppyDisk/> save knop. Ten slotte kan je <MagnifyingGlass/> naar elementen binnen de notitie zoeken.
        \
        Aan de rechterbovenhoek van het scherm heb je de werkbalk\
        ![toolbar](/img/document_view_toolbar. ng)\
        Standaard heeft deze balk de <ScribbleLoop/> lasso tool; de <Pen/> pennentool; het pad <Path/> wis tool; de <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, en de <Hand/> hand tool. Dan heb je de knop <Plus/> om elementen toe te voegen aan de werkbalk, de knop <Wrench/> om het document te configureren. en tot slot de <Lock/> tool om de zoom en/of de positie van het scherm te bekijken. 
        ### Belangrijke opmerkingen
        1. Als sommige van het element op de werkbalk niet zichtbaar zijn, klikt u op en sleep (of veeg) naar links en rechts om verdere hulpmiddelen te onthullen. 
        2. Na het selecteren van een tool zal een klein menu verschijnen. Als u weer lang klikt op het gereedschap kunt u het naar een nieuwe positie slepen
        3. Je kunt meer gereedschappen toevoegen aan de werkbalk door op de <Plus/> plus teken te klikken. 
    </TabItem>
    <TabItem value="mobile">
        In de mobiele weergave heeft u de bestands balk \
        ![file_bar](/img/document_view_file_bar. ng)\
        Deze vasthoudingen, van links naar rechts. de 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        vlinder knop om het menu te openen. Hierna is het naam veld dat de naam van de notitie weergeeft. U kunt de notitie hernoemen door een nieuwe naam in dat veld in te typen en deze op te slaan met de <FloppyDisk/> save knop. Ten slotte kan je <MagnifyingGlass/> naar elementen binnen de notitie zoeken.
        \
        Aan de onderkant van het scherm heb je de werkbalk\
        ![toolbar](/img/document_view_toolbar. ng)\
        Standaard heeft deze balk de <ScribbleLoop/> lasso tool; de <Pen/> pennentool; het pad <Path/> wis tool; de <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, en de <Hand/> hand tool. Dan heb je de knop <Plus/> om elementen toe te voegen aan de werkbalk, de knop <Wrench/> om het document te configureren. en tot slot de <Lock/> tool om de zoom en/of de positie van het scherm te bekijken. 
        ### Belangrijke opmerkingen
        1. Als sommige van het element op de werkbalk niet zichtbaar zijn voor jou, of veeg naar links en rechts om verdere elementen te onthullen. 
        2. Na het selecteren van een tool verschijnt een klein menu om de tool te configureren. Als u weer lang klikt op het gereedschap kunt u het naar een nieuwe positie slepen
        3. Je kunt meer gereedschappen toevoegen aan de werkbalk door op de <Plus/> plus teken te klikken. 
    </TabItem>
</Tabs>
	

