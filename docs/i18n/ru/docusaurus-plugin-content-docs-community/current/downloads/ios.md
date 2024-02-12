---
title: iOS
sidebar_position: 6
---

![Ночной релиз](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fночное%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

:::warning

Версия iOS Butterfly находится в предварительном просмотре и может не работать, как ожидалось.
Нажмите [here](https://github.com/LinwoodDev/Butterfly/issues/244), чтобы посетить проблему на GitHub, чтобы найти текущие известные ошибки и обновления. Пожалуйста, сообщите о любых проблемах.

:::

## Ссылки

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">Ночь</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

Подробнее о ночной версии Butterfly [here](/nightly).

## Установка

Файл IPA, который мы распространяем, не подписан. Это означает, что вы должны подписать его самостоятельно, прежде чем иметь возможность установить его на ваше iOS устройство. \
Fortunately, there are projects like [AltStore](https://altstore.io) (open source) or [sideloadly](https://sideloadly.io) (closed source). \
\
Вам нужен Apple ID для погрузки Бабочки. Мы рекомендуем создать новый специально для этой цели. Пожалуйста, войдите в [Apple Developer](https://developer.apple.com) хотя бы один раз и примите их условия.
\
Если на вашем устройстве запущен iOS 16.0 или новее, включите режим разработчика в Настройках/Режим конфиденциальности/разработчика.

## Installing (AltStore)

1. Настройте AltStore, используя инструкции, содержащиеся на сайте AltStore.
2. Получить копию файла IPA на ваше устройство. Лучший способ это скачать его с помощью веб-браузера или посылать zip-файл, содержащий IPA самому себе. Не используйте Airdrop. Кроме того, не отправляйте файл непосредственно себе. Возможно, вы не сможете открыть его.
3. Откройте файл IPA, используйте меню «Поделиться» и нажмите «AltStore». Если ваше устройство подключено к компьютеру под управлением AltServer (проводной или беспроводной), оно будет установлено автоматически.

## Установка (Sideloadly)

1. Настройте Sideloadly используя руководства, предоставленные на sideloadly.io.
2. Откройте поперечно на вашем ПК.
3. Добавьте IPA в правом верхнем углу, выберите устройство и Apple ID. Нажмите Пуск. Приложение будет установлено на ваше устройство.
   Если вы получили всплывающее сообщение, что разработчику не доверяют в Настройки/Общие/VPN и Управление устройствами и измените это.
