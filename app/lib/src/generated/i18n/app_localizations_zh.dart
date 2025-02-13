// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get open => '打开';

  @override
  String get settings => '设置';

  @override
  String get personalization => '个性化';

  @override
  String get theme => '主题';

  @override
  String get darkTheme => '暗色主题';

  @override
  String get lightTheme => '亮色主题';

  @override
  String get systemTheme => '使用系统默认主题';

  @override
  String get view => '查看';

  @override
  String get edit => '编辑';

  @override
  String get export => '导出';

  @override
  String get save => '保存';

  @override
  String get zoom => '缩放';

  @override
  String get zoomIn => '缩放';

  @override
  String get zoomOut => '缩放';

  @override
  String get resetZoom => 'Reset zoom';

  @override
  String get strokeWidth => '笔画宽度';

  @override
  String get includeEraser => '包括擦除器？';

  @override
  String get thinning => '闪光灯';

  @override
  String get pen => '笔';

  @override
  String get eraser => '橡皮擦';

  @override
  String get pathEraser => '整笔擦除';

  @override
  String get label => '标签';

  @override
  String get delete => '删除';

  @override
  String get areYouSure => '您确定吗？';

  @override
  String get reallyDelete => '您真的想要删除这个项目吗？';

  @override
  String get no => '否';

  @override
  String get yes => '否';

  @override
  String get undo => '撤消操作';

  @override
  String get redo => '重做';

  @override
  String get general => '常规';

  @override
  String get copyTitle => '复制到剪贴板';

  @override
  String get loading => '加载中...';

  @override
  String get enterText => '输入文本';

  @override
  String get size => '大小';

  @override
  String get width => '宽度';

  @override
  String get height => '高度';

  @override
  String get count => '计数';

  @override
  String get space => '空间';

  @override
  String get background => '背景';

  @override
  String get box => '框';

  @override
  String get locale => '本地化';

  @override
  String get systemLocale => '系统区域设置';

  @override
  String get information => '信息';

  @override
  String get license => '许可协议';

  @override
  String get imprint => '图形';

  @override
  String get privacypolicy => '隐私政策';

  @override
  String get source => '源代码';

  @override
  String get documentation => '文件';

  @override
  String get changelog => '更新日志';

  @override
  String get existOverride => '此元素已经存在。覆盖吗？';

  @override
  String get description => '描述';

  @override
  String get fill => '填充';

  @override
  String get defaultPalette => '默认调色板';

  @override
  String get highlighter => '高亮器';

  @override
  String get add => '添加';

  @override
  String get remove => '删除';

  @override
  String get removeConfirm => '您真的想要删除这个吗？';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => '自定义';

  @override
  String get decoration => '装饰';

  @override
  String get underline => '下划线';

  @override
  String get overline => '轮廓线';

  @override
  String get strikethrough => '删除线';

  @override
  String get thickness => '厚度';

  @override
  String get style => '样式';

  @override
  String get solid => 'Solid';

  @override
  String get double => '双精度';

  @override
  String get dotted => '虚线';

  @override
  String get dashed => '虚线';

  @override
  String get wavy => '瓦维文';

  @override
  String get fontWeight => '字体权重';

  @override
  String get normal => '普通的';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => '剪切板';

  @override
  String get file => '文件';

  @override
  String get data => '数据';

  @override
  String get share => '分享';

  @override
  String get spacing => '间距';

  @override
  String get image => '图片';

  @override
  String get enterUrl => '输入网址';

  @override
  String get scale => '缩放比例';

  @override
  String get help => '帮助';

  @override
  String get reallyReset => '您真的想要重置吗？';

  @override
  String get whatToDo => '您想要做什么？';

  @override
  String get ignore => '忽略';

  @override
  String get backup => '备份';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return '文件 $fileName 是在更新版本 ($fileVersion)中创建的。该文件应该怎么办？';
  }

  @override
  String get waypoints => '航点';

  @override
  String get origin => '始发地';

  @override
  String get import => '导入';

  @override
  String get newContent => '新的';

  @override
  String get selectElement => '选择元素';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => '偏移';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => '复制版本';

  @override
  String get input => 'Input';

  @override
  String get behaviors => '行为';

  @override
  String get dataDirectory => '数据目录';

  @override
  String get defaultPath => '默认路径';

  @override
  String get dateFormat => '日期格式';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return '更新于： $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return '创建于: $dateTimeString';
  }

  @override
  String get rename => '重命名：';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => '手';

  @override
  String get folder => '文件夹';

  @override
  String get move => '移动';

  @override
  String get copy => '复制';

  @override
  String get back => '后退';

  @override
  String get zoomDependent => '依靠缩放';

  @override
  String get shapeDetection => '形状检测';

  @override
  String get delay => '延迟';

  @override
  String get defaultLayer => '默认图层';

  @override
  String get layer => '图层';

  @override
  String get layers => '图层';

  @override
  String get notSet => '未设置';

  @override
  String get enterLayer => '输入图层名称';

  @override
  String get selectElements => '选择元素';

  @override
  String get deleteElements => '删除元素';

  @override
  String get deleteElementsConfirm => '您真的想要删除选定的元素吗？';

  @override
  String get selectCustomCollection => '选择一个自定义收藏';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => '灵敏度';

  @override
  String get sensitivityHint => '值越高，输入越灵敏度';

  @override
  String get horizontal => '水平';

  @override
  String get vertical => '垂直的';

  @override
  String get plain => '纯色';

  @override
  String get light => '亮色的';

  @override
  String get ruled => '已规则';

  @override
  String get quad => '四月';

  @override
  String get music => '音乐';

  @override
  String get dark => '深色';

  @override
  String get plainDark => '深色';

  @override
  String get ruledDark => '限定的暗色';

  @override
  String get quadDark => '四极暗色';

  @override
  String get musicDark => '音乐黑色';

  @override
  String get templates => '模板';

  @override
  String get untitled => '无标题';

  @override
  String get createTemplate => '创建模板';

  @override
  String get createTemplateContent => '您真的想要从此文档创建一个模板吗？原始文档将被删除。';

  @override
  String get replace => '替换';

  @override
  String get reallyReplace => '您真的想要替换模板吗？此操作不能撤消！';

  @override
  String get defaultTemplate => '默认模板';

  @override
  String get insert => 'Insert';

  @override
  String get document => '文件';

  @override
  String get camera => '摄像头';

  @override
  String get printout => '打印输出';

  @override
  String get selectCamera => '选择相机';

  @override
  String get changeDocumentPath => '更改文档路径';

  @override
  String get deleteWholeStroke => '删除整个笔记';

  @override
  String get alpha => '阿尔法';

  @override
  String get area => '区域';

  @override
  String get selectArea => '选择区域';

  @override
  String get aspectRatio => '纵横比';

  @override
  String get presets => '预设值';

  @override
  String get pagePortrait => '页面肖像';

  @override
  String get pageLandscape => '横屏页面';

  @override
  String get square => '方形';

  @override
  String get areas => '地区';

  @override
  String get enterArea => '输入区域';

  @override
  String get exitArea => '退出区域';

  @override
  String get currentArea => '当前区域';

  @override
  String get design => '设计';

  @override
  String get text => '文本';

  @override
  String welcome(String codeName) {
    return '嘿，它是 Linwood Butterflight';
  }

  @override
  String get welcomeContent => '一个自由和开源的绘图空间！';

  @override
  String updated(String version) {
    return '应用程序更新到版本 $version';
  }

  @override
  String get releaseNotes => '发布笔记';

  @override
  String get constraints => '制约因素';

  @override
  String get scaled => '缩放';

  @override
  String get fixed => '固定的';

  @override
  String get dynamicContent => '动态';

  @override
  String get none => '无';

  @override
  String get includeArea => '包含区域';

  @override
  String get verticalAlignment => '垂直对齐';

  @override
  String get horizontalAlignment => '水平对齐';

  @override
  String get top => '顶端';

  @override
  String get center => '居中';

  @override
  String get bottom => '底部';

  @override
  String get left => '左侧';

  @override
  String get right => '右侧';

  @override
  String get justify => '对齐';

  @override
  String get constraint => '制约因素';

  @override
  String get length => '长度';

  @override
  String get exportSvg => '导出SVG';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => '选择页面';

  @override
  String get recentFiles => '最近的文件';

  @override
  String get start => '开始';

  @override
  String get noRecentFiles => '没有最近的文件';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '1页面',
      zero: '没有页面',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return '第 $index 页';
  }

  @override
  String get exit => '退出';

  @override
  String get noElements => '没有元素';

  @override
  String get invertSelection => '反转选择';

  @override
  String get errorWhileImporting => '导入时出错';

  @override
  String get errorWhileImportingContent => '导入文件时出错';

  @override
  String get showDetails => '显示详细信息';

  @override
  String get hideDetails => '隐藏详细信息';

  @override
  String get error => '错误';

  @override
  String get stackTrace => '堆栈跟踪';

  @override
  String get laser => '激光器';

  @override
  String get duration => '期限';

  @override
  String get quality => '质量';

  @override
  String get exportPdf => '导出 PDF';

  @override
  String get local => '本地的';

  @override
  String get addConnection => '添加连接';

  @override
  String get connections => '连接';

  @override
  String get noConnections => '没有连接';

  @override
  String get url => '网址';

  @override
  String get connect => '连接';

  @override
  String get username => '用户名';

  @override
  String get password => '密码';

  @override
  String get webNotSupported => '网络不支持';

  @override
  String get advanced => '高级版';

  @override
  String get directory => '目录';

  @override
  String get documentsDirectory => '文档目录';

  @override
  String get templatesDirectory => '模板目录';

  @override
  String get errorWhileCreatingConnection => '创建连接时出错';

  @override
  String get cannotConnect => '无法连接';

  @override
  String get urlNotValid => 'URL无效';

  @override
  String get icon => '图标';

  @override
  String get update => '更新';

  @override
  String get updateAvailable => '可用更新';

  @override
  String get stable => '稳定的';

  @override
  String get nightly => '每晚一次';

  @override
  String get checkForUpdates => '检查更新';

  @override
  String get checkForUpdatesWarning => '检查更新将连接到Butterfair网站获取信息。';

  @override
  String get usingLatestStable => '您正在使用最新的稳定版本';

  @override
  String get usingLatestNightly => '您正在使用最新的夜间版本';

  @override
  String get currentVersion => '当前版本';

  @override
  String get updateNow => '立即更新';

  @override
  String get shape => '形状';

  @override
  String get circle => '圆圈';

  @override
  String get rectangle => '矩形';

  @override
  String get triangle => '三角形';

  @override
  String get line => '直线';

  @override
  String get cornerRadius => 'Corner radius';

  @override
  String get topLeft => '左上方';

  @override
  String get topRight => '右上';

  @override
  String get bottomLeft => '左下';

  @override
  String get bottomRight => '右下';

  @override
  String get caches => '缓存';

  @override
  String get manage => '管理';

  @override
  String get clearCaches => '清除缓存';

  @override
  String get createCache => '创建缓存';

  @override
  String get thirdPartyLicenses => '第三方许可证';

  @override
  String get syncing => '正在同步...';

  @override
  String get synced => '已同步';

  @override
  String get notSynced => '未同步';

  @override
  String get conflict => '冲突';

  @override
  String get keepLocal => '保持本地状态';

  @override
  String get keepConnection => '保持连接';

  @override
  String get keepBoth => '两者都保留';

  @override
  String get forAll => '所有的';

  @override
  String fileConflict(String file, String connection) {
    return '$file 在 $connection 有冲突';
  }

  @override
  String get offline => '离线的';

  @override
  String get localLatest => '本地最新版本';

  @override
  String get connectionLatest => '最新连接';

  @override
  String get path => '路径';

  @override
  String get folderSynced => '文件夹已同步';

  @override
  String get syncRootDirectory => '同步根目录';

  @override
  String get penOnlyInput => '只输入笔数';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => '原生标题栏';

  @override
  String get syncMode => '同步模式';

  @override
  String get connection => '连接';

  @override
  String get always => '总是显示';

  @override
  String get noMobile => '无手机';

  @override
  String get manual => '手动模式';

  @override
  String get search => '搜索';

  @override
  String get properties => '属性';

  @override
  String get pin => '置顶';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => '元素';

  @override
  String get painter => '涂料';

  @override
  String get position => '位置';

  @override
  String get note => '说明';

  @override
  String get packs => '包';

  @override
  String get pack => '包';

  @override
  String get more => '更多';

  @override
  String get askForName => '询问名称';

  @override
  String areaIndex(int index) {
    return '区域 $index';
  }

  @override
  String get startInFullScreen => '全屏启动';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => '鼠标键';

  @override
  String get touch => '触摸时';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => '快捷键';

  @override
  String get middle => '中';

  @override
  String get first => '第一页';

  @override
  String get second => '秒';

  @override
  String get tools => '工具';

  @override
  String get showGrid => '显示网格';

  @override
  String get grid => '网格';

  @override
  String get ruler => '标标';

  @override
  String get angle => '角度';

  @override
  String get report => '报告';

  @override
  String get newFolder => '新建文件夹';

  @override
  String get createPack => '创建包';

  @override
  String get editPack => '编辑包';

  @override
  String get packsDirectory => '包目录';

  @override
  String get stamp => '印章';

  @override
  String get addToPack => '添加到包';

  @override
  String get sureImportPack => '您确定要导入包吗？';

  @override
  String byAuthor(String author) {
    return '由 $author';
  }

  @override
  String get author => '作者';

  @override
  String get addAsset => '添加资产';

  @override
  String get editAsset => '编辑素材';

  @override
  String get scope => '范围';

  @override
  String get noPacks => '目前没有可用的包';

  @override
  String get components => '组件';

  @override
  String get waypoint => '航点';

  @override
  String get actions => '行动';

  @override
  String get painters => '绘画';

  @override
  String get breakingChangesTitle => '打破更改';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return '此版本的更改正在中断。请在更新前阅读更新日志。 当前文件版本是 $version，新版本是 $newVersion。';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => '第18段';

  @override
  String get fontFamily => '字体类';

  @override
  String get smoothing => '平滑化';

  @override
  String get streamline => '简化行';

  @override
  String get presentation => '列报内容';

  @override
  String get selectAsset => '选择素材';

  @override
  String get clearStyle => '清除样式';

  @override
  String get unknownImportType => '未知导入类型';

  @override
  String get sureImportTemplate => '您确定要导入模板吗？';

  @override
  String get frame => 'Frame';

  @override
  String get play => '播放';

  @override
  String get video => '视频';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => '断点';

  @override
  String get presentationControls => '演示控制';

  @override
  String get nextSlide => '下一张幻灯片';

  @override
  String get nextSlideDescription => '向右滑动或按右箭头键进入下一张幻灯片';

  @override
  String get previousSlide => '上一张幻灯片';

  @override
  String get previousSlideDescription => '向左滑动或按左箭头键进入上一张幻灯片';

  @override
  String get exitPresentation => '退出演示文稿';

  @override
  String get exitPresentationDescription => '按下转义键或向下滑动退出演示文稿';

  @override
  String get pausePresentation => '暂停演示记录';

  @override
  String get pausePresentationDescription => '点击屏幕或按空格键暂停或继续演示文稿';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => '您已经到了演示文稿的末尾。';

  @override
  String get startOfPresentation => '您已经到了演示文稿的开始';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return '标题 $index';
  }

  @override
  String get code => '代码';

  @override
  String get quote => '引用';

  @override
  String get link => '链接';

  @override
  String get checkbox => '复选框';

  @override
  String get deleted => '已删除';

  @override
  String get emphasis => '重点：';

  @override
  String get listBullet => '列表符号';

  @override
  String get strong => '强度';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => '首页';

  @override
  String get files => '文件';

  @override
  String get sortBy => '排序方式';

  @override
  String get location => '地点';

  @override
  String get whatsNew => '有什么新鲜事？';

  @override
  String get unstar => '取消星标';

  @override
  String get star => '星标';

  @override
  String get goUp => '向上移动';

  @override
  String get created => '已创建';

  @override
  String get modified => '已修改';

  @override
  String get quickstart => '快速开始';

  @override
  String get noTemplates => '目前没有可用的模板';

  @override
  String get importCorePack => '导入核心包';

  @override
  String get importCorePackDescription => '导入包含所有基本资源以启动的核心包。这将覆盖当前的核心包。';

  @override
  String get never => '从不使用';

  @override
  String get onlyOnUpdates => '仅在更新';

  @override
  String get visibility => '可见性';

  @override
  String get captureThumbnail => '捕获缩略图';

  @override
  String get capturedThumbnail => '成功抓取缩略图';

  @override
  String get chooseLabelMode => '选择标签模式';

  @override
  String get foreground => '前景';

  @override
  String get version => '版本';

  @override
  String get repository => '存储库';

  @override
  String get pages => '页 次';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => '安排';

  @override
  String get bringToFront => '置于前端';

  @override
  String get sendToBack => '发送到背面';

  @override
  String get bringForward => '前进中';

  @override
  String get sendBackward => '向后发送';

  @override
  String get rotation => '旋转';

  @override
  String get onlyAvailableLargerScreen => '仅在大屏幕上可用';

  @override
  String get toolbarPosition => '工具栏位置';

  @override
  String get rotate => '旋转';

  @override
  String get spacer => '空格';

  @override
  String get navigationRail => '导航铁道';

  @override
  String get cut => '剪辑';

  @override
  String get insertBefore => '插入前';

  @override
  String get insertAfter => '在此处插入';

  @override
  String get insertFirst => '先插入';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => '粘贴';

  @override
  String get ascending => '升序';

  @override
  String get descending => '降序';

  @override
  String get imageScale => '图像缩放';

  @override
  String get select => '选择';

  @override
  String get tool => '工具';

  @override
  String get texture => '纹理';

  @override
  String get platformTheme => '平台主题';

  @override
  String get desktop => '桌面';

  @override
  String get mobile => '移动设备';

  @override
  String get pdfQuality => 'PDF 质量';

  @override
  String get surface => '表面';

  @override
  String get pattern => '图案';

  @override
  String get sureClose => '您确定要关闭文档吗？';

  @override
  String get thereAreUnsavedChanges => '有未保存的更改';

  @override
  String get page => '纸张';

  @override
  String get iceServers => 'ICE 服务器';

  @override
  String get collaboration => '合作';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Web 套接字';

  @override
  String get iceServer => 'ICE 服务器';

  @override
  String get port => '端口';

  @override
  String get type => '类型';

  @override
  String get side => '侧面';

  @override
  String get client => '客户端：';

  @override
  String get server => '服务器';

  @override
  String get switchView => '切换视图';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => '隐藏界面';

  @override
  String get density => '密度';

  @override
  String get compact => '紧凑的';

  @override
  String get comfortable => '舒适的';

  @override
  String get standard => '标准的';

  @override
  String get lock => '锁定';

  @override
  String get addElement => '添加元素';

  @override
  String get notDefaultConnection => '不是默认连接';

  @override
  String get defaultConnection => '默认连接';

  @override
  String get hide => '隐藏';

  @override
  String get show => '显示';

  @override
  String get pause => '暂停';

  @override
  String get stop => '停止';

  @override
  String get refresh => '刷新';

  @override
  String get print => '打印';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => '眼睛投射器';

  @override
  String get users => '用户';

  @override
  String get experiments => '实验';

  @override
  String get address => '地址';

  @override
  String get spreadToPages => '扩展到页面';

  @override
  String get rootDirectorySpecifiedDescription =>
      '已指定根目录。所有高级目录路径将与此目录相对。保持空白以禁用此目录类型。';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      '未指定根目录。需要名称。所有高级目录路径将是绝对路径。保留空白以禁用此目录类型。';

  @override
  String get unsecureConnectionTitle => '不安全的连接';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return '此连接不安全，有潜在风险。请确保信任此连接再继续。sha1指纹是 $fingerprint。';
  }

  @override
  String get continueAnyway => '仍然继续';

  @override
  String get zoomControl => '缩放控制';

  @override
  String get highContrast => '高对比度';

  @override
  String get shouldANumber => '此值应该是有效的数字';

  @override
  String get createAreas => '创建区域';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => '业务活动';

  @override
  String get medium => '中';

  @override
  String get large => '大的';

  @override
  String get toolbarSize => '工具栏大小';

  @override
  String get addAll => '添加全部';

  @override
  String get onlyCurrentPage => '仅当前页面';

  @override
  String get smoothNavigation => '平滑导航';

  @override
  String get exact => '精准的';

  @override
  String get inline => '内联';

  @override
  String get toolbarRows => '工具栏行';

  @override
  String get pointerTest => '指针测试';

  @override
  String get pressure => '气压';

  @override
  String get small => '小的';

  @override
  String get tiny => '微调';

  @override
  String get selectAll => '选择所有';

  @override
  String get overrideTools => '覆盖工具';

  @override
  String get hideCursorWhileDrawing => '绘制时隐藏光标';

  @override
  String get installed => '已安装';

  @override
  String get install => '安装';

  @override
  String get deselect => '取消选择';

  @override
  String get changeCollection => '更改收藏';

  @override
  String get collections => 'A. 收款情况';

  @override
  String get fullSelection => '完整选择';

  @override
  String get fullSelectionDescription => '需要元素完全在选择框内。';

  @override
  String get collection => '收藏';

  @override
  String get defaultCollection => '默认收藏';

  @override
  String get scroll => '滚动';

  @override
  String get onStartup => '启动时';

  @override
  String get homeScreen => '主屏幕';

  @override
  String get lastNote => '最后一个笔记';

  @override
  String get newNote => '新建笔记';

  @override
  String get convertToLayer => '转换为图层';

  @override
  String get merge => '合并';

  @override
  String get up => '上移';

  @override
  String get down => '向下';

  @override
  String get other => '其他';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '元素$count 元素',
      one: '元素',
      zero: '没有元素',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => '颜色工具栏';

  @override
  String get yesButShowButtons => '是的，但显示按钮';

  @override
  String get optionsPanelPosition => '选项面板位置';

  @override
  String get hideDuration => '隐藏持续时间';

  @override
  String get animation => '动画';

  @override
  String get performance => '业绩';

  @override
  String get performanceDescription => '优化速度和内存使用率。只将笔记的可见部分填入图像。';

  @override
  String get normalDescription => '平衡质量和性能。使图像覆盖可见区域的1.5倍，在滚动时提供更加顺利的转化。';

  @override
  String get high => '高';

  @override
  String get highDescription =>
      '说明：以牺牲性能为代价最大限度地提高质量。 使图像覆盖可见区域的2倍，确保即使在快速滚动或缩放时也能无缝渲染。';

  @override
  String get renderResolution => '渲染分辨率';

  @override
  String get translate => '翻译';

  @override
  String get unencrypted => '未加密';

  @override
  String get encrypted => '加密的';

  @override
  String get encryptDocumentMessage => '点击以加密文档';

  @override
  String get unencryptDocumentMessage => '点击取消加密文档';

  @override
  String get unencrypt => '不加密';

  @override
  String get encrypt => '加密';

  @override
  String get encryptWarning => '这将加密文档。您需要记住密码才能解密它。';

  @override
  String get unencryptWarning => '这将取消加密文档。密码将被删除，所有有访问权限的人都能够打开它。';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get passwordMismatch => '密码不匹配';

  @override
  String get action => '动作';

  @override
  String get svgText => 'SVG 文本';

  @override
  String get offset => '偏移量';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}

