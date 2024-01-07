---
sidebar_label: Colaborare
sidebar_position: 4
title: Colaborare
---

:::warning 🧪 Experiment

Această caracteristică se află în spatele unui steag pentru experimente. Citește mai mult [here](/nightly#experiments).
Totul din această secţiune este supus schimbării.

:::

## Introducere

Sincer versiunea 2.0 beta, Butterfly suportă colaborarea. Asta înseamnă că poți edita același fișier cu mai multe persoane în același timp. Acest lucru este util dacă doriţi să lucraţi împreună la un document.

## Cum funcţionează

Butterfly folosește un server websocket care va fi găzduit pe calculatorul tău. Acest server trebuie să fie accesibil de pe internet sau rețeaua dvs. locală. Clientul se va conecta la acest server. Serverul sincronizează toate modificările și evenimentele cu toți clienții.

## Configurați serverul

:::note

Această caracteristică de server nu este disponibilă pe web.

:::

În primul rând, să permită experimentul de colaborare în setări. După ce deschideți documentul dvs. doriți să partajați. Apoi dă click pe butonul de partajare din colțul din stânga sus spre titlu. Aceasta va deschide un dialog. Faceți clic pe `Start server`.

Serverul implicit va fi găzduit pe toate interfeţele de pe portul `28005`. Puteți schimba acest lucru în dialog. Trebuie să te asiguri că acest server este accesibil clientului.
În rețeaua locală, acest lucru ar trebui să funcționeze din cutie. Dacă doriți să accesați serverul de pe internet, trebuie să redirecționați portul din router. Mai multe informații despre acest [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Dacă nu puteți redirecționa portul, puteți folosi un serviciu ca [ngrok](https://ngrok.com/). Acest lucru va crea un tunel pentru serverul dvs. local. Acest lucru este util dacă doriţi să partajaţi documentul cu alte persoane.

Pentru ngrok, comanda ar arăta așa:

```bash
ngrok http 28005
```

## Conectează-te la server

Acum trebuie să te conectezi la server. Pentru a face acest lucru, mergi la pagina principală şi apasă pe butonul plus ca ai crea un nou document. Acolo veți vedea un element de meniu nou, numit `Connect`.

Faceți clic pe acest lucru și veți vedea un dialog. Introduceți URL-ul de conectare aici.
Dacă vă aflați în aceeași rețea, puteți utiliza adresa ip locală a calculatorului pe care rulează serverul.
Url-ul ar trebui să arate astfel: `ws://{ip}:28005`. Înlocuiți `{ip}` cu adresa ip a calculatorului. Puteți găsi adresa ip cu comanda `ipconfig` pe windows sau `ifconfig` pe linux. Pe android puteţi găsi adresa ip în setările Wi-Fi.

Dacă nu sunteți în aceeași rețea, trebuie să utilizați adresa ip publică a calculatorului. Poți găsi acest lucru căutând `ceea ce este ip`-ul meu\` în browserul tău de căutare preferat. Url-ul ar trebui să arate ca cel de mai sus, dar cu adresa ip publică.

Dacă folosești ngrok, configurarea este puțin diferită. Înlocuiţi `http`` cu `wss`şi adăugaţi portul`:28005`la sfârşit. Url-ul ar trebui să arate astfel:`wss\://{random}:28005\`. Înlocuiește partea aleatoare cu partea pe care ți-o oferă ngrokul.
