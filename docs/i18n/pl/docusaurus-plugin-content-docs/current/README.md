---
title: Wprowadzanie
id: intro
slug: /intro
sidebar_position: 1
---

importuj zakładki z '@theme/Tabs'; zaimportuj zakładkę z '@theme/Tabela'; import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Ścieżka ArrowCounterClockline, ArrowClockline, Dłoń, Wrench, Lock} z "@phosphor-icons/react";

![Sztandar](/img/banner.png)

---

> Witamy w Butterfly, aplikacji "opensource notatka".

Butterfly to notatka z aplikacją, która ma na celu ujednolicenie doświadczenia na wszystkich platformach. Zapewnia prosty interfejs użytkownika z potężnym dostosowywaniem.

## Pierwsze kroki

> Możesz użyć paska bocznego, aby szybko nawigować przez wiki.

Aby rozpocząć pracę nad aplikacją, masz dwie opcje:

1. [Pobiera](/downloads) wersję aplikacji, która jest odpowiednia dla Twojej platformy (Butterfly może działać na większości telefonów komórkowych, desktopowych i webplatfroms).
2. Użyj [web version](https://web.butterfly.linwood.dev) jeśli nie możesz znaleźć swojej platformy lub jeśli nie chcesz na niej zainstalować. Zobacz [tutaj](storage#web) o przechowywaniu plików w wersji internetowej.

> Po otwarciu aplikacji, kontynuuj czytanie.

## Widok główny

![Widok główny](main.png)

Główny widok składa się z kilku elementów
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Ekran powitalny](/img/welcome_screen_desktop.png)
        Górna część ekranu zawiera baner do aktualizacji, link do tej dokumentacji i ikonę konfiguracji <Gear/>. Na koniec, po prawej stronie symbolu konfiguracji <Gear/> masz rozwijane menu do kontrolowania, kiedy ten baner pojawi się (zawsze/nigdy/nigdy/na aktualizacjach).
        Sekcja "Pliki" w głównej części po lewej stronie. Tam możesz wykonać typowe operacje:
            - Wybierz typ wyświetlania (siatka lub lista)
            - Wybierz [pamięć źródłowa](przechowywanie) plików
            - Sortuj kolejność wyświetlania plików
            - Dodaj folder, plik, szablon, lub zaimportuj pliki klikając <Plus/> plus znak
            - Wpisz bezpośrednią ścieżkę do żądanej lokalizacji (pole lokalizacji),
            - Szukaj plików
        Wreszcie, po prawej, masz szybki ekran startowy z szablonami dostępnymi w bieżącej lokalizacji. Dla świeżej instalacji zawiera jasny i ciemny szablon
    </TabItem>
    <TabItem value="mobile">
        Podczas otwierania Butterfly na urządzeniu mobilnym zostaniesz zaprezentowany na ekranie jako
        ! Pierwsza część ekranu powitalnego](/img/welcome_screen_mobile_1. ng)   
        Górna część ekranu trzyma baner do aktualizacji, i poniżej niego możesz znaleźć link dokumnentacji, a obok ikony <Gear/>. Na koniec, po prawej stronie symbolu konfiguracji <Gear/> masz rozwijane menu do kontrolowania, kiedy ten baner pojawi się (zawsze/nigdy/nigdy/na aktualizacjach).
        Poniżej znajdziesz sekcję szybkiego startu, trzymając szablony w znacznym stopniu dla Ciebie. Przez defaule szablony są jasnymi i ciemnymi szablonami. 
        Przewijanie w dół, zobaczysz interfejs pliku:
        \
        ! Druga część ekranu powitalnego](/img/welcome_screen_mobile_2. ng)  
        Sekcja "Pliki" w głównym obszarze po lewej stronie. Tam możesz wykonać typowe operacje:
        - Wybierz typ wyświetlania (siatka lub lista)
        - Wybierz [pamięć źródłowa](przechowywanie) plików
        - Sortuj kolejność wyświetlania plików
        - Dodaj folder, plik, szablon, lub zaimportuj pliki klikając <Plus/> plus znak
        - Wpisz bezpośrednią ścieżkę do żądanej lokalizacji (pole lokalizacji),
        - Szukaj plików
    </TabItem>
