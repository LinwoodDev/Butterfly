---
title: "Depozitare"
sidebar_position: 2
---

## Web

Datele aplicației sunt stocate în browser-ul tău. Este stocat într-un spaţiu de stocare local. Deschideți instrumentele de dezvoltare din browser și veți vedea datele.

## Platforme native

În mod implicit, aplicația salvează datele din dosarul documente într-un subdosar numit "Linwood/Butterfly". Acest folder este creat atunci când salvați primele date. Acest dosar poate fi modificat în setări.

## Stocare la distanță {#remote}

:::note

Această caracteristică nu este disponibilă pe web.

:::

Aplicația poate fi salvată pe un server de la distanță. Acest lucru este util dacă doriți să partajați datele cu alte persoane sau dacă aveți mai multe computere. În prezent, numai protocolul `WebDAV` este acceptat.

Pentru a adăuga un server de la distanţă, accesaţi setările şi faceţi clic pe `Remotes`. Apoi faceţi clic pe `Adăugare la distanţă`. Adăugați adresa URL a serverului remote și numele de utilizator și parola. După aceasta, puteți specifica folderul în care sunt stocate datele.

Pentru a obține url-ul webdac, vă rugăm să vizitați documentația:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (ar trebui să arate astfel: `https://nextcloud.example.com/remote.php/dav/files/username/`, înlocuiește `numele de utilizator` și `nextcloud.example.com` cu valorile corecte)

### Sincronizare offline {#offline}

Această funcție vă permite să editați fișierele pe serverele la distanță în timp ce sunteți offline. Deschideți meniul popup într-un fișier sau folder și faceți clic pe `Sync`. Acest lucru va descărca fișierul sau dosarul și îl va salva local. Pentru a sincroniza întregul director rădăcină, faceţi clic pe bifa din dialogul de creare sau faceţi clic pe telecomanda din setare şi faceţi clic pe bifa din secţiunea de gestionare.

Există câteva limitări:

* Poți sincroniza doar nivelul de sus al unui director. De exemplu, dacă ai un director `a/b/test.bfly`, acest fișier nu va fi sincronizat.
* Nu puteți șterge un fișier sau un dosar în timp ce sunteți offline.
* Nu puteți adăuga, edita sau șterge șabloane în timp ce sunteți offline.
