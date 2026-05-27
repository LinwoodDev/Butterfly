---
title: Stiftunterstützung
---

Diese Seite sammelt das aktuelle Verhalten von Stift- und Stylus-Eingaben in Butterfly.

## Unterstützt platforms

- **Android / mobil:** Stylus-Eingabe funktioniert derzeit am besten und ist der wichtigste unterstützte Weg.
- **Desktop (Windows/Linux):** Stylus-Eingabe ist aktuell durch die Eingabeunterstützung von Flutter eingeschränkt.
- **Web:** Oft eine gute Ausweichmöglichkeit, wenn sich ein Stift auf dem Desktop uneinheitlich verhält.

## Stylus-related Einstellungen

Optionen zum Stylus finden Sie unter **Einstellungen → Eingabe → Stift**:

- **Nur-Stift-Eingabe** (geändert in 2.5): Hilft, versehentliches Zeichnen mit Finger/Touch bei Verwendung eines Stifts zu vermeiden.
- **Nur-Stift-Schalter bei Stifterkennung:** Wenn ein Stift erkannt wird, wird ein schneller Nur-Stift-Schalter aktiviert; Sie können ihn weiterhin unter **Einstellungen → Eingabe → Stift** deaktivieren.
- **Druck ignorieren:** Nützlich, wenn Druckdaten unzuverlässig sind. Dies ist gesetzt, um in Fällen zu helfen, in denen Firefox bei der ersten Eingabe falschen Druck meldet.
- **Eingabetest:** Damit können Sie prüfen, welche Pointer-/Stylus-Ereignisse Ihr Gerät aktuell meldet.

## Stift-Kurzbefehle und Zeigertest

Butterfly unterstützt Stift-/Stylus-Kürzel; die Tastenbelegung kann je nach Gerät/Betriebssystem variieren. Wenn Kurzbefehle nicht wie erwartet funktionieren, öffnen Sie zuerst den **Eingabetest** und prüfen Sie die Schaltflächenwerte:

- **Primary Schaltfläche** commonly appears as `10` (`2`)
- **Sekundäre Schaltfläche** erscheint häufig als `100` (`4`) oder `100000` (`32`)

Diese Werte sind Bit-Zuordnungen aus Pointer-Button-Flags.

## Bekannte Framework-Einschränkungen

Einige Stylus-Probleme entstehen durch die Eingabeverarbeitung von Flutter und nicht direkt durch Butterfly.

- Android S-Stift tracking issue: [flutter/flutter#42846](https://github.com/flutter/flutter/issues/42846)
- Windows-Stiftprobleme: [flutter/flutter#65248](https://github.com/flutter/flutter/issues/65248), [flutter/flutter#102836](https://github.com/flutter/flutter/issues/102836)
- Linux-Stiftproblem: [flutter/flutter#63209](https://github.com/flutter/flutter/issues/63209)

Wenn Ihr Setup betroffen ist, melden Sie es bitte trotzdem in den Butterfly-Issues mit Plattform, Gerätemodell und App-Version.
