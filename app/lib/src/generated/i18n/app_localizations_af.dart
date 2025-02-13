// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Afrikaans (`af`).
class AppLocalizationsAf extends AppLocalizations {
  AppLocalizationsAf([String locale = 'af']) : super(locale);

  @override
  String get open => 'Open';

  @override
  String get settings => 'Settings';

  @override
  String get personalization => 'Personalization';

  @override
  String get theme => 'Theme';

  @override
  String get darkTheme => 'Dark theme';

  @override
  String get lightTheme => 'Light theme';

  @override
  String get systemTheme => 'Use default system theme';

  @override
  String get view => 'View';

  @override
  String get edit => 'Edit';

  @override
  String get export => 'Export';

  @override
  String get save => 'Save';

  @override
  String get zoom => 'Zoom';

  @override
  String get zoomIn => 'Zoom in';

  @override
  String get zoomOut => 'Zoom out';

  @override
  String get resetZoom => 'Reset zoom';

  @override
  String get strokeWidth => 'Stroke width';

  @override
  String get includeEraser => 'Include eraser?';

  @override
  String get thinning => 'Thinning';

  @override
  String get pen => 'Pen';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Path eraser';

  @override
  String get label => 'Label';

  @override
  String get delete => 'Delete';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get reallyDelete => 'Do you really want to delete this item?';

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get undo => 'Undo';

  @override
  String get redo => 'Redo';

  @override
  String get general => 'General';

  @override
  String get copyTitle => 'Copied to clipboard';

  @override
  String get loading => 'Loading...';

  @override
  String get enterText => 'Enter the text';

  @override
  String get size => 'Size';

  @override
  String get width => 'Width';

  @override
  String get height => 'Height';

  @override
  String get count => 'Count';

  @override
  String get space => 'Space';

  @override
  String get background => 'Background';

  @override
  String get box => 'Box';

  @override
  String get locale => 'Locale';

  @override
  String get systemLocale => 'System locale';

  @override
  String get information => 'Information';

  @override
  String get license => 'License';

  @override
  String get imprint => 'Imprint';

  @override
  String get privacypolicy => 'Privacy policy';

  @override
  String get source => 'Source';

  @override
  String get documentation => 'Documentation';

  @override
  String get changelog => 'Changelog';

  @override
  String get existOverride => 'This element already exist. Overwrite?';

  @override
  String get description => 'Description';

  @override
  String get fill => 'Fill';

  @override
  String get defaultPalette => 'Default palette';

  @override
  String get highlighter => 'Highlighter';

  @override
  String get add => 'Add';

  @override
  String get remove => 'Remove';

  @override
  String get removeConfirm => 'Do you really want to remove this?';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => 'Custom';

  @override
  String get decoration => 'Decoration';

  @override
  String get underline => 'Underline';

  @override
  String get overline => 'Overline';

  @override
  String get strikethrough => 'Strikethrough';

  @override
  String get thickness => 'Thickness';

  @override
  String get style => 'Style';

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
  String get fontWeight => 'Font weight';

  @override
  String get normal => 'Normal';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Clipboard';

  @override
  String get file => 'File';

  @override
  String get data => 'Data';

  @override
  String get share => 'Share';

  @override
  String get spacing => 'Spacing';

  @override
  String get image => 'Image';

  @override
  String get enterUrl => 'Enter the url';

  @override
  String get scale => 'Scale';

  @override
  String get help => 'Help';

  @override
  String get reallyReset => 'Do you really want to reset it?';

  @override
  String get whatToDo => 'What do you want to do?';

  @override
  String get ignore => 'Ignore';