/// The translations for Chinese, using the Han script (`zh_Hant`).
class AppLocalizationsZhHant extends AppLocalizationsZh {
  AppLocalizationsZhHant() : super('zh_Hant');

  @override
  String get open => '開啟';

  @override
  String get settings => '設定';

  @override
  String get personalization => '個人化';

  @override
  String get theme => '主題';

  @override
  String get darkTheme => '深色主題';

  @override
  String get lightTheme => '淺色主題';

  @override
  String get systemTheme => '使用系統預設主題';

  @override
  String get view => '查看';

  @override
  String get edit => '編輯';

  @override
  String get export => '匯出';

  @override
  String get save => '儲存';

  @override
  String get zoom => '縮放';

  @override
  String get zoomIn => '放大';

  @override
  String get zoomOut => '縮小';

  @override
  String get resetZoom => '重設縮放';

  @override
  String get strokeWidth => '筆劃寬度';

  @override
  String get includeEraser => '包含橡皮擦？';

  @override
  String get thinning => '稀薄化';

  @override
  String get pen => '筆';

  @override
  String get eraser => '橡皮擦';

  @override
  String get pathEraser => '路徑橡皮擦';

  @override
  String get label => '標記';

  @override
  String get delete => '刪除';

  @override
  String get areYouSure => '確定嗎？';

