---
title: Stiftwerkzeug
---

Mit diesem Werkzeug können Sie Striche auf der unendlichen Leinwand zeichnen!

Striche sind die Linien, die Sie mit dem Stift zeichnest.

Dieses Werkzeug hat viele Eigenschaften, sodass Sie mit dem Stiftwerkzeug auch einen Textmarker erstellen können!

## So wird aus dem ~~Stift~~ ein Textmarker

Das Stiftwerkzeug kann auf Wunsch als Textmarker verwendet werden!

### Folge diesen Schritten oder dem Video unten

Fügen Sie zuerst ein neues Stiftwerkzeug zur Symbolleiste hinzu

1. Drücke die +-Schaltfläche in der Symbolleiste!
2. Stift hinzufügen
3. Halte das neue Stiftsymbol gedrückt, um es zu verschieben
   - Note: when moving any tool, make sure to modify the settings in the behaviors tab to make sure
     the correct tool is activated for each input

Ändern Sie anschließend den neuen Stift

1. Öffnen Sie das Eigenschaftenfeld des neuen Stifts, indem Sie erneut darauf drücken
2. Benennen Sie den Stift um, indem Sie doppelt auf den Werkzeugnamen tippen.
3. After renaming the pen to highlighter, change the icon to match the highlighter look by pressing
   the icon

Schließlich, nachdem Sie das Aussehen des Werkzeugs angepasst haben. Jetzt ist es Zeit, die Eigenschaften anzupassen!

1. Ändern Sie die Strichbreite auf eine große Zahl, zum Beispiel 50.
   Textmarker haben schließlich breite Striche
2. Setze die Ausdünnung auf 0.  
   Textmarker haben keine variable Strichbreite.
3. Setze auch die Glättung auf 0.  
   Glättung ist nichts, was Textmarker verwenden.
4. Setze die Glättung auf MAX (1),  
   damit die Striche des Textmarkers eher wie Linien aussehen :]
5. Setze den Alpha-Wert auf 50 oder ähnlich,  
   damit die Striche unter der Hervorhebung sichtbar bleiben.

### Dieses Video zeigt, wie Sie die obige Anleitung anwendest

<video controls width="600">
  <source src="/vid/How2Highlighter.mp4" type="video/mp4" />
  
  Ihr Browser unterstützt das Video-Tag nicht.
</video>

**Glückwunsch, Sie haben jetzt einen Textmarker!**

## Konfiguration

|            Objekt |                            Standard                           | Beschreibung                                                                                                                                                   |
| ----------------: | :-----------------------------------------------------------: | :------------------------------------------------------------------------------------------------------------------------------------------------------------- |
|      Zoomabhängig |                             falsch                            | Dies ändert die Pinselbreite basierend auf der Zoomstufe.                                                                                      |
| Pfade kombinieren |                             falsch                            | This will merge all strokes it touches into one path                                                                                                           |
|     Formerkennung | false (Verzögerung: 0,5 s) | Dadurch wird versucht, Formen während des Zeichnens zu erkennen. Wenn eine Form erkannt wird, wird sie durch die Form ersetzt. |
|      Strichbreite |                               5                               | Die Breite des Strichs                                                                                                                                         |
|        Ausdünnung |                      0.4                      | Dies ist der Einfluss des Drucks auf die Strichgröße                                                                                                           |
|          Glättung |                      0.5                      | Dadurch werden die Kanten des Strichs geglättet.                                                                                               |
|           Glätten |                      0.3                      | Wie stark der Stift der Mausbewegung folgt.                                                                                                    |
|             Farbe |             Solid Color (Black)            | [Customization](../../colors/#further-customization) for the color of the stroke                                                                               |
|            Füllen |          Solid Color (Transparent)         | [Customization](../../colors/#further-customization) for the color drawn inside the enclosed area                                                              |