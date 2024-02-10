---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

## 链接

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

阅读更多关于每晚版本的 Butterfell [here](/夜间)。

## 正在安装

我们分发的IPA文件未签名。 这意味着您必须先登录才能将其安装到您的 iOS 设备上。 \
幸运的是，有一些项目，例如 [AltStore](https://altstore.io) (open source) 或 [sideloadly](https://sideloadly.io) (closed source)。 \你确实需要一个 Apple ID 作为侧边装载Butterfly. 我们建议为此目的建立一个新的机构。 请至少登录到 [Apple Developer](https://developer.apple.com)一次并接受他们的条款。
\
如果您的设备运行iOS 16.0或更高版本，请在设置/隐私/开发者模式中启用开发者模式。

## Installing (AltStore)

1. 使用 AltStore 网站上的说明设置 AltStore 。
2. 获取您设备上的 IPA 文件副本。 最好的方法是使用网页浏览器下载它，或者向自己发送包含IPA的压缩文件。 不使用 Airdrop 此外，不要将文件直接发送给您自己。 您可能无法打开它。
3. 打开 IPA 文件，使用“共享”菜单，然后点击"AltStore"。 如果您的设备连接到您运行的 AltServer (有线或无线)的电脑，它会自动安装。

## 正在安装 (Sideloady)

1. 使用sideloadly.io上提供的指南设置侧列。
2. 在您的 PC 上当面打开.
3. 在右上角添加IPA，选择您的设备和 Apple ID。 点击Start。 应用将安装到您的设备上。
   如果你有一个弹出窗口，开发人员不会被信任去设置/通用/VPN 和设备管理并更改它。
