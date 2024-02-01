---
title: "Úložiště"
sidebar_position: 2
---

## Datový adresář

Datový adresář je adresář, kde jsou uloženy dokumenty, šablony a balíčky. Na ploše najdete ho v `~/Documents/Linwood/Butterfly`. Na mobilu je v `getExternalFilesDir(null)/Linwood/Butterfly`. Můžete to také změnit v nastavení pod `Data`.

V tomto adresáři najdete složku `Dokumenty`, `Šablony` a `balíčky`.

## Webová

Data aplikace jsou uložena ve vašem prohlížeči. Je uložen v místním úložišti. Otevřete nástroje vývojáře ve vašem prohlížeči a uvidíte data.

## Domácí nástupiště

Jako výchozí nastavení aplikace ukládá data ve složce dokumentů do podsložky nazvané "Linwood/Butterfly". Tato složka je vytvořena, když uložíte první data. Tuto složku lze změnit v nastavení.

## Vzdálené úložiště {#remote}

:::note

Tato funkce není dostupná na webu.

:::

Aplikaci lze uložit na vzdálený server. To je užitečné, pokud chcete sdílet data s ostatními lidmi nebo pokud máte více počítačů. V současné době je podporován pouze `WebDAV`.

Chcete-li přidat vzdálený server, přejděte do nastavení a klikněte na `Remotes`. Poté klikněte na `Přidat vzdálené`. Přidejte URL vzdáleného serveru a uživatelské jméno a heslo. Poté můžete specifikovat složku, kde jsou data uložena.

Chcete-li získat webdav url, navštivte dokumentaci:

* [Nextcloud](https://docs.nextcloud.com/server/latest/user_manual/en/files/access_webdav.html) (měl by vypadat takto: `https://nextcloud.example.com/remote.php/dav/files/username/`, nahraďte `uživatelské jméno` a `nextcloud.example.com` správnými hodnotami)

### Offline synchronizace {#offline}

Tato funkce umožňuje upravit soubory na vzdálených serverech, když jste v režimu offline. Otevřete vyskakovací menu v souboru nebo složce a klikněte na `Sync`. Toto stáhne soubor nebo složku a uloží ji lokálně. Synchronizovat celý kořenový adresář, klikněte na zaškrtávací značku v dialogovém okně pro vytvoření nebo klikněte na ovladač v nastavení a klikněte na zaškrtávací značku v sekci Správa záznamů.

Existuje několik omezení:

* Můžete synchronizovat pouze nejvyšší úroveň složky. Například pokud máte adresář `a/b/test.bfly`, tento soubor nebude synchronizován.
* Nelze odstranit soubor nebo složku, pokud jste v režimu offline.
* Nemůžete přidávat, upravovat nebo odstraňovat šablony, když jste offline.

## Other storage methods

If you are on a native device you can also sync the application directory with your favorite platform. Google drive has [an official app](https://www.google.com/drive/download/) on windows and there are unofficial onces on the play store. On linux you can also use the native remote storage system and change your data directory to this or add a new external storage if you click on the add connection button.
