---
title: iOS
sidebar_position: 6
---

![Nightly release version](https://img.shields.io/badge/dynamic/yaml?color=f7d28c\&label=Nightly\&query=%24.version\&url=https%3A%2F%2Fraw.githubusercontent.com%2FLinwoodDev%2Fchover%2FNightly%2Fapp%2Fpubspec.yaml\&style=for-the-badge)

## リンク

<div className="dropdown dropdown--hoverable margin--sm">
  <button className="button button--outline button--danger button--lg">ナイトリー</button>
  <ul className="dropdown__menu">
    <li>
      <DownloadButton className="dropdown__link" href="https://github.com/LinwoodDev/butterfly/releases/download/nightly/linwood-butterfly-ios.ipa">
        IPA
      </DownloadButton>
    </li>
  </ul>
</div>

Butterfly [here](/nightly)のナイトリーバージョンの詳細をご覧ください。

## インストール中

私たちが配布しているIPAファイルは署名されていません。 これは、iOSデバイスにインストールする前に自分でサインインする必要があることを意味します。 \
幸いなことに、 [AltStore](https://altstore.io) (オープンソース) または [sideloadly](https://sideloadly.io) (クローズソース) のようなプロジェクトがあります。 \
\
サイドローディング蝶にはApple IDが必要です。 特にこの目的のために新しいものを作成することをお勧めします。 format@@0(https\://developer.apple.com)に少なくとも一度ログインし、条件に同意してください。
\
お使いのデバイスが iOS 16.0 以降を実行している場合は、Settings/Privacy/Developer Mode で開発者モードを有効にしてください。

## Installing (AltStore)

1. AltStoreのウェブサイトの指示に従ってAltStoreを設定します。
2. お使いのデバイスにIPAファイルのコピーを取得します。 最善の方法は、Webブラウザを使用してダウンロードするか、IPAを含むzipファイルを自分自身に送信することです。 Airdropを使用しないでください。 また、ファイルを自分自身に直接送信しないでください。 それを開くことができないかもしれません。
3. IPAファイルを開き、「共有」メニューを使用して「AltStore」をタップします。 お使いのデバイスがAltServer(有線または無線)を実行しているPCに接続されている場合は、自動的にインストールされます。

## インストール中 (Sideloady)

1. sideloadly.ioで提供されているガイドを使用して、Sideloadlyを設定します。
2. PC上でサイドローダードリーを開きます。
3. 右上隅にIPAを追加し、デバイスとApple IDを選択します。 format@@0 をクリックします。 アプリが端末にインストールされます。
   開発者が信頼されていないというポップアップが表示された場合は、「設定/一般/VPN」および「デバイス管理」に移動して変更してください。
