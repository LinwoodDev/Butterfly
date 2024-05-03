---
title: Einführung
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![Banner](/img/banner.png)

---

> Willkommen bei Butterfly, der Opensource Notiz-App.

Butterfly ist eine Notizenanwendung, die auf einheitliche Erfahrungen auf allen Plattformen abzielt. Es bietet einfache Benutzeroberfläche mit leistungsstarken Anpassungen.

## Erste Schritte

> Sie können die Seitenleiste benutzen, um schnell durch das Wiki zu navigieren.

Um mit der Arbeit an der App zu beginnen, haben Sie zwei Möglichkeiten:

1. [Downloads](/downloads) die App-Version, die für Ihre Plattform geeignet ist (Butterfly kann auf den meisten Mobiltelefonen, Desktop- und Web-Plattformen ausgeführt werden).
2. Verwenden Sie [Web-Version](https://web.butterfly.linwood.dev) , wenn Sie Ihre Plattform nicht finden oder sie nicht auf ihr installieren möchten. Siehe [hier](storage#web) über Dateispeicher auf der Web-Version.

> Sobald Sie die App geöffnet haben, lesen Sie weiter.

## Hauptansicht

![Hauptansicht](main.png)

Die Hauptansicht besteht aus mehreren Elementen
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Welcome screen](/img/welcome_screen_desktop.png)
        The top of the screen holds the banner for updates, the link to this documentations, and the <Gear/> config icon. Auf der rechten Seite des <Gear/> Konfig-Symbols haben Sie schließlich ein Dropdown-Menü, mit dem Sie kontrollieren können, wann dieser Banner angezeigt wird (immer/nein/bei Updates).
        Der Abschnitt "Dateien" im Hauptbereich der linken Seite. Dort, du kannst die typischen Vorgänge durchführen:
            - Wählen Sie den Anzeigetyp (Gitter oder Liste)
            - Wählen Sie den [Quellspeicher](storage) der Dateien
            - Sortieren Sie die Anzeigereihenfolge der Dateien
            - Fügen Sie einen Ordner hinzu, Datei, Vorlage, oder importieren Sie Dateien durch Klicken auf <Plus/> plus Zeichen
            - Geben Sie den direkten Pfad zu einem gewünschten Ort ein (Ortsfeld),
            - Suche nach Dateien
        Schließlich rechts Sie haben die Schnellstartanzeige mit den Vorlagen, die an der aktuellen Stelle verfügbar sind. Für eine neue Installation beinhaltet dies die helle und dunkle Vorlage
    </TabItem>
    <TabItem value="mobile">
        Beim Öffnen von Butterfly auf einem mobilen Gerät wird dir ein Bildschirm wie dieses
        vorgestellt! Startbildschirm erster Teil](/img/welcome_screen_mobile_1. ng)   
        Der obere Rand des Bildschirms enthält den Banner für Updates, und darunter finden Sie den Link zur Dokumentation und daneben das <Gear/> Konfigurations-Symbol. Auf der rechten Seite des <Gear/> Konfig-Symbols haben Sie schließlich ein Dropdown-Menü, mit dem Sie kontrollieren können, wann dieser Banner angezeigt wird (immer/nein/bei Updates).
        Unter diesen finden Sie den Schnellstart-Abschnitt mit den Vorlagen, die für Sie zugänglich sind. Mit defaule sind die Vorlagen die hellen und dunklen Vorlagen. 
        Herunterscrollen Sie werden die Dateischnittstelle sehen:
        \
        ! Begrüßungsbildschirm zweiter Teil](/img/welcome_screen_mobile_2. ng)  
        Der Abschnitt "Dateien" im Hauptbereich der linken Seite. Dort, du kannst die typischen Vorgänge durchführen:
        - Wählen Sie den Anzeigetyp (Gitter oder Liste)
        - Wählen Sie den [Quellspeicher](storage) der Dateien
        - Sortieren Sie die Anzeigereihenfolge der Dateien
        - Fügen Sie einen Ordner hinzu, Datei, Vorlage, oder importieren Sie Dateien durch Klicken auf <Plus/> plus Zeichen
        - Geben Sie den direkten Pfad zu einem gewünschten Ort ein (Ortsfeld),
        - Dateien suchen
    </TabItem>
