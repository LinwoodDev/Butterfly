---
title: Zkratky
sidebar_position: 2
---

## Keyboard

Existuje několik zkratek, které můžete použít v editoru.
Některé z nich jsou zapsány pod tlačítky.

### Obecná ustanovení

- `Ctrl` + `N`: Nový soubor
- `Ctrl` + `Shift` + `N`: Nový soubor ze šablony
- `Ctrl` + `E`: Exportovat soubor
- `Ctrl` + `P`: Tisknout soubor
- `Ctrl` + `Shift` + `E`: Exportovat soubor jako obrázek
- `Ctrl` + `Alt` + `E`: Exportovat soubor jako svg
- `Ctrl` + `Alt` + `Shift` + `E`: Exportovat soubor jako svg
- `Ctrl` + `Alt` + `P`: Otevřené balíčky
- `Ctrl` + `Alt` + `S`: Otevřít nastavení

### Projekt

- `Ctrl` + `Z`: Vrátit zpět
- `Ctrl` + `Y`: Znovu
- `Ctrl` + `Shift` + `P`: Otevřete dialog trasových bodů
- `Ctrl` + `B`: Otevřít dialog na pozadí
- `Ctrl` + `Shift` + `A`: dialogové okno otevřených oblastí
- `Ctrl` + `S`: Uložit
- `Alt` + `S`: Změna cesty
- `Ctrl` + (`1` - `0`): Přepnout na nástroj
- `Ctrl` + `+`: Přiblížení
- `Ctrl` + `-`: Oddálit

## Pec

Ve výchozím nastavení je pero nastaveno tak, aby fungovalo:

- `Pen`: nakonfigurován jako pen.
- `First` (Primární tlačítko, pokud je podporováno): Přepnout na ruční nástroj při stisknutí.
- `Second` (druhé tlačítko, pokud je podporováno): Po stisknutí přepněte na druhý nástroj (viz [configure](#configure).

## Konfigurovat {#configure}

Ovládací prvky můžete přizpůsobit zadáním všech ovládacích prvků indexu nástrojů. Nástroj indexování začíná vlevo od panelu nástrojů, přičemž prvním indexem je `1`. Viz příklad níže

![toolbar numbered](toolbar_numbered.png)

Tady 1 odkazuje na nástroj lasso, 2, na nástroj pánve atd.

Možnosti konfigurace, které máte, jsou následující:

- Prázdný - nástroj je rozbalen.
- 0 - nástroj bude v tomto režimu fungovat jako pohyb (tj. ručně).
- Pozitivní číslo - nástroj bude následovat indexace, jak je vysvětleno výše.
