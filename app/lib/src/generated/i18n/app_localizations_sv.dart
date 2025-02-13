// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get open => 'Öppna';

  @override
  String get settings => 'Inställningar';

  @override
  String get personalization => 'Personalisering';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Mörkt tema';

  @override
  String get lightTheme => 'Ljust tema';

  @override
  String get systemTheme => 'Använd standard systemtema';

  @override
  String get view => 'Visa';

  @override
  String get edit => 'Redigera';

  @override
  String get export => 'Exportera';

  @override
  String get save => 'Spara';

  @override
  String get zoom => 'Zooma';

  @override
  String get zoomIn => 'Zooma in';

  @override
  String get zoomOut => 'Zooma ut';

  @override
  String get resetZoom => 'Reset zoom';

  @override
  String get strokeWidth => 'Stroke bredd';

  @override
  String get includeEraser => 'Inkludera suddgummi?';

  @override
  String get thinning => 'Gallring';

  @override
  String get pen => 'Penna';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Radering av sökväg';

  @override
  String get label => 'Etikett';

  @override
  String get delete => 'Radera';

  @override
  String get areYouSure => 'Är du säker?';

  @override
  String get reallyDelete => 'Vill du verkligen ta bort detta objekt?';

  @override
  String get no => 'Nej';

  @override
  String get yes => 'Ja';

  @override
  String get undo => 'Ångra';

  @override
  String get redo => 'Gör om';

  @override
  String get general => 'Allmänt';

  @override
  String get copyTitle => 'Kopierad till urklipp';

  @override
  String get loading => 'Laddar...';

  @override
  String get enterText => 'Ange texten';

  @override
  String get size => 'Storlek';

  @override
  String get width => 'Width';

  @override
  String get height => 'Höjd';

  @override
  String get count => 'Antal';

  @override
  String get space => 'Mellanslag';

  @override
  String get background => 'Bakgrund';

  @override
  String get box => 'Låda';

  @override
  String get locale => 'Lokalt';

  @override
  String get systemLocale => 'Systemets språk';

  @override
  String get information => 'Information';

  @override
  String get license => 'Licens';

  @override
  String get imprint => 'Avtryck';

  @override
  String get privacypolicy => 'Integritetspolicy';

  @override
  String get source => 'Källa';

  @override
  String get documentation => 'Dokumentation';

  @override
  String get changelog => 'Ändringslogg';

  @override
  String get existOverride => 'Detta element finns redan. Skriv över?';

  @override
  String get description => 'Beskrivning';

  @override
  String get fill => 'Fyll';

  @override
  String get defaultPalette => 'Standard palett';

  @override
  String get highlighter => 'Highlighter';

  @override
  String get add => 'Lägg till';

  @override
  String get remove => 'Radera';

  @override
  String get removeConfirm => 'Vill du verkligen ta bort detta?';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => 'Anpassad';

  @override
  String get decoration => 'Dekoration';

  @override
  String get underline => 'Understruken';

  @override
  String get overline => 'Overline';

  @override
  String get strikethrough => 'Genomstruken';

  @override
  String get thickness => 'Tjocklek';

  @override
  String get style => 'Stil';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Dubbel';

  @override
  String get dotted => 'Prickad';

  @override
  String get dashed => 'Streckad';

  @override
  String get wavy => 'Vågig';

  @override
  String get fontWeight => 'Teckensnittets vikt';

  @override
  String get normal => 'Normal';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Urklipp';

  @override
  String get file => 'Fil';

  @override
  String get data => 'Data';

  @override
  String get share => 'Dela';

  @override
  String get spacing => 'Avstånd';

  @override
  String get image => 'Bild';

  @override
  String get enterUrl => 'Ange webbadressen';

  @override
  String get scale => 'Skala';

  @override
  String get help => 'Hjälp';

  @override
  String get reallyReset => 'Vill du verkligen återställa den?';

  @override
  String get whatToDo => 'Vad vill du göra?';

  @override
  String get ignore => 'Ignorera';

  @override
  String get backup => 'Säkerhetskopiera';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'Filen $fileName skapades i en nyare version ($fileVersion). Vad bör göras med den här filen?';
  }

  @override
  String get waypoints => 'Vägpunkter';

  @override
  String get origin => 'Ursprung';

  @override
  String get import => 'Importera';

  @override
  String get newContent => 'Ny';

  @override
  String get selectElement => 'Välj element';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Skift';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Kopiera version';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Beteenden';

  @override
  String get dataDirectory => 'Datakatalog';

  @override
  String get defaultPath => 'Standard sökväg';

  @override
  String get dateFormat => 'Datumformat';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Uppdaterad den: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Skapad den: $dateTimeString';
  }

  @override
  String get rename => 'Döp om';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => 'Hand';

  @override
  String get folder => 'Mapp';

  @override
  String get move => 'Flytta';

  @override
  String get copy => 'Kopiera';

  @override
  String get back => 'Tillbaka';

  @override
  String get zoomDependent => 'Zooma beroende';

  @override
  String get shapeDetection => 'Form detektion';

  @override
  String get delay => 'Fördröjning';

  @override
  String get defaultLayer => 'Förvalt lager';

  @override
  String get layer => 'Lager';

  @override
  String get layers => 'Lager';

  @override
  String get notSet => 'Ej inställd';

  @override
  String get enterLayer => 'Ange lagrets namn';

  @override
  String get selectElements => 'Välj element';

  @override
  String get deleteElements => 'Ta bort element';

  @override
  String get deleteElementsConfirm =>
      'Vill du verkligen ta bort de markerade elementen?';

  @override
  String get selectCustomCollection => 'Välj en anpassad samling';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => 'Känslighet';

  @override
  String get sensitivityHint =>
      'Ju högre värde, desto känsligare är inmatningen';

  @override
  String get horizontal => 'Horisontell';

  @override
  String get vertical => 'Vertikal';

  @override
  String get plain => 'Oformaterad';

  @override
  String get light => 'Ljus';

  @override
  String get ruled => 'Reglerad';

  @override
  String get quad => 'Fyrtal';

  @override
  String get music => 'Musik';

  @override
  String get dark => 'Mörk';

  @override
  String get plainDark => 'Mörk';

  @override
  String get ruledDark => 'Reglerat mörkt';

  @override
  String get quadDark => 'Fyrtal mörkt';

  @override
  String get musicDark => 'Mörk musik';

  @override
  String get templates => 'Mallar';

  @override
  String get untitled => 'Namnlös';

  @override
  String get createTemplate => 'Skapa mall';

  @override
  String get createTemplateContent =>
      'Vill du verkligen skapa en mall från detta dokument? Det ursprungliga dokumentet kommer att raderas.';

  @override
  String get replace => 'Ersätt';

  @override
  String get reallyReplace =>
      'Vill du verkligen ersätta mallen? Den här åtgärden kan inte ångras!';

  @override
  String get defaultTemplate => 'Standard mall';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'Dokument';

  @override
  String get camera => 'Kamera';

  @override
  String get printout => 'Utskrift';

  @override
  String get selectCamera => 'Välj en kamera';

  @override
  String get changeDocumentPath => 'Ändra dokumentets sökväg';

  @override
  String get deleteWholeStroke => 'Ta bort hela slaget';

  @override
  String get alpha => 'Alfa';

  @override
  String get area => 'Område';

  @override
  String get selectArea => 'Välj ett område';

  @override
  String get aspectRatio => 'Bildförhållande';

  @override
  String get presets => 'Förval';

  @override
  String get pagePortrait => 'Porträtt av sida';

  @override
  String get pageLandscape => 'Sidans landskap';

  @override
  String get square => 'Kvadrat';

  @override
  String get areas => 'Områden';

  @override
  String get enterArea => 'Ange området';

  @override
  String get exitArea => 'Avsluta området';

  @override
  String get currentArea => 'Nuvarande område';

  @override
  String get design => 'Design';

  @override
  String get text => 'Text';

  @override
  String welcome(String codeName) {
    return 'Hej, detta är Linwood fjäril';
  }

  @override
  String get welcomeContent => 'En fri och öppen källkodsritningsyta!';

  @override
  String updated(String version) {
    return 'Appen uppdaterad till version $version';
  }

  @override
  String get releaseNotes => 'Släpp anteckningar';

  @override
  String get constraints => 'Begränsningar';

  @override
  String get scaled => 'Skalad';

  @override
  String get fixed => 'Fast';

  @override
  String get dynamicContent => 'Dynamisk';

  @override
  String get none => 'Ingen';

  @override
  String get includeArea => 'Inkludera område';

  @override
  String get verticalAlignment => 'Vertikal justering';

  @override
  String get horizontalAlignment => 'Horisontell justering';

  @override
  String get top => 'Överst';

  @override
  String get center => 'Centrera';

  @override
  String get bottom => 'Botten';

  @override
  String get left => 'Vänster';

  @override
  String get right => 'Höger';

  @override
  String get justify => 'Justera';

  @override
  String get constraint => 'Begränsa';

  @override
  String get length => 'Längd';

  @override
  String get exportSvg => 'Exportera SVG';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => 'Välj sidor';

  @override
  String get recentFiles => 'Senaste filer';

  @override
  String get start => 'Starta';

  @override
  String get noRecentFiles => 'Inga nya filer';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count sidor',
      one: '1 sida',
      zero: 'Inga sidor',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Sida $index';
  }

  @override
  String get exit => 'Avsluta';

  @override
  String get noElements => 'Inga element';

  @override
  String get invertSelection => 'Invertera markering';

  @override
  String get errorWhileImporting => 'Fel vid import';

  @override
  String get errorWhileImportingContent =>
      'Ett fel inträffade när filen skulle importeras';

  @override
  String get showDetails => 'Visa detaljer';

  @override
  String get hideDetails => 'Dölj detaljer';

  @override
  String get error => 'Fel';

  @override
  String get stackTrace => 'Stack spår';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Varaktighet';

  @override
  String get quality => 'Kvalitet';

  @override
  String get exportPdf => 'Exportera PDF';

  @override
  String get local => 'Lokal';

  @override
  String get addConnection => 'Lägg till kontakt';

  @override
  String get connections => 'Anslutningar';

  @override
  String get noConnections => 'Inga kontakter';

  @override
  String get url => 'URL';

  @override
  String get connect => 'Anslut';

  @override
  String get username => 'Användarnamn';

  @override
  String get password => 'Lösenord';

  @override
  String get webNotSupported => 'Webben stöds inte';

  @override
  String get advanced => 'Avancerat';

  @override
  String get directory => 'Katalog';

  @override
  String get documentsDirectory => 'Katalog för dokument';

  @override
  String get templatesDirectory => 'Mall katalog';

  @override
  String get errorWhileCreatingConnection => 'Fel vid skapande av anslutning';

  @override
  String get cannotConnect => 'Kan inte ansluta';

  @override
  String get urlNotValid => 'URL är inte giltig';

  @override
  String get icon => 'Ikon';

  @override
  String get update => 'Uppdatera';

  @override
  String get updateAvailable => 'Uppdatering tillgänglig';

  @override
  String get stable => 'Stabil';

  @override
  String get nightly => 'Nattlig';

  @override
  String get checkForUpdates => 'Sök efter uppdateringar';

  @override
  String get checkForUpdatesWarning =>
      'Utföra en sökning efter uppdateringar kommer att ansluta till fjärilens webbplats för att få informationen.';

  @override
  String get usingLatestStable => 'Du använder den senaste stabila versionen';

  @override
  String get usingLatestNightly => 'Du använder den senaste nattliga versionen';

  @override
  String get currentVersion => 'Nuvarande version';

  @override
  String get updateNow => 'Uppdatera nu';

  @override
  String get shape => 'Form';

  @override
  String get circle => 'Cirkel';

  @override
  String get rectangle => 'Rektangel';

  @override
  String get triangle => 'Triangel';

  @override
  String get line => 'Linje';

  @override
  String get cornerRadius => 'Corner radius';

  @override
  String get topLeft => 'Överst till vänster';

  @override
  String get topRight => 'Överst till höger';

  @override
  String get bottomLeft => 'Nere till vänster';

  @override
  String get bottomRight => 'Nere till höger';

  @override
  String get caches => 'Cacher';

  @override
  String get manage => 'Hantera';

  @override
  String get clearCaches => 'Rensa cacher';

  @override
  String get createCache => 'Skapa cache';

  @override
  String get thirdPartyLicenses => 'Tredje parts licenser';

  @override
  String get syncing => 'Synkroniserar...';

  @override
  String get synced => 'Synkroniserad';

  @override
  String get notSynced => 'Inte synkroniserad';

  @override
  String get conflict => 'Konflikt';

  @override
  String get keepLocal => 'Behåll lokal';

  @override
  String get keepConnection => 'Behåll kontakt';

  @override
  String get keepBoth => 'Behåll båda';

  @override
  String get forAll => 'För alla';

  @override
  String fileConflict(String file, String connection) {
    return '$file i $connection har en konflikt';
  }

  @override
  String get offline => 'Offline';

  @override
  String get localLatest => 'Lokalt senaste';

  @override
  String get connectionLatest => 'Anslutning senaste';

  @override
  String get path => 'Sökväg';

  @override
  String get folderSynced => 'Mappen synkroniserad';

  @override
  String get syncRootDirectory => 'Synkronisera rotkatalog';

  @override
  String get penOnlyInput => 'Endast penna inmatning';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Namnfält med ursprungsbeteckning';

  @override
  String get syncMode => 'Synkronisera läge';

  @override
  String get connection => 'Anslutning';

  @override
  String get always => 'Alltid';

  @override
  String get noMobile => 'Ingen mobil';

  @override
  String get manual => 'Manuell';

  @override
  String get search => 'Sök';

  @override
  String get properties => 'Egenskaper';

  @override
  String get pin => 'Fäst';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Element';

  @override
  String get painter => 'Målare';

  @override
  String get position => 'Befattning';

  @override
  String get note => 'Anteckning';

  @override
  String get packs => 'Paket';

  @override
  String get pack => 'Paket';

  @override
  String get more => 'Mer';

  @override
  String get askForName => 'Fråga efter namn';

  @override
  String areaIndex(int index) {
    return 'Område $index';
  }

  @override
  String get startInFullScreen => 'Starta i helskärm';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Mus';

  @override
  String get touch => 'Tryck';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Genvägar';

  @override
  String get middle => 'Mitten';

  @override
  String get first => 'Första';

  @override
  String get second => 'Sekund';

  @override
  String get tools => 'Verktyg';

  @override
  String get showGrid => 'Visa rutnät';

  @override
  String get grid => 'Rutnät';

  @override
  String get ruler => 'Linjal';

  @override
  String get angle => 'Vinkel';

  @override
  String get report => 'Rapportera';

  @override
  String get newFolder => 'Ny mapp';

  @override
  String get createPack => 'Skapa paket';

  @override
  String get editPack => 'Redigera paket';

  @override
  String get packsDirectory => 'Paketkatalog';

  @override
  String get stamp => 'Stämpel';

  @override
  String get addToPack => 'Lägg till i paket';

  @override
  String get sureImportPack => 'Är du säker du vill importera paketet?';

  @override
  String byAuthor(String author) {
    return 'av $author';
  }

  @override
  String get author => 'Författare';

  @override
  String get addAsset => 'Lägg till tillgång';

  @override
  String get editAsset => 'Redigera tillgång';

  @override
  String get scope => 'Omfattning';

  @override
  String get noPacks => 'Det finns för närvarande inga paket tillgängliga';

  @override
  String get components => 'Komponenter';

  @override
  String get waypoint => 'Waypoint';

  @override
  String get actions => 'Åtgärder';

  @override
  String get painters => 'Målare';

  @override
  String get breakingChangesTitle => 'Bryta ändringar';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Det bryter ändringar i denna version. Läs ändringsloggen innan du uppdaterar. Den aktuella filversionen är $version, den nya versionen är $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Punkt';

  @override
  String get fontFamily => 'Typsnitt familj';

  @override
  String get smoothing => 'Utjämning';

  @override
  String get streamline => 'Effektivisera';

  @override
  String get presentation => 'Presentation';

  @override
  String get selectAsset => 'Välj tillgång';

  @override
  String get clearStyle => 'Rensa stil';

  @override
  String get unknownImportType => 'Okänd importtyp';

  @override
  String get sureImportTemplate =>
      'Är du säker på att du vill importera mallen?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Spela';

  @override
  String get video => 'Video';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Brytpunkt';

  @override
  String get presentationControls => 'Presentationskontroller';

  @override
  String get nextSlide => 'Nästa bild';

  @override
  String get nextSlideDescription =>
      'Svep åt höger eller tryck på höger piltangent för att gå till nästa bild';

  @override
  String get previousSlide => 'Föregående bild';

  @override
  String get previousSlideDescription =>
      'Svep åt vänster eller tryck på vänster piltangent för att gå till föregående bild';

  @override
  String get exitPresentation => 'Avsluta presentation';

  @override
  String get exitPresentationDescription =>
      'Tryck på escape-knappen eller svep nedåt för att avsluta presentationen';

  @override
  String get pausePresentation => 'Pausa presentation';

  @override
  String get pausePresentationDescription =>
      'Tryck på skärmen eller tryck på mellanslagstangenten för att pausa eller återuppta presentationen';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'Du har nått slutet av presentationen';

  @override
  String get startOfPresentation => 'Du har nått början av presentationen';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Rubrik $index';
  }

  @override
  String get code => 'Kod';

  @override
  String get quote => 'Offert';

  @override
  String get link => 'Länk';

  @override
  String get checkbox => 'Kryssruta';

  @override
  String get deleted => 'Borttagen';

  @override
  String get emphasis => 'Tonvikt';

  @override
  String get listBullet => 'Lista punkt';

  @override
  String get strong => 'Stark';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Hem';

  @override
  String get files => 'Filer';

  @override
  String get sortBy => 'Sortera efter';

  @override
  String get location => 'Plats';

  @override
  String get whatsNew => 'Vad är nytt?';

  @override
  String get unstar => 'Avmarkera';

  @override
  String get star => 'Stjärna';

  @override
  String get goUp => 'Gå upp';

  @override
  String get created => 'Skapad';

  @override
  String get modified => 'Ändrad';

  @override
  String get quickstart => 'Snabbstart';

  @override
  String get noTemplates => 'Det finns för närvarande inga tillgängliga mallar';

  @override
  String get importCorePack => 'Importera kärnpaket';

  @override
  String get importCorePackDescription =>
      'Importera kärnpaketet som innehåller alla grundläggande tillgångar för att komma igång. Detta åsidosätter det aktuella kärnpaketet.';

  @override
  String get never => 'Aldrig';

  @override
  String get onlyOnUpdates => 'Endast på uppdateringar';

  @override
  String get visibility => 'Synlighet';

  @override
  String get captureThumbnail => 'Fånga miniatyrbild';

  @override
  String get capturedThumbnail => 'Framgångsrikt fångad miniatyrbild';

  @override
  String get chooseLabelMode => 'Välj etikettläge';

  @override
  String get foreground => 'Förgrund';

  @override
  String get version => 'Version';

  @override
  String get repository => 'Utveckling';

  @override
  String get pages => 'Sidor';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Ordna';

  @override
  String get bringToFront => 'Ta fram';

  @override
  String get sendToBack => 'Skicka till baksidan';

  @override
  String get bringForward => 'Ta fram';

  @override
  String get sendBackward => 'Skicka bakåt';

  @override
  String get rotation => 'Rotation';

  @override
  String get onlyAvailableLargerScreen => 'Finns endast på större skärmar';

  @override
  String get toolbarPosition => 'Verktygsfältets position';

  @override
  String get rotate => 'Rotera';

  @override
  String get spacer => 'Mellanslag';

  @override
  String get navigationRail => 'Navigeringsräls';

  @override
  String get cut => 'Klipp';

  @override
  String get insertBefore => 'Infoga före';

  @override
  String get insertAfter => 'Infoga efter';

  @override
  String get insertFirst => 'Infoga först';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Klistra in';

  @override
  String get ascending => 'Stigande';

  @override
  String get descending => 'Fallande';

  @override
  String get imageScale => 'Skala bild';

  @override
  String get select => 'Välj';

  @override
  String get tool => 'Verktyg';

  @override
  String get texture => 'Textur';

  @override
  String get platformTheme => 'Plattformens tema';

  @override
  String get desktop => 'Skrivbord';

  @override
  String get mobile => 'Mobil';

  @override
  String get pdfQuality => 'PDF kvalitet';

  @override
  String get surface => 'Yta';

  @override
  String get pattern => 'Mönster';

  @override
  String get sureClose => 'Är du säker på att du vill stänga dokumentet?';

  @override
  String get thereAreUnsavedChanges => 'Det finns osparade ändringar';

  @override
  String get page => 'Sida';

  @override
  String get iceServers => 'ICE servrar';

  @override
  String get collaboration => 'Samarbete';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Webb Socket';

  @override
  String get iceServer => 'ICE Server';

  @override
  String get port => 'Port';

  @override
  String get type => 'Typ';

  @override
  String get side => 'Sida';

  @override
  String get client => 'Klient';

  @override
  String get server => 'Server';

  @override
  String get switchView => 'Växla vy';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'Dölj gränssnitt';

  @override
  String get density => 'Densitet';

  @override
  String get compact => 'Kompakt';

  @override
  String get comfortable => 'Bekväm';

  @override
  String get standard => 'Standard';

  @override
  String get lock => 'Lås';

  @override
  String get addElement => 'Lägg till element';

  @override
  String get notDefaultConnection => 'Inte standardanslutning';

  @override
  String get defaultConnection => 'Förvald kontakt';

  @override
  String get hide => 'Dölj';

  @override
  String get show => 'Visa';

  @override
  String get pause => 'Pausa';

  @override
  String get stop => 'Stoppa';

  @override
  String get refresh => 'Uppdatera';

  @override
  String get print => 'Skriv ut';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Ögondroppare';

  @override
  String get users => 'Användare';

  @override
  String get experiments => 'Experiment';

  @override
  String get address => 'Adress';

  @override
  String get spreadToPages => 'Sprid till sidor';

  @override
  String get rootDirectorySpecifiedDescription =>
      'Rotkatalogen är angiven. Alla avancerade katalogvägar kommer att vara relativa till denna katalog. Håll den tom för att inaktivera denna katalogtyp.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'Rotkatalogen är inte angiven. Ett namn krävs. Alla avancerade katalogsökvägar kommer att vara absolut. Håll den tom för att inaktivera denna katalogtyp.';

  @override
  String get unsecureConnectionTitle => 'Osäker anslutning';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'Anslutningen är inte säker. Detta kan vara en säkerhetsrisk. Fortsätt bara om du litar på anslutningen. Fingeravtrycket sha1 är $fingerprint.';
  }

  @override
  String get continueAnyway => 'Fortsätt ändå';

  @override
  String get zoomControl => 'Zooma kontroll';

  @override
  String get highContrast => 'Hög kontrast';

  @override
  String get shouldANumber => 'Detta värde bör vara giltigt nummer';

  @override
  String get createAreas => 'Skapa områden';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Åtgärder';

  @override
  String get medium => 'Medel';

  @override
  String get large => 'Stor';

  @override
  String get toolbarSize => 'Storlek på verktygsfält';

  @override
  String get addAll => 'Lägg till alla';

  @override
  String get onlyCurrentPage => 'Endast aktuell sida';

  @override
  String get smoothNavigation => 'Smidig navigering';

  @override
  String get exact => 'Exakt';

  @override
  String get inline => 'Infogad';

  @override
  String get toolbarRows => 'Verktygsfält rader';

  @override
  String get pointerTest => 'Pekare test';

  @override
  String get pressure => 'Tryck';

  @override
  String get small => 'Liten';

  @override
  String get tiny => 'Liten';

  @override
  String get selectAll => 'Markera alla';

  @override
  String get overrideTools => 'Åsidosätt verktyg';

  @override
  String get hideCursorWhileDrawing => 'Dölj markören medan du ritar';

  @override
  String get installed => 'Installerad';

  @override
  String get install => 'Installera';

  @override
  String get deselect => 'Avmarkera';

  @override
  String get changeCollection => 'Ändra samling';

  @override
  String get collections => 'Samlingar';

  @override
  String get fullSelection => 'Fullt urval';

  @override
  String get fullSelectionDescription =>
      'Kräver element för att vara helt i urvalsrutan.';

  @override
  String get collection => 'Samling';

  @override
  String get defaultCollection => 'Förvald samling';

  @override
  String get scroll => 'Rulla';

  @override
  String get onStartup => 'Vid uppstart';

  @override
  String get homeScreen => 'Startskärmen';

  @override
  String get lastNote => 'Senaste anteckning';

  @override
  String get newNote => 'Ny anteckning';

  @override
  String get convertToLayer => 'Konvertera till lager';

  @override
  String get merge => 'Sammanfoga';

  @override
  String get up => 'Upp';

  @override
  String get down => 'Ner';

  @override
  String get other => 'Annat';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count element',
      one: '1 element',
      zero: 'Inga element',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Färg verktygsfält';

  @override
  String get yesButShowButtons => 'Ja, men visa knappar';

  @override
  String get optionsPanelPosition => 'Alternativ panel position';

  @override
  String get hideDuration => 'Dölj varaktighet';

  @override
  String get animation => 'Animering';

  @override
  String get performance => 'Prestation';

  @override
  String get performanceDescription =>
      'Optimerad för hastighet och minnesanvändning. Endast den synliga delen av noten bakas in i bilden.';

  @override
  String get normalDescription =>
      'Balanserar kvalitet och prestanda. Bakar en bild som täcker 1,5 gånger det synliga området, vilket ger jämnare övergångar vid rullning.';

  @override
  String get high => 'Hög';

  @override
  String get highDescription =>
      'Beskrivning: Maximerar kvaliteten till priset av prestanda. Bakar en bild som täcker 2 gånger det synliga området, vilket säkerställer sömlös rendering även under snabb rullning eller zoomning.';

  @override
  String get renderResolution => 'Rendera upplösning';

  @override
  String get translate => 'Översätt';

  @override
  String get unencrypted => 'Okrypterad';

  @override
  String get encrypted => 'Krypterad';

  @override
  String get encryptDocumentMessage => 'Klicka för att kryptera dokumentet';

  @override
  String get unencryptDocumentMessage => 'Klicka för att okryptera dokumentet';

  @override
  String get unencrypt => 'Okryptera';

  @override
  String get encrypt => 'Kryptera';

  @override
  String get encryptWarning =>
      'Detta krypterar dokumentet. Du måste komma ihåg lösenordet för att dekryptera det.';

  @override
  String get unencryptWarning =>
      'Detta kommer att okryptera dokumentet. Lösenordet kommer att tas bort och alla med åtkomst kommer att kunna öppna det.';

  @override
  String get confirmPassword => 'Bekräfta lösenord';

  @override
  String get passwordMismatch => 'Lösenorden matchar inte';

  @override
  String get action => 'Åtgärd';

  @override
  String get svgText => 'SVG Text';

  @override
  String get offset => 'Förskjutning';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
