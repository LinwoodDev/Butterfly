---
title: Pamięć
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Katalog danych

Katalog danych jest katalogiem, w którym przechowywane są dokumenty, szablony i paczki.
Na pulpicie możesz go znaleźć w `~/Documents/Linwood/Butterfly`.
Na urządzeniu mobilnym znajduje się w `getExternalFilesDir(null)/Linwood/Butterfly`.
Możesz to również zmienić w ustawieniach w `Data`.

W tym katalogu znajdziesz folder `Documents`, `Templates` i `Packs`.

## Web

Dane aplikacji są przechowywane w przeglądarce. Lek jest przechowywany w miejscu przechowywania.
Otwórz narzędzia deweloperskie w przeglądarce i zobaczysz dane.

## Platformy rodzime

Domyślnie aplikacja zapisuje dane w folderze dokumentów w podfolderze o nazwie "Linwood/Butterfly". Ten folder jest tworzony podczas zapisywania pierwszych danych. Ten folder może zostać zmieniony w ustawieniach.

## Zdalna pamięć {#remote}

:::note

Ta funkcja nie jest dostępna w sieci.

:::

Aplikacja może być zapisana na zdalnym serwerze. Jest to przydatne, jeśli chcesz udostępnić dane innym osobom lub jeśli masz wiele komputerów. Obecnie obsługiwany jest tylko protokół `WebDAV`.

Aby dodać zdalny serwer, przejdź do ustawień i kliknij na `Remotes`. Następnie kliknij na `Dodaj zdalne`.
Dodaj adres URL zdalnego serwera oraz nazwę użytkownika i hasło. Następnie możesz określić folder, w którym przechowywane są dane.

Aby uzyskać adres URL webdava, odwiedź dokumentację:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (powinien wyglądać tak: `https://nextcloud.example.com/remote.php/dav/files/username/`, zamiana `username` i `nextcloud.example.com` na prawidłowe wartości)

### Synchronizacja offline {#offline}

Ta funkcja pozwala na edycję plików na serwerach zdalnych, gdy jesteś offline.
Otwórz menu wyskakujące w pliku lub folderze i kliknij na `Sync`. Spowoduje to pobranie pliku lub folderu i zapisanie go lokalnie. Aby zsynchronizować cały katalog główny, kliknij znacznik wyboru w oknie utwórz lub kliknij na pilota w ustawieniach i kliknij na znacznik wyboru w sekcji zarządzania.

Istnieje kilka ograniczeń:

- Możesz zsynchronizować tylko najwyższy poziom katalogu. Na przykład, jeśli masz katalog `a/b/test.bfly`, ten plik nie zostanie zsynchronizowany.
- Nie można usunąć pliku lub folderu, gdy jesteś offline.
- Nie możesz dodawać, edytować ani usuwać szablonów, gdy jesteś offline.

## Inne metody przechowywania

Jeśli jesteś na natywnym urządzeniu, możesz również zsynchronizować katalog aplikacji z ulubioną platformą.
Dysk Google ma [oficjalną aplikację](https://www.google.com/drive/download/) na oknie i w sklepie odtwarzania są nieoficjalne.
Na Linux możesz również użyć natywnego zdalnego systemu przechowywania danych i zmienić katalog na ten lub dodać nową pamięć zewnętrzną, jeśli klikniesz przycisk Dodaj połączenie.

## Supported file types

Butterfly supports importing SVG, Butterfly Note (.bfly), Butterfly Raw Note (.tbfly).

### Butterfly Note (.bfly)

This file type is the recommended for saving notes.

It is a zip archive containing the information (mostly in JSON files) about the note.
These included JSON files aren't optimized for being human readable.

### Butterfly Raw Note (.tbfly)

This file is recommended for use with version control software like git.

This file is **not** a zip archive, instead it is a _JSON_ file.
It contains all the information about the note in a single JSON file that is optimized for being readable and nicely formatted. It is **slower** than the normal Butterfly Note in loading speed.

### SVG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by butterfly.
