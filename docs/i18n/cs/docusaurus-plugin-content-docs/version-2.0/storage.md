---
title: Úložiště
sidebar_position: 2
---

## Datový adresář

Datový adresář je adresář, kde jsou uloženy dokumenty, šablony a balíčky.
Na počítači je můžete najít v `~/Documents/Linwood/Butterfly`.
Na mobilu je v `getExternalFilesDir(null)/Linwood/Butterfly`.
Můžete to také změnit v nastavení pod `Data`.

V tomto adresáři najdete složku `Documents`, `Templates` a `Packs`.

## Webová

Data aplikace jsou uložena ve vašem prohlížeči. Je uložen v místním úložišti.
Otevřete nástroje vývojáře ve vašem prohlížeči a uvidíte data.

## Domácí nástupiště

Jako výchozí nastavení aplikace ukládá data ve složce dokumentů do podsložky nazvané "Linwood/Butterfly". Tato složka je vytvořena, když uložíte první data. Tuto složku lze změnit v nastavení.

## Vzdálené úložiště {#remote}

:::note

Tato funkce není dostupná na webu.

:::

Aplikaci lze uložit na vzdálený server. To je užitečné, pokud chcete sdílet data s ostatními lidmi nebo pokud máte více počítačů. V současné době je podporován pouze protokol `WebDAV`.

Chcete-li přidat vzdálený server, přejděte do nastavení a klikněte na "Remotes". Poté klikněte na "Přidat vzdálené".
Přidejte URL vzdáleného serveru a uživatelské jméno a heslo. Poté můžete specifikovat složku, kde jsou data uložena.

Chcete-li získat webdav url, navštivte dokumentaci:

- [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (mělo by to vypadat takto: `https://nextcloud.example.com/remote.php/dav/files/username/`, nahraďte `username` a `nextcloud.example.com` správnými hodnotami)

### Offline synchronizace {#offline}

Tato funkce umožňuje upravit soubory na vzdálených serverech, když jste v režimu offline.
Otevřete vyskakovací menu v souboru nebo složce a klikněte na "Synchronizovat". Toto stáhne soubor nebo složku a uloží ji lokálně. Synchronizovat celý kořenový adresář, klikněte na zaškrtávací značku v dialogovém okně pro vytvoření nebo klikněte na ovladač v nastavení a klikněte na zaškrtávací značku v sekci Správa záznamů.

Existuje několik omezení:

- Můžete synchronizovat pouze nejvyšší úroveň složky. Například pokud máte adresář `a/b/test.bfly`, tento soubor nebude synchronizován.
- Nelze odstranit soubor nebo složku, pokud jste v režimu offline.
- Nemůžete přidávat, upravovat nebo odstraňovat šablony, když jste offline.

## Jiné metody skladování

Pokud jste na nativním zařízení, můžete také synchronizovat adresář aplikace s vaší oblíbenou platformou.
Google disk má [oficiální aplikaci](https://www.google.com/drive/download/) v oknech a v obchodě Play jsou neoficiální online.
Na linuxu můžete také použít nativní vzdálené úložiště a změnit v něm adresář dat nebo přidat nové externí úložiště, pokud klepnete na tlačítko Přidat připojení.
