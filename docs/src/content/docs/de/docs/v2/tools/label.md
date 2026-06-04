---
title: Beschriftungswerkzeug
---

Mit diesem Werkzeug können Sie Text oder mathematische Formeln auf der unendlichen Leinwand hinzufügen.

# Mathematik

Mit dem Textbeschriftungswerkzeug können Sie mathematische Formeln schreiben, statt sie zu zeichnen.

Das Textbeschriftungswerkzeug unterstützt **LaTeX** zum Definieren mathematischer Formeln.

## Wie Sie möchten! Was ist LaTeX?

LaTeX ist eine Auszeichnungssprache mit vielen Funktionen; Sie können sie verwenden, um mathematische Formeln in Butterfly zu **schreiben**.

### Warum sollte ich mathematische Gleichungen schreiben, wenn ich sie zeichnen kann?

Das liegt bei Ihnen, aber manchmal ist ein sauber formatierter mathematischer Ausdruck Handschrift vorzuziehen.

## Wie wende ich LaTeX an?

Um LaTeX auf geschriebenen Text anzuwenden, müssen Sie den Text auswählen und dann das Mathe-Symbol in der Symbolleiste drücken.

Damit dies funktioniert, müssen Sie die LaTeX-Syntax einhalten!

## LaTeX-Syntax

Um LaTeX zu verwenden, müssen Sie seine Syntax kennen!

Keine Sorge, die Syntax ist einfach; Sie müssen nur einige Begriffe kennen.

### Grundlegende Anleitung

Vor jedem LaTeX-Befehl muss ein Backslash (\\) stehen, damit er als Befehl erkannt wird.

Ein Beispielbefehl ist `\int_{7}^{6}`, mit dem das Integralsymbol angezeigt wird:

```math
\int_{7}^{6}
```

#### Liste nützlicher Befehle

| Befehl                                       | Beschreibung                                                                             | Beispiel                                                            | Beispielbefehl                            |
| -------------------------------------------- | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------- | ----------------------------------------- |
| `\sqrt[n]{arg}`                             | Quadratwurzelsymbol oder n-te Wurzel                                                     | $\sqrt[3]{x+1}$ | `\sqrt[3]{x+1}`                          |
| `\frac{num}{den}`                           | Bruch mit Zähler und Nenner                                                              | $\frac{a+1}{b-1}$                                                   | `\frac{a+1}{b-1}`                        |
| `\stackrel{a}{b}`                           | Setzt etwas (`a`) über etwas anderes (`b`)         | $\stackrel{!}{=}$                                                   | `\stackrel{!}{=}`                        |
| `\left<delimiter>` and `\right<delimiter>` | Skalierende Klammern/Begrenzer. `\left` must be paired with a `\right` | $\left( \frac{x}{2} \right)$                     | `\left( \frac{x}{2} \right)`           |
| `\sum_{lower}^{upper}`                      | Summenzeichen mit Grenzen                                                                | $\sum_{i=1}^{n} i$                             | `\sum_{i=1}^{n} i`                       |
| `\mid`                                      | Vertikaler Strich als Relation („teilt“ oder Bedingung)               | $a\mid b$                                                           | `a\mid b`                                |
| `\prod_{lower}^{upper}`                     | Produktzeichen mit Grenzen                                                               | $\prod_{k=1}^{m} k$                            | `\prod_{k=1}^{m} k`                      |
| `\int_{a}^{b}`                              | Integral mit Grenzen                                                                     | $\int_{0}^{1} x^2\,dx$                        | `\int_{0}^{1} x^2\,dx`                  |
| `\langle` and `\rangle`                    | Winkelklammern (innere Produkte, Tupel)                               | $\langle v,w\rangle$                                                | `\langle v,w\rangle`                    |
| `\in` and `\notin`                         | Elementbeziehung oder Nicht-Elementbeziehung                                             | $x\in A$, $y\notin B$                                               | `x\in A`, `y\notin B`                   |
| `\forall` and `\exists`                    | All- oder Existenzquantoren                                                              | $\forall x\in\mathbb{R},\ \exists y$                                | `\forall x\in\mathbb{R},\ \exists y` |
| `\to`                                       | Pfeil nach rechts (Funktionen, Grenzwerte)                            | $f:A\to B$, $x_n\to x$         | `f:A\to B`, `x_n\to x`                  |

## Konfiguration

| Objekt | Standard | Beschreibung         |
| -----: | :------: | :------------------- |
|  Größe |    12    | Die Größe des Textes |
