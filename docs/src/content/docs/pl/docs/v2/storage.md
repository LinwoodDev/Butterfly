---
title: Pamięć
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Katalog danych

The data directory is the directory where documents, templates, and packs are stored.
On desktop you can find it in `~/Documents/Linwood/Butterfly`.
Na urządzeniu mobilnym znajduje się w `getExternalFilesDir(null)/Linwood/Butterfly`.
Możesz to również zmienić w ustawieniach w `Data`.

W tym katalogu znajdziesz folder `Documents`, `Templates` i `Packs`.

## Web

Dane aplikacji są przechowywane w przeglądarce. Lek jest przechowywany w miejscu przechowywania.
Otwórz narzędzia deweloperskie w przeglądarce i zobaczysz dane.

## Platformy rodzime

By default, the application saves the data in your documents folder in a subfolder called "Linwood/Butterfly". This folder is created when you save data for the first time. Ten folder może zostać zmieniony w ustawieniach.

## Zdalna pamięć {#remote}

:::note

Ta funkcja nie jest dostępna w sieci.

:::

The application data can be stored on a remote server. Jest to przydatne, jeśli chcesz udostępnić dane innym osobom lub jeśli masz wiele komputerów. Obecnie obsługiwany jest tylko protokół `WebDAV`.

Aby dodać zdalny serwer, przejdź do ustawień i kliknij na `Remotes`. Następnie kliknij na `Dodaj zdalne`.
Dodaj adres URL zdalnego serwera oraz nazwę użytkownika i hasło. Następnie możesz określić folder, w którym przechowywane są dane.

To get the WebDAV URL, please visit the documentation:

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
Google Drive has [an official app](https://www.google.com/drive/download/) on Windows and there are unofficial ones on the Play Store.
On Linux you can also use the native remote storage system and change your data directory to this or add a new external storage if you click on the add connection button.

## Supported file types

Butterfly supports importing SVG, Butterfly Note (.bfly), Butterfly Raw Note (.tbfly).

### Butterfly Note (.bfly)

This file type is the recommended format for saving notes.

It is a zip archive containing the information (mostly in JSON files) about the note.
These included JSON files aren't optimized for human readability.

### Butterfly Raw Note (.tbfly)

This file is recommended for use with version control software like git.

This file is **not** a zip archive; instead it is a _JSON_ file.
It contains all the information about the note in a single JSON file that is optimized for being readable and nicely formatted. It is slower to load than the normal Butterfly Note.

### SVG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by Butterfly.
