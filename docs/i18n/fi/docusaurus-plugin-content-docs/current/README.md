---
title: Johdanto
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Mainospalkki](/img/banner.png)

---

> Tervetuloa Butterfly, opensource note app.

Butterfly on muistiinpanon sovellus, joka tähtää yhtenäiseen kokemukseen kaikilla alustoilla. Se tarjoaa yksinkertaisen käyttöliittymän tehokkaalla muokkauksella.

## Aloittaminen

> Voit käyttää sivupalkkia navigoidaksesi nopeasti wikin kautta.


Jos haluat aloittaa sovelluksen käytön, sinulla on kaksi vaihtoehtoa:
1. [Lataa](/downloads) sovellusversio, joka sopii alustallesi (Butterfly voi ajaa useimmilla mobiili-, työpöytä- ja web-alustoilla).
2. Käytä [web-versiota](https://butterfly.linwood.dev) , jos et löydä alustaasi tai jos et halua asentaa sitä siihen. Katso [täällä](storage#web) tiedoston tallennustilasta web-versiossa.

> Kun olet avannut sovelluksen, jatka lukemista.



## Päänäkymä

![Päänäkymä](main.png)

Tärkein näkemys koostuu useista tekijöistä
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Tervetuloa näyttö](/img/welcome_screen_desktop.png)
        Näytön yläosassa on mainospalkki päivityksille, linkki tähän dokumentaatioon ja <Gear/> config-kuvake. Lopuksi, oikealle <Gear/> config symboli sinulla on pudota alas valikko valvoa milloin tämä banneri näkyy (aina / ei päivityksiä).
        The "Files" section in the major area of the left. Siellä, voit tehdä tyypillisiä toimintoja:
            - Valitse näyttötyyppi (ruudukko tai lista)
            - Valitse [lähdetallennus](tallennus) tiedostoista
            - Järjestä tiedostojen näyttöjärjestys
            - Lisää kansio, tiedostomalli, tai tuo tiedostoja klikkaamalla <Plus/> plus merkki
            - Kirjoita suora polku haluttuun paikkaan (Sijaintikenttä),
            - Etsi tiedostoja
        Lopuksi, oikealle, sinulla on nopea käynnistys näyttö malleja, jotka ovat käytettävissä nykyisessä paikassa. Uutta asennusta varten tämä sisältää vaalean ja tumman mallin
    </TabItem>
    <TabItem value="mobile">
        Kun avaat Butterfly mobiililaitteella, sinulle esitetään näyttö kuin tämä
        ! Tervetuloa näytön ensimmäinen osa](/img/welcome_screen_mobile_1. ng)   
        Näytön yläosassa on mainospalkki päivityksiä varten, ja sen alapuolella löydät documnentation linkin, ja sen vieressä <Gear/> config kuvake. Lopuksi, oikealle <Gear/> config symboli sinulla on pudota alas valikko valvoa milloin tämä banneri näkyy (aina / ei päivityksiä).
        Alla ne, löydät nopean alun osion pitämällä malleja avialable sinulle. Sivupohjat ovat vaaleita ja tummia malleja. 
        Vieritä alas, näet tiedoston käyttöliittymä:
        \
        ! Tervetuloa näyttö toinen osa](/img/welcome_screen_mobile_2. ng)  
        The "Files" -osio vasemman pääosassa. Siellä, voit tehdä tyypillisiä toimintoja:
        - Valitse näyttötyyppi (ruudukko tai lista)
        - Valitse [lähdetallennus](tallennus) tiedostoista
        - Järjestä tiedostojen näyttöjärjestys
        - Lisää kansio, tiedostomalli, tai tuo tiedostoja klikkaamalla <Plus/> plus merkki
        - Kirjoita suora polku haluttuun paikkaan (Sijaintikenttä),
        - Etsi tiedostoja
    </TabItem>
</Tabs>

Kun asiakirja on avattu valitsemalla malli tai olemassa oleva tiedosto, pääset **Document View**


## Asiakirjan Näkymä

