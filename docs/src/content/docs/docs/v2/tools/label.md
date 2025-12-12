---
title: Label tool
---


With this tool you can add text or mathematical formulas into the infinite canvas.


## Configuration

| Property | Default | Description          |
|---------:|:-------:|:---------------------|
|     Size |   12    | The size of the text |


# Mathematics
You can write mathematical formulas instead of drawing them by using the text label tool.

The text label tool supports **Latex** for defining mathematical formulas.


## What you say! What is Latex?

Latex is a markup language that has many feature, you can use it to **write** mathematical formulas in Butterfly


### Why should I write math equation when I can draw them?

It is up to you, but sometimes, you need to have a proper looking math equation, without using handwriting.


## How do I apply Latex?

To apply latex to the text you have written, you need to select the text and then press the math symbol in the toolbar.

You need to follow Latex syntax for this to work!


## Latex Syntax

To start using Latex, you need to know its syntax!

Do not worry, the syntax is easy, you only need to know some words.


### Basic guide 

Everything your write isnt changed, until you insert a backslash before a command (\) (Insert image here showing it on the physical keybaord and softkeybaord because not everyone is terminally on their computers like me)

An example command: 
`\int` which shows the symbol for integrating


#### List of useful commands

| Command | Description | Example |
|---------|-------------|---------|
|`\sqrt[n]{arg}`| square root symbol, or nth root | `\sqrt[3]{x+1}` |
|`\frac{num}{den}`| Fraction with numerator and denominator | `\frac{a+1}{b-1}` |
|`\stackrel{a}{b}`| Places something(`a`) above another(`b`) | `\stackrel{!}{=}` |
|`\left<delimiter>` and `\right<delimiter>`| Scaling delimiters. `\left` must be paired with a `\right` | `\left( /frac{x}{2} \right)` |
|`\sum_{lower}^{upper}`| Summation symbol with limits | `\sum_{i=1}^{n} i` |
|`\mid`| Vertical bar as relation ("divides" or conditional) | `a\mid b` |
|`\prod_{lower}^{upper}`| Product symbol with limits | `\prod_{k=1}^{m} k` |
|`\int_{a}^{b}`| Integral with limits | `\int_{0}^{1} x^2\,dx` |
|`\langle` and `\rangle`| Angle brackets (inner products, tuples) | `\langle v,w\rangle` |
|`\in` and `\notin`| Set membership or not membership | `x\in A`, `y\notin B` |
|`\forall` and `\exists`| Universal or existential quantifiers | `\forall x\in\mathbb{R},\ \exists y` |
|`\to`| Right arrow (functions, limits) | `f:A\to B`, `x_n\to x` |










