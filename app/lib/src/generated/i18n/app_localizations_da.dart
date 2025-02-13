// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get open => 'Åbn';

  @override
  String get settings => 'Indstillinger';

  @override
  String get personalization => 'Personliggørelse';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Mørkt tema';

  @override
  String get lightTheme => 'Lyst tema';

  @override
  String get systemTheme => 'Brug standard-systemtema';

  @override
  String get view => 'Vis';

  @override
  String get edit => 'Rediger';

  @override
  String get export => 'Eksporter';

  @override
  String get save => 'Gem';

  @override
  String get zoom => 'Zoom';

  @override
  String get zoomIn => 'Zoom ind';

  @override
  String get zoomOut => 'Zoom ud';

  @override
  String get resetZoom => 'Reset zoom';

  @override
  String get strokeWidth => 'Slaglængde';

  @override
  String get includeEraser => 'Inkludér viskelæder?';

  @override
  String get thinning => 'Udtynding';

  @override
  String get pen => 'Pen';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Sti viskelæder';

  @override
  String get label => 'Etiket';

  @override
  String get delete => 'Slet';

  @override
  String get areYouSure => 'Er du sikker?';

  @override
  String get reallyDelete => 'Sikker på, at du vil slette dette element?';

  @override
  String get no => 'Nej';

  @override
  String get yes => 'Ja';

  @override
  String get undo => 'Fortryd';

  @override
  String get redo => 'Gendan';

  @override
  String get general => 'Generelt';

  @override
  String get copyTitle => 'Kopieret til udklipsholder';

  @override
  String get loading => 'Indlæser...';

  @override
  String get enterText => 'Indtast teksten';

  @override
  String get size => 'Størrelse';

  @override
  String get width => 'Width';

  @override
  String get height => 'Højde';

  @override
  String get count => 'Antal';

  @override
  String get space => 'Mellemrum';

  @override
  String get background => 'Baggrund';

  @override
  String get box => 'Boks';

  @override
  String get locale => 'Landestandard';

  @override
  String get systemLocale => 'System landestandard';

  @override
  String get information => 'Information';

  @override
  String get license => 'Licens';

  @override
  String get imprint => 'Imprint';

  @override
  String get privacypolicy => 'Privatliv politik';

  @override
  String get source => 'Kilde';

  @override
  String get documentation => 'Dokumentation';

  @override
  String get changelog => 'Ændringslog';

  @override
  String get existOverride => 'Dette element eksisterer allerede. Overskriv?';

  @override
  String get description => 'Varebeskrivelse';

  @override
  String get fill => 'Udfyld';

  @override
  String get defaultPalette => 'Standard palet';

  @override
  String get highlighter => 'Fremhævning';

  @override
  String get add => 'Tilføj';

  @override
  String get remove => 'Fjern';

  @override
  String get removeConfirm => 'Vil du virkelig fjerne dette?';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => 'Tilpasset';

  @override
  String get decoration => 'Dekoration';

  @override
  String get underline => 'Understreget';

  @override
  String get overline => 'Overstregning';

  @override
  String get strikethrough => 'Gennemstreget';

  @override
  String get thickness => 'Tykkelse';

  @override
  String get style => 'Stil';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Dobbelt';

  @override
  String get dotted => 'Stiplet';

  @override
  String get dashed => 'Stiplet';

  @override
  String get wavy => 'Bølget';

  @override
  String get fontWeight => 'Skrifttype vægt';

  @override
  String get normal => 'Normal';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Udklipsholder';

  @override
  String get file => 'Fil';

  @override
  String get data => 'Data';

  @override
  String get share => 'Del';

  @override
  String get spacing => 'Afstand';

  @override
  String get image => 'Billede';

  @override
  String get enterUrl => 'Angiv URL';

  @override
  String get scale => 'Skaler';

  @override
  String get help => 'Hjælp';

  @override
  String get reallyReset => 'Vil du virkelig nulstille den?';

  @override
  String get whatToDo => 'Hvad vil du gøre?';

  @override
  String get ignore => 'Ignorer';

  @override
  String get backup => 'Sikkerhedskopi';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'Filen $fileName blev oprettet i en nyere version ($fileVersion). Hvad skal der gøres med denne fil?';
  }

  @override
  String get waypoints => 'Waypoints';

  @override
  String get origin => 'Oprindelse';

  @override
  String get import => 'Importér';

  @override
  String get newContent => 'Ny';

  @override
  String get selectElement => 'Vælg element';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Skift';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Kopier version';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Opførsel';

  @override
  String get dataDirectory => 'Data mappe';

  @override
  String get defaultPath => 'Standard sti';

  @override
  String get dateFormat => 'Dato format';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Opdateret på: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Oprettet den: $dateTimeString';
  }

  @override
  String get rename => 'Omdøb';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => 'Hånd';

  @override
  String get folder => 'Mappe';

  @override
  String get move => 'Flyt';

  @override
  String get copy => 'Kopiér';

  @override
  String get back => 'Tilbage';

  @override
  String get zoomDependent => 'Zoom afhængig';

  @override
  String get shapeDetection => 'Form- Detektering';

  @override
  String get delay => 'Forsinkelse';

  @override
  String get defaultLayer => 'Standard lag';

  @override
  String get layer => 'Lag';

  @override
  String get layers => 'Lag';

  @override
  String get notSet => 'Ikke angivet';

  @override
  String get enterLayer => 'Indtast lagets navn';

  @override
  String get selectElements => 'Vælg elementer';

  @override
  String get deleteElements => 'Slet elementer';

  @override
  String get deleteElementsConfirm =>
      'Vil du virkelig slette de valgte elementer?';

  @override
  String get selectCustomCollection => 'Vælg en brugerdefineret samling';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => 'Følsomhed';

  @override
  String get sensitivityHint => 'Jo højere værdi, jo mere følsom input';

  @override
  String get horizontal => 'Horisontal';

  @override
  String get vertical => 'Lodret';

  @override
  String get plain => 'Enkelt';

  @override
  String get light => 'Lys';

  @override
  String get ruled => 'Hersket';

  @override
  String get quad => 'Quad';

  @override
  String get music => 'Musik';

  @override
  String get dark => 'Mørk';

  @override
  String get plainDark => 'Mørk';

  @override
  String get ruledDark => 'Hersket mørk';

  @override
  String get quadDark => 'Quad mørk';

  @override
  String get musicDark => 'Mørk musik';

  @override
  String get templates => 'Skabeloner';

  @override
  String get untitled => 'Unavngivet';

  @override
  String get createTemplate => 'Opret skabelon';

  @override
  String get createTemplateContent =>
      'Vil du virkelig oprette en skabelon fra dette dokument? Originaldokumentet vil blive slettet.';

  @override
  String get replace => 'Erstat';

  @override
  String get reallyReplace =>
      'Vil du virkelig erstatte skabelonen? Denne handling kan ikke fortrydes!';

  @override
  String get defaultTemplate => 'Standard skabelon';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'Dokument';

  @override
  String get camera => 'Kamera';

  @override
  String get printout => 'Udskrift';

  @override
  String get selectCamera => 'Vælg et kamera';

  @override
  String get changeDocumentPath => 'Skift dokumentsti';

  @override
  String get deleteWholeStroke => 'Slet hele stregen';

  @override
  String get alpha => 'Alfa';

  @override
  String get area => 'Område';

  @override
  String get selectArea => 'Vælg et område';

  @override
  String get aspectRatio => 'Aspekt forhold';

  @override
  String get presets => 'Forudindstillinger';

  @override
  String get pagePortrait => 'Side stående';

  @override
  String get pageLandscape => 'Side liggende';

  @override
  String get square => 'Kvadrat';

  @override
  String get areas => 'Områder';

  @override
  String get enterArea => 'Indtast området';

  @override
  String get exitArea => 'Afslut området';

  @override
  String get currentArea => 'Aktuelt område';

  @override
  String get design => 'Design';

  @override
  String get text => 'Tekst';

  @override
  String welcome(String codeName) {
    return 'Hey, dette er Linwood Butterfly';
  }

  @override
  String get welcomeContent => 'Et gratis og open source tegneplads!';

  @override
  String updated(String version) {
    return 'App opdateret til version $version';
  }

  @override
  String get releaseNotes => 'Udgivelsesnoter';

  @override
  String get constraints => 'Restriktioner';

  @override
  String get scaled => 'Skaleret';

  @override
  String get fixed => 'Fast';

  @override
  String get dynamicContent => 'Dynamisk';

  @override
  String get none => 'Ingen';

  @override
  String get includeArea => 'Inkludér område';

  @override
  String get verticalAlignment => 'Lodret justering';

  @override
  String get horizontalAlignment => 'Horisontal justering';

  @override
  String get top => 'Øverst';

  @override
  String get center => 'Centreret';

  @override
  String get bottom => 'Bund';

  @override
  String get left => 'Venstre';

  @override
  String get right => 'Højre';

  @override
  String get justify => 'Justify';

  @override
  String get constraint => 'Begræns';

  @override
  String get length => 'Længde';

  @override
  String get exportSvg => 'Eksporter SVG';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => 'Vælg sider';

  @override
  String get recentFiles => 'Seneste filer';

  @override
  String get start => 'Start';

  @override
  String get noRecentFiles => 'Ingen seneste filer';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sider',
      one: '1 side',
      zero: 'Ingen sider',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Side $index';
  }

  @override
  String get exit => 'Afslut';

  @override
  String get noElements => 'Ingen elementer';

  @override
  String get invertSelection => 'Invertér valg';

  @override
  String get errorWhileImporting => 'Fejl under import';

  @override
  String get errorWhileImportingContent =>
      'Der opstod en fejl under import af filen';

  @override
  String get showDetails => 'Vis detaljer';

  @override
  String get hideDetails => 'Skjul detaljer';

  @override
  String get error => 'Fejl';

  @override
  String get stackTrace => 'Stak spor';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Varighed';

  @override
  String get quality => 'Kvalitet';

  @override
  String get exportPdf => 'Eksporter PDF';

  @override
  String get local => 'Lokal';

  @override
  String get addConnection => 'Tilføj forbindelse';

  @override
  String get connections => 'Forbindelser';

  @override
  String get noConnections => 'Ingen forbindelser';

  @override
  String get url => 'URL';

  @override
  String get connect => 'Forbind';

  @override
  String get username => 'Brugernavn';

  @override
  String get password => 'Adgangskode';

  @override
  String get webNotSupported => 'Web understøttes ikke';

  @override
  String get advanced => 'Avanceret';

  @override
  String get directory => 'Mappe';

  @override
  String get documentsDirectory => 'Dokumenter mappe';

  @override
  String get templatesDirectory => 'Mappe til skabeloner';

  @override
  String get errorWhileCreatingConnection =>
      'Fejl under oprettelse af forbindelse';

  @override
  String get cannotConnect => 'Kan ikke forbinde';

  @override
  String get urlNotValid => 'URL ugyldig';

  @override
  String get icon => 'Ikon';

  @override
  String get update => 'Opdater';

  @override
  String get updateAvailable => 'Opdatering tilgængelig';

  @override
  String get stable => 'Stabil';

  @override
  String get nightly => 'Natligt';

  @override
  String get checkForUpdates => 'Søg efter opdateringer';

  @override
  String get checkForUpdatesWarning =>
      'Udførelse af en check for opdateringer vil forbinde til Butterfly hjemmeside for at få oplysningerne.';

  @override
  String get usingLatestStable => 'Du bruger den seneste stabile version';

  @override
  String get usingLatestNightly => 'Du bruger den seneste natlige version';

  @override
  String get currentVersion => 'Nuværende version';

  @override
  String get updateNow => 'Opdater nu';

  @override
  String get shape => 'Form';

  @override
  String get circle => 'Cirkel';

  @override
  String get rectangle => 'Rektangel';

  @override
  String get triangle => 'Trekant';

  @override
  String get line => 'Linje';

  @override
  String get cornerRadius => 'Corner radius';

  @override
  String get topLeft => 'Øverst til venstre';

  @override
  String get topRight => 'Øverst til højre';

  @override
  String get bottomLeft => 'Nederst til venstre';

  @override
  String get bottomRight => 'Nederst til højre';

  @override
  String get caches => 'Cacher';

  @override
  String get manage => 'Administrer';

  @override
  String get clearCaches => 'Ryd caches';

  @override
  String get createCache => 'Opret cache';

  @override
  String get thirdPartyLicenses => 'Tredjeparts licenser';

  @override
  String get syncing => 'Synkroniserer...';

  @override
  String get synced => 'Synkroniseret';

  @override
  String get notSynced => 'Ikke synkroniseret';

  @override
  String get conflict => 'Konflikt';

  @override
  String get keepLocal => 'Behold lokal';

  @override
  String get keepConnection => 'Behold forbindelse';

  @override
  String get keepBoth => 'Behold begge';

  @override
  String get forAll => 'For alle';

  @override
  String fileConflict(String file, String connection) {
    return '$file i $connection har en konflikt';
  }

  @override
  String get offline => 'Offline';

  @override
  String get localLatest => 'Lokal seneste';

  @override
  String get connectionLatest => 'Forbindelse seneste';

  @override
  String get path => 'Sti';

  @override
  String get folderSynced => 'Mappe synkroniseret';

  @override
  String get syncRootDirectory => 'Synkroniser rodmappen';

  @override
  String get penOnlyInput => 'Kun pen input';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Lokal titellinje';

  @override
  String get syncMode => 'Synkroniser tilstand';

  @override
  String get connection => 'Forbindelse';

  @override
  String get always => 'Altid';

  @override
  String get noMobile => 'Ingen mobil';

  @override
  String get manual => 'Manuelt';

  @override
  String get search => 'Søg';

  @override
  String get properties => 'Egenskaber';

  @override
  String get pin => 'Fastgør';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Element';

  @override
  String get painter => 'Maler';

  @override
  String get position => 'Placering';

  @override
  String get note => 'Bemærkning';

  @override
  String get packs => 'Pakker';

  @override
  String get pack => 'Pakke';

  @override
  String get more => 'Mere';

  @override
  String get askForName => 'Bed om navn';

  @override
  String areaIndex(int index) {
    return 'Område $index';
  }

  @override
  String get startInFullScreen => 'Start i fuld skærm';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Mus';

  @override
  String get touch => 'Berøring';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Genveje';

  @override
  String get middle => 'Midterste';

  @override
  String get first => 'Første';

  @override
  String get second => 'Sekund';

  @override
  String get tools => 'Værktøjer';

  @override
  String get showGrid => 'Vis gitter';

  @override
  String get grid => 'Gitter';

  @override
  String get ruler => 'Lineal';

  @override
  String get angle => 'Vinkel';

  @override
  String get report => 'Rapport';

  @override
  String get newFolder => 'Ny mappe';

  @override
  String get createPack => 'Opret pakke';

  @override
  String get editPack => 'Rediger pakke';

  @override
  String get packsDirectory => 'Pakker mappe';

  @override
  String get stamp => 'Stempel';

  @override
  String get addToPack => 'Tilføj til pakke';

  @override
  String get sureImportPack => 'Er du sikker på du vil importere pakken?';

  @override
  String byAuthor(String author) {
    return 'af $author';
  }

  @override
  String get author => 'Forfatter';

  @override
  String get addAsset => 'Tilføj fil';

  @override
  String get editAsset => 'Rediger fil';

  @override
  String get scope => 'Anvendelsesområde';

  @override
  String get noPacks => 'Der er i øjeblikket ingen tilgængelige pakker';

  @override
  String get components => 'Komponenter';

  @override
  String get waypoint => 'Waypoint';

  @override
  String get actions => 'Handlinger';

  @override
  String get painters => 'Malere';

  @override
  String get breakingChangesTitle => 'Breaking ændringer';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Der er ændringer i denne version. Læs ændringsloggen før du opdaterer. Den aktuelle filversion er $version, den nye version er $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Afsnit';

  @override
  String get fontFamily => 'Skrifttype familie';

  @override
  String get smoothing => 'Udglatning';

  @override
  String get streamline => 'Strømlinet';

  @override
  String get presentation => 'Præsentation';

  @override
  String get selectAsset => 'Vælg aktiv';

  @override
  String get clearStyle => 'Ryd stil';

  @override
  String get unknownImportType => 'Ukendt importtype';

  @override
  String get sureImportTemplate =>
      'Er du sikker på du vil importere skabelonen?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Afspil';

  @override
  String get video => 'Video';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Breakpoint';

  @override
  String get presentationControls => 'Kontroller for præsentation';

  @override
  String get nextSlide => 'Næste dias';

  @override
  String get nextSlideDescription =>
      'Stryg til højre eller tryk på piletasten til højre for at gå til næste dias';

  @override
  String get previousSlide => 'Forrige dias';

  @override
  String get previousSlideDescription =>
      'Stryg mod venstre eller tryk på venstre piletasten for at gå til forrige dias';

  @override
  String get exitPresentation => 'Afslut præsentation';

  @override
  String get exitPresentationDescription =>
      'Tryk på flugt tasten eller stryg ned for at afslutte præsentationen';

  @override
  String get pausePresentation => 'Pause præsentation';

  @override
  String get pausePresentationDescription =>
      'Tryk på skærmen, eller tryk på mellemrumstasten for at afbryde eller genoptage præsentationen';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'Du har nået slutningen af præsentationen';

  @override
  String get startOfPresentation => 'Du har nået starten på præsentationen';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Overskrift $index';
  }

  @override
  String get code => 'Kode';

  @override
  String get quote => 'Tilbud';

  @override
  String get link => 'Link';

  @override
  String get checkbox => 'Afkrydsningsfelt';

  @override
  String get deleted => 'Slettet';

  @override
  String get emphasis => 'Fremhævelse';

  @override
  String get listBullet => 'List punkt';

  @override
  String get strong => 'Stærk';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Hjem';

  @override
  String get files => 'Filer';

  @override
  String get sortBy => 'Sorter efter';

  @override
  String get location => 'Placering';

  @override
  String get whatsNew => 'Hvad er nyt?';

  @override
  String get unstar => 'Unstar';

  @override
  String get star => 'Stjerne';

  @override
  String get goUp => 'Gå op';

  @override
  String get created => 'Oprettet';

  @override
  String get modified => 'Ændret';

  @override
  String get quickstart => 'Hurtigstart';

  @override
  String get noTemplates => 'Der er i øjeblikket ingen tilgængelige skabeloner';

  @override
  String get importCorePack => 'Importér kernepakke';

  @override
  String get importCorePackDescription =>
      'Importér kernepakken der indeholder alle grundlæggende aktiver for at komme i gang. Dette vil tilsidesætte den aktuelle kernepakke.';

  @override
  String get never => 'Aldrig';

  @override
  String get onlyOnUpdates => 'Kun ved opdateringer';

  @override
  String get visibility => 'Synlighed';

  @override
  String get captureThumbnail => 'Optag miniature';

  @override
  String get capturedThumbnail => 'Miniaturebillede med succes';

  @override
  String get chooseLabelMode => 'Vælg etiket tilstand';

  @override
  String get foreground => 'Forgrund';

  @override
  String get version => 'Version';

  @override
  String get repository => 'Lagre';

  @override
  String get pages => 'Sider';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Arrangér';

  @override
  String get bringToFront => 'Bring til forsiden';

  @override
  String get sendToBack => 'Send til tilbage';

  @override
  String get bringForward => 'Bring fremad';

  @override
  String get sendBackward => 'Send tilbage';

  @override
  String get rotation => 'Rotation';

  @override
  String get onlyAvailableLargerScreen => 'Kun tilgængelig på større skærme';

  @override
  String get toolbarPosition => 'Værktøjslinjens position';

  @override
  String get rotate => 'Rotér';

  @override
  String get spacer => 'Mellemrum';

  @override
  String get navigationRail => 'Navigation jernbane';

  @override
  String get cut => 'Klip';

  @override
  String get insertBefore => 'Indsæt før';

  @override
  String get insertAfter => 'Indsæt efter';

  @override
  String get insertFirst => 'Indsæt først';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Indsæt';

  @override
  String get ascending => 'Stigende';

  @override
  String get descending => 'Faldende';

  @override
  String get imageScale => 'Billed skala';

  @override
  String get select => 'Vælg';

  @override
  String get tool => 'Værktøj';

  @override
  String get texture => 'Tekstur';

  @override
  String get platformTheme => 'Platform tema';

  @override
  String get desktop => 'Skrivebord';

  @override
  String get mobile => 'Mobil';

  @override
  String get pdfQuality => 'PDF kvalitet';

  @override
  String get surface => 'Overflade';

  @override
  String get pattern => 'Mønster';

  @override
  String get sureClose => 'Er du sikker på, at du vil lukke dokumentet?';

  @override
  String get thereAreUnsavedChanges => 'Der er ikke-gemte ændringer';

  @override
  String get page => 'Side';

  @override
  String get iceServers => 'ICE Servere';

  @override
  String get collaboration => 'Samarbejde';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Web Sokkel';

  @override
  String get iceServer => 'Ic- Server';

  @override
  String get port => 'Port';

  @override
  String get type => 'Type';

  @override
  String get side => 'Side';

  @override
  String get client => 'Klient';

  @override
  String get server => 'Server';

  @override
  String get switchView => 'Skift Visning';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'Skjul Brugerflade';

  @override
  String get density => 'Tæthed';

  @override
  String get compact => 'Kompakt';

  @override
  String get comfortable => 'Behageligt';

  @override
  String get standard => 'Standard';

  @override
  String get lock => 'Lås';

  @override
  String get addElement => 'Tilføj element';

  @override
  String get notDefaultConnection => 'Ikke standard forbindelse';

  @override
  String get defaultConnection => 'Standard forbindelse';

  @override
  String get hide => 'Skjul';

  @override
  String get show => 'Vis';

  @override
  String get pause => 'Pause';

  @override
  String get stop => 'Stop';

  @override
  String get refresh => 'Opdater';

  @override
  String get print => 'Udskriv';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Øjendråber';

  @override
  String get users => 'Brugere';

  @override
  String get experiments => 'Eksperimenter';

  @override
  String get address => 'Adresse';

  @override
  String get spreadToPages => 'Spred til sider';

  @override
  String get rootDirectorySpecifiedDescription =>
      'Rodmappen er angivet. Alle avancerede mappestier vil være relativt til denne mappe. Hold den tom for at deaktivere denne mappetype.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'Rodmappen er ikke angivet. Et navn er påkrævet. Alle avancerede mappestier vil være absolute. Hold det tomt for at deaktivere denne mappetype.';

  @override
  String get unsecureConnectionTitle => 'Usikker forbindelse';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'Forbindelsen er ikke sikker. Dette kan være en sikkerhedsrisiko. Fortsæt kun, hvis du stoler på forbindelsen. sha1 fingeraftrykket er $fingerprint.';
  }

  @override
  String get continueAnyway => 'Fortsæt alligevel';

  @override
  String get zoomControl => 'Zoom kontrol';

  @override
  String get highContrast => 'Høj kontrast';

  @override
  String get shouldANumber => 'Denne værdi skal være gyldigt nummer';

  @override
  String get createAreas => 'Opret områder';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Operationer';

  @override
  String get medium => 'Mellem';

  @override
  String get large => 'Stor';

  @override
  String get toolbarSize => 'Værktøjslinjens størrelse';

  @override
  String get addAll => 'Tilføj alle';

  @override
  String get onlyCurrentPage => 'Kun nuværende side';

  @override
  String get smoothNavigation => 'Glat navigation';

  @override
  String get exact => 'Præcis';

  @override
  String get inline => 'Indlejret';

  @override
  String get toolbarRows => 'Værktøjslinje- rækker';

  @override
  String get pointerTest => 'Markør test';

  @override
  String get pressure => 'Tryk';

  @override
  String get small => 'Lille';

  @override
  String get tiny => 'Lille';

  @override
  String get selectAll => 'Vælg alle';

  @override
  String get overrideTools => 'Tilsidesæt værktøjer';

  @override
  String get hideCursorWhileDrawing => 'Skjul markør under tegning';

  @override
  String get installed => 'Installeret';

  @override
  String get install => 'Installér';

  @override
  String get deselect => 'Fravælg';

  @override
  String get changeCollection => 'Skift samling';

  @override
  String get collections => 'Samlinger';

  @override
  String get fullSelection => 'Fuld udvælgelse';

  @override
  String get fullSelectionDescription =>
      'Kræver elementer for at være helt inde i markeringsfeltet for valg.';

  @override
  String get collection => 'Samling';

  @override
  String get defaultCollection => 'Standard samling';

  @override
  String get scroll => 'Rul';

  @override
  String get onStartup => 'Ved opstart';

  @override
  String get homeScreen => 'Startskærm';

  @override
  String get lastNote => 'Sidste note';

  @override
  String get newNote => 'Ny note';

  @override
  String get convertToLayer => 'Konvertér til lag';

  @override
  String get merge => 'Flet';

  @override
  String get up => 'Op';

  @override
  String get down => 'Ned';

  @override
  String get other => 'Andet';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementer',
      one: '1 element',
      zero: 'Ingen elementer',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Farve værktøjslinje';

  @override
  String get yesButShowButtons => 'Ja, men vis knapper';

  @override
  String get optionsPanelPosition => 'Valgmuligheder panel position';

  @override
  String get hideDuration => 'Skjul varighed';

  @override
  String get animation => 'Animation';

  @override
  String get performance => 'Ydeevne';

  @override
  String get performanceDescription =>
      'Optimeret til hastighed og hukommelsesforbrug. Kun den synlige del af noten er bagt ind i billedet.';

  @override
  String get normalDescription =>
      'Balancer kvalitet og ydeevne. Bager et billede, der dækker 1,5 gange det synlige område, giver glattere overgange ved rulning.';

  @override
  String get high => 'Høj';

  @override
  String get highDescription =>
      'Beskrivelse: Maksimerer kvalitet på bekostning af ydeevne. Bager et billede, der dækker 2 gange det synlige område, sikrer problemfri gengivelse selv under hurtig rulning eller zooming.';

  @override
  String get renderResolution => 'Gengiv opløsning';

  @override
  String get translate => 'Oversæt';

  @override
  String get unencrypted => 'Ukrypteret';

  @override
  String get encrypted => 'Krypteret';

  @override
  String get encryptDocumentMessage => 'Klik for at kryptere dokumentet';

  @override
  String get unencryptDocumentMessage => 'Klik for at afkryptere dokumentet';

  @override
  String get unencrypt => 'Fjern Kryptering';

  @override
  String get encrypt => 'Kryptér';

  @override
  String get encryptWarning =>
      'Dette vil kryptere dokumentet. Du skal huske adgangskoden for at dekryptere den.';

  @override
  String get unencryptWarning =>
      'Dette vil afkryptere dokumentet. Adgangskoden vil blive fjernet og alle med adgang vil kunne åbne den.';

  @override
  String get confirmPassword => 'Bekræft adgangskode';

  @override
  String get passwordMismatch => 'Adgangskoderne er ikke ens';

  @override
  String get action => 'Handling';

  @override
  String get svgText => 'SVG Tekst';

  @override
  String get offset => 'Forskydning';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
