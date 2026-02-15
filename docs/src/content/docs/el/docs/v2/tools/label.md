---
title: Label tool
---

With this tool you can add text or mathematical formulas into the infinite canvas.

# Mathematics

You can write mathematical formulas instead of drawing them by using the text label tool.

The text label tool supports **LaTeX** for defining mathematical formulas.

## What you say! What is LaTeX?

LaTeX is a markup language that has many features, you can use it to **write** mathematical formulas in Butterfly.

### Why should I write math equations when I can draw them?

It is up to you, but sometimes, a properly formatted mathematical expression is preferred over handwriting.

## How do I apply LaTeX?

To apply LaTeX to the text you have written, you need to select the text and then press the math symbol in the toolbar.

You need to follow LaTeX syntax for this to work!

## LaTeX Syntax

To start using LaTeX, you need to know its syntax!

Do not worry, the syntax is easy, you only need to know some words.

### Basic guide

A backslash (\\) must precede any LaTeX command to indicate it is a command.

An example command is `\int_{7}^{6}`, which is used to show the integral symbol:

```math
\int_{7}^{6}
```

#### List of useful commands

| Command                                      | Περιγραφή                                                                      | Example                                                             | Example Command                           |
| -------------------------------------------- | ------------------------------------------------------------------------------ | ------------------------------------------------------------------- | ----------------------------------------- |
| `\sqrt[n]{arg}`                             | square root symbol, or nth root                                                | $\sqrt[3]{x+1}$ | `\sqrt[3]{x+1}`                          |
| `\frac{num}{den}`                           | Fraction with numerator and denominator                                        | $\frac{a+1}{b-1}$                                                   | `\frac{a+1}{b-1}`                        |
| `\stackrel{a}{b}`                           | Places something(`a`) above another(`b`) | $\stackrel{!}{=}$                                                   | `\stackrel{!}{=}`                        |
| `\left<delimiter>` and `\right<delimiter>` | Scaling delimiters. `\left` must be paired with a `\right`   | $\left( \frac{x}{2} \right)$                     | `\left( \frac{x}{2} \right)`           |
| `\sum_{lower}^{upper}`                      | Summation symbol with limits                                                   | $\sum_{i=1}^{n} i$                             | `\sum_{i=1}^{n} i`                       |
| `\mid`                                      | Vertical bar as relation ("divides" or conditional)         | $a\mid b$                                                           | `a\mid b`                                |
| `\prod_{lower}^{upper}`                     | Product symbol with limits                                                     | $\prod_{k=1}^{m} k$                            | `\prod_{k=1}^{m} k`                      |
| `\int_{a}^{b}`                              | Integral with limits                                                           | $\int_{0}^{1} x^2\,dx$                        | `\int_{0}^{1} x^2\,dx`                  |
| `\langle` and `\rangle`                    | Angle brackets (inner products, tuples)                     | $\langle v,w\rangle$                                                | `\langle v,w\rangle`                    |
| `\in` and `\notin`                         | Set membership or not membership                                               | $x\in A$, $y\notin B$                                               | `x\in A`, `y\notin B`                   |
| `\forall` and `\exists`                    | Universal or existential quantifiers                                           | $\forall x\in\mathbb{R},\ \exists y$                                | `\forall x\in\mathbb{R},\ \exists y` |
| `\to`                                       | Right arrow (functions, limits)                             | $f:A\to B$, $x_n\to x$         | `f:A\to B`, `x_n\to x`                  |

## Διαμόρφωση

| Ιδιότητα | Προεπιλογή | Περιγραφή               |
| -------: | :--------: | :---------------------- |
|  Μέγεθος |     12     | Το μέγεθος του κειμένου |
