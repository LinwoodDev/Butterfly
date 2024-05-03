---
title: Indledning
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Banner](/img/banner.png)

---

> Velkommen til Butterfly, opensource note app.

Butterfly er en note tager app, der sigter efter samlet oplevelse på tværs af alle platforme. Det giver enkel brugerflade med kraftig tilpasning.

## Før injektion

> Du kan bruge sidebjælken til at navigere hurtigt gennem wikien.

For at begynde at arbejde på appen, har du to muligheder:

1. [Downloads](/downloads) den app-version, der passer til din platform (Butterfly kan køre på de fleste mobil, skrivebord og webplatfra).
2. Brug [webversion](https://web.butterfly.linwood.dev) , hvis du ikke kan finde din platform, eller hvis du ikke ønsker at installere den på den. Se [her](storage#web) om fillagring i webversionen.

> Når du åbner appen, fortsæt med at læse.

## Hoved visning

![Hoved visning](main.png)

Hovedvisningen er sammensat af flere elementer
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Velkomstskærm](/img/welcome_screen_desktop.png)
        Toppen af skærmen indeholder banneret for opdateringer, linket til disse dokumenter og <Gear/> config ikonet. Endelig, til højre for <Gear/> config symbolet har du en rullemenu til at styre, hvornår dette banner vises (altid/aldrig/på opdateringer).
        Afsnittet "Filer" i det store område af venstre. Der, du kan gøre de typiske handlinger:
            - Vælg visningstypen (gitter eller liste)
            - Vælg [kilde lagerplads] af filerne
            - Sorter visningsrækkefølgen af filerne
            - Tilføj en mappe, fil, skabelon eller import filer ved at klikke på <Plus/> plus sign
            - Skriv den direkte sti til et ønsket sted (Placeringsfeltet),
            - Søg efter filer
        Endelig til højre, du har den hurtige start display med skabeloner til rådighed i den aktuelle placering. For en frisk installere dette omfatter lys og mørk skabelon
    </TabItem>
    <TabItem value="mobile">
        Når du åbner Butterfly på en mobil enhed, vil du blive præsenteret for en skærm som denne
        ! Velkomstskærm første del](/img/welcome_screen_mobile_1. ng)   
        Toppen af skærmen indeholder banneret for opdateringer, og under den kan du finde documnentation linket, og ved siden af <Gear/> config ikonet. Endelig, til højre for <Gear/> config symbolet har du en rullemenu til at styre, hvornår dette banner vises (altid/aldrig/på opdateringer).
        Nedenfor dem, kan du finde den hurtige start sektion, der holder skabeloner avialable til dig. Ved defaule er skabelonerne de lyse og mørke skabeloner. 
        Ruller ned, vil du se filgrænsefladen:
        \
        ! Welcome screen second part](/img/welcome_screen_mobile_2. ng)  
        sektionen "Filer" i det store område af venstre. Der, du kan gøre de typiske handlinger:
        - Vælg visningstypen (gitter eller liste)
        - Vælg [kilde lagerplads] af filerne
        - Sorter visningsrækkefølgen af filerne
        - Tilføj en mappe, fil, skabelon eller import filer ved at klikke på <Plus/> plus sign
        - Skriv den direkte sti til et ønsket sted (Placeringsfeltet),
        - Søg efter filer
    </TabItem>
</Tabs>

Når du åbner et dokument ved at vælge en skabelon eller en eksisterende fil, vil du komme til **Document View**

## Dokumentvisningen

Du kan vende tilbage fra dokumentvisningen til dokumentlisten med baghandlingen på din enhed. Som med hovedvisningen, vises dokumentet ændringer baseret på din enhed.

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        I skrivebordsvisningen har du øverst til venstre for filbjælken\
        ![file_bar](/img/document_view_file_bar. ng)\
        Dette holder, fra venstre mod højre, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        butterfly knap til at åbne menuen. Ved siden af det er der navnet felt, der viser navnet på noten. Du kan omdøbe noten ved at skrive et nyt navn i feltet og gemme det ved hjælp af <FloppyDisk/> gem knappen. Endelig kan du <MagnifyingGlass/> søge efter elementer i noten.
        \
        Øverst til højre på skærmen har du værktøjslinjen\
        ![toolbar](/img/document_view_toolbar. ng)\
        Som standard har denne linje <ScribbleLoop/> lassoværktøjet. værktøjet <Pen/> <Path/> sti slette værktøj; <ArrowCounterClockwise/> fortryd og <ArrowClockwise/> redo butons, og <Hand/> håndværktøj. Derefter har du knappen <Plus/> for at tilføje elementer til værktøjslinjen, <Wrench/> -knappen for at konfigurere dokumentet, og endelig <Lock/> værktøj til at se zoom og/eller placeringen af skærmen. 
        ### Vigtige noter
        1. Hvis noget af elementet på værktøjslinjen ikke er synligt for dig, klik og træk (eller stryge) til venstre og højre for at afsløre yderligere værktøjer. 
        2. Når du har valgt et værktøj, vises en lille menu. Langt at klikke på værktøjet igen vil give dig mulighed for at trække det til en ny position
        3. Du kan tilføje flere værktøjer til værktøjslinjen ved at klikke på <Plus/> plus tegn. 
    </TabItem>
    <TabItem value="mobile">
        I den mobile visning har du øverst filbjælken\
        ![file_bar](/img/document_view_file_bar. ng)\
        Dette holder, fra venstre mod højre, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        butterfly knap til at åbne menuen. Ved siden af det er der navnet felt, der viser navnet på noten. Du kan omdøbe noten ved at skrive et nyt navn i feltet og gemme det ved hjælp af <FloppyDisk/> gem knappen. Endelig kan du <MagnifyingGlass/> søge efter elementer i noten.
        \
        I bunden af skærmen har du værktøjslinjen\
        ![toolbar](/img/document_view_toolbar. ng)\
        Som standard har denne linje <ScribbleLoop/> lassoværktøjet. værktøjet <Pen/> <Path/> sti slette værktøj; <ArrowCounterClockwise/> fortryd og <ArrowClockwise/> redo butons, og <Hand/> håndværktøj. Derefter har du knappen <Plus/> for at tilføje elementer til værktøjslinjen, <Wrench/> -knappen for at konfigurere dokumentet, og endelig <Lock/> værktøj til at se zoom og/eller placeringen af skærmen. 
        ### Vigtige noter
        1. Hvis noget af elementet på værktøjslinjen ikke er synligt for dig, eller stryg til venstre og højre for at afsløre yderligere elementer. 
        2. Når du har valgt et værktøj, vil en lille menu se ud til at indstille det. Langt at klikke på værktøjet igen vil give dig mulighed for at trække det til en ny position
        3. Du kan tilføje flere værktøjer til værktøjslinjen ved at klikke på <Plus/> plus tegn. 
    </TabItem>
</Tabs>
