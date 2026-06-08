---
title: Beschriftungswerkzeug
---

With this tool you can add text, Markdown, or mathematical formulas into the infinite canvas.

## Modes

The label tool can be used in different modes:

|    Modus | Beschreibung                                    |
| -------: | :---------------------------------------------- |
|     Text | Adds plain text labels.         |
| Markdown | Adds formatted Markdown labels. |

## Mathematik

Mit dem Textbeschriftungswerkzeug können Sie mathematische Formeln schreiben, statt sie zu zeichnen.

Das Textbeschriftungswerkzeug unterstützt **LaTeX** zum Definieren mathematischer Formeln.

## Was ist LaTeX?

LaTeX is a markup language that has many features. You can use it to **write** mathematical formulas in Butterfly.

### Warum sollte ich mathematische Gleichungen schreiben, wenn ich sie zeichnen kann?

It is up to you, but sometimes a properly formatted mathematical expression is preferred over handwriting.

## Wie wende ich LaTeX an?

To apply LaTeX to the text you have written, select the text and then press the math symbol in the toolbar.

You need to follow LaTeX syntax for this to work.

## LaTeX syntax

To start using LaTeX, you need to know its syntax.

A backslash (`\`) must precede any LaTeX command to indicate it is a command.

Ein Beispielbefehl ist `\int_{7}^{6}`, mit dem das Integralsymbol angezeigt wird:

```math
\int_{7}^{6}
```

### Useful commands

| Befehl                                       | Beschreibung                                                                             | Beispiel                                                            | Example command                           |
| -------------------------------------------- | ---------------------------------------------------------------------------------------- | ------------------------------------------------------------------- | ----------------------------------------- |
| `\sqrt[n]{arg}`                             | Square root symbol, or nth root                                                          | $\sqrt[3]{x+1}$ | `\sqrt[3]{x+1}`                          |
| `\frac{num}{den}`                           | Bruch mit Zähler und Nenner                                                              | $\frac{a+1}{b-1}$                                                   | `\frac{a+1}{b-1}`                        |
| `\stackrel{a}{b}`                           | Places something (`a`) above another (`b`)         | $\stackrel{!}{=}$                                                   | `\stackrel{!}{=}`                        |
| `\left<delimiter>` and `\right<delimiter>` | Skalierende Klammern/Begrenzer. `\left` must be paired with a `\right` | $\left( \frac{x}{2} \right)$                     | `\left( \frac{x}{2} \right)`           |
| `\sum_{lower}^{upper}`                      | Summenzeichen mit Grenzen                                                                | $\sum_{i=1}^{n} i$                             | `\sum_{i=1}^{n} i`                       |
| `\mid`                                      | Vertical bar as relation, such as “divides” or conditional                               | $a\mid b$                                                           | `a\mid b`                                |
| `\prod_{lower}^{upper}`                     | Produktzeichen mit Grenzen                                                               | $\prod_{k=1}^{m} k$                            | `\prod_{k=1}^{m} k`                      |
| `\int_{a}^{b}`                              | Integral mit Grenzen                                                                     | $\int_{0}^{1} x^2\,dx$                        | `\int_{0}^{1} x^2\,dx`                  |
| `\langle` and `\rangle`                    | Angle brackets for inner products or tuples                                              | $\langle v,w\rangle$                                                | `\langle v,w\rangle`                    |
| `\in` and `\notin`                         | Elementbeziehung oder Nicht-Elementbeziehung                                             | $x\in A$, $y\notin B$                                               | `x\in A`, `y\notin B`                   |
| `\forall` and `\exists`                    | All- oder Existenzquantoren                                                              | $\forall x\in\mathbb{R},\ \exists y$                                | `\forall x\in\mathbb{R},\ \exists y` |
| `\to`                                       | Right arrow for functions or limits                                                      | $f:A\to B$, $x_n\to x$         | `f:A\to B`, `x_n\to x`                  |

## Konfiguration

|       Objekt | Standard | Beschreibung                                                                           |
| -----------: | :------: | :------------------------------------------------------------------------------------- |
|        Modus |   Text   | The label mode. Available modes are Text and Markdown. |
|  Vordergrund |  Schwarz | The text color.                                                        |
|      Maßstab |     2    | The scale of the label.                                                |
| Zoomabhängig |  falsch  | Changes the label size based on the zoom level.                        |
|  Style sheet |   Keine  | The style sheet used for the label.                                    |
