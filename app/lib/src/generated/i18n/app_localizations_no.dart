// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian (`no`).
class AppLocalizationsNo extends AppLocalizations {
  AppLocalizationsNo([String locale = 'no']) : super(locale);

  @override
  String get open => 'Åpne';

  @override
  String get settings => 'Innstillinger';

  @override
  String get personalization => 'Personalisering';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Mørkt tema';

  @override
  String get lightTheme => 'Lyst tema';

  @override
  String get systemTheme => 'Bruk standard systemtema';

  @override
  String get view => 'Vis';

  @override
  String get edit => 'Rediger';

  @override
  String get export => 'Eksporter';

  @override
  String get save => 'Lagre';

  @override
  String get zoom => 'Forstørre';

  @override
  String get zoomIn => 'Zoom inn';

  @override
  String get zoomOut => 'Zoom ut';

  @override
  String get resetZoom => 'Reset zoom';

  @override
  String get strokeWidth => 'Bredde på slagbredde';

  @override
  String get includeEraser => 'Inkluder eraser?';

  @override
  String get thinning => 'Tynn';

  @override
  String get pen => 'Penn';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Bane eraser';

  @override
  String get label => 'Etikett';

  @override
  String get delete => 'Slett';

  @override
  String get areYouSure => 'Er du sikker?';

  @override
  String get reallyDelete => 'Vil du virkelig slette dette elementet?';

  @override
  String get no => 'Nei';

  @override
  String get yes => 'Ja';

  @override
  String get undo => 'Angre';

  @override
  String get redo => 'Gjenta';

  @override
  String get general => 'Generelt';

  @override
  String get copyTitle => 'Kopiert til utklippstavle';

  @override
  String get loading => 'Laster...';

  @override
  String get enterText => 'Skriv inn teksten';

  @override
  String get size => 'Størrelse';

  @override
  String get width => 'Width';

  @override
  String get height => 'Høyde';

  @override
  String get count => 'Antall';

  @override
  String get space => 'Mellomrom';

  @override
  String get background => 'Bakgrunn';

  @override
  String get box => 'Boks';

  @override
  String get locale => 'Språk';

  @override
  String get systemLocale => 'System nasjonale innstillinger';

  @override
  String get information => 'Informasjon';

  @override
  String get license => 'Lisens';

  @override
  String get imprint => 'Avtrykk';

  @override
  String get privacypolicy => 'Retningslinjer for personvern';

  @override
  String get source => 'Kilde';

  @override
  String get documentation => 'Dokumentasjon';

  @override
  String get changelog => 'Endringslogg';

  @override
  String get existOverride => 'Dette elementet finnes allerede. Overskriv?';

  @override
  String get description => 'Beskrivelse';

  @override
  String get fill => 'Fyll';

  @override
  String get defaultPalette => 'Standard palett';

  @override
  String get highlighter => 'Uthever';

  @override
  String get add => 'Legg til';

  @override
  String get remove => 'Fjern';

  @override
  String get removeConfirm => 'Vil du virkelig fjerne dette?';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => 'Egendefinert';

  @override
  String get decoration => 'Dekorasjon';

  @override
  String get underline => 'Understreking';

  @override
  String get overline => 'Overlinje';

  @override
  String get strikethrough => 'Gjennomstreking';

  @override
  String get thickness => 'Tykkelse';

  @override
  String get style => 'Stil';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Dobbel';

  @override
  String get dotted => 'Prikket';

  @override
  String get dashed => 'Stiplet';

  @override
  String get wavy => 'Bølgefull';

  @override
  String get fontWeight => 'Skriftens vekt';

  @override
  String get normal => 'Vanlig';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Utklippstavle';

  @override
  String get file => 'Fil';

  @override
  String get data => 'Data';

  @override
  String get share => 'Del';

  @override
  String get spacing => 'Avstand';

  @override
  String get image => 'Bilde';

  @override
  String get enterUrl => 'Skriv inn nettadressen';

  @override
  String get scale => 'Skala';

  @override
  String get help => 'Hjelp';

