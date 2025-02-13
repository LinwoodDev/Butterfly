// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get open => '開く';

  @override
  String get settings => '設定';

  @override
  String get personalization => '個人設定';

  @override
  String get theme => 'テーマ';

  @override
  String get darkTheme => 'ダークテーマ';

  @override
  String get lightTheme => 'ライトテーマ';

  @override
  String get systemTheme => 'デフォルトのシステムテーマを使用する';

  @override
  String get view => '表示';

  @override
  String get edit => '編集';

  @override
  String get export => 'エクスポート';

  @override
  String get save => '保存';

  @override
  String get zoom => 'ズーム';

  @override
  String get zoomIn => '拡大';

  @override
  String get zoomOut => 'ズームアウト';

  @override
  String get resetZoom => 'Reset zoom';

  @override
  String get strokeWidth => 'ストロークの幅';

  @override
  String get includeEraser => '消去を含めますか？';

  @override
  String get thinning => '薄肉化';

  @override
  String get pen => 'ペン';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'パスの消去';

  @override
  String get label => 'ラベル';

  @override
  String get delete => '削除';

  @override
  String get areYouSure => 'よろしいですか？';

  @override
  String get reallyDelete => '本当にこのアイテムを削除しますか？';

  @override
  String get no => 'いいえ';

  @override
  String get yes => 'はい';

  @override
  String get undo => '元に戻す';

  @override
  String get redo => 'Redo';

  @override
  String get general => '全般';

  @override
  String get copyTitle => 'クリップボードにコピーしました';

  @override
  String get loading => '読み込み中...';

  @override
  String get enterText => 'テキストを入力してください';

  @override
  String get size => 'サイズ';

  @override
  String get width => 'Width';

  @override
  String get height => '高さ';

  @override
  String get count => 'カウント';

  @override
  String get space => 'スペース';

  @override
  String get background => '背景';

  @override
  String get box => 'Box';

  @override
  String get locale => 'ロケール';

  @override
  String get systemLocale => 'システムロケール：';

  @override
  String get information => '情報';

  @override
  String get license => 'ライセンス';

  @override
  String get imprint => 'インプリント';

  @override
  String get privacypolicy => 'プライバシーポリシー';

  @override
  String get source => 'ソース';

  @override
  String get documentation => 'ドキュメント';

  @override
  String get changelog => '更新履歴';

  @override
  String get existOverride => 'この要素は既に存在します。上書きしますか？';

  @override
  String get description => '説明';

  @override
  String get fill => '塗りつぶし';

  @override
  String get defaultPalette => 'デフォルトのパレット';

  @override
  String get highlighter => 'ハイライト';

  @override
  String get add => '追加';

  @override
  String get remove => '削除';

  @override
  String get removeConfirm => '本当に削除しますか？';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => 'カスタム';

  @override
  String get decoration => '装飾';

  @override
  String get underline => 'アンダーライン';

  @override
  String get overline => 'オーバーライン';

  @override
  String get strikethrough => '取り消し線';

  @override
  String get thickness => '太さ';

  @override
  String get style => 'スタイル';

  @override
  String get solid => 'Solid';

  @override
  String get double => '倍精度';

  @override
  String get dotted => '点線';

  @override
  String get dashed => '破線';

  @override
  String get wavy => 'Wavy';

  @override
  String get fontWeight => 'フォントの重量';

  @override
  String get normal => '標準';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Clipboard';

  @override
  String get file => 'ファイル';

  @override
  String get data => 'データ';

  @override
  String get share => '共有';

  @override
  String get spacing => '間隔';

  @override
  String get image => '画像';

  @override
  String get enterUrl => 'URL を入力してください';

  @override
  String get scale => '拡大縮小';

  @override
  String get help => 'ヘルプ';

  @override
  String get reallyReset => '本当にリセットしますか？';

  @override
  String get whatToDo => 'あなたは何をしたいですか?';

  @override
  String get ignore => '無視';

  @override
  String get backup => 'バックアップ';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'ファイル $fileName は、新しいバージョン ($fileVersion) で作成されました。このファイルをどうすればよいですか？';
  }

  @override
  String get waypoints => 'ウェイポイント';

  @override
  String get origin => '原点：';

  @override
  String get import => 'インポート';

  @override
  String get newContent => '新規作成';

  @override
  String get selectElement => '要素を選択';

  @override
  String get ctrlKey => '(Ctrl)';

  @override
  String get shiftKey => 'Shift';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'バージョンをコピー';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'ビヘイビア';

  @override
  String get dataDirectory => 'データディレクトリ';

  @override
  String get defaultPath => 'デフォルトのパス';

  @override
  String get dateFormat => '日付の形式';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return '更新日時: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return '作成日時: $dateTimeString';
  }

  @override
  String get rename => '名前の変更';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => '手';

  @override
  String get folder => 'フォルダ';

  @override
  String get move => '移動';

  @override
  String get copy => 'コピー';

  @override
  String get back => '戻る';

  @override
  String get zoomDependent => 'ズームに依存する';

  @override
  String get shapeDetection => 'シェイプ検出';

  @override
  String get delay => '遅延';

  @override
  String get defaultLayer => '既定のレイヤー';

  @override
  String get layer => 'レイヤー';

  @override
  String get layers => 'レイヤー';

  @override
  String get notSet => '未設定';

  @override
  String get enterLayer => 'レイヤー名を入力してください';

  @override
  String get selectElements => '要素を選択';

  @override
  String get deleteElements => '要素を削除';

  @override
  String get deleteElementsConfirm => '選択した要素を本当に削除しますか？';

  @override
  String get selectCustomCollection => 'カスタムコレクションを選択';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => '感度';

  @override
  String get sensitivityHint => '値が高いほど入力の感度が高くなります';

  @override
  String get horizontal => '水平方向';

  @override
  String get vertical => '垂直方向';

  @override
  String get plain => 'Plain';

  @override
  String get light => 'ライト';

  @override
  String get ruled => '支配された';

  @override
  String get quad => 'クワッド';

  @override
  String get music => '音楽';

  @override
  String get dark => 'ダーク';

  @override
  String get plainDark => 'ダーク';

  @override
  String get ruledDark => '規則のあるダーク';

  @override
  String get quadDark => 'クワッドダーク';

  @override
  String get musicDark => '暗い音楽';

  @override
  String get templates => 'テンプレート';

  @override
  String get untitled => '無題のタイトル';

  @override
  String get createTemplate => 'テンプレートを作成';

  @override
  String get createTemplateContent =>
      'このドキュメントからテンプレートを作成してもよろしいですか？元のドキュメントが削除されます。';

  @override
  String get replace => '置換';

  @override
  String get reallyReplace => 'テンプレートを置き換えますか？この操作は元に戻せません！';

  @override
  String get defaultTemplate => 'デフォルトのテンプレート';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'ドキュメント';

  @override
  String get camera => 'カメラ';

  @override
  String get printout => '印刷';

  @override
  String get selectCamera => 'カメラを選択';

  @override
  String get changeDocumentPath => 'ドキュメントのパスを変更';

  @override
  String get deleteWholeStroke => 'ストローク全体を削除';

  @override
  String get alpha => 'アルファ';

  @override
  String get area => 'エリア';

  @override
  String get selectArea => 'エリアを選択';

  @override
  String get aspectRatio => 'アスペクト比';

  @override
  String get presets => 'プリセット';

  @override
  String get pagePortrait => '縦向きページ';

  @override
  String get pageLandscape => '横向きページ';

  @override
  String get square => '正方形（正方形）';

  @override
  String get areas => 'エリア';

  @override
  String get enterArea => '領域を入力してください';

  @override
  String get exitArea => 'エリアを終了する';

  @override
  String get currentArea => '現在のエリア';

  @override
  String get design => 'デザイン';

  @override
  String get text => 'テキスト';

  @override
  String welcome(String codeName) {
    return 'おい、これはLinwood Butterfly';
  }

  @override
  String get welcomeContent => 'フリーでオープンソースのドローイングスペース！';

  @override
  String updated(String version) {
    return 'アプリをバージョン $version に更新しました';
  }

  @override
  String get releaseNotes => 'リリースノート';

  @override
  String get constraints => '制約';

  @override
  String get scaled => '拡大縮小';

  @override
  String get fixed => '固定';

  @override
  String get dynamicContent => 'ダイナミック';

  @override
  String get none => 'なし';

  @override
  String get includeArea => 'エリアを含める';

  @override
  String get verticalAlignment => '縦方向の配置';

  @override
  String get horizontalAlignment => '水平方向の配置';

  @override
  String get top => '上';

  @override
  String get center => '中央揃え';

  @override
  String get bottom => '下揃え';

  @override
  String get left => '左';

  @override
  String get right => '右';

  @override
  String get justify => '両端揃え';

  @override
  String get constraint => '制約';

  @override
  String get length => '長さ';

  @override
  String get exportSvg => 'SVGをエクスポート';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => 'ページを選択';

  @override
  String get recentFiles => '最近使ったファイル';

  @override
  String get start => '開始';

  @override
  String get noRecentFiles => '最近使ったファイルはありません';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ページ',
      one: '1 ページ',
      zero: 'ページがありません',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'ページ $index';
  }

  @override
  String get exit => '終了';

  @override
  String get noElements => '要素がありません';

  @override
  String get invertSelection => '選択を反転';

  @override
  String get errorWhileImporting => 'インポート中のエラー';

  @override
  String get errorWhileImportingContent => 'ファイルのインポート中にエラーが発生しました';

  @override
  String get showDetails => '詳細を表示';

  @override
  String get hideDetails => '詳細を隠す';

  @override
  String get error => 'エラー';

  @override
  String get stackTrace => 'スタックトレース';

  @override
  String get laser => 'レーザー';

  @override
  String get duration => '期間';

  @override
  String get quality => '品質';

  @override
  String get exportPdf => 'PDFをエクスポート';

  @override
  String get local => 'ローカル';

  @override
  String get addConnection => 'コネクションを追加';

  @override
  String get connections => 'コネクション';

  @override
  String get noConnections => 'コネクションがありません';

  @override
  String get url => 'URL';

  @override
  String get connect => '接続する';

  @override
  String get username => 'ユーザー名';

  @override
  String get password => 'パスワード';

  @override
  String get webNotSupported => 'Webはサポートされていません';

  @override
  String get advanced => '高度な設定';

  @override
  String get directory => 'ディレクトリ';

  @override
  String get documentsDirectory => 'ドキュメントディレクトリ';

  @override
  String get templatesDirectory => 'テンプレートディレクトリ';

  @override
  String get errorWhileCreatingConnection => '接続の作成中にエラー';

  @override
  String get cannotConnect => '接続できません';

  @override
  String get urlNotValid => 'URL が無効です';

  @override
  String get icon => 'アイコン';

  @override
  String get update => '更新';

  @override
  String get updateAvailable => 'アップデートがあります';

  @override
  String get stable => '安定版';

  @override
  String get nightly => 'ナイトリー';

  @override
  String get checkForUpdates => 'アップデートを確認';

  @override
  String get checkForUpdatesWarning =>
      'アップデートのチェックを実行すると、Butterflyのウェブサイトに接続して情報を取得できます。';

  @override
  String get usingLatestStable => '最新の安定版を使用しています';

  @override
  String get usingLatestNightly => '最新のナイトリーバージョンを使用しています';

  @override
  String get currentVersion => '現在のバージョン';

  @override
  String get updateNow => '今すぐ更新';

  @override
  String get shape => '形状';

  @override
  String get circle => '円';

  @override
  String get rectangle => '矩形';

  @override
  String get triangle => 'Triangle';

  @override
  String get line => '線';

  @override
  String get cornerRadius => 'Corner radius';

  @override
  String get topLeft => '左上';

  @override
  String get topRight => '右上へ';

  @override
  String get bottomLeft => '左下';

  @override
  String get bottomRight => '右下';

  @override
  String get caches => 'キャッシュ';

  @override
  String get manage => '管理';

  @override
  String get clearCaches => 'キャッシュをクリア';

  @override
  String get createCache => 'キャッシュを作成';

  @override
  String get thirdPartyLicenses => 'サードパーティライセンス';

  @override
  String get syncing => '同期中...';

  @override
  String get synced => '同期済み';

  @override
  String get notSynced => '同期していません';

  @override
  String get conflict => '競合';

  @override
  String get keepLocal => 'ローカルを維持';

  @override
  String get keepConnection => '接続を維持';

  @override
  String get keepBoth => '両方を保持';

  @override
  String get forAll => 'すべて';

  @override
  String fileConflict(String file, String connection) {
    return '$file で $connection が競合しています';
  }

  @override
  String get offline => 'オフライン';

  @override
  String get localLatest => '最新のローカル';

  @override
  String get connectionLatest => '最新の接続';

  @override
  String get path => 'パス';

  @override
  String get folderSynced => 'フォルダを同期しました';

  @override
  String get syncRootDirectory => 'ルートディレクトリを同期';

  @override
  String get penOnlyInput => 'ペンのみ入力';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'ネイティブのタイトルバー';

  @override
  String get syncMode => '同期モード';

  @override
  String get connection => '接続';

  @override
  String get always => '常に表示';

  @override
  String get noMobile => '携帯電話がありません';

  @override
  String get manual => 'マニュアル';

  @override
  String get search => '検索';

  @override
  String get properties => 'プロパティー';

  @override
  String get pin => 'ピン留めする';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => '要素';

  @override
  String get painter => 'Painter';

  @override
  String get position => '位置';

  @override
  String get note => 'メモ';

  @override
  String get packs => 'パック';

  @override
  String get pack => 'パック';

  @override
  String get more => 'もっと見る';

  @override
  String get askForName => '名前を求める';

  @override
  String areaIndex(int index) {
    return 'エリア $index';
  }

  @override
  String get startInFullScreen => '全画面表示で開始';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'マウス';

  @override
  String get touch => 'タッチ';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'ショートカット';

  @override
  String get middle => '中央';

  @override
  String get first => '最初の';

  @override
  String get second => '秒';

  @override
  String get tools => 'ツール';

  @override
  String get showGrid => 'グリッドを表示';

  @override
  String get grid => 'グリッド';

  @override
  String get ruler => 'ルーラー設定';

  @override
  String get angle => '角度';

  @override
  String get report => 'レポート';

  @override
  String get newFolder => '新しいフォルダ';

  @override
  String get createPack => 'パックを作成';

  @override
  String get editPack => 'パックを編集';

  @override
  String get packsDirectory => 'Packsディレクトリ';

  @override
  String get stamp => '切手（スタンプ）';

  @override
  String get addToPack => 'パックに追加';

  @override
  String get sureImportPack => 'パックをインポートしてもよろしいですか？';

  @override
  String byAuthor(String author) {
    return 'by $author';
  }

  @override
  String get author => '作成者';

  @override
  String get addAsset => 'アセットを追加';

  @override
  String get editAsset => 'アセットを編集';

  @override
  String get scope => 'スコープ';

  @override
  String get noPacks => '現在利用可能なパックはありません';

  @override
  String get components => 'コンポーネント';

  @override
  String get waypoint => '通過点';

  @override
  String get actions => 'アクション';

  @override
  String get painters => 'Painters';

  @override
  String get breakingChangesTitle => '破壊的な変更';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'このバージョンには互換性のない変更があります。更新する前に更新履歴をお読みください。 現在のファイルバージョンは $versionで、新しいバージョンは $newVersion です。';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => '段落';

  @override
  String get fontFamily => 'フォントファミリー';

  @override
  String get smoothing => 'スムージング';

  @override
  String get streamline => 'Streamline';

  @override
  String get presentation => 'プレゼンテーション';

  @override
  String get selectAsset => 'アセットを選択';

  @override
  String get clearStyle => 'スタイルをクリア';

  @override
  String get unknownImportType => '不明なインポートタイプ';

  @override
  String get sureImportTemplate => 'テンプレートをインポートしてもよろしいですか？';

  @override
  String get frame => 'Frame';

  @override
  String get play => '再生';

  @override
  String get video => 'ビデオ';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'ブレークポイント';

  @override
  String get presentationControls => 'プレゼンテーションコントロール';

  @override
  String get nextSlide => '次のスライド';

  @override
  String get nextSlideDescription => '右にスワイプするか、右矢印キーを押して次のスライドに移動します';

  @override
  String get previousSlide => '前のスライド';

  @override
  String get previousSlideDescription => '左にスワイプするか、左矢印キーを押して前のスライドに移動します';

  @override
  String get exitPresentation => 'プレゼンテーションを終了';

  @override
  String get exitPresentationDescription => 'エスケープキーまたは下にスワイプしてプレゼンテーションを終了します';

  @override
  String get pausePresentation => 'プレゼンテーションを一時停止';

  @override
  String get pausePresentationDescription =>
      '画面をタップするか、スペースバーを押してプレゼンテーションを一時停止または再開します';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'プレゼンテーションの最後に達しました';

  @override
  String get startOfPresentation => 'プレゼンテーションの開始に達しました';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return '見出し $index';
  }

  @override
  String get code => 'コード';

  @override
  String get quote => '引用';

  @override
  String get link => 'リンク';

  @override
  String get checkbox => 'Checkbox';

  @override
  String get deleted => '削除しました';

  @override
  String get emphasis => '強調表示';

  @override
  String get listBullet => '箇条書きリスト';

  @override
  String get strong => '強い';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'ホーム';

  @override
  String get files => 'ファイル';

  @override
  String get sortBy => '並び替え';

  @override
  String get location => '場所';

  @override
  String get whatsNew => '新着情報';

  @override
  String get unstar => 'スターを外す';

  @override
  String get star => 'スター';

  @override
  String get goUp => '上へ';

  @override
  String get created => '作成済み';

  @override
  String get modified => '修正されました';

  @override
  String get quickstart => 'クイックスタート';

  @override
  String get noTemplates => '現在利用可能なテンプレートはありません';

  @override
  String get importCorePack => 'コア パックをインポート';

  @override
  String get importCorePackDescription =>
      '始めるためのすべての基本的なアセットを含むコア パックをインポートします。これは現在のコア パックを上書きします。';

  @override
  String get never => '一切なし';

  @override
  String get onlyOnUpdates => '更新時のみ';

  @override
  String get visibility => '公開範囲';

  @override
  String get captureThumbnail => 'サムネイルをキャプチャする';

  @override
  String get capturedThumbnail => 'サムネイルをキャプチャしました';

  @override
  String get chooseLabelMode => 'ラベルモードを選択';

  @override
  String get foreground => 'フォアグラウンド（前面）';

  @override
  String get version => 'バージョン';

  @override
  String get repository => 'リポジトリ';

  @override
  String get pages => 'ページ';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => '整列';

  @override
  String get bringToFront => '前面へ移動';

  @override
  String get sendToBack => '背面へ送る';

  @override
  String get bringForward => '前方へ移動';

  @override
  String get sendBackward => '後方に送る';

  @override
  String get rotation => '回転';

  @override
  String get onlyAvailableLargerScreen => 'より大きな画面でのみ利用可能';

  @override
  String get toolbarPosition => 'ツールバーの位置';

  @override
  String get rotate => '回転';

  @override
  String get spacer => 'スペーサー';

  @override
  String get navigationRail => 'ナビゲーション レール';

  @override
  String get cut => '切り取り';

  @override
  String get insertBefore => '前に挿入';

  @override
  String get insertAfter => '後に挿入';

  @override
  String get insertFirst => '最初に挿入';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => '貼り付け';

  @override
  String get ascending => '昇順';

  @override
  String get descending => '降順';

  @override
  String get imageScale => '画像の大きさ';

  @override
  String get select => '選択';

  @override
  String get tool => 'ツール';

  @override
  String get texture => 'テクスチャ';

  @override
  String get platformTheme => 'プラットフォームのテーマ';

  @override
  String get desktop => 'デスクトップ';

  @override
  String get mobile => 'モバイル';

  @override
  String get pdfQuality => 'PDFの品質';

  @override
  String get surface => 'Surface';

  @override
  String get pattern => 'パターン';

  @override
  String get sureClose => 'ドキュメントを閉じてもよろしいですか？';

  @override
  String get thereAreUnsavedChanges => '保存されていない変更があります';

  @override
  String get page => 'ページ';

  @override
  String get iceServers => 'ICE サーバー';

  @override
  String get collaboration => 'コラボレーション';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Web Socket';

  @override
  String get iceServer => 'ICE サーバー';

  @override
  String get port => 'ポート';

  @override
  String get type => 'タイプ';

  @override
  String get side => 'サイド';

  @override
  String get client => 'クライアント';

  @override
  String get server => 'サーバー';

  @override
  String get switchView => 'ビューの切り替え';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'UI を隠す';

  @override
  String get density => '解像度:';

  @override
  String get compact => 'コンパクト化';

  @override
  String get comfortable => '快適さ';

  @override
  String get standard => '標準';

  @override
  String get lock => 'ロック';

  @override
  String get addElement => '要素を追加';

  @override
  String get notDefaultConnection => 'デフォルトの接続ではありません';

  @override
  String get defaultConnection => '既定の接続';

  @override
  String get hide => '非表示';

  @override
  String get show => '表示';

  @override
  String get pause => '一時停止';

  @override
  String get stop => '停止';

  @override
  String get refresh => '更新';

  @override
  String get print => '印刷';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'スポイト';

  @override
  String get users => 'ユーザー';

  @override
  String get experiments => '実験';

  @override
  String get address => '住所';

  @override
  String get spreadToPages => 'ページにスプレッド';

  @override
  String get rootDirectorySpecifiedDescription =>
      'ルートディレクトリが指定されています。すべての高度なディレクトリパスはこのディレクトリからの相対パスになります。このディレクトリタイプを無効にするには空のままにしてください。';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'ルートディレクトリが指定されていません。名前は必須です。すべての高度なディレクトリパスは絶対的です。このディレクトリタイプを無効にするには空にしてください。';

  @override
  String get unsecureConnectionTitle => 'セキュアでない接続';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return '接続が安全ではありません。これはセキュリティ上のリスクがあります。接続を信頼している場合にのみ続けてください。sha1 指紋は $fingerprint です。';
  }

  @override
  String get continueAnyway => 'それでも続ける';

  @override
  String get zoomControl => 'ズームコントロール';

  @override
  String get highContrast => '高コントラストformat@@0';

  @override
  String get shouldANumber => 'この値は有効な数字でなければなりません';

  @override
  String get createAreas => 'エリアを作成';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => '操作';

  @override
  String get medium => 'ミディアム';

  @override
  String get large => '大';

  @override
  String get toolbarSize => 'ツールバーのサイズ';

  @override
  String get addAll => 'すべて追加';

  @override
  String get onlyCurrentPage => '現在のページのみ';

  @override
  String get smoothNavigation => 'スムーズなナビゲーション';

  @override
  String get exact => '正確な';

  @override
  String get inline => 'インライン';

  @override
  String get toolbarRows => 'ツールバーの行';

  @override
  String get pointerTest => 'ポインタテスト';

  @override
  String get pressure => '<unk>';

  @override
  String get small => '小';

  @override
  String get tiny => '<unk>';

  @override
  String get selectAll => 'すべて選択';

  @override
  String get overrideTools => 'ツールを上書きする';

  @override
  String get hideCursorWhileDrawing => '描画中にカーソルを隠す';

  @override
  String get installed => 'インストール済み';

  @override
  String get install => 'インストール';

  @override
  String get deselect => '選択を解除';

  @override
  String get changeCollection => 'コレクションを変更';

  @override
  String get collections => 'コレクション';

  @override
  String get fullSelection => '完全な選択';

  @override
  String get fullSelectionDescription => '選択するには、選択ボックス内に要素を完全に含める必要があります。';

  @override
  String get collection => 'コレクション';

  @override
  String get defaultCollection => 'デフォルトのコレクション';

  @override
  String get scroll => 'スクロール';

  @override
  String get onStartup => '起動時';

  @override
  String get homeScreen => 'ホーム画面';

  @override
  String get lastNote => '最後のメモ';

  @override
  String get newNote => '新規ノート';

  @override
  String get convertToLayer => 'レイヤーに変換';

  @override
  String get merge => '結合';

  @override
  String get up => '上へ';

  @override
  String get down => '下';

  @override
  String get other => 'その他';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 要素',
      one: '1 要素',
      zero: '要素なし',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'カラーツールバー';

  @override
  String get yesButShowButtons => 'はい、しかしボタンを表示する';

  @override
  String get optionsPanelPosition => 'オプションパネルの位置';

  @override
  String get hideDuration => '期間を隠す';

  @override
  String get animation => 'アニメーション';

  @override
  String get performance => 'パフォーマンス';

  @override
  String get performanceDescription =>
      '速度とメモリ使用量に合わせて最適化されました。ノートの表示部分だけが画像に焼き付けられます。';

  @override
  String get normalDescription =>
      'バランスの良さとパフォーマンス。可視領域の1.5倍の画像を焼き、スクロール時にスムーズなトランジションを提供します。';

  @override
  String get high => '高い';

  @override
  String get highDescription =>
      '概要: 性能を犠牲にして品質を最大化します。 可視領域の2倍の画像を作成し、高速スクロールやズーム時でもシームレスなレンダリングを実現します。';

  @override
  String get renderResolution => 'レンダリング解像度';

  @override
  String get translate => '翻訳する';

  @override
  String get unencrypted => '暗号化なし';

  @override
  String get encrypted => '暗号化済み';

  @override
  String get encryptDocumentMessage => 'クリックしてドキュメントを暗号化します';

  @override
  String get unencryptDocumentMessage => 'クリックしてドキュメントの暗号化を解除';

  @override
  String get unencrypt => '暗号化解除';

  @override
  String get encrypt => '暗号化';

  @override
  String get encryptWarning => 'これはドキュメントを暗号化します。復号するにはパスワードを忘れないようにしてください。';

  @override
  String get unencryptWarning =>
      'これはドキュメントの暗号化を解除します。パスワードは削除され、アクセス権を持つ全員がそれを開くことができます。';

  @override
  String get confirmPassword => 'パスワードの確認';

  @override
  String get passwordMismatch => 'パスワードが一致しません';

  @override
  String get action => 'アクション';

  @override
  String get svgText => 'SVGテキスト';

  @override
  String get offset => 'オフセット';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
