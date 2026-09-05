---
title: Stiftunterstützung
---

This page collects the current stylus-input behavior in Butterfly.

## Unterstützt platforms

- **Android / mobil:** Stylus-Eingabe funktioniert derzeit am besten und ist der wichtigste unterstützte Weg.
- **Desktop (Linux):** Stylus input is currently limited by Flutter input support.
- **Web:** Oft eine gute Ausweichmöglichkeit, wenn sich ein Stift auf dem Desktop uneinheitlich verhält.

## Stylus-related Einstellungen

You can find stylus-related options in **Settings → Input → Stylus**:

- **Stylus-only input** (changed in 2.5): helps avoid accidental finger/touch drawing when using a stylus.
- **Stylus-only toggle on stylus detection:** when a stylus is detected, a quick Stylus-only toggle is activated; you can still disable it in **Settings → Input → Stylus**.
- **Druck ignorieren:** Nützlich, wenn Druckdaten unzuverlässig sind. Dies ist gesetzt, um in Fällen zu helfen, in denen Firefox bei der ersten Eingabe falschen Druck meldet.
- **Eingabetest:** Damit können Sie prüfen, welche Pointer-/Stylus-Ereignisse Ihr Gerät aktuell meldet.

## Stylus shortcuts and pointer test

Butterfly supports stylus shortcuts (button mappings can vary by device/OS). Wenn Kurzbefehle nicht wie erwartet funktionieren, öffnen Sie zuerst den **Eingabetest** und prüfen Sie die Schaltflächenwerte:

- **Primary Schaltfläche** commonly appears as `10` (`2`)
- **Sekundäre Schaltfläche** erscheint häufig als `100` (`4`) oder `100000` (`32`)

Diese Werte sind Bit-Zuordnungen aus Pointer-Button-Flags.

## Bekannte Framework-Einschränkungen

Einige Stylus-Probleme entstehen durch die Eingabeverarbeitung von Flutter und nicht direkt durch Butterfly.

- Android S-Stift tracking issue: [flutter/flutter#42846](https://github.com/flutter/flutter/issues/42846)
- Linux-Stiftproblem: [flutter/flutter#63209](https://github.com/flutter/flutter/issues/63209)

Wenn Ihr Setup betroffen ist, melden Sie es bitte trotzdem in den Butterfly-Issues mit Plattform, Gerätemodell und App-Version.
