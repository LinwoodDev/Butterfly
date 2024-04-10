---
title: Introduktion
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Banderoll](/img/banner.png)

---

> Välkommen till Butterfly, appen för öppen källkod.

Fjärilen är en anteckningsapp som syftar till en enhetlig upplevelse över alla plattformar. Det ger enkel UI med kraftfull anpassning.

## Komma igång

> Du kan använda sidofältet för att navigera snabbt genom wikin.

För att börja arbeta med appen har du två alternativ:

1. [Nedladdningar](/downloads) appversionen som är lämplig för din plattform (Butterfly kan köras på de flesta mobiler, skrivbord och webbplattformar).
2. Använd [webbversion](https://web.butterfly.linwood.dev) om du inte hittar din plattform eller om du inte vill installera den på den. Se [här](storage#web) om fillagring på webbversionen.

> När du öppnar appen, fortsätt läsa.

## Huvudvy

![Huvudvy](main.png)

Huvudvyn består av flera element
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Welcome screen](/img/welcome_screen_desktop.png)
        Den översta delen av skärmen innehåller bannern för uppdateringar, länken till denna dokumentation och konfigurationsikonen <Gear/>. Till höger om konfigurationssymbolen <Gear/> har du en rullgardinsmeny för att kontrollera när denna banner visas (alltid/aldrig/aldrig/on/on uppdateringar).
        "Filer" sektionen i den stora delen av vänster. Där du kan göra de typiska operationerna:
            - Välj visningstyp (rutnät eller lista)
            - Välj [källlagring](lagring) för filerna
            - Sortera visningsordningen för filerna
            - Lägg till en mapp, fil, mall, eller importera filer genom att klicka på <Plus/> plustecken
            - Skriv den direkta sökvägen till önskad plats (platsfältet),
            - Sök efter filer
        Slutligen, till höger, du har snabbstartsdisplayen med de mallar som finns på den aktuella platsen. För en ny installation innehåller detta ljus och mörk mall
    </TabItem>
    <TabItem value="mobile">
        När du öppnar fjärilen på en mobil enhet kommer du att presenteras med en skärm som denna
        ! Första delen av välkomstskärmen](/img/welcome_screen_mobile_1. ng)   
        Överst på skärmen håller bannern för uppdateringar, och nedan kan du hitta documnentation länk, och bredvid det <Gear/> config ikonen. Till höger om konfigurationssymbolen <Gear/> har du en rullgardinsmeny för att kontrollera när denna banner visas (alltid/aldrig/aldrig/on/on uppdateringar).
        Nedanför dessa kan du hitta snabbstart avsnitt som håller mallarna avialable till dig. Genom defaule, mallarna är ljus och mörka mallar. 
        Rullar ner, du kommer att se filgränssnittet:
        \
        ! Andra delen av välkomstskärmen](/img/welcome_screen_mobile_2. ng)  
        "Filer" sektionen i den stora delen av vänster. Där du kan göra de typiska operationerna:
        - Välj visningstyp (rutnät eller lista)
        - Välj [källlagring](lagring) för filerna
        - Sortera visningsordningen för filerna
        - Lägg till en mapp, fil, mall, eller importera filer genom att klicka på <Plus/> plustecken
        - Skriv den direkta sökvägen till önskad plats (platsfältet),
        - Sök efter filer
    </TabItem>
</Tabs>

När du har öppnat ett dokument genom att välja en mall eller en befintlig fil, kommer du till **Document View**

## Dokumentvyn

Du kan återvända från dokumentvyn till dokumentlistan med den bakre åtgärden av din enhet. Precis som med huvudvyn ändras dokumentet baserat på din enhet.

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        I skrivbordsvyn har du högst upp till vänster i filbar\
        ![file_bar](/img/document_view_file_bar. ng)\
        Detta innehar, från vänster till höger, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        fjärilsknapp för att öppna menyn. Bredvid det finns det namnfältet som visar namnet på anteckningen. Du kan byta namn på anteckningen genom att skriva ett nytt namn i det fältet och spara det med hjälp av knappen <FloppyDisk/> spara. Slutligen kan du <MagnifyingGlass/> söka efter element i anteckningen.
        \
        Överst till höger på skärmen har du verktygsfältet \
        ![toolbar](/img/document_view_toolbar. ng)\
        Som standard har detta fält <ScribbleLoop/> lasso verktyg; <Pen/> pennverktyget <Path/> sökväg radera verktyg; <ArrowCounterClockwise/> ångra och <ArrowClockwise/> redo butons, och <Hand/> handverktyg. Sedan har du knappen <Plus/> för att lägga till element i verktygsfältet, knappen <Wrench/> för att konfigurera dokumentet, och slutligen verktyget <Lock/> för att titta på zoom och / eller positionen på skärmen. 
        ### Viktiga anteckningar
        1. Om en del av elementet i verktygsfältet inte är synligt för dig, klicka och dra (eller svepa) åt vänster och höger för att visa ytterligare verktyg. 
        2. Efter att du valt ett verktyg visas en liten meny. Långklicka på verktyget igen gör att du kan dra det till en ny position
        3. Du kan lägga till fler verktyg i verktygsfältet genom att klicka på <Plus/> plusknappen. 
    </TabItem>
    <TabItem value="mobile">
        I den mobila vyn har du högst upp i filen bar\
        ![file_bar](/img/document_view_file_bar. ng)\
        Detta innehar, från vänster till höger, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        fjärilsknapp för att öppna menyn. Bredvid det finns det namnfältet som visar namnet på anteckningen. Du kan byta namn på anteckningen genom att skriva ett nytt namn i det fältet och spara det med hjälp av knappen <FloppyDisk/> spara. Slutligen kan du <MagnifyingGlass/> söka efter element i anteckningen.
        \
        Längst ner på skärmen har du verktygsfältet \
        ![toolbar](/img/document_view_toolbar. ng)\
        Som standard har detta fält <ScribbleLoop/> lasso verktyg; <Pen/> pennverktyget <Path/> sökväg radera verktyg; <ArrowCounterClockwise/> ångra och <ArrowClockwise/> redo butons, och <Hand/> handverktyg. Sedan har du knappen <Plus/> för att lägga till element i verktygsfältet, knappen <Wrench/> för att konfigurera dokumentet, och slutligen verktyget <Lock/> för att titta på zoom och / eller positionen på skärmen. 
        ### Viktiga anteckningar
        1. Om en del av elementet i verktygsfältet inte är synliga för dig, eller svep åt vänster och höger för att visa ytterligare element. 
        2. Efter att du valt ett verktyg kommer en liten meny att visas för att konfigurera den. Långklicka på verktyget igen gör att du kan dra det till en ny position
        3. Du kan lägga till fler verktyg i verktygsfältet genom att klicka på <Plus/> plusknappen. 
    </TabItem>
</Tabs>