  @override
  String get backup => 'Backup';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'The file $fileName was created in a newer version ($fileVersion). What should be done with this file?';
  }

  @override
  String get waypoints => 'Waypoints';

  @override
  String get origin => 'Origin';

  @override
  String get import => 'Import';

  @override
  String get newContent => 'New';

  @override
  String get selectElement => 'Select element';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Shift';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Copy version';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Behaviors';

  @override
  String get dataDirectory => 'Data directory';

  @override
  String get defaultPath => 'Default path';

  @override
  String get dateFormat => 'Date format';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Updated at: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Created at: $dateTimeString';
  }

  @override
  String get rename => 'Rename';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => 'Hand';

  @override
  String get folder => 'Folder';

  @override
  String get move => 'Move';

  @override
  String get copy => 'Copy';

  @override
  String get back => 'Back';

  @override
  String get zoomDependent => 'Zoom dependent';

  @override
  String get shapeDetection => 'Shape Detection';

  @override
  String get delay => 'Delay';

  @override
  String get defaultLayer => 'Default layer';

  @override
  String get layer => 'Layer';

  @override
  String get layers => 'Layers';

  @override
  String get notSet => 'Not set';

  @override
  String get enterLayer => 'Enter the layer name';

  @override
  String get selectElements => 'Select elements';

  @override
  String get deleteElements => 'Delete elements';

  @override
  String get deleteElementsConfirm =>
      'Do you really want to delete the selected elements?';

  @override
  String get selectCustomCollection => 'Select a custom collection';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => 'Sensitivity';

  @override
  String get sensitivityHint =>
      'The higher the value, the more sensitive the input';

  @override
  String get horizontal => 'Horizontal';

  @override
  String get vertical => 'Vertical';

  @override
  String get plain => 'Plain';

  @override
  String get light => 'Light';

  @override
  String get ruled => 'Ruled';

  @override
  String get quad => 'Quad';

  @override
  String get music => 'Music';

  @override
  String get dark => 'Dark';

  @override
  String get plainDark => 'Dark';

  @override
  String get ruledDark => 'Ruled dark';

  @override
  String get quadDark => 'Quad dark';

  @override
  String get musicDark => 'Music dark';

  @override
  String get templates => 'Templates';

  @override
  String get untitled => 'Untitled';

  @override
  String get createTemplate => 'Create template';

  @override
  String get createTemplateContent =>
      'Do you really want to create a template from this document? The original document will get deleted.';

  @override
  String get replace => 'Replace';

  @override
  String get reallyReplace =>
      'Do you really want to replace the template? This operation can be not undone!';

  @override
  String get defaultTemplate => 'Default template';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'Document';

  @override
  String get camera => 'Camera';

  @override
  String get printout => 'Printout';

  @override
  String get selectCamera => 'Select a camera';

  @override
  String get changeDocumentPath => 'Change document path';

  @override
  String get deleteWholeStroke => 'Delete whole stroke';

  @override
  String get alpha => 'Alpha';

  @override
  String get area => 'Area';

  @override
  String get selectArea => 'Select an area';

  @override
  String get aspectRatio => 'Aspect ratio';

  @override
  String get presets => 'Presets';

  @override
  String get pagePortrait => 'Page portrait';

  @override
  String get pageLandscape => 'Page landscape';

  @override
  String get square => 'Square';

  @override
  String get areas => 'Areas';

  @override
  String get enterArea => 'Enter the area';

  @override
  String get exitArea => 'Exit the area';

  @override
  String get currentArea => 'Current area';

  @override
  String get design => 'Design';

  @override
  String get text => 'Text';

  @override
  String welcome(String codeName) {
    return 'Hey, this is Linwood Butterfly';
  }

  @override
  String get welcomeContent => 'A free and open-source drawing space!';

  @override
  String updated(String version) {
    return 'App updated to version $version';
  }

  @override
  String get releaseNotes => 'Release notes';

  @override
  String get constraints => 'Constraints';

  @override
  String get scaled => 'Scaled';

  @override
  String get fixed => 'Fixed';

  @override
  String get dynamicContent => 'Dynamic';

  @override
  String get none => 'None';

  @override
  String get includeArea => 'Include area';

  @override
  String get verticalAlignment => 'Vertical alignment';

  @override
  String get horizontalAlignment => 'Horizontal alignment';

  @override
  String get top => 'Top';

  @override
  String get center => 'Center';

  @override
  String get bottom => 'Bottom';

  @override
  String get left => 'Left';

  @override
  String get right => 'Right';

  @override
  String get justify => 'Justify';

  @override
  String get constraint => 'Constraint';

  @override
  String get length => 'Length';

  @override
  String get exportSvg => 'Export SVG';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => 'Select pages';

  @override
  String get recentFiles => 'Recent files';

  @override
  String get start => 'Start';

  @override
  String get noRecentFiles => 'No recent files';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '1 page',
      zero: 'No pages',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Page $index';
  }

  @override
  String get exit => 'Exit';

  @override
  String get noElements => 'No elements';

  @override
  String get invertSelection => 'Invert selection';

  @override
  String get errorWhileImporting => 'Error while importing';

  @override
  String get errorWhileImportingContent =>
      'An error occurred while importing the file';

  @override
  String get showDetails => 'Show details';

  @override
  String get hideDetails => 'Hide details';

  @override
  String get error => 'Error';

  @override
  String get stackTrace => 'Stack trace';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Duration';

  @override
  String get quality => 'Quality';

  @override
  String get exportPdf => 'Export PDF';

  @override
  String get local => 'Local';

  @override
  String get addConnection => 'Add connection';

  @override
  String get connections => 'Connections';

  @override
  String get noConnections => 'No connections';

  @override
  String get url => 'URL';

  @override
  String get connect => 'Connect';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get webNotSupported => 'Web not supported';

  @override
  String get advanced => 'Advanced';

  @override
  String get directory => 'Directory';

  @override
  String get documentsDirectory => 'Documents directory';

  @override
  String get templatesDirectory => 'Templates directory';

  @override
  String get errorWhileCreatingConnection => 'Error while creating connection';

  @override
  String get cannotConnect => 'Cannot connect';

  @override
  String get urlNotValid => 'URL not valid';

  @override
  String get icon => 'Icon';

  @override
  String get update => 'Update';

  @override
  String get updateAvailable => 'Update available';

  @override
  String get stable => 'Stable';

  @override
  String get nightly => 'Nightly';

  @override
  String get checkForUpdates => 'Check for updates';

  @override
  String get checkForUpdatesWarning =>
      'Performing a check for updates will connect to the Butterfly website to get the information.';

  @override
  String get usingLatestStable => 'You are using the latest stable version';

  @override
  String get usingLatestNightly => 'You are using the latest nightly version';

  @override
  String get currentVersion => 'Current version';

  @override
  String get updateNow => 'Update now';

  @override
  String get shape => 'Shape';

  @override
  String get circle => 'Circle';

  @override
  String get rectangle => 'Rectangle';

  @override
  String get triangle => 'Triangle';

  @override
  String get line => 'Line';

  @override
  String get cornerRadius => 'Corner radius';

  @override
  String get topLeft => 'Top left';

  @override
  String get topRight => 'Top right';

  @override
  String get bottomLeft => 'Bottom left';

  @override
  String get bottomRight => 'Bottom right';

  @override
  String get caches => 'Caches';

  @override
  String get manage => 'Manage';

  @override
  String get clearCaches => 'Clear caches';

  @override
  String get createCache => 'Create cache';

  @override
  String get thirdPartyLicenses => 'Third party licenses';

  @override
  String get syncing => 'Syncing...';

  @override
  String get synced => 'Synced';

  @override
  String get notSynced => 'Not synced';

  @override
  String get conflict => 'Conflict';

  @override
  String get keepLocal => 'Keep local';

  @override
  String get keepConnection => 'Keep connection';

  @override
  String get keepBoth => 'Keep both';

  @override
  String get forAll => 'For all';

  @override
  String fileConflict(String file, String connection) {
    return '$file in $connection has a conflict';
  }

  @override
  String get offline => 'Offline';

  @override
  String get localLatest => 'Local latest';

  @override
  String get connectionLatest => 'Connection latest';

  @override
  String get path => 'Path';

  @override
  String get folderSynced => 'Folder synced';

  @override
  String get syncRootDirectory => 'Sync root directory';

  @override
  String get penOnlyInput => 'Pen only input';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Native title bar';

  @override
  String get syncMode => 'Sync mode';

  @override
  String get connection => 'Connection';

  @override
  String get always => 'Always';

  @override
  String get noMobile => 'No mobile';

  @override
  String get manual => 'Manual';

  @override
  String get search => 'Search';

  @override
  String get properties => 'Properties';

  @override
  String get pin => 'Pin';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Element';

  @override
  String get painter => 'Painter';

  @override
  String get position => 'Position';

  @override
  String get note => 'Note';

  @override
  String get packs => 'Packs';

  @override
  String get pack => 'Pack';

  @override
  String get more => 'More';

  @override
  String get askForName => 'Ask for name';

  @override
  String areaIndex(int index) {
    return 'Area $index';
  }

  @override
  String get startInFullScreen => 'Start in full screen';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Mouse';

  @override
  String get touch => 'Touch';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Shortcuts';

  @override
  String get middle => 'Middle';

  @override
  String get first => 'First';

  @override
  String get second => 'Second';

  @override
  String get tools => 'Tools';

  @override
  String get showGrid => 'Show grid';

  @override
  String get grid => 'Grid';

  @override
  String get ruler => 'Ruler';

  @override
  String get angle => 'Angle';

  @override
  String get report => 'Report';

  @override
  String get newFolder => 'New folder';

  @override
  String get createPack => 'Create pack';

  @override
  String get editPack => 'Edit pack';

  @override
  String get packsDirectory => 'Packs directory';

  @override
  String get stamp => 'Stamp';

  @override
  String get addToPack => 'Add to pack';

  @override
  String get sureImportPack => 'Are you sure you want to import the pack?';

  @override
  String byAuthor(String author) {
    return 'by $author';
  }

  @override
  String get author => 'Author';

  @override
  String get addAsset => 'Add asset';

  @override
  String get editAsset => 'Edit asset';

  @override
  String get scope => 'Scope';

  @override
  String get noPacks => 'There are currently no packs available';

  @override
  String get components => 'Components';

  @override
  String get waypoint => 'Waypoint';

  @override
  String get actions => 'Actions';

  @override
  String get painters => 'Painters';

  @override
  String get breakingChangesTitle => 'Breaking changes';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'There are breaking changes in this version. Please read the changelog before updating. The current file version is $version, the new version is $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Paragraph';

  @override
  String get fontFamily => 'Font family';

  @override
  String get smoothing => 'Smoothing';

  @override
  String get streamline => 'Streamline';

  @override
  String get presentation => 'Presentation';

  @override
  String get selectAsset => 'Select asset';

  @override
  String get clearStyle => 'Clear style';

  @override
  String get unknownImportType => 'Unknown import type';

  @override
  String get sureImportTemplate =>
      'Are you sure you want to import the template?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Play';

  @override
  String get video => 'Video';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Breakpoint';

  @override
  String get presentationControls => 'Presentation controls';

  @override
  String get nextSlide => 'Next slide';

  @override
  String get nextSlideDescription =>
      'Swipe to the right or press the right arrow key to go to the next slide';

  @override
  String get previousSlide => 'Previous slide';

  @override
  String get previousSlideDescription =>
      'Swipe to the left or press the left arrow key to go to the previous slide';

  @override
  String get exitPresentation => 'Exit presentation';

  @override
  String get exitPresentationDescription =>
      'Press the escape key or swipe down to exit the presentation';

  @override
  String get pausePresentation => 'Pause presentation';

  @override
  String get pausePresentationDescription =>
      'Tap the screen or press the space bar to pause or resume the presentation';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation =>
      'You have reached the end of the presentation';

  @override
  String get startOfPresentation =>
      'You have reached the start of the presentation';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Headline $index';
  }

  @override
  String get code => 'Code';

  @override
  String get quote => 'Quote';

  @override
  String get link => 'Link';

  @override
  String get checkbox => 'Checkbox';

  @override
  String get deleted => 'Deleted';

  @override
  String get emphasis => 'Emphasis';

  @override
  String get listBullet => 'List bullet';

  @override
  String get strong => 'Strong';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Home';

  @override
  String get files => 'Files';

  @override
  String get sortBy => 'Sort by';

  @override
  String get location => 'Location';

  @override
  String get whatsNew => 'What\'s new?';

  @override
  String get unstar => 'Unstar';

  @override
  String get star => 'Star';

  @override
  String get goUp => 'Go up';

  @override
  String get created => 'Created';

  @override
  String get modified => 'Modified';

  @override
  String get quickstart => 'Quickstart';

  @override
  String get noTemplates => 'There are currently no templates available';

  @override
  String get importCorePack => 'Import core pack';

  @override
  String get importCorePackDescription =>
      'Import the core pack that contains all basic assets to get started. This will override the current core pack.';

  @override
  String get never => 'Never';

  @override
  String get onlyOnUpdates => 'Only on updates';

  @override
  String get visibility => 'Visibility';

  @override
  String get captureThumbnail => 'Capture thumbnail';

  @override
  String get capturedThumbnail => 'Successfully captured thumbnail';

  @override
  String get chooseLabelMode => 'Choose label mode';

  @override
  String get foreground => 'Foreground';

  @override
  String get version => 'Version';

  @override
  String get repository => 'Repository';

  @override
  String get pages => 'Pages';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Arrange';

  @override
  String get bringToFront => 'Bring to front';

  @override
  String get sendToBack => 'Send to back';

  @override
  String get bringForward => 'Bring forward';

  @override
  String get sendBackward => 'Send backward';

  @override
  String get rotation => 'Rotation';

  @override
  String get onlyAvailableLargerScreen => 'Only available on larger screens';

  @override
  String get toolbarPosition => 'Toolbar position';

  @override
  String get rotate => 'Rotate';

  @override
  String get spacer => 'Spacer';

  @override
  String get navigationRail => 'Navigation rail';

  @override
  String get cut => 'Cut';

  @override
  String get insertBefore => 'Insert before';

  @override
  String get insertAfter => 'Insert after';

  @override
  String get insertFirst => 'Insert first';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Paste';

  @override
  String get ascending => 'Ascending';

  @override
  String get descending => 'Descending';

  @override
  String get imageScale => 'Image scale';

  @override
  String get select => 'Select';

  @override
  String get tool => 'Tool';

  @override
  String get texture => 'Texture';

  @override
  String get platformTheme => 'Platform theme';

  @override
  String get desktop => 'Desktop';

  @override
  String get mobile => 'Mobile';

  @override
  String get pdfQuality => 'PDF quality';

  @override
  String get surface => 'Surface';

  @override
  String get pattern => 'Pattern';

  @override
  String get sureClose => 'Are you sure you want to close the document?';

  @override
  String get thereAreUnsavedChanges => 'There are unsaved changes';

  @override
  String get page => 'Page';

  @override
  String get iceServers => 'ICE Servers';

  @override
  String get collaboration => 'Collaboration';

  @override
  String get webRtc => 'Web RTC';

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

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
