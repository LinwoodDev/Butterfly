---
title: Introduksjon
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Fane](/img/banner.png)

---

> Velkommen til Butterfly, the opensource note app.

Sommerfugl arbeider et notat som tar app som sikter mot en enhetlig opplevelse på tvers av alle plattformer. Den har et enkelt brukergrensesnitt med kraftfull tilpasning.

## Komme i gang

> Du kan bruke sidepanelet til å raskt navigere gjennom wikien.


For å begynne å jobbe med appen har du to alternativer:
1. [Downloads](/downloads) appversjonen som passer for plattformen (Butterfly kan kjøre på mest mobil, skrivebord og nettplater).
2. Bruk [web versjon](https://butterfly.linwood.dev) hvis du ikke finner plattformen din, eller hvis du ikke vil installere den i den. Se [her](storage#web) om fillagring på nettversjonen.

> Fortsett å lese når du åpner appen.



## Hoved visning

![Hoved visning](main.png)

Hovedvisningen er satt sammen av flere elementer
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        λ Welcome-skjerm](/img/welcome_screen_desktop.png)
        Øverst på skjermen holder banneret for oppdateringer, lenken til dette dokumentasjonen, og <Gear/> konfigurasjonsikonet. Til slutt til høyre for <Gear/> config-symbolet har du en rullegardinmeny for å kontrollere når dette banneret vises (alltid/aldri/on updates).
        «Filer»-seksjonen i det største området til venstre. There, you can do the typical operations:
            - Select the display type (grid or list)
            - Select the [source storage](storage) of the files
            - Sort the display order of the files
            - Add a folder, file, template, or import files by clicking the <Plus/> plus sign
            - Type the direct path to a desired location (the Location field),
            - Search for files
        Finally, to the right, you have the quick start display with the templates available in the current location. På frisk installasjon inneholder dette lys og mørk mal
    </TabItem>
    <TabItem value="mobile">
        Når du åpner Sommerfugl på en mobil enhet vil du bli vist med en skjerm som denne
        ! Velkommen skjerm første part](/img/welcome_screen_mobile_1. ng)   
        toppen av skjermen holder banner for oppdateringer, og under er det mulig å finne documnentation link, og ved siden av <Gear/> konfigurasjonsikonkonet. Til slutt til høyre for <Gear/> config-symbolet har du en rullegardinmeny for å kontrollere når dette banneret vises (alltid/aldri/on updates).
        Under dem, kan du finne hurtigseksjonen som holder disse malene utenfor deg. By defaule, the templates are the light and dark templates. 
        Rulling ned. du vil se filgrensesnittet:
        \
        ! Velkommen neste del ](/img/welcome_screen_mobile_2. ng)  
        seksjonen «Filer» i det største området til venstre. There, you can do the typical operations:
        - Select the display type (grid or list)
        - Select the [source storage](storage) of the files
        - Sort the display order of the files
        - Add a folder, file, template, or import files by clicking the <Plus/> plus sign
        - Type the direct path to a desired location (the Location field),
        - Search for files
    </TabItem>
</Tabs>

Når du åpner et dokument ved å velge en mal eller en eksisterende fil, vil du gå til **Dokumentvisning**

## Dokumentvisning (Automatic Translation)

Fra dokumentvisningen kan du returnere til dokumentlisten med den bakenforliggende handlingen for enheten. Som for hovedvisningen vises dokumentet basert på enheten din. 

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        I Desktop view, så er du øverst til venstre i fillinjen\
        ![file_bar](/img/document_view_file_bar. ng)\
        Dette holder, fra venstre til høyre, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        sommerfuglknapp for å åpne menyen. Ved siden av det er det navnefeltet som viser navnet på merknaden. Du kan endre navn på notatet ved å skrive et nytt navn i det feltet og lagre det ved hjelp av <FloppyDisk/> Lagre-knappen. Til slutt kan du <MagnifyingGlass/> søke etter elementer i notatet.
        \
        øverst til høyre på skjermen har du verktøylinjen\
        ![toolbar](/img/document_view_toolbar. ng)\
        Som standard har denne linjen verktøyet <ScribbleLoop/> lasso; verktøyet for <Pen/> penn; verktøyet <Path/> bane-feltet; <ArrowCounterClockwise/> undo og <ArrowClockwise/> redo-butonene og verktøyet <Hand/> Deretter har du knappen <Plus/> for å legge til elementer til verktøylinjen, <Wrench/> for å konfigurere dokumentet, og til slutt verktøyet <Lock/> for å se zoomen og/eller posisjonen til skjermen. 
        ### Viktige merknader
        1. Hvis noe av elementet på verktøylinjen ikke er synlig for deg, klikk og dra (eller sveiper) til venstre og høyre for å vise flere verktøy. 
        2. Etter å ha valgt et verktøy vil en liten meny vises. Langt klikk på verktøyet igjen lar deg dra den til en ny posisjon
        3. Du kan legge til flere verktøy til verktøylinjen ved å klikke på <Plus/> pluss skilt. 
    </TabItem>
    <TabItem value="mobile">
        I den mobile visningen, så har du øverst fillinjen\
        ![file_bar](/img/document_view_file_bar. ng)\
        Dette holder, fra venstre til høyre, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        sommerfuglknapp for å åpne menyen. Ved siden av det er det navnefeltet som viser navnet på merknaden. Du kan endre navn på notatet ved å skrive et nytt navn i det feltet og lagre det ved hjelp av <FloppyDisk/> Lagre-knappen. Til slutt kan du <MagnifyingGlass/> søke etter elementer i notatet.
        \
        på bunnen av skjermen har du verktøylinjen\
        ![toolbar](/img/document_view_toolbar. ng)\
        Som standard har denne linjen verktøyet <ScribbleLoop/> lasso; verktøyet for <Pen/> penn; verktøyet <Path/> bane-feltet; <ArrowCounterClockwise/> undo og <ArrowClockwise/> redo-butonene og verktøyet <Hand/> Deretter har du knappen <Plus/> for å legge til elementer til verktøylinjen, <Wrench/> for å konfigurere dokumentet, og til slutt verktøyet <Lock/> for å se zoomen og/eller posisjonen til skjermen. 
        ### Viktige merknader
        1. Hvis noe av elementet på verktøylinjen ikke er synlig for deg, eller du sveiper mot venstre og høyre for å vise flere elementer. 
        2. Etter å ha valgt et verktøy vil det vises en liten meny for å konfigurere den. Langt klikk på verktøyet igjen lar deg dra den til en ny posisjon
        3. Du kan legge til flere verktøy til verktøylinjen ved å klikke på <Plus/> pluss skilt. 
    </TabItem>
</Tabs>
	

