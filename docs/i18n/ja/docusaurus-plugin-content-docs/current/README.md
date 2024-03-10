---
title: はじめに
id: intro
slug: /intro
sidebar_position: 1
---

import Tabs from '@theme/Tabs';
import TabItem from '@theme/TabItem';
import { Gear, Plus, FloppyDisk, MagnifyingGlass, ScribbleLoop, Pen, Path, ArrowCounterClockwise, ArrowClockwise, Hand, Wrench, Lock} from "@phosphor-icons/react";

![バナー](/img/banner.png)

---

> オープンソースノートアプリ「Butterfly」へようこそ。

Butterflyは、すべてのプラットフォームで統一されたエクスペリエンスを目指しているノートテイクアプリです。 パワフルなカスタマイズでシンプルなUIを提供します。

## はじめに

> サイドバーを使用して、Wikiを素早くナビゲートできます。


アプリの作業を開始するには、2つのオプションがあります。
1. [ダウンロード](/downloads) ご使用のプラットフォームに適したアプリバージョン (ほとんどのモバイル、デスクトップ、および Web プラットフォームで実行できます)。
2. プラットフォームが見つからない場合や、インストールしたくない場合は、 [ウェブバージョン](https://butterfly.linwood.dev) を使用してください。 See [here](storage#web) about file storage on the web version.

> アプリを開いたら、お読みください。



## メインビュー

![メインビュー](main.png)

メインビューはいくつかの要素で構成されています
<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        ![Welcome screen](/img/welcome_screen_desktop.png)
        The top of the screen holds the banner for updates, the link to this documentations, and the <Gear/> config icon. 最後に、 <Gear/> 設定シンボルの右側に、このバナーが表示されるタイミングを制御するためのドロップダウンメニューがあります(常時/更新なし/更新時)。
        左の主要な領域の「ファイル」セクション。 There, you can do the typical operations:
            - Select the display type (grid or list)
            - Select the [source storage](storage) of the files
            - Sort the display order of the files
            - Add a folder, file, template, or import files by clicking the <Plus/> plus sign
            - Type the direct path to a desired location (the Location field),
            - Search for files
        Finally, to the right, you have the quick start display with the templates available in the current location. 新しくインストールするには、ライトとダークのテンプレートが含まれています
    </TabItem>
    <TabItem value="mobile">
        When opening Butterfly on a mobile device you will be presented with a screen as this
        ![Welcome screen first part](/img/welcome_screen_mobile_1.png)   
        The top of the screen holds the banner for updates, and below it you can find the documnentation link, and next to it the <Gear/> config icon. 最後に、 <Gear/> 設定シンボルの右側に、このバナーが表示されるタイミングを制御するためのドロップダウンメニューがあります(常時/更新なし/更新時)。
        それらの下には、利用可能なテンプレートを保持するクイックスタートセクションがあります。 Defauleでは、テンプレートはライトとダークのテンプレートです。 
        Scrolling down, you will see the file interface:
        \
        ![Welcome screen second part](/img/welcome_screen_mobile_2.png)  
        The "Files" section in the major area of the left. There, you can do the typical operations:
        - Select the display type (grid or list)
        - Select the [source storage](storage) of the files
        - Sort the display order of the files
        - Add a folder, file, template, or import files by clicking the <Plus/> plus sign
        - Type the direct path to a desired location (the Location field),
        - Search for files
    </TabItem>
</Tabs>

テンプレートまたは既存のファイルを選択してドキュメントを開くと、 **ドキュメントビュー** に移動します。

## ドキュメントビュー

デバイスのバックアクションを使用して、ドキュメント ビューからドキュメント リストに戻ることができます。 メインビューと同様に、お使いのデバイスに基づいてドキュメントが表示されます。

<Tabs
    defaultValue = "desktop"
    groupId="platfrom"
        values={[
        {label:"Desktop", value:'desktop'},
 {label:"Mobile", value:'mobile'},
 ]}>
    <TabItem value="desktop">
        In the Desktop view, you'll have at the top left the file bar\
        ![file_bar](/img/document_view_file_bar.png)\
        This holds, from left to right, the 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo.png)
        butterfly button to open the menu. その隣には、ノートの名前を表示するformat@@0フィールドがあります。 そのフィールドに新しい名前を入力し、「 <FloppyDisk/> 保存」ボタンを使用してノートを保存することで、ノートの名前を変更できます。 Finally you can <MagnifyingGlass/> search for elements within the note.
        \
        At the top right of the screen you have the toolbar\
        ![toolbar](/img/document_view_toolbar.png)\
        By default this bar has the <ScribbleLoop/> lasso tool; the <Pen/> pen tool; the <Path/> path erase tool; the <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, and the <Hand/> hand tool. Then you have the <Plus/> button to add elements to the tool bar, the <Wrench/> button to configure the document, and finally the <Lock/> tool to look the zoom and/or the position of the screen. 
        ### 重要な注意事項
        1. ツールバーの要素の一部が表示されない場合は、左右をクリックしてドラッグ(またはスワイプ)し、さらなるツールを表示します。 
        2. ツールを選択すると、小さなメニューが表示されます。 Long clicking the tool again will allow you to drag it to a new position
        3. ツールバーに <Plus/> プラス記号をクリックすると、さらにツールを追加できます。 
    </TabItem>
    <TabItem value="mobile">
        In the mobile view, you'll have at the top the file bar\
        ![file_bar](/img/document_view_file_bar.png)\
        This holds, from left to right, the 
        [<img alt="logo" src="/img/logo.png" width="16"/>](/img/logo.png)
        butterfly button to open the menu. その隣には、ノートの名前を表示するformat@@0フィールドがあります。 そのフィールドに新しい名前を入力し、「 <FloppyDisk/> 保存」ボタンを使用してノートを保存することで、ノートの名前を変更できます。 Finally you can <MagnifyingGlass/> search for elements within the note.
        \
        At the bottom of the screen you have the toolbar\
        ![toolbar](/img/document_view_toolbar.png)\
        By default this bar has the <ScribbleLoop/> lasso tool; the <Pen/> pen tool; the <Path/> path erase tool; the <ArrowCounterClockwise/> undo and <ArrowClockwise/> redo butons, and the <Hand/> hand tool. Then you have the <Plus/> button to add elements to the tool bar, the <Wrench/> button to configure the document, and finally the <Lock/> tool to look the zoom and/or the position of the screen. 
        ### 重要な注意事項
        1. ツールバーの要素の一部が表示されていない場合、または左右にスワイプして要素を表示します。 
        2. ツールを選択すると、小さなメニューが表示されます。 Long clicking the tool again will allow you to drag it to a new position
        3. ツールバーに <Plus/> プラス記号をクリックすると、さらにツールを追加できます。 
    </TabItem>
</Tabs>
	

