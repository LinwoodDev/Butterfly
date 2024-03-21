---
title: Úvod
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Banner](/img/banner.png)

---

> Vítejte v aplikaci Butterfly, opensource poznámky.

Butterfly je aplikace pro přijímání poznámek, která se zaměřuje na jednotné zkušenosti na všech platformách. Poskytuje jednoduché uživatelské rozhraní s účinným přizpůsobením.

## Jak začít

> K rychlému procházení wiki můžete použít postranní panel.


Chcete-li začít pracovat na aplikaci, máte dvě možnosti:
1. [Stahování](/downloads) verze aplikace, která je vhodná pro vaši platformu (Butterfly může běžet na většině mobilních, stolních a webových platforem).
2. Použijte [webovou verzi](https://butterfly.linwood.dev) , pokud nemůžete najít platformu nebo na ni nechcete nainstalovat. Podívejte se na [](storage#web) o úložišti souborů ve webové verzi.

> Jakmile otevřete aplikaci, pokračujte ve čtení.



## Hlavní pohled

![Hlavní pohled](main.png)

Hlavní pohled se skládá z několika prvků.
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Welcome screen](/img/welcome_screen_desktop.png)
        Horní část obrazovky drží banner pro aktualizace, odkaz na tuto dokumentaci a ikonu <Gear/>. Konečně vpravo od <Gear/> konfiguračního symbolu máte rozbalovací menu pro ovládání, kdy se zobrazí tento banner (vždy/nikdy/nikdy).
        Sekce "Soubory" v hlavní části levé části. Tam můžete provést typické operace:
            - Vyberte typ zobrazení (mřížka nebo seznam)
            - Vyberte [zdrojové úložiště](úložiště) souborů
            - Seřadit pořadí zobrazení souborů
            - Přidat složku, soubor, šablona, nebo importovat soubory kliknutím na <Plus/> plus znak
            - zadejte přímou cestu do požadovaného umístění (pole Místo,
            - Hledat soubory
        Nakonec vpravo máte na aktuálním místě dostupné šablony pro rychlý start. Pro novou instalaci zahrnuje světlou a tmavou šablonu
    </TabItem>
    <TabItem value="mobile">
        Při otevírání Butterfly na mobilním zařízení budete prezentováni s obrazovkou jako je ta
        ! První část úvodní obrazovky](/img/welcome_screen_mobile_1. ng)   
        Horní část obrazovky drží banner pro aktualizace, a níže můžete najít odkaz na poznámku a vedle něj ikonu <Gear/>. Konečně vpravo od <Gear/> konfiguračního symbolu máte rozbalovací menu pro ovládání, kdy se zobrazí tento banner (vždy/nikdy/nikdy).
        Níže najdete sekci rychlého startu a držíte šablony pro vás nedostupné. Pomocí defaule jsou šablony světlé a tmavé šablony. 
        rolování dolů, uvidíte rozhraní souboru:
        \
        ! Vítejte obrazovku druhé části](/img/welcome_screen_mobile_2. ng)  
        Sekce "Soubory" v hlavní části levé části. Tam můžete provést typické operace:
        - Vyberte typ zobrazení (mřížka nebo seznam)
        - Vyberte [zdrojové úložiště](úložiště) souborů
        - Seřadit pořadí zobrazení souborů
        - Přidat složku, soubor, šablona, nebo importovat soubory kliknutím na <Plus/> plus znak
        - zadejte přímou cestu do požadovaného umístění (pole Místo,
        - Hledat soubory
    </TabItem>
</Tabs>

Po otevření dokumentu výběrem šablony nebo existujícího souboru se dostanete do **Zobrazení dokumentu**


## Zobrazení dokumentu

Můžete se vrátit z zobrazení dokumentu do seznamu dokumentů pomocí zadní akce vašeho zařízení. Stejně jako v případě hlavního zobrazení, změny zobrazení dokumentu na základě vašeho zařízení.

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        V zobrazení plochy budete mít v levém horním rohu souboru\
        ![file_bar](/img/document_view_file_bar. ng)\
        To podrží, zleva doprava. 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        tlačítko "motýle" pro otevření menu. Vedle toho je pole, které zobrazuje název poznámky. Poznámka můžete přejmenovat zadáním nového jména do tohoto pole a jeho uložením pomocí tlačítka <FloppyDisk/> uložit. Konečně můžete <MagnifyingGlass/> hledat prvky v poznámce.
        \
        V pravém horním rohu obrazovky máte panel nástrojů\
        ![toolbar](/img/document_view_toolbar. ng)\
        Tento panel má ve výchozím nastavení nástroj <ScribbleLoop/> , nástroje pera <Pen/> , cesta <Path/> vymaže nástroj; <ArrowCounterClockwise/> vrátit zpět a <ArrowClockwise/> vrátit butony a ruční nástroj <Hand/>. Pak máte tlačítko <Plus/> pro přidání prvků na nástrojovou lištu, tlačítko <Wrench/> pro konfiguraci dokumentu, a nakonec nástroj <Lock/> pro zobrazení přiblížení a/nebo polohy obrazovky. 
        ### Důležité poznámky
        1. Pokud nejsou některé prvky na panelu nástrojů viditelné pro vás, klikněte a přetáhněte (či potáhněte) vlevo a vpravo, abyste odhalili další nástroje. 
        2. Po výběru nástroje se objeví malé menu. Dlouhým kliknutím na tento nástroj můžete přetáhnout na novou pozici
        3. Další nástroje můžete přidat kliknutím na <Plus/> plus na znaménko. 
    </TabItem>
    <TabItem value="mobile">
        V mobilním zobrazení budete mít v horní části panelu souborů\
        ![file_bar](/img/document_view_file_bar. ng)\
        To podrží, zleva doprava. 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        tlačítko "motýle" pro otevření menu. Vedle toho je pole, které zobrazuje název poznámky. Poznámka můžete přejmenovat zadáním nového jména do tohoto pole a jeho uložením pomocí tlačítka <FloppyDisk/> uložit. Konečně můžete <MagnifyingGlass/> hledat prvky v poznámce.
        \
        V dolní části obrazovky máte panel nástrojů\
        ![toolbar](/img/document_view_toolbar. ng)\
        Tento panel má ve výchozím nastavení nástroj <ScribbleLoop/> , nástroje pera <Pen/> , cesta <Path/> vymaže nástroj; <ArrowCounterClockwise/> vrátit zpět a <ArrowClockwise/> vrátit butony a ruční nástroj <Hand/>. Pak máte tlačítko <Plus/> pro přidání prvků na nástrojovou lištu, tlačítko <Wrench/> pro konfiguraci dokumentu, a nakonec nástroj <Lock/> pro zobrazení přiblížení a/nebo polohy obrazovky. 
        ### Důležité poznámky
        1. Pokud některé prvky na panelu nástrojů nejsou viditelné nebo přejetím vlevo a vpravo zobrazíte další prvky. 
        2. Po výběru nástroje se objeví malá nabídka. Dlouhým kliknutím na tento nástroj můžete přetáhnout na novou pozici
        3. Další nástroje můžete přidat kliknutím na <Plus/> plus na znaménko. 
    </TabItem>
</Tabs>
	