  @override
  String get reallyDelete => '確定要刪除此項目嗎？';

  @override
  String get no => '否';

  @override
  String get yes => '是';

  @override
  String get undo => '還原';

  @override
  String get redo => '復原';

  @override
  String get general => '一般';

  @override
  String get copyTitle => '已複製到剪貼簿';

  @override
  String get loading => '載入中……';

  @override
  String get enterText => '輸入文字';

  @override
  String get size => '大小';

  @override
  String get width => '寬度';

  @override
  String get height => '高度';

  @override
  String get count => '線數';

  @override
  String get space => '間隔';

  @override
  String get background => '背景';

  @override
  String get box => '盒子';

  @override
  String get locale => '區域';

  @override
  String get systemLocale => '系統語言';

  @override
  String get information => '資訊';

  @override
  String get license => '授權';

  @override
  String get imprint => '發行頁面';

  @override
  String get privacypolicy => '隱私政策';

  @override
  String get source => '來源';

  @override
  String get documentation => '文件';

  @override
  String get changelog => '更新紀錄';

  @override
  String get existOverride => '此元素已存在。要覆寫嗎？';

  @override
  String get description => '說明';

  @override
  String get fill => '填滿';

  @override
  String get defaultPalette => '預設調色板';

  @override
  String get highlighter => '螢光筆';

