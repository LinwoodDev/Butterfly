---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fbutterfly%2Fnightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

## Liens

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

Read more about the nightly version of Butterfly [here](/nightly).

## Installing

The IPA file we distribute is unsigned. This means you'll have to sign it yourself before being able to install it onto your iOS device. \
Fortunately, there are projects like [AltStore](https://altstore.io) (open source) or [sideloadly](https://sideloadly.io) (closed source). \
\
You do need an Apple ID for sideloading Butterfly. We recommend creating a new one especially for this purpose. Please log into [Apple Developer](https://developer.apple.com) at least once and accept their terms.
\
If your device is running iOS 16.0 or newer, enable developer mode in Settings/Privacy/Developer Mode.

## Installing (AltStore)

1. Set up AltStore using the instructions provided on the AltStore website.
2. Get a copy of the IPA file onto your device. The best way is to download it using a web browser or sending a zip file containing the IPA to yourself. Do not use Airdrop. Also, do not send the file directly to yourself. You might not be able to open it.
3. Open the IPA file, use the "share" menu and tap "AltStore". If your device is connected to your PC running AltServer (wired or wirelessly) it'll install automatically.

## Installing (Sideloadly)

1. Set up Sideloadly using the guides provided on sideloadly.io.
2. Open sideloadly on your PC.
3. Add the IPA in the top right corner, select your device and Apple ID. Click Start. The app will be installed onto your device.
   If you get a popup saying a developer isn't trusted go to Settings/General/VPN and Device Management and change that.
