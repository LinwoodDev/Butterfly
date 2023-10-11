---
title: "Pamięć"
sidebar_position: 2
---

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