  @override
  String get add => '新增';

  @override
  String get remove => '移除';

  @override
  String get removeConfirm => '確定要移除嗎？';

  @override
  String get resetPalette => '重設調色板';

  @override
  String get custom => '自訂';

  @override
  String get decoration => '彩飾';

  @override
  String get underline => '下劃線';

  @override
  String get overline => '上劃線';

  @override
  String get strikethrough => '刪除線';

  @override
  String get thickness => '寬度';

  @override
  String get style => '樣式';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Double';

  @override
  String get dotted => 'Dotted';

  @override
  String get dashed => 'Dashed';

  @override
  String get wavy => 'Wavy';

  @override
  String get fontWeight => '字重';

  @override
  String get normal => '標準';

  @override
  String get bold => '粗體';

  @override
  String get italic => '斜體';

  @override
  String get clipboard => '剪貼簿';

  @override
  String get file => '檔案';

  @override
  String get data => '資料';

  @override
  String get share => '分享';

  @override
  String get spacing => '間距';

  @override
  String get image => '圖片';

  @override
  String get enterUrl => '輸入網址';

  @override
  String get scale => '縮放';

  @override
  String get help => '幫助';

  @override
  String get reallyReset => '確定要重設嗎？';

  @override
  String get whatToDo => '您想要做什麼？';