  @override
  String get reallyReset => 'Vil du virkelig tilbakestille det?';

  @override
  String get whatToDo => 'Hva vil du gjøre?';

  @override
  String get ignore => 'Ignorer';

  @override
  String get backup => 'Sikkerhetskopi';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'Filen $fileName ble laget i en nyere versjon ($fileVersion). Hva bør gjøres med denne filen?';
  }

  @override
  String get waypoints => 'Veipunkter';

  @override
  String get origin => 'Opprinnelse';

  @override
  String get import => 'Importer';

  @override
  String get newContent => 'Ny';

  @override
  String get selectElement => 'Velg element';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Skift';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Kopier versjon';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Oppførsler';

  @override
  String get dataDirectory => 'Datamaskin katalog';

  @override
  String get defaultPath => 'Standard sti';

  @override
  String get dateFormat => 'Dato format';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Oppdatert kl: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Opprettet den: $dateTimeString';
  }

  @override
  String get rename => 'Omdøp';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => 'Hånd';

  @override
  String get folder => 'Mappe';

  @override
  String get move => 'Flytt';

  @override
  String get copy => 'Kopier';

  @override
  String get back => 'Tilbake';

  @override
  String get zoomDependent => 'Zoom avhengig';

  @override
  String get shapeDetection => 'Finn form';

  @override
  String get delay => 'Forsinkelse';

  @override
  String get defaultLayer => 'Standard lag';

  @override
  String get layer => 'Lag';

  @override
  String get layers => 'Lag';

  @override
  String get notSet => 'Ikke angitt';

  @override
  String get enterLayer => 'Angi navn på lag';

  @override
  String get selectElements => 'Velg elementer';

  @override
  String get deleteElements => 'Slett elementer';

  @override
  String get deleteElementsConfirm =>
      'Vil du virkelig slette de valgte elementene?';

  @override
  String get selectCustomCollection => 'Velg en egendefinert samling';

  @override
  String get svg => 'Svg';

  @override
  String get sensitivity => 'Sensitivitet';

  @override
  String get sensitivityHint =>
      'Jo høyere verdien er, desto mer følsom inndata';

  @override
  String get horizontal => 'Horisontal';

  @override
  String get vertical => 'Vertikal';

  @override
  String get plain => 'Enkel';

  @override
  String get light => 'Lys';

  @override
  String get ruled => 'Linjert';

  @override
  String get quad => 'Avrunding';

  @override
  String get music => 'Musikk';

  @override
  String get dark => 'Mørk';

  @override
  String get plainDark => 'Mørk';

  @override
  String get ruledDark => 'Rulert mørk';

  @override
  String get quadDark => 'Quad dark';

  @override
  String get musicDark => 'Musikk mørkt';

  @override
  String get templates => 'Maler';

  @override
  String get untitled => 'Navnløs';

  @override
  String get createTemplate => 'Opprett mal';

  @override
  String get createTemplateContent =>
      'Vil du virkelig opprette en mal fra dette dokumentet? Det opprinnelige dokumentet vil bli slettet.';

  @override
  String get replace => 'Erstatt';

  @override
  String get reallyReplace =>
      'Er du sikker på at du vil erstatte malen? Den kan ikke bli reversert!';

  @override
  String get defaultTemplate => 'Standard mal';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'Dokument';

  @override
  String get camera => 'Kamera';

  @override
  String get printout => 'Utskrift';

  @override
  String get selectCamera => 'Velg et kamera';

  @override
  String get changeDocumentPath => 'Endre sti for dokument';

  @override
  String get deleteWholeStroke => 'Slett hele slag';

  @override
  String get alpha => 'Alfa';

  @override
  String get area => 'Område';

  @override
  String get selectArea => 'Velg et område';

  @override
  String get aspectRatio => 'Høyde- og breddeforhold';

  @override
  String get presets => 'Forhåndsinnstillinger';

  @override
  String get pagePortrait => 'Side portrett';

  @override
  String get pageLandscape => 'Side landskap';

  @override
  String get square => 'Firkant';

  @override
  String get areas => 'Områder';

  @override
  String get enterArea => 'Angi området';

  @override
  String get exitArea => 'Avslutt området';

  @override
  String get currentArea => 'Gjeldende område';

  @override
  String get design => 'Utforming';

  @override
  String get text => 'Tekst';

  @override
  String welcome(String codeName) {
    return 'Hey, dette er Linwood Butterfly';
  }

  @override
  String get welcomeContent => 'En gratis og åpen kildekode tegning plass!';

  @override
  String updated(String version) {
    return 'App oppdatert til versjon $version';
  }

  @override
  String get releaseNotes => 'Slipp notater';

  @override
  String get constraints => 'Betingelser';

  @override
  String get scaled => 'Skalert';

  @override
  String get fixed => 'Fast';

  @override
  String get dynamicContent => 'Dynamisk';

  @override
  String get none => 'Ingen';

  @override
  String get includeArea => 'Inkluder området';

  @override
  String get verticalAlignment => 'Vertikal justering';

  @override
  String get horizontalAlignment => 'Horisontal justering';

  @override
  String get top => 'Topp';

  @override
  String get center => 'Midtstilt';

  @override
  String get bottom => 'Bunn';

  @override
  String get left => 'Venstre';

  @override
  String get right => 'Høyre';

  @override
  String get justify => 'Juster';

  @override
  String get constraint => 'Begrunnelse';

  @override
  String get length => 'Lengde';

  @override
  String get exportSvg => 'Eksporter SVG';

  @override
  String get pdf => 'Pdf';

  @override
  String get selectPages => 'Velg sider';

  @override
  String get recentFiles => 'Siste filer';

  @override
  String get start => 'Begynn';

  @override
  String get noRecentFiles => 'Ingen nylige filer';

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
  String get exit => 'Avslutt';

  @override
  String get noElements => 'Ingen elementer';

  @override
  String get invertSelection => 'Inverter merking';

  @override
  String get errorWhileImporting => 'Feil ved import';

  @override
  String get errorWhileImportingContent =>
      'En feil oppstod under import av filen';

  @override
  String get showDetails => 'Vis detaljer';

  @override
  String get hideDetails => 'Skjul detaljer';

  @override
  String get error => 'Feil';

  @override
  String get stackTrace => 'Stabel spor';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Varighet';

  @override
  String get quality => 'Kvalitet';

  @override
  String get exportPdf => 'Eksporter PDF';

  @override
  String get local => 'Lokal';

  @override
  String get addConnection => 'Legg til forbindelse';

  @override
  String get connections => 'Tilkoblinger';

  @override
  String get noConnections => 'Ingen tilkoblinger';

  @override
  String get url => 'Nettadresse';

  @override
  String get connect => 'Nettverk';

  @override
  String get username => 'Brukernavn';

  @override
  String get password => 'Passord';

  @override
  String get webNotSupported => 'Web støttes ikke';

  @override
  String get advanced => 'Avansert';

  @override
  String get directory => 'Katalog';

  @override
  String get documentsDirectory => 'Dokumenter katalog';

  @override
  String get templatesDirectory => 'Mappe for maler';

  @override
  String get errorWhileCreatingConnection =>
      'Feil under oppretting av tilkobling';

  @override
  String get cannotConnect => 'Kan ikke koble til';

  @override
  String get urlNotValid => 'URL ikke gyldig';

  @override
  String get icon => 'Ikon';

  @override
  String get update => 'Oppdater';

  @override
  String get updateAvailable => 'Oppdatering tilgjengelig';

  @override
  String get stable => 'Stabil';

  @override
  String get nightly => 'Nattlig';

  @override
  String get checkForUpdates => 'Se etter oppdateringer';

  @override
  String get checkForUpdatesWarning =>
      'Utføre en sjekk for oppdateringer vil koble til nettstedet Butterfly for å få informasjonen.';

  @override
  String get usingLatestStable => 'Du bruker den nyeste stabile versjonen';

  @override
  String get usingLatestNightly => 'Du bruker den siste nattlige versjonen';

  @override
  String get currentVersion => 'Gjeldende versjon';

  @override
  String get updateNow => 'Oppdater nå';

  @override
  String get shape => 'Form';

  @override
  String get circle => 'Sirkel';

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
  String get topRight => 'Øverst til høyre';

  @override
  String get bottomLeft => 'Nederst til venstre';

  @override
  String get bottomRight => 'Nederst til høyre';

  @override
  String get caches => 'Cacher';

  @override
  String get manage => 'Administrer';

  @override
  String get clearCaches => 'Tøm hurtiglager';

  @override
  String get createCache => 'Opprett cache';

  @override
  String get thirdPartyLicenses => 'Tredjeparts lisenser';

  @override
  String get syncing => 'Synkroniserer...';

  @override
  String get synced => 'Synkronisert';

  @override
  String get notSynced => 'Ikke synkronisert';

  @override
  String get conflict => 'Konflikt';

  @override
  String get keepLocal => 'Behold lokalt';

  @override
  String get keepConnection => 'Behold tilkoblingen';

  @override
  String get keepBoth => 'Behold begge';

  @override
  String get forAll => 'For alle';

  @override
  String fileConflict(String file, String connection) {
    return '$file i $connection har en konflikt';
  }

  @override
  String get offline => 'Frakoblet';

  @override
  String get localLatest => 'Lokal siste';

  @override
  String get connectionLatest => 'Tilkobling nyeste';

  @override
  String get path => 'Sti';

  @override
  String get folderSynced => 'Mappe synkronisert';

  @override
  String get syncRootDirectory => 'Synkroniser rotkatalogen';

  @override
  String get penOnlyInput => 'Pennen er kun inndata';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Native tittellinjen';

  @override
  String get syncMode => 'Synk modus';

  @override
  String get connection => 'Tilkobling';

  @override
  String get always => 'Alltid';

  @override
  String get noMobile => 'Ingen mobil';

  @override
  String get manual => 'Manuell';

  @override
  String get search => 'Søk';

  @override
  String get properties => 'Egenskaper';

  @override
  String get pin => 'Fest';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Element';

  @override
  String get painter => 'Kunstner';

  @override
  String get position => 'Posisjon';

  @override
  String get note => 'Notat';

  @override
  String get packs => 'Pakker';

  @override
  String get pack => 'Pakke';

  @override
  String get more => 'Mer';

  @override
  String get askForName => 'Spør om navn';

  @override
  String areaIndex(int index) {
    return 'Område $index';
  }

  @override
  String get startInFullScreen => 'Start på fullskjerm';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Mus';

  @override
  String get touch => 'Berør';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Snarveier';

  @override
  String get middle => 'Midten';

  @override
  String get first => 'Første';

  @override
  String get second => 'Sekund';

  @override
  String get tools => 'Verktøy';

  @override
  String get showGrid => 'Vis rutenett';

  @override
  String get grid => 'Rutenett';

  @override
  String get ruler => 'Linjal';

  @override
  String get angle => 'Vinkel';

  @override
  String get report => 'Rapporter';

  @override
  String get newFolder => 'Ny mappe';

  @override
  String get createPack => 'Opprett pakke';

  @override
  String get editPack => 'Rediger pakke';

  @override
  String get packsDirectory => 'Mappe for pakker';

  @override
  String get stamp => 'Stempel';

  @override
  String get addToPack => 'Legg til i pakke';

  @override
  String get sureImportPack => 'Er du sikker på at du vil importere pakken?';

  @override
  String byAuthor(String author) {
    return 'av $author';
  }

  @override
  String get author => 'Forfatter';

  @override
  String get addAsset => 'Legg til ressurs';

  @override
  String get editAsset => 'Rediger eiendel';

  @override
  String get scope => 'Omfang';

  @override
  String get noPacks => 'Det er for tiden ingen tilgjengelige pakker';

  @override
  String get components => 'Komponenter';

  @override
  String get waypoint => 'Veipunkt';

  @override
  String get actions => 'Handlinger';

  @override
  String get painters => 'Malere';

  @override
  String get breakingChangesTitle => 'Endringer brytes';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Det er brytende endringer i denne versjonen. Vennligst les endringsloggen før du oppdaterer. Gjeldende filversjon er $version, den nye versjonen er $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Avsnitt';

  @override
  String get fontFamily => 'Skrift familie';

  @override
  String get smoothing => 'Utjevning';

  @override
  String get streamline => 'Streamline';

  @override
  String get presentation => 'Presentasjon';

  @override
  String get selectAsset => 'Velg ressurs';

  @override
  String get clearStyle => 'Fjern stil';

  @override
  String get unknownImportType => 'Ukjent importtype';

  @override
  String get sureImportTemplate => 'Er du sikker på at du vil importere malen?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Spill';

  @override
  String get video => 'Video';

  @override
  String get fps => 'BPS';

  @override
  String get breakpoint => 'Brytningspunkt';

  @override
  String get presentationControls => 'Slike presentasjonskontroller';

  @override
  String get nextSlide => 'Neste side';

  @override
  String get nextSlideDescription =>
      'Sveip til høyre eller trykk på høyre piltast for å gå til neste side';

  @override
  String get previousSlide => 'Forrige side';

  @override
  String get previousSlideDescription =>
      'Sveip til venstre eller trykk på venstre piltasten for å gå til forrige lysbilde';

  @override
  String get exitPresentation => 'Avslutt presentasjon';

  @override
  String get exitPresentationDescription =>
      'Trykk på rømningstasten eller dra ned for å avslutte presentasjonen';

  @override
  String get pausePresentation => 'Pause presentasjonen';

  @override
  String get pausePresentationDescription =>
      'Trykk på skjermen eller trykk på mellomromstangen for å stanse eller gjenoppta presentasjonen';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'Du har nådd slutten av presentasjonen';

  @override
  String get startOfPresentation => 'Du har nådd starten av presentasjonen';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Overskrift $index';
  }

  @override
  String get code => 'Kode';

  @override
  String get quote => 'Sitat';

  @override
  String get link => 'Lenke';

  @override
  String get checkbox => 'Avmerkingsboks';

  @override
  String get deleted => 'Slettet';

  @override
  String get emphasis => 'Emphasis';

  @override
  String get listBullet => 'Liste punkt';

  @override
  String get strong => 'Sterk';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Hjem';

  @override
  String get files => 'Filer';

  @override
  String get sortBy => 'Sorter etter';

  @override
  String get location => 'Sted';

  @override
  String get whatsNew => 'Hva er nytt?';

  @override
  String get unstar => 'Stjerne';

  @override
  String get star => 'Stjerne';

  @override
  String get goUp => 'Gå opp';

  @override
  String get created => 'Opprettet';

  @override
  String get modified => 'Endret';

  @override
  String get quickstart => 'Hurtigstart';

  @override
  String get noTemplates => 'Det er ingen maler tilgjengelig';

  @override
  String get importCorePack => 'Importer kjerne pakke';

  @override
  String get importCorePackDescription =>
      'Importer kjerne pakken som inneholder alle grunnleggende ressurser for å komme i gang. Dette vil overstyre den gjeldende kjernepakken.';

  @override
  String get never => 'Aldri';

  @override
  String get onlyOnUpdates => 'Bare når det gjelder oppdateringer';

  @override
  String get visibility => 'Synlighet';

  @override
  String get captureThumbnail => 'Ta opp miniatyrbilde';

  @override
  String get capturedThumbnail => 'Miniatyrbildet ble tatt opp';

  @override
  String get chooseLabelMode => 'Velg etikett-modus';

  @override
  String get foreground => 'Forgrunn';

  @override
  String get version => 'Versjon';

  @override
  String get repository => 'Kodelager';

  @override
  String get pages => 'Sider';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Ordne';

  @override
  String get bringToFront => 'Plasser lengst frem';

  @override
  String get sendToBack => 'Send til tilbake';

  @override
  String get bringForward => 'Send fremover';

  @override
  String get sendBackward => 'Send bakover';

  @override
  String get rotation => 'Rotasjon';

  @override
  String get onlyAvailableLargerScreen =>
      'Bare tilgjengelig på større skjermer';

  @override
  String get toolbarPosition => 'Plassering av verktøylinje';

  @override
  String get rotate => 'Roter';

  @override
  String get spacer => 'Mellomrom';

  @override
  String get navigationRail => 'Navigasjon bane';

  @override
  String get cut => 'Klipp';

  @override
  String get insertBefore => 'Innsett før';

  @override
  String get insertAfter => 'Innsett etter';

  @override
  String get insertFirst => 'Sett inn først';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Lim';

  @override
  String get ascending => 'Stigende';

  @override
  String get descending => 'Synkende';

  @override
  String get imageScale => 'Bilde skalering';

  @override
  String get select => 'Velg';

  @override
  String get tool => 'Verktøy';

  @override
  String get texture => 'Tekstur';

  @override
  String get platformTheme => 'Plattform-tema';

  @override
  String get desktop => 'Skrivebord';

  @override
  String get mobile => 'Mobil';

  @override
  String get pdfQuality => 'PDF kvalitet';

  @override
  String get surface => 'Overflate';

  @override
  String get pattern => 'Mønster';

  @override
  String get sureClose => 'Er du sikker på at du vil lukke dokumentet?';

  @override
  String get thereAreUnsavedChanges => 'Det er ulagrede endringer';

  @override
  String get page => 'Side';

  @override
  String get iceServers => 'ICE servere';

  @override
  String get collaboration => 'Samarbeid';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Web Socket';

  @override
  String get iceServer => 'ICE server';

  @override
  String get port => 'Port';

  @override
  String get type => 'Type:';

  @override
  String get side => 'Farge';

  @override
  String get client => 'Klient';

  @override
  String get server => 'Tjener';

  @override
  String get switchView => 'Bytt visning';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'Skjul brukergrensesnitt';

  @override
  String get density => 'Tetthet';

  @override
  String get compact => 'Kompakt';

  @override
  String get comfortable => 'Komfortabel';

  @override
  String get standard => 'Vanlig';

  @override
  String get lock => 'Lås';

  @override
  String get addElement => 'Legg til element';

  @override
  String get notDefaultConnection => 'Ikke standard tilkobling';

  @override
  String get defaultConnection => 'Standard tilkobling';

  @override
  String get hide => 'Skjul';

  @override
  String get show => 'Vis';

  @override
  String get pause => 'pause';

  @override
  String get stop => 'Stopp';

  @override
  String get refresh => 'Oppdater';

  @override
  String get print => 'Utskrift';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Øyedråper';

  @override
  String get users => 'Brukere';

  @override
  String get experiments => 'Eksperimenter';

  @override
  String get address => 'Adresse';

  @override
  String get spreadToPages => 'Spre til sider';

  @override
  String get rootDirectorySpecifiedDescription =>
      'Rotmappen er angitt. Alle avanserte katalogbaner vil være relative til denne mappen. Behold den tom for å deaktivere denne mappen.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'Rotmappen er ikke angitt. Et navn kreves. Alle avanserte katalogbaner er absolutt. Behold den tom for å deaktivere denne mappetypen.';

  @override
  String get unsecureConnectionTitle => 'Usikker tilkobling';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'Tilkoblingen er ikke sikker. Dette kan være en sikkerhetsrisiko. Bare fortsett hvis du stoler på tilkoblingen. Da er sha1 fingeravtrykk er $fingerprint.';
  }

  @override
  String get continueAnyway => 'Fortsett likevel';

  @override
  String get zoomControl => 'Zoom kontroll';

  @override
  String get highContrast => 'Høy kontrast';

  @override
  String get shouldANumber => 'Denne verdien må være et gyldig tall';

  @override
  String get createAreas => 'Opprett områder';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Aktiviteter';

  @override
  String get medium => 'Middels';

  @override
  String get large => 'Stor';

  @override
  String get toolbarSize => 'Størrelse på verktøylinje';

  @override
  String get addAll => 'Legg til alle';

  @override
  String get onlyCurrentPage => 'Bare gjeldende side';

  @override
  String get smoothNavigation => 'Jevn navigasjon';

  @override
  String get exact => 'Nøyaktig';

  @override
  String get inline => 'Innebygd';

  @override
  String get toolbarRows => 'Linjer på verktøylinje';

  @override
  String get pointerTest => 'Pekers test';

  @override
  String get pressure => 'Trykk';

  @override
  String get small => 'Liten';

  @override
  String get tiny => 'Bitteliten';

  @override
  String get selectAll => 'Velg alle';

  @override
  String get overrideTools => 'Overstyr verktøy';

  @override
  String get hideCursorWhileDrawing => 'Skjul markøren under tegning';

  @override
  String get installed => 'Installert';

  @override
  String get install => 'Installer';

  @override
  String get deselect => 'Avvelg';

  @override
  String get changeCollection => 'Endre samling';

  @override
  String get collections => 'Samlinger';

  @override
  String get fullSelection => 'Fullt valg';

  @override
  String get fullSelectionDescription =>
      'Krever at elementer er fullstendig inne i avmerkingsboksen for valg.';

  @override
  String get collection => 'Samling';

  @override
  String get defaultCollection => 'Standard samling';

  @override
  String get scroll => 'Rull';

  @override
  String get onStartup => 'Ved oppstart';

  @override
  String get homeScreen => 'Hjem-skjerm';

  @override
  String get lastNote => 'Siste notat';

  @override
  String get newNote => 'Nytt notat';

  @override
  String get convertToLayer => 'Konverter til lag';

  @override
  String get merge => 'Flett';

  @override
  String get up => 'Opp';

  @override
  String get down => 'Ned';

  @override
  String get other => 'Annet';

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
  String get colorToolbar => 'Farge Verktøylinje';

  @override
  String get yesButShowButtons => 'Ja, men vis knapper';

  @override
  String get optionsPanelPosition => 'Options panel plassering';

  @override
  String get hideDuration => 'Skjul varighet';

  @override
  String get animation => 'Animasjon';

  @override
  String get performance => 'Ytelse';

  @override
  String get performanceDescription =>
      'Optimalisert for hastighet og minnebruk. Bare synlig del av notatet blir bakt i bildet.';

  @override
  String get normalDescription =>
      'Balanser kvalitet og ytelse. Baker et bilde over 1,5 ganger synlig område, gir jevnere overgang når man scroller.';

  @override
  String get high => 'Høy';

  @override
  String get highDescription =>
      'Beskrivelse: Maksimer kvalitet på kostnadene ved ytelse. Baker et bilde som dekker to ganger det synlige området, noe som sikrer sømløs gjengivelse selv under rask rulling eller zooming.';

  @override
  String get renderResolution => 'Gjengi oppløsning';

  @override
  String get translate => 'Oversett';

  @override
  String get unencrypted => 'Ukryptert';

  @override
  String get encrypted => 'Kryptert';

  @override
  String get encryptDocumentMessage => 'Klikk for å kryptere dokumentet';

  @override
  String get unencryptDocumentMessage =>
      'Klikk for å fjerne kryptering av dokumentet';

  @override
  String get unencrypt => 'Ukryptert';

  @override
  String get encrypt => 'Krypter';

  @override
  String get encryptWarning =>
      'Vil kryptere dokumentet. Du må huske passordet for å dekryptere dokumentet.';

  @override
  String get unencryptWarning =>
      'Dette vil ukryptere dokumentet. Passordet vil bli fjernet, og alle med tilgang vil kunne åpne det.';

  @override
  String get confirmPassword => 'Bekreft passord';

  @override
  String get passwordMismatch => 'Passordene samsvarer ikke';

  @override
  String get action => 'Handling';

  @override
  String get svgText => 'SVG tekst';

  @override
  String get offset => 'Forskyvning';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
