---
title: Depozitare
sidebar_position: 2
---

There are multiple ways of storing notes in Butterfly.
Either by using your device storage, or by using the cloud storage (WebDAV).

## Director de date

Dosarul cu date este directorul unde sunt stocate documentele, șabloanele și pachetele.
Pe desktop îl poți găsi în `~/Documents/Linwood/Butterfly`.
Pe mobil este în `getExternalFilesDir(null)/Linwood/Butterfly`.
De asemenea, îl puteţi schimba în setările din `Data`.

În acest director veţi găsi un folder `Documents`, `Templates` şi `Packs`.

## Web

Datele aplicației sunt stocate în browser-ul tău. Este stocat într-un spaţiu de stocare local.
Deschideți instrumentele de dezvoltare din browser și veți vedea datele.

## Platforme native

În mod implicit, aplicația salvează datele din dosarul documente într-un subdosar numit "Linwood/Butterfly". Acest folder este creat atunci când salvați primele date. Acest dosar poate fi modificat în setări.

## Stocare la distanță {#remote}

:::note

Această caracteristică nu este disponibilă pe web.

:::

Aplicația poate fi salvată pe un server de la distanță. Acest lucru este util dacă doriți să partajați datele cu alte persoane sau dacă aveți mai multe computere. În prezent, numai protocolul `WebDAV` este suportat.

Pentru a adăuga un server de la distanţă, mergeţi la setări şi faceţi clic pe `Remotes`. Apoi faceţi clic pe `Adăugare telecomandă`.
Adăugați adresa URL a serverului remote și numele de utilizator și parola. După aceasta, puteți specifica folderul în care sunt stocate datele.

Pentru a obține url-ul webdac, vă rugăm să vizitați documentația:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (ar trebui să arate astfel: `https://nextcloud.example.com/remote.php/dav/files/username/`, înlocuiți `username` și `nextcloud.example.com` cu valorile corecte)

### Sincronizare offline {#offline}

Această funcție vă permite să editați fișierele pe serverele la distanță în timp ce sunteți offline.
Deschideți meniul popup pe un fișier sau folder și faceți clic pe `Sync`. Acest lucru va descărca fișierul sau dosarul și îl va salva local. Pentru a sincroniza întregul director rădăcină, faceţi clic pe bifa din dialogul de creare sau faceţi clic pe telecomanda din setare şi faceţi clic pe bifa din secţiunea de gestionare.

Există câteva limitări:

- Poți sincroniza doar nivelul de sus al unui director. De exemplu, dacă aveţi un director `a/b/test.bfly`, acest fişier nu va fi sincronizat.
- Nu puteți șterge un fișier sau un dosar în timp ce sunteți offline.
- Nu puteți adăuga, edita sau șterge șabloane în timp ce sunteți offline.

## Alte metode de depozitare

Dacă ești pe un dispozitiv nativ, poți sincroniza și directorul aplicației cu platforma ta preferată.
Google drive are [o aplicație oficială](https://www.google.com/drive/download/) pe ferestre și sunt lucruri neoficiale în magazinul de joacă.
În linux puteţi folosi şi sistemul nativ de stocare la distanţă şi să schimbaţi folderul de date la acesta sau să adăugaţi o nouă stocare externă dacă faceţi clic pe butonul de adăugare conexiune.

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

### VSG

This file type doesn't save information about the note!
When this file is imported into Butterfly, it is treated as a single image.

Use this _ONLY_ when the note shouldn't be modified by butterfly.