</Tabs>

Po otwarciu dokumentu wybierając szablon lub istniejący plik, przejdziesz do **Widok dokumentu**

## Widok dokumentu

Możesz wrócić z widoku dokumentu do listy dokumentów z akcją wsteczną urządzenia. Tak jak w widoku głównym, dokument wyświetla zmiany w oparciu o Twoje urządzenie.

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        W widoku na pulpicie będziesz miał w lewym górnym rogu pasek pliku\
        ![file_bar](/img/document_view_file_bar. ng)\
        To trzyma się od lewej do prawej, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        przycisk motyl, aby otworzyć menu. Obok niego jest pole nazwy, które wyświetla nazwę notatki. Możesz zmienić nazwę notatki, wpisując nową nazwę w tym polu i zapisując ją za pomocą przycisku <FloppyDisk/>. Na koniec możesz <MagnifyingGlass/> wyszukać elementy w notatce.
        \
        W prawym górnym rogu ekranu masz pasek narzędzi\
        ![toolbar](/img/document_view_toolbar. ng)\
        Domyślnie ten pasek posiada narzędzie laserowe <ScribbleLoop/> ; narzędzie pióra <Pen/> ; narzędzie do usuwania ścieżki <Path/> ; cofnij <ArrowCounterClockwise/> i <ArrowClockwise/> powtórz butony, oraz ręczne narzędzie <Hand/>. Następnie masz przycisk <Plus/> aby dodać elementy do paska narzędzi, przycisk <Wrench/> aby skonfigurować dokument, i wreszcie narzędzie <Lock/> do oglądania powiększenia i/lub pozycji ekranu. 
        ### Ważne uwagi
        1. Jeśli część elementu na pasku narzędzi nie jest dla Ciebie widoczna, kliknij i przeciągnij (lub przesuń) w lewo i w prawo, aby wyświetlić kolejne narzędzia. 
        2. Po wybraniu narzędzia pojawi się małe menu. Długie kliknięcie narzędzia ponownie pozwoli przeciągnąć go do nowej pozycji
        3. Możesz dodać więcej narzędzi do paska narzędzi, klikając znak <Plus/> plus. 
    </TabItem>
    <TabItem value="mobile">
        W widoku mobilnym będziesz mieć na górze paska plików\
        ![file_bar](/img/document_view_file_bar. ng)\
        To trzyma się od lewej do prawej, 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        przycisk motyl, aby otworzyć menu. Obok niego jest pole nazwy, które wyświetla nazwę notatki. Możesz zmienić nazwę notatki, wpisując nową nazwę w tym polu i zapisując ją za pomocą przycisku <FloppyDisk/>. Na koniec możesz <MagnifyingGlass/> wyszukać elementy w notatce.
        \
        Na dole ekranu masz pasek narzędzi\
        ![toolbar](/img/document_view_toolbar. ng)\
        Domyślnie ten pasek posiada narzędzie laserowe <ScribbleLoop/> ; narzędzie pióra <Pen/> ; narzędzie do usuwania ścieżki <Path/> ; cofnij <ArrowCounterClockwise/> i <ArrowClockwise/> powtórz butony, oraz ręczne narzędzie <Hand/>. Następnie masz przycisk <Plus/> aby dodać elementy do paska narzędzi, przycisk <Wrench/> aby skonfigurować dokument, i wreszcie narzędzie <Lock/> do oglądania powiększenia i/lub pozycji ekranu. 
        ### Ważne uwagi
        1. Jeśli część elementu na pasku narzędzi nie jest widoczna lub przesuń palcem w lewo i w prawo, aby wyświetlić kolejne elementy. 
        2. Po wybraniu narzędzia pojawi się małe menu, aby go skonfigurować. Długie kliknięcie narzędzia ponownie pozwoli przeciągnąć go do nowej pozycji
        3. Możesz dodać więcej narzędzi do paska narzędzi, klikając znak <Plus/> plus. 
    </TabItem>
</Tabs>
