---
title: "Skróty"
sidebar_position: 2
---


## Keyboard

Jest kilka skrótów, których możesz użyć w edytorze. Niektóre z nich są napisane pod przyciskami.

### Ogólny

* `Ctrl` + `N`: Nowy plik
* `Ctrl` + `Shift` + `N`: Nowy plik z szablonu
* `Ctrl` + `E`: Eksportuj plik
* `Ctrl` + `P`: Wydrukuj plik
* `Ctrl` + `Shift` + `E`: Eksportuj plik jako obraz
* `Ctrl` + `Alt` + `E`: Eksportuj plik jako svg
* `Ctrl` + `Alt` + `Shift` + `E`: Eksportuj plik jako svg
* `Ctrl` + `Alt` + `P`: Otwórz pakiety
* `Ctrl` + `Alt` + `S`: Otwórz ustawienia

### Projekt

* `Ctrl` + `K`: Otwórz wyszukiwanie
* `Ctrl` + `Z`: Cofnij
* `Ctrl` + `Y`: Ponów
* `Ctrl` + `Shift` + `P`: Open waypoints dialog
* `Ctrl` + `B`: Otwórz okno w tle
* `Ctrl` + `S`: Zapisz
* `Alt` + `S`: Zmień ścieżkę
* `Ctrl` + (`1` - `0`): Przełącz na narzędzie
* `Ctrl` + `+`: Przybliż
* `Ctrl` + `-`: Pomniejsz

## Długopis

Domyślnie wstrzykiwacz jest skonfigurowany do następujących funkcji:
* `Pen`: skonfigurowany jako długopis.
* `najpierw` (główny przycisk, jeśli jest obsługiwany): Zmień na narzędzie ręczne po naciśnięciu.
* `Drugie` (Drugi przycisk, jeśli jest wspierany): Zmień na drugie narzędzie (patrz sekcja [skonfiguruj](#configure) poniżej) po naciśnięciu.



## Skonfiguruj {#configure}

Możesz dostosować ustawienia poprzez nadanie każdej kontroli indeksu narzędzi. Indeksowanie narzędzi zaczyna się od lewej strony paska narzędzi, przy czym `1` jest pierwszym indeksem Zobacz przykład poniżej

![pasek narzędzi ponumerowany](toolbar_numbered.png)

W tym miejscu 1 odnosi się do narzędzia laserowego, 2, narzędzia do panewki itp.

Konfiguruj następujące opcje:

* Puste - narzędzie jest odcięte.
* 0 - narzędzie będzie działać jako poruszające się (tj. ręcznie) w tym modze.
* Liczba dodatnia - Narzędzie będzie podążać za indeksacją, jak wyjaśniono powyżej. 