  @override
  String get ignore => '略過';

  @override
  String get backup => '備份';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return '「$fileName」是在第 $fileVersion 版（較新的版本）中建立的。要如何處理這份檔案？';
  }

  @override
  String get waypoints => '定位點';

  @override
  String get origin => '原點';

  @override
  String get import => '匯入';

  @override
  String get newContent => '新建';

  @override
  String get selectElement => '選擇元素';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Shift';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => '複製版本資訊';

  @override
  String get input => '輸入';

  @override
  String get behaviors => '行爲';

  @override
  String get dataDirectory => '資料夾';

  @override
  String get defaultPath => '預設路徑';

  @override
  String get dateFormat => '日期格式';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return '更新於：$dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return '建立於：$dateTimeString';
  }

  @override
  String get rename => '改名';

  @override
  String get duplicate => '再製';

  @override
  String get hand => '手';

  @override
  String get folder => '資料夾';

  @override
  String get move => '移動';

  @override
  String get copy => '複製';

  @override
  String get back => '返回';

  @override
  String get zoomDependent => '隨應縮放';

  @override
  String get shapeDetection => '形狀偵測';

  @override
  String get delay => '延遲';

  @override
  String get defaultLayer => '預設圖層';

  @override
  String get layer => '圖層';

  @override
  String get layers => '圖層';

  @override
  String get notSet => '未設';

  @override
  String get enterLayer => '輸入圖層名稱';

  @override
  String get selectElements => '選取元素';

  @override
  String get deleteElements => '刪除元素';

  @override
  String get deleteElementsConfirm => '確定要刪除所選元素嗎？';

  @override
  String get selectCustomCollection => 'Select a custom collection';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => '靈敏度';

  @override
  String get sensitivityHint => '數值越高，輸入越靈敏';

  @override
  String get horizontal => '水平';

  @override
  String get vertical => '垂直';

  @override
  String get plain => '素色';

  @override
  String get light => '亮';

  @override
  String get ruled => '直紋';

  @override
  String get quad => '方格';

  @override
  String get music => '樂譜';

  @override
  String get dark => '暗';

  @override
  String get plainDark => '暗';

  @override
  String get ruledDark => '直紋 - 暗';

  @override
  String get quadDark => '方格 - 暗';

  @override
  String get musicDark => '樂譜 - 暗';

  @override
  String get templates => '模板';

  @override
  String get untitled => '無標題';

  @override
  String get createTemplate => '建立模板';

  @override
  String get createTemplateContent =>
      'Do you really want to create a template from this document? The original document will get deleted.';

  @override
  String get replace => '取代';

  @override
  String get reallyReplace => '確定要取代模板嗎？這無法復原喔！';

  @override
  String get defaultTemplate => '預設模板';

  @override
  String get insert => '插入';

  @override
  String get document => '文件';

  @override
  String get camera => '鏡頭';

  @override
  String get printout => '印出';

  @override
  String get selectCamera => '選擇鏡頭';

  @override
  String get changeDocumentPath => '修改文件路徑';

  @override
  String get deleteWholeStroke => '刪除整條筆劃';

  @override
  String get alpha => '不透明';

  @override
  String get area => '分區';

  @override
  String get selectArea => '選擇分區';

  @override
  String get aspectRatio => '長寬比';

  @override
  String get presets => '預設';

  @override
  String get pagePortrait => '直式紙張';

  @override
  String get pageLandscape => '橫式紙張';

  @override
  String get square => '正方形';

  @override
  String get areas => '分區';

  @override
  String get enterArea => '進入分區';

  @override
  String get exitArea => '退出分區';

  @override
  String get currentArea => '目前分區';

  @override
  String get design => '配色';

  @override
  String get text => '文字';

  @override
  String welcome(String codeName) {
    return '嗨，在下 Linwood Butterfly';
  }

  @override
  String get welcomeContent => '是一塊自由且開源的繪圖空間！';

  @override
  String updated(String version) {
    return 'App 版本已更新至 $version';
  }

  @override
  String get releaseNotes => '發行備註';

  @override
  String get constraints => '限制條件';

  @override
  String get scaled => '已縮放';

  @override
  String get fixed => '固定';

  @override
  String get dynamicContent => '動態';

  @override
  String get none => '無';

  @override
  String get includeArea => '包含分區';

  @override
  String get verticalAlignment => '垂直對齊';

  @override
  String get horizontalAlignment => '水平對齊';

  @override
  String get top => '上';

  @override
  String get center => '中';

  @override
  String get bottom => '下';

  @override
  String get left => '左';

  @override
  String get right => '右';

  @override
  String get justify => '左右對齊';

  @override
  String get constraint => '限制';

  @override
  String get length => '長度';

  @override
  String get exportSvg => '匯出 SVG';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => '選取頁面';

  @override
  String get recentFiles => '最近使用的檔案';

  @override
  String get start => '開始';

  @override
  String get noRecentFiles => '沒有最近使用的檔案';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '共 $count 頁',
      one: '共 $count 頁',
      zero: '沒有頁面',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return '第 $index 頁';
  }

  @override
  String get exit => '退出';

  @override
  String get noElements => '沒有元素';

  @override
  String get invertSelection => '反向選取';

  @override
  String get errorWhileImporting => '匯入時發生錯誤';

  @override
  String get errorWhileImportingContent => '匯入檔案時發生錯誤';

  @override
  String get showDetails => '顯示細節';

  @override
  String get hideDetails => '隱藏細節';

  @override
  String get error => '錯誤';

  @override
  String get stackTrace => '堆疊追蹤';

  @override
  String get laser => '雷射';

  @override
  String get duration => '存續時間';

  @override
  String get quality => '品質';

  @override
  String get exportPdf => '匯出 PDF';

  @override
  String get local => '本機';

  @override
  String get addConnection => '新增連線';

  @override
  String get connections => '連線';

  @override
  String get noConnections => '沒有連線';

  @override
  String get url => '網址';

  @override
  String get connect => '連線';

  @override
  String get username => '使用者名稱';

  @override
  String get password => '密碼';

  @override
  String get webNotSupported => '不支援的網路';

  @override
  String get advanced => '進階';

  @override
  String get directory => '目錄';

  @override
  String get documentsDirectory => '文件目錄';

  @override
  String get templatesDirectory => '模板目錄';

  @override
  String get errorWhileCreatingConnection => '建立連線時發生錯誤';

  @override
  String get cannotConnect => '無法連線';

  @override
  String get urlNotValid => '網址無效';

  @override
  String get icon => '圖示';

  @override
  String get update => '更新';

  @override
  String get updateAvailable => '有更新';

  @override
  String get stable => '穩定版';

  @override
  String get nightly => '預覽版';

  @override
  String get checkForUpdates => '檢查更新';

  @override
  String get checkForUpdatesWarning =>
      'Performing a check for updates will connect to the Butterfly website to get the information.';

  @override
  String get usingLatestStable => '現在的是最新穩定版';

  @override
  String get usingLatestNightly => '現在的是最新夜間版';

  @override
  String get currentVersion => '目前版本';

  @override
  String get updateNow => '立即更新';

  @override
  String get shape => '形狀';

  @override
  String get circle => '圓形';

  @override
  String get rectangle => '矩形';

  @override
  String get triangle => '三角形';

  @override
  String get line => '直線';

  @override
  String get cornerRadius => '圓角大小';

  @override
  String get topLeft => '左上角';

  @override
  String get topRight => '右上角';

  @override
  String get bottomLeft => '左下角';

  @override
  String get bottomRight => '右下角';

  @override
  String get caches => '快取';

  @override
  String get manage => '管理';

  @override
  String get clearCaches => '清除快取';

  @override
  String get createCache => '建立快取';

  @override
  String get thirdPartyLicenses => '第三方授權';

  @override
  String get syncing => '同步中……';

  @override
  String get synced => '已同步';

  @override
  String get notSynced => '未同步';

  @override
  String get conflict => '衝突';

  @override
  String get keepLocal => '保留在本機';

  @override
  String get keepConnection => '保持連線';

  @override
  String get keepBoth => '兩者皆保留';

  @override
  String get forAll => '都保留';

  @override
  String fileConflict(String file, String connection) {
    return '「$connection」中的「$file」有衝突';
  }

  @override
  String get offline => '離線';

  @override
  String get localLatest => '本機最新';

  @override
  String get connectionLatest => '連線最新';

  @override
  String get path => '路徑';

  @override
  String get folderSynced => '已同步資料夾';

  @override
  String get syncRootDirectory => '同步根目錄';

  @override
  String get penOnlyInput => '只讓筆輸入';

  @override
  String get inputGestures => '手勢輸入';

  @override
  String get nativeTitleBar => '原生標題列';

  @override
  String get syncMode => '同步模式';

  @override
  String get connection => '連線';

  @override
  String get always => '一律';

  @override
  String get noMobile => '沒有行動裝置';

  @override
  String get manual => '手動';

  @override
  String get search => '搜尋';

  @override
  String get properties => '屬性';

  @override
  String get pin => '釘選';

  @override
  String get unpin => '取消釘選';

  @override
  String get element => '元素';

  @override
  String get painter => '畫具';

  @override
  String get position => '位置';

  @override
  String get note => '筆記';

  @override
  String get packs => '素材包';

  @override
  String get pack => '素材包';

  @override
  String get more => '更多';

  @override
  String get askForName => '討取名稱';

  @override
  String areaIndex(int index) {
    return '分區 $index';
  }

  @override
  String get startInFullScreen => '以全螢幕啟動';

  @override
  String get inputs => '輸入';

  @override
  String get mouse => '滑鼠';

  @override
  String get touch => '觸控';

  @override
  String get keyboard => '鍵盤';

  @override
  String get shortcuts => 'Shortcuts';

  @override
  String get middle => '中';

  @override
  String get first => '第一';

  @override
  String get second => '第二';

  @override
  String get tools => '工具';

  @override
  String get showGrid => '顯示格線';

  @override
  String get grid => '格線';

  @override
  String get ruler => '標尺';

  @override
  String get angle => '角度';

  @override
  String get report => '報告';

  @override
  String get newFolder => '建新資料夾';

  @override
  String get createPack => '建立素材包';

  @override
  String get editPack => '編輯素材包';

  @override
  String get packsDirectory => '素材包目錄';

  @override
  String get stamp => '圖章';

  @override
  String get addToPack => '加入素材包';

  @override
  String get sureImportPack => '確定要匯入素材包嗎？';

  @override
  String byAuthor(String author) {
    return '作者：$author';
  }

  @override
  String get author => '作者';

  @override
  String get addAsset => '新增素材';

  @override
  String get editAsset => '編輯素材';

  @override
  String get scope => '範圍';

  @override
  String get noPacks => '目前沒有能用的素材包';

  @override
  String get components => '元件';

  @override
  String get waypoint => '定位點';

  @override
  String get actions => 'Actions';

  @override
  String get painters => 'Painters';

  @override
  String get breakingChangesTitle => '重大更新';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return '此版本有重大更新。請在更新前閱讀更新紀錄。目前的檔案是第 $version 版，新版本爲第 $newVersion 版。';
  }

  @override
  String get styles => '樣式';

  @override
  String get paragraph => '段落';

  @override
  String get fontFamily => '字族';

  @override
  String get smoothing => '平滑化';

  @override
  String get streamline => '流線化';

  @override
  String get presentation => '簡報';

  @override
  String get selectAsset => '選擇素材';

  @override
  String get clearStyle => '清除樣式';

  @override
  String get unknownImportType => '未知的匯入類型';

  @override
  String get sureImportTemplate => '確定要刪除此模板嗎？';

  @override
  String get frame => '影格';

  @override
  String get play => '播放';

  @override
  String get video => '影片';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => '暫停點';

  @override
  String get presentationControls => '操控簡報';

  @override
  String get nextSlide => '下一張投影片';

  @override
  String get nextSlideDescription => '向右滑動或按箭頭右鍵可以移至下一張投影片';

  @override
  String get previousSlide => '上一張投影片';

  @override
  String get previousSlideDescription => '向左滑動或按箭頭左鍵可以移至下一張投影片';

  @override
  String get exitPresentation => '退出簡報';

  @override
  String get exitPresentationDescription => '按逸出鍵（ESC 鍵）或向下滑動可以退出簡報';

  @override
  String get pausePresentation => '暫停簡報';

  @override
  String get pausePresentationDescription => '點選螢幕或按空格鍵可以暫停或繼續簡報';

  @override
  String get keyframe => '關鍵畫面';

  @override
  String get endOfPresentation => '已到達簡報結尾';

  @override
  String get startOfPresentation => '已到達簡報開頭';

  @override
  String get palettes => '調色板';

  @override
  String headline(int index) {
    return '標題 $index';
  }

  @override
  String get code => '程式碼';

  @override
  String get quote => '引述';

  @override
  String get link => '鏈結';

  @override
  String get checkbox => '核取方塊';

  @override
  String get deleted => '已刪除';

  @override
  String get emphasis => '強調';

  @override
  String get listBullet => '項目符號';

  @override
  String get strong => 'Strong';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => '首頁';

  @override
  String get files => '檔案';

  @override
  String get sortBy => '排序方式';

  @override
  String get location => '位置';

  @override
  String get whatsNew => '有什麼新鮮事？';

  @override
  String get unstar => '取消星號';

  @override
  String get star => '星號';

  @override
  String get goUp => '回上一層';

  @override
  String get created => '建立之時';

  @override
  String get modified => '修改之時';

  @override
  String get quickstart => '快速開始';

  @override
  String get noTemplates => '目前沒有模板能用';

  @override
  String get importCorePack => '匯入核心素材包';

  @override
  String get importCorePackDescription =>
      '匯入包含所有基本素材的核心素材包，以便開始使用。這會覆寫目前的核心素材包。';

  @override
  String get never => '永不';

  @override
  String get onlyOnUpdates => '更新後';

  @override
  String get visibility => '顯示條件';

  @override
  String get captureThumbnail => '擷爲縮圖';

  @override
  String get capturedThumbnail => '已擷爲縮圖';

  @override
  String get chooseLabelMode => '選擇標記模式';

  @override
  String get foreground => '前景';

  @override
  String get version => '版本';

  @override
  String get repository => '儲存庫';

  @override
  String get pages => '頁面';

  @override
  String get navigator => '導覽';

  @override
  String get arrange => '排列';

  @override
  String get bringToFront => '提至頂層';

  @override
  String get sendToBack => '推至底層';

  @override
  String get bringForward => '上提一層';

  @override
  String get sendBackward => '下推一層';

  @override
  String get rotation => 'Rotation';

  @override
  String get onlyAvailableLargerScreen => '僅適用於大螢幕設備';

  @override
  String get toolbarPosition => '工具列位置';

  @override
  String get rotate => 'Rotate';

  @override
  String get spacer => '間隔';

  @override
  String get navigationRail => '導覽杆';

  @override
  String get cut => '剪下';

  @override
  String get insertBefore => 'Insert before';

  @override
  String get insertAfter => 'Insert after';

  @override
  String get insertFirst => 'Insert first';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => '貼上';

  @override
  String get ascending => 'Ascending';

  @override
  String get descending => 'Descending';

  @override
  String get imageScale => '圖片縮放';

  @override
  String get select => '選擇';

  @override
  String get tool => '工具';

  @override
  String get texture => '紋理';

  @override
  String get platformTheme => '平台主題';

  @override
  String get desktop => '電腦';

  @override
  String get mobile => '手機';

  @override
  String get pdfQuality => 'PDF 品質';

  @override
  String get surface => 'Surface';

  @override
  String get pattern => '圖案';

  @override
  String get sureClose => '您確定要關閉此文件嗎？';

  @override
  String get thereAreUnsavedChanges => '此處有未儲存的變更';

  @override
  String get page => '頁面';

  @override
  String get iceServers => 'ICE Servers';

  @override
  String get collaboration => 'Collaboration';

  @override
  String get webRtc => '';

  @override
  String get webSocket => 'Web Socket';

  @override
  String get iceServer => 'ICE Server';

  @override
  String get port => 'Port';

  @override
  String get type => 'Type';

  @override
  String get side => 'Side';

  @override
  String get client => 'Client';

  @override
  String get server => 'Server';

  @override
  String get switchView => 'Switch View';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'Hide UI';

  @override
  String get density => 'Density';

  @override
  String get compact => 'Compact';

  @override
  String get comfortable => 'Comfortable';

  @override
  String get standard => 'Standard';

  @override
  String get lock => 'Lock';

  @override
  String get addElement => 'Add element';

  @override
  String get notDefaultConnection => 'Not default connection';

  @override
  String get defaultConnection => 'Default connection';

  @override
  String get hide => 'Hide';

  @override
  String get show => 'Show';

  @override
  String get pause => 'Pause';

  @override
  String get stop => 'Stop';

  @override
  String get refresh => 'Refresh';

  @override
  String get print => 'Print';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Eye dropper';

  @override
  String get users => 'Users';

  @override
  String get experiments => 'Experiments';

  @override
  String get address => 'Address';

  @override
  String get spreadToPages => 'Spread to pages';

  @override
  String get rootDirectorySpecifiedDescription =>
      'The root directory is specified. All advanced directory paths will be relative to this directory. Keep it empty to disable this directory type.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'The root directory is not specified. A name is required. All advanced directory paths will be absolute. Keep it empty to disable this directory type.';

  @override
  String get unsecureConnectionTitle => 'Unsecure connection';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'The connection is not secure. This can be a security risk. Please only continue if you trust the connection. The sha1 fingerprint is $fingerprint.';
  }

  @override
  String get continueAnyway => 'Continue anyway';

  @override
  String get zoomControl => 'Zoom control';

  @override
  String get highContrast => 'High contrast';

  @override
  String get shouldANumber => 'This value should be valid number';

  @override
  String get createAreas => 'Create areas';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Operations';

  @override
  String get medium => 'Medium';

  @override
  String get large => 'Large';

  @override
  String get toolbarSize => 'Toolbar size';

  @override
  String get addAll => 'Add all';

  @override
  String get onlyCurrentPage => 'Only current page';

  @override
  String get smoothNavigation => 'Smooth navigation';

  @override
  String get exact => 'Exact';

  @override
  String get inline => 'Inline';

  @override
  String get toolbarRows => 'Toolbar rows';

  @override
  String get pointerTest => 'Pointer test';

  @override
  String get pressure => 'Pressure';

  @override
  String get small => 'Small';

  @override
  String get tiny => 'Tiny';

  @override
  String get selectAll => 'Select all';

  @override
  String get overrideTools => 'Override tools';

  @override
  String get hideCursorWhileDrawing => 'Hide cursor while drawing';

  @override
  String get installed => 'Installed';

  @override
  String get install => 'Install';

  @override
  String get deselect => 'Deselect';

  @override
  String get changeCollection => 'Change collection';

  @override
  String get collections => 'Collections';

  @override
  String get fullSelection => 'Full selection';

  @override
  String get fullSelectionDescription =>
      'Requires elements to be fully within the selection box for selection.';

  @override
  String get collection => 'Collection';

  @override
  String get defaultCollection => 'Default collection';

  @override
  String get scroll => 'Scroll';

  @override
  String get onStartup => 'On startup';

  @override
  String get homeScreen => 'Home screen';

  @override
  String get lastNote => 'Last note';

  @override
  String get newNote => 'New note';

  @override
  String get convertToLayer => 'Convert to layer';

  @override
  String get merge => 'Merge';

  @override
  String get up => 'Up';

  @override
  String get down => 'Down';

  @override
  String get other => 'Other';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elements',
      one: '1 element',
      zero: 'No elements',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Color toolbar';

  @override
  String get yesButShowButtons => 'Yes, but show buttons';

  @override
  String get optionsPanelPosition => 'Options panel position';

  @override
  String get hideDuration => 'Hide duration';

  @override
  String get animation => 'Animation';

  @override
  String get performance => 'Performance';

  @override
  String get performanceDescription =>
      'Optimized for speed and memory usage. Only the visible portion of the note is baked into the image.';

  @override
  String get normalDescription =>
      'Balances quality and performance. Bakes an image covering 1.5 times the visible area, providing smoother transitions when scrolling.';

  @override
  String get high => 'High';

  @override
  String get highDescription =>
      'Description: Maximizes quality at the cost of performance. Bakes an image covering 2 times the visible area, ensuring seamless rendering even during rapid scrolling or zooming.';

  @override
  String get renderResolution => 'Render resolution';

  @override
  String get translate => 'Translate';

  @override
  String get unencrypted => 'Unencrypted';

  @override
  String get encrypted => 'Encrypted';

  @override
  String get encryptDocumentMessage => 'Click to encrypt the document';

  @override
  String get unencryptDocumentMessage => 'Click to unencrypt the document';

  @override
  String get unencrypt => 'Unencrypt';

  @override
  String get encrypt => 'Encrypt';

  @override
  String get encryptWarning =>
      'This will encrypt the document. You will need to remember the password to decrypt it.';

  @override
  String get unencryptWarning =>
      'This will unencrypt the document. The password will be removed and everyone with access will be able to open it.';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get passwordMismatch => 'The passwords do not match';

  @override
  String get action => 'Action';

  @override
  String get svgText => 'SVG Text';

  @override
  String get offset => 'Offset';
}
