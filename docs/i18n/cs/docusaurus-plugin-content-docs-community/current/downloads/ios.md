---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2FButterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

:::warning

Verze Butterfly iOS je v náhledu a nemusí fungovat podle očekávání.
Klikněte [here](https://github.com/LinwoodDev/Butterfly/issues/244) a navštivte problém na GitHub a najdete známé chyby a aktualizace. Prosím nahlaste tam jakékoliv problémy.

:::

## Odkazy

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Noční</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

Přečtěte si více o noční verzi Butterfly [here](/nightly).

## Instalace

Soubor IPA, který distribuujeme, není podepsán. To znamená, že se budete muset přihlásit před instalací na vaše iOS zařízení. \
Naštěstí existují projekty jako [AltStore](https://altstore.io) (open source) nebo [sideloadly](https://sideloadly.io) (uzavřený zdroj). \
\
Potřebuješ Apple ID pro postranní tažení Butterfly. Pro tento účel doporučujeme vytvořit nový. Přihlaste se alespoň jednou do [Apple Developer](https://developer.apple.com) a přijměte jejich podmínky.
\
Pokud vaše zařízení běží na iOS 16.0 nebo novější, povolte vývojářský režim v Nastavení/Soukromí/Vývojářský režim.

## Installing (AltStore)

1. Nastavte AltStore pomocí instrukcí uvedených na webu AltStore.
2. Získejte kopii IPA souboru do vašeho zařízení. Nejlepším způsobem je stáhnout pomocí webového prohlížeče nebo poslat zip soubor obsahující IPA sami sobě. Nepoužívejte Airdrop. Také neposílejte soubor přímo sobě. Možná jej nebudete moci otevřít.
3. Otevřete IPA soubor, použijte menu "Sdílet" a klepněte na "AltStore". Pokud je vaše zařízení připojeno k vašemu počítači se systémem AltServer (kabelový nebo bezdrátový), nainstaluje se automaticky.

## Instalace (Sideloadly)

1. Nastavte Sideloadly pomocí návodů uvedených na sideloadly.io.
2. Otevřete sideloadly na Vašem PC.
3. Přidejte IPA v pravém horním rohu, vyberte zařízení a Apple ID. Klepněte na tlačítko Start. Aplikace bude nainstalována na vaše zařízení.
   Pokud dostanete vyskakovací okno, že vývojář není důvěryhodný, přejděte do Nastavení/General/VPN a správy zařízení a změňte to.
