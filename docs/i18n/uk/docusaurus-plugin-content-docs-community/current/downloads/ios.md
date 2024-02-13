---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

:::warning

Версія iOS метелика переглядається і може працювати не так, як очікується.
Клацніть [here](https://github.com/LinwoodDev/Butterfly/issues/244) щоб відвідати проблему на GitHub, щоб знайти поточні відомі помилки та оновлення. Будь ласка, повідомте про будь-які проблеми.

:::

## Посилання

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Nightly</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

Дізнайтеся більше про нічну версію Butterfly [here](/nightly).

## Встановлення

IPA-файл не підписаний. Це означає, що вам доведеться підписати його самостійно, перш ніж встановлювати його на ваш iOS пристрій. \
На щастя, існують такі проекти, як [AltStore](https://altstore.io) (відкритий переклад) або [sideloadly](https://sideloadly.io) (закритий переклад). \
\
You do need an Apple ID for sideloading Butterfly. Ми рекомендуємо створити нову особливо для цієї мети. Увійдіть в [Apple Developer](https://developer.apple.com) хоча б один раз і прийміть їхні умови.
\
якщо ваш пристрій працює на iOS 16.0 або новіше, увімкніть режим розробника в Налаштуваннях/Приватність/Режим розробника.

## Installing (AltStore)

1. Налаштувати AltStore використовуючи інструкції, надані на сайті AltStore.
2. Отримайте копію файлу IPA на вашому пристрої. Найкращий спосіб - завантажити його за допомогою веб-браузера або надіслати zip-файл, що містить сам IPA. Не користуйтеся Airdrop. Також, не надсилайте файл напряму собі. Ви не зможете відкрити його.
3. Відкрийте файл IPA, скористайтеся меню "share" та натисніть "AltStore". Якщо ваш пристрій підключено до AltServer (дротовий чи бездротовий, він встановиться автоматично.

## Встановлення (Sideloadly)

1. Встановіть Sideloadly використовуючи інструкції, що надаються в sideloadly.io.
2. Відкрий на ПК.
3. Додайте IPA у правому верхньому куті, виберіть пристрій та Apple ID. Натисніть почати. Додаток буде встановлено на Вашому пристрої.
   Якщо ви отримуєте спливаюче вікно, що розробник не довіряє, в Налаштуваннях/General/VPN та Керування пристроями та змінювати це.
