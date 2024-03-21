---
title: "Pamięć"
sidebar_position: 2
---

## Katalog danych

Katalog danych jest katalogiem, w którym przechowywane są dokumenty, szablony i paczki. Na pulpicie możesz go znaleźć w `~/Documents/Linwood/Butterfly`. Na urządzeniu mobilnym jest w `getExternalFilesDir(null)/Linwood/Butterfly`. Możesz to również zmienić w ustawieniach w sekcji `Data`.

W tym katalogu znajdziesz folder `Dokumenty`, `Szablony` i `Pakiety`.

## Web

Dane aplikacji są przechowywane w przeglądarce. Lek jest przechowywany w miejscu przechowywania. Otwórz narzędzia deweloperskie w przeglądarce i zobaczysz dane.

## Platformy rodzime

Domyślnie aplikacja zapisuje dane w folderze dokumentów w podfolderze o nazwie "Linwood/Butterfly". Ten folder jest tworzony podczas zapisywania pierwszych danych. Ten folder może zostać zmieniony w ustawieniach.

## Zdalna pamięć {#remote}

:::note

Ta funkcja nie jest dostępna w sieci.

:::

Aplikacja może być zapisana na zdalnym serwerze. Jest to przydatne, jeśli chcesz udostępnić dane innym osobom lub jeśli masz wiele komputerów. Obecnie obsługiwany jest tylko protokół `WebDAV`.

Aby dodać zdalny serwer, przejdź do ustawień i kliknij na `Usuń`. Następnie kliknij na `Dodaj zdalny`. Dodaj adres URL zdalnego serwera oraz nazwę użytkownika i hasło. Następnie możesz określić folder, w którym przechowywane są dane.

Aby uzyskać adres URL webdava, odwiedź dokumentację:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (powinien wyglądać tak: `https://nextcloud.example.com/remote.php/dav/files/username/`, zamiana `nazwy użytkownika` i `nextcloud.example.com` na prawidłowe wartości)

### Synchronizacja offline {#offline}

Ta funkcja pozwala na edycję plików na serwerach zdalnych, gdy jesteś offline. Otwórz menu wyskakujące w pliku lub folderze i kliknij `Synchronizuj`. Spowoduje to pobranie pliku lub folderu i zapisanie go lokalnie. Aby zsynchronizować cały katalog główny, kliknij znacznik wyboru w oknie utwórz lub kliknij na pilota w ustawieniach i kliknij na znacznik wyboru w sekcji zarządzania.

Istnieje kilka ograniczeń:

* Możesz zsynchronizować tylko najwyższy poziom katalogu. Na przykład jeśli masz katalog `a/b/test.bfly`, ten plik nie zostanie zsynchronizowany.
* Nie można usunąć pliku lub folderu, gdy jesteś offline.
* Nie możesz dodawać, edytować ani usuwać szablonów, gdy jesteś offline.

## Inne metody przechowywania

Jeśli jesteś na natywnym urządzeniu, możesz również zsynchronizować katalog aplikacji z ulubioną platformą. Dysk Google ma [oficjalną aplikację](https://www.google.com/drive/download/) na oknach i w sklepie odtwarzania są nieoficjalne. Na Linux możesz również użyć natywnego zdalnego systemu przechowywania danych i zmienić katalog na ten lub dodać nową pamięć zewnętrzną, jeśli klikniesz przycisk Dodaj połączenie.
