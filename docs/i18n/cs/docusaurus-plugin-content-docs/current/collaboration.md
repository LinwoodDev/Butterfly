---
sidebar_label: Spolupráce
sidebar_position: 4
title: Spolupráce
---

:::warning 🧪 Experiment

Tato funkce stojí za příznakem experimentu. Přečtěte si více [here](/nightly#experiments).
Všechno v této sekci se změní.

:::

## Úvod

Sinced 2.0 beta verze, Butterfly podporuje spolupráci. To znamená, že můžete upravit stejný soubor současně s více lidmi. To je užitečné, pokud chcete pracovat společně na dokumentu.

## Jak to funguje

Butterfly používá server se socketem, který bude hostován na vašem počítači. Tento server musí být přístupný z internetu nebo z místní sítě. Klient se připojí k tomuto serveru. Server synchronizuje všechny změny a události se všemi klienty.

## Nastavit server

:::note

Tato funkce serveru není dostupná na webu.

:::

Zaprvé umožnit experiment pro spolupráci v nastavení. Poté otevřete Váš dokument chcete sdílet. Poté klikněte na tlačítko sdílení v levém horním rohu vpravo do názvu. Tím se otevře dialog. Klikněte na `Spustit server`.

Výchozí hodnota bude server hostován na všech rozhraních na portu `28005`. Můžete to změnit v dialogu. Musíte se ujistit, že je tento server přístupný klientovi.
V místní síti by to mělo fungovat mimo krabici. Pokud chcete přistupovat k serveru z internetu, musíte přeposlat port ve vašem routeru. Více informací o tomto [here](https://en.wikipedia.org/wiki/Port_forwarding/).

Pokud nemůžete přeposílat port, můžete použít službu jako [ngrok](https://ngrok.com/). Tímto vytvoříte tunel na váš místní server. Toto je užitečné, pokud chcete sdílet dokument s ostatními lidmi.

Pro ngrok by příkaz vypadal takto:

```bash
ngrok http 28005
```

## Připojit k serveru

Nyní se musíte připojit k serveru. Chcete-li to provést, přejděte na domovskou stránku a klikněte na tlačítko plus, chcete-li vytvořit nový dokument. Zde uvidíte novou položku menu nazvanou `Connect`.

Klikněte na toto a uvidíte dialog. Zde zadejte adresu připojení.
Pokud jste ve stejné síti, můžete použít místní IP adresu počítače, kde server běží.
URL by měla vypadat takto: `w://{ip}:28005`. Nahradit `{ip}` IP adresou počítače. ip adresu s příkazem `ipconfig` naleznete v oknech nebo `ifconfig` na linuxu. Na androidu můžete najít IP adresu v nastavení wifi.

Pokud nejste ve stejné síti, musíte použít veřejnou IP adresu počítače. Toto můžete najít vyhledáním `co je moje ip` ve Vašem oblíbeném vyhledávacím prohlížeči. Adresa url by měla vypadat jako výše uvedená, ale s veřejnou IP adresou.

Pokud používáte ngrok, nastavení je trochu jiné. Nahraďte `https://` `wss` a přidejte na konec port `:28005`. URL by měla vypadat takto: `wss://{random}:28005`. Nahraďte náhodnou část částí, kterou vám ngrok poskytne.