Voit palata asiakirjan näkymästä asiakirjan luetteloon, jossa on laitteen takatoiminto (back action of your device). Kuten päänäkymässä, dokumentin näytön muutokset perustuvat laitteeseesi.

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        Työpöydän näkymässä, sinulla on vasemmassa yläreunassa tiedosto bar\
        ![file_bar](/img/document_view_file_bar. ng)\
        Tässä on vasemmalta oikealle, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        perhonen painiketta avataksesi valikon. Sen vieressä on nimikenttä, joka näyttää huomautuksen nimen. Voit uudelleennimetä merkinnän kirjoittamalla uuden nimen kyseiseen kenttään ja tallentamalla sen käyttämällä <FloppyDisk/> -näppäintä. Finally you can <MagnifyingGlass/> search for elements within the note.
        \
        Näytön oikeassa yläkulmassa on työkalurivi\
        ![toolbar](/img/document_view_toolbar. ng)\
        Oletuksena tällä palkilla on <ScribbleLoop/> lasso työkalu; <Pen/> -kynän työkalu, <Path/> polku poistaa työkalun; <ArrowCounterClockwise/> kumoa ja <ArrowClockwise/> redo butonit ja <Hand/> kädentyökalu. Sitten sinulla on <Plus/> -painike lisätäksesi elementtejä työkaluriviin, <Wrench/> -painikkeeseen, jolla voit määrittää asiakirjan, ja lopuksi <Lock/> työkalu näyttääksesi näytön zoomauksen ja/tai sijainnin. 
        ### Tärkeitä muistiinpanoja
        1. Jos osa työkalupalkin elementeistä ei näy sinulle, klikkaa ja vedä (tai pyyhkäise) vasemmalle ja oikealle paljastaaksesi lisää työkaluja. 
        2. Työkalun valinnan jälkeen ilmestyy pieni valikko. Pitkä klikkaamalla työkalua uudelleen voit vetää sen uuteen kohtaan
        3. Voit lisätä työkaluriviin lisää työkaluja klikkaamalla <Plus/> plus -merkkiä. 
    </TabItem>
    <TabItem value="mobile">
        Mobiilinäkymällä, sinulla on tiedoston alkuun palkki\
        ![file_bar](/img/document_view_file_bar. ng)\
        Tässä on vasemmalta oikealle, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        perhonen painiketta avataksesi valikon. Sen vieressä on nimikenttä, joka näyttää huomautuksen nimen. Voit uudelleennimetä merkinnän kirjoittamalla uuden nimen kyseiseen kenttään ja tallentamalla sen käyttämällä <FloppyDisk/> -näppäintä. Finally you can <MagnifyingGlass/> search for elements within the note.
        \
        Näytön alareunassa on työkalurivi\
        ![toolbar](/img/document_view_toolbar. ng)\
        Oletuksena tällä palkilla on <ScribbleLoop/> lasso työkalu; <Pen/> -kynän työkalu, <Path/> polku poistaa työkalun; <ArrowCounterClockwise/> kumoa ja <ArrowClockwise/> redo butonit ja <Hand/> kädentyökalu. Sitten sinulla on <Plus/> -painike lisätäksesi elementtejä työkaluriviin, <Wrench/> -painikkeeseen, jolla voit määrittää asiakirjan, ja lopuksi <Lock/> työkalu näyttääksesi näytön zoomauksen ja/tai sijainnin. 
        ### Tärkeitä muistiinpanoja
        1. Jos osa työkalupalkin elementeistä ei näy sinulle, tai pyyhkäise vasemmalle ja oikealle paljastaaksesi uusia elementtejä. 
        2. Työkalun valinnan jälkeen sen määrittämiseen näytetään pieni valikko. Pitkä klikkaamalla työkalua uudelleen voit vetää sen uuteen kohtaan
        3. Voit lisätä työkaluriviin lisää työkaluja klikkaamalla <Plus/> plus -merkkiä. 
    </TabItem>
</Tabs>
	