</Tabs>

Sobald Sie ein Dokument durch Auswahl einer Vorlage oder einer existierenden Datei geöffnet haben, gelangen Sie zur **Dokumentenansicht**

## Die Dokumentansicht

Sie können von der Dokumentenansicht mit der Rücken-Aktion Ihres Geräts in die Dokumentenliste zurückkehren. Wie bei der Hauptansicht zeigt das Dokument Änderungen basierend auf Ihrem Gerät an.

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        In der Desktop-Ansicht haben Sie oben links die Datei Bar\
        ![file_bar](/img/document_view_file_bar. ng)\
        Dies hält von links nach rechts die 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        Schmetterlings-Taste zum Öffnen des Menüs. Daneben befindet sich das Namensfeld, das den Namen der Notiz anzeigt. Sie können die Notiz umbenennen, indem Sie einen neuen Namen in dieses Feld eingeben und mit dem <FloppyDisk/> Speichern-Button speichern. Schließlich kannst du <MagnifyingGlass/> nach Elementen innerhalb der Notiz suchen.
        \
        At the top right of the screen you have the toolbar\
        ![toolbar](/img/document_view_toolbar.png)\
        By default this bar has the <ScribbleLoop/> lasso tool; the <Pen/> pen tool; the <Path/> path erase tool; the <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, and the <Hand/> hand tool. Dann haben Sie die <Plus/> -Taste, um Elemente zur Werkzeugleiste hinzuzufügen, die <Wrench/> Schaltfläche zum Konfigurieren des Dokuments und schließlich das <Lock/> Werkzeug, um den Zoom und/oder die Position des Bildschirms zu sehen. 
        ### Wichtige Hinweise
        1. Wenn einige der Elemente in der Werkzeugleiste nicht für Sie sichtbar sind, klicken Sie und ziehen (oder wischen) nach links und rechts, um weitere Werkzeuge anzuzeigen. 
        2. Nach der Auswahl eines Werkzeugs erscheint ein kleines Menü. Durch langes Klicken auf das Werkzeug können Sie es an eine neue Position
        3 ziehen. Sie können weitere Werkzeuge zur Werkzeugleiste hinzufügen, indem Sie auf das <Plus/> Plus-Zeichen klicken. 
    </TabItem>
    <TabItem value="mobile">
        In der mobilen Ansicht haben Sie oben die Datei bar\
        ![file_bar](/img/document_view_file_bar. ng)\
        Dies hält von links nach rechts die 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo. ng)
        Schmetterlings-Taste zum Öffnen des Menüs. Daneben befindet sich das Namensfeld, das den Namen der Notiz anzeigt. Sie können die Notiz umbenennen, indem Sie einen neuen Namen in dieses Feld eingeben und mit dem <FloppyDisk/> Speichern-Button speichern. Schließlich kannst du <MagnifyingGlass/> nach Elementen innerhalb der Notiz suchen.
        \
        At the bottom of the screen you have the toolbar\
        ![toolbar](/img/document_view_toolbar.png)\
        By default this bar has the <ScribbleLoop/> lasso tool; the <Pen/> pen tool; the <Path/> path erase tool; the <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, and the <Hand/> hand tool. Dann haben Sie die <Plus/> -Taste, um Elemente zur Werkzeugleiste hinzuzufügen, die <Wrench/> Schaltfläche zum Konfigurieren des Dokuments und schließlich das <Lock/> Werkzeug, um den Zoom und/oder die Position des Bildschirms zu sehen. 
        ### Wichtige Hinweise
        1. Wenn einige der Elemente in der Werkzeugleiste nicht für Sie sichtbar sind, oder wischen Sie links und rechts, um weitere Elemente anzuzeigen. 
        2. Nach der Auswahl eines Werkzeugs erscheint ein kleines Menü, um es zu konfigurieren. Durch langes Klicken auf das Werkzeug können Sie es an eine neue Position
        3 ziehen. Sie können weitere Werkzeuge zur Werkzeugleiste hinzufügen, indem Sie auf das <Plus/> Plus-Zeichen klicken. 
    </TabItem>
</Tabs>
