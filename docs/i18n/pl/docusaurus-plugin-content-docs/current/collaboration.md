---
sidebar_label: Współpraca
sidebar_position: 4
title: Współpraca
---

:::warning 🧪 Eksperymentalny

Ta funkcja stoi za flagą eksperymentu. Przeczytaj więcej [here](/nightly#experiments).
Wszystko w tej sekcji podlega zmianie.

:::

## Wprowadzanie

Powołano się w wersji 2.0, Motylka wspiera współpracę. Oznacza to, że możesz edytować ten sam plik z wieloma osobami w tym samym czasie. Jest to przydatne, jeśli chcesz wspólnie pracować nad dokumentem.

## Jak to działa

Butterfly używa serwera websocket, który będzie hostowany na Twoim komputerze. Ten serwer musi być dostępny z Internetu lub Twojej sieci lokalnej. Klient połączy się z tym serwerem. Serwer synchronizuje wszystkie zmiany i zdarzenia ze wszystkimi klientami.

## Skonfiguruj serwer

:::note

Ta funkcja serwera nie jest dostępna w sieci.

:::

Po pierwsze, umożliwienie eksperymentu współpracy w ustawieniach. Po tym otwarciu dokumentu chcesz udostępnić. Następnie kliknij przycisk udostępniania w lewym górnym rogu po prawej stronie tytułu. To otworzy dialog. Kliknij na `Start serwer`.

Domyślnie serwer będzie hostowany na wszystkich interfejsach portu `28005`. Możesz to zmienić w oknie. Musisz upewnić się, że ten serwer jest dostępny dla klienta.
W sieci lokalnej powinno to być niemożliwe. Jeśli chcesz uzyskać dostęp do serwera z Internetu, musisz przekazać port w swoim routerze. Więcej informacji na temat tego [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Jeśli nie możesz przenieść portu, możesz użyć usługi takiej jak [ngrok](https://ngrok.com/). Spowoduje to utworzenie tunelu na lokalnym serwerze. Jest to przydatne, jeśli chcesz udostępnić dokument innym osobom.

Dla ngrok polecenie wyglądałoby tak:

```bash
ngrok http 28005
```

## Połącz z serwerem

Teraz musisz połączyć się z serwerem. Aby to zrobić, przejdź do strony głównej i kliknij na przycisk plus, tak jakbyś utworzył nowy dokument. Zobaczysz nową pozycję menu o nazwie `Connect`.

Kliknij na to i zobaczysz dialog. Wprowadź adres url połączenia.
Jeśli jesteś w tej samej sieci, możesz użyć lokalnego adresu IP komputera, w którym działa serwer.
URL powinien wyglądać tak: `ws://{ip}:28005`. Zastąp `{ip}` adresem IP komputera. Adres IP można znaleźć z komendą `ipconfig` na windows lub `ifconfig` na linux. W systemie Android znajdziesz adres IP w ustawieniach wifi.

Jeśli nie jesteś w tej samej sieci, musisz użyć publicznego adresu IP komputera. Możesz to znaleźć, szukając `czym jest mój ip` w swojej ulubionej przeglądarce wyszukiwania. Adres url powinien wyglądać jak ten powyżej, ale z publicznym adresem IP.

Jeśli używasz ngrok, konfiguracja jest nieco inna. Zastąp `https` na `wss` i dodaj port `:28005` na końcu. URL powinien wyglądać tak: `wss://{random}:28005`. Zastąp losową część częścią która ngrok ci da.
