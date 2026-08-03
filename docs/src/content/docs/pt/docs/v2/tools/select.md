---
title: Select tool
---

With this tool you can select elements and access their [Context menu](../../context_menu).

## Configuração

| Propriedade |     Padrão     | Descrição                                                        |
| ----------: | :------------: | :--------------------------------------------------------------- |
|        Mode |    Retângulo   | Mode of selection. Valid are Rectangle and Lasso |
|    Hit mode | Touch anywhere | [Hit shapes mode](#hit-mode)                                     |

### Hit mode {#hit-mode}

Defines which part of an element needs to be touched for it to be selected.

Note that Touch edges and Touch anywhere are only relevant for [shapes](../shape)
and [polygons](../polygon).

|                                 Mode | Descrição                                                                                   |
| -----------------------------------: | :------------------------------------------------------------------------------------------ |
|                       Full Selection | The selected area needs to fully enclose the element.                       |
|        Selecionar ao tocar as bordas | The shape will be selected when the selected area intersects any edge.      |
| Selecione ao tocar em qualquer lugar | The shape will be selected when any part of it is inside the selected area. |
