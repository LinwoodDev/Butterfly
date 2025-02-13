// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get open => 'Open';

  @override
  String get settings => 'Instellingen';

  @override
  String get personalization => 'Personalisatie';

  @override
  String get theme => 'Thema';

  @override
  String get darkTheme => 'Donker thema';

  @override
  String get lightTheme => 'Licht thema';

  @override
  String get systemTheme => 'Gebruik standaard systeemthema';

  @override
  String get view => 'Bekijken';

  @override
  String get edit => 'Bewerken';

  @override
  String get export => 'Exporteren';

  @override
  String get save => 'Opslaan';

  @override
  String get zoom => 'Inzoomen';

  @override
  String get zoomIn => 'Zoom in';

  @override
  String get zoomOut => 'Zoom uit';

  @override
  String get resetZoom => 'Reset zoom';

  @override
  String get strokeWidth => 'Stroke breedte';

  @override
  String get includeEraser => 'Inclusief gum';

  @override
  String get thinning => 'Duiken';

  @override
  String get pen => 'pennen';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Pad gum';

  @override
  String get label => 'Omschrijving';

  @override
  String get delete => 'Verwijderen';

  @override
  String get areYouSure => 'Weet je het zeker?';

  @override
  String get reallyDelete => 'Weet u zeker dat u dit artikel wilt verwijderen?';

  @override
  String get no => 'Neen';

  @override
  String get yes => 'ja';

  @override
  String get undo => 'Herstel';

  @override
  String get redo => 'Opnieuw';

  @override
  String get general => 'Algemeen';

  @override
  String get copyTitle => 'Gekopieerd naar klembord';

  @override
  String get loading => 'Laden...';

  @override
  String get enterText => 'Voer de tekst in';

  @override
  String get size => 'Grootte';

  @override
  String get width => 'Width';

  @override
  String get height => 'Højde';

  @override
  String get count => 'Tel';

  @override
  String get space => 'Spatiebalk';

  @override
  String get background => 'Achtergrond';

  @override
  String get box => 'Vierkant';

  @override
  String get locale => 'Lokalisatie';

  @override
  String get systemLocale => 'Systeem lokalisatie';

  @override
  String get information => 'Informatie';

  @override
  String get license => 'Licentie';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacypolicy => 'Privacy Beleid';

  @override
  String get source => 'Bron';

  @override
  String get documentation => 'Documentatie';

  @override
  String get changelog => 'Wijzigingslogboek';

  @override
  String get existOverride => 'Dit element bestaat al. Overschrijven?';

  @override
  String get description => 'Beschrijving';

  @override
  String get fill => 'Invullen';

  @override
  String get defaultPalette => 'Standaard palet';

  @override
  String get highlighter => 'Markeerstift';

  @override
  String get add => 'Toevoegen';

  @override
  String get remove => 'Verwijderen';

  @override
  String get removeConfirm => 'Weet je zeker dat je dit wilt verwijderen?';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => 'Aangepaste';

  @override
  String get decoration => 'Decoratie';

  @override
  String get underline => 'Onderstrepen';

  @override
  String get overline => 'Overlijn';

  @override
  String get strikethrough => 'Doorhalen';

  @override
  String get thickness => 'Dikte';

  @override
  String get style => 'CSS';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Dubbel';

  @override
  String get dotted => 'Gestippeld';

  @override
  String get dashed => 'Onderbroken';

  @override
  String get wavy => 'Golf';

  @override
  String get fontWeight => 'Lettertype gewicht';

  @override
  String get normal => 'normaal';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Klembord';

  @override
  String get file => 'Bestand';

  @override
  String get data => 'Gegevens';

  @override
  String get share => 'Delen';

  @override
  String get spacing => 'Afstand';

  @override
  String get image => 'Afbeelding';

  @override
  String get enterUrl => 'Voer de URL in';

  @override
  String get scale => 'Schaal';

  @override
  String get help => 'Hulp';

  @override
  String get reallyReset => 'Weet u zeker dat u het wilt resetten?';

  @override
  String get whatToDo => 'Wat wil je doen?';

  @override
  String get ignore => 'Negeren';

  @override
  String get backup => 'Back-up';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'Het bestand $fileName is gemaakt in een nieuwere versie ($fileVersion). Wat moet er met dit bestand worden gedaan?';
  }

  @override
  String get waypoints => 'Routepunten';

  @override
  String get origin => 'Oorsprong';

  @override
  String get import => 'Importeren';

  @override
  String get newContent => 'Nieuw';

  @override
  String get selectElement => 'Element selecteren';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Verschuiving';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Versie kopiëren';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Gedrag';

  @override
  String get dataDirectory => 'Data map';

  @override
  String get defaultPath => 'Standaard pad';

  @override
  String get dateFormat => 'Datum formaat';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Bijgewerkt op: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Aangemaakt op: $dateTimeString';
  }

  @override
  String get rename => 'Hernoem';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => 'Hand';

  @override
  String get folder => 'Map';

  @override
  String get move => 'Verplaatsen';

  @override
  String get copy => 'Kopiëren';

  @override
  String get back => 'Achterzijde';

  @override
  String get zoomDependent => 'Afhankelijk zoomen';

  @override
  String get shapeDetection => 'Vorm Detectie';

  @override
  String get delay => 'Vertraging';

  @override
  String get defaultLayer => 'Standaard laag';

  @override
  String get layer => 'Laag';

  @override
  String get layers => 'Lagen';

  @override
  String get notSet => 'Niet ingesteld';

  @override
  String get enterLayer => 'Voer de naam van de laag in';

  @override
  String get selectElements => 'Elementen selecteren';

  @override
  String get deleteElements => 'Elementen verwijderen';

  @override
  String get deleteElementsConfirm =>
      'Weet u zeker dat u de geselecteerde elementen wilt verwijderen?';

  @override
  String get selectCustomCollection => 'Selecteer een aangepaste collectie';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => 'Gevoeligheid';

  @override
  String get sensitivityHint => 'Hoe hoger de waarde, hoe gevoeliger de input';

  @override
  String get horizontal => 'Horizontaal';

  @override
  String get vertical => 'Verticaal';

  @override
  String get plain => 'Eenvoudig';

  @override
  String get light => 'Licht';

  @override
  String get ruled => 'Gerecht';

  @override
  String get quad => 'Quad';

  @override
  String get music => 'Muziek';

  @override
  String get dark => 'Donker';

  @override
  String get plainDark => 'Donker';

  @override
  String get ruledDark => 'Geruïneerd donker';

  @override
  String get quadDark => 'Quad donker';

  @override
  String get musicDark => 'Muziek donker';

  @override
  String get templates => 'Sjablonen';

  @override
  String get untitled => 'Naamloos';

  @override
  String get createTemplate => 'Sjabloon aanmaken';

  @override
  String get createTemplateContent =>
      'Wilt u echt een template van dit document aanmaken? Het oorspronkelijke document zal worden verwijderd.';

  @override
  String get replace => 'Vervangen';

  @override
  String get reallyReplace =>
      'Wilt u echt de template vervangen? Deze actie kan niet ongedaan worden gemaakt!';

  @override
  String get defaultTemplate => 'Standaard sjabloon';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'Document';

  @override
  String get camera => 'camera';

  @override
  String get printout => 'Afdrukken';

  @override
  String get selectCamera => 'Selecteer een camera';

  @override
  String get changeDocumentPath => 'Documentpad wijzigen';

  @override
  String get deleteWholeStroke => 'Verwijder hele streek';

  @override
  String get alpha => 'Transparantie';

  @override
  String get area => 'Oppervlak';

  @override
  String get selectArea => 'Selecteer een gebied';

  @override
  String get aspectRatio => 'Aspect verhouding';

  @override
  String get presets => 'Voorkeursinstellingen';

  @override
  String get pagePortrait => 'Pagina portret';

  @override
  String get pageLandscape => 'Pagina liggend';

  @override
  String get square => 'Vierkant';

  @override
  String get areas => 'Gebieden';

  @override
  String get enterArea => 'Voer het gebied in';

  @override
  String get exitArea => 'Verlaat het gebied';

  @override
  String get currentArea => 'Huidig gebied';

  @override
  String get design => 'Ontwerp';

  @override
  String get text => 'Tekstveld';

  @override
  String welcome(String codeName) {
    return 'Hé, dit is Linwood Vlinder';
  }

  @override
  String get welcomeContent => 'Een vrije en open source tekenruimte!';

  @override
  String updated(String version) {
    return 'App bijgewerkt naar versie $version';
  }

  @override
  String get releaseNotes => 'Release notities';

  @override
  String get constraints => 'beperkingen';

  @override
  String get scaled => 'Geschaald';

  @override
  String get fixed => 'Opgelost';

  @override
  String get dynamicContent => 'Dynamisch';

  @override
  String get none => 'geen';

  @override
  String get includeArea => 'Opnemen van gebied';

  @override
  String get verticalAlignment => 'Verticale uitlijning';

  @override
  String get horizontalAlignment => 'Horizontale uitlijning';

  @override
  String get top => 'Bovenkant';

  @override
  String get center => 'Gecentreerd';

  @override
  String get bottom => 'Onderaan';

  @override
  String get left => 'Linkerkant';

  @override
  String get right => 'Rechterkant';

  @override
  String get justify => 'Uitlijnen';

  @override
  String get constraint => 'Beperking';

  @override
  String get length => 'longueur';

  @override
  String get exportSvg => 'SVG exporteren';

  @override
  String get pdf => 'PDF-bestand';

  @override
  String get selectPages => 'Pagina\'s selecteren';

  @override
  String get recentFiles => 'Recente bestanden';

  @override
  String get start => 'Beginnen';

  @override
  String get noRecentFiles => 'Geen recente bestanden';

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
    return 'Pagina $index';
  }

  @override
  String get exit => 'Afsluiten';

  @override
  String get noElements => 'Geen elementen';

  @override
  String get invertSelection => 'Selectie omkeren';

  @override
  String get errorWhileImporting => 'Fout tijdens importeren';

  @override
  String get errorWhileImportingContent =>
      'Er is een fout opgetreden tijdens het importeren van het bestand';

  @override
  String get showDetails => 'Details weergeven';

  @override
  String get hideDetails => 'Details verbergen';

  @override
  String get error => 'Foutmelding';

  @override
  String get stackTrace => 'Stapel traceren';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Duur';

  @override
  String get quality => 'Kwaliteit';

  @override
  String get exportPdf => 'Exporteren als PDF';

  @override
  String get local => 'lokaal';

  @override
  String get addConnection => 'Contact toevoegen';

  @override
  String get connections => 'Verbindingen';

  @override
  String get noConnections => 'Geen verbindingen';

  @override
  String get url => 'URL';

  @override
  String get connect => 'Verbinden';

  @override
  String get username => 'Gebruikersnaam';

  @override
  String get password => 'Wachtwoord';

  @override
  String get webNotSupported => 'Web niet ondersteund';

  @override
  String get advanced => 'Geavanceerd';

  @override
  String get directory => 'Catalogus';

  @override
  String get documentsDirectory => 'Documenten map';

  @override
  String get templatesDirectory => 'Templates map';

  @override
  String get errorWhileCreatingConnection =>
      'Fout tijdens het maken van de verbinding';

  @override
  String get cannotConnect => 'Kan niet verbinden';

  @override
  String get urlNotValid => 'URL niet geldig';

  @override
  String get icon => 'Pictogram';

  @override
  String get update => 'Vernieuwen';

  @override
  String get updateAvailable => 'Update beschikbaar';

  @override
  String get stable => 'Stabiel';

  @override
  String get nightly => 'Nachtelijk';

  @override
  String get checkForUpdates => 'Op updates controleren';

  @override
  String get checkForUpdatesWarning =>
      'Bij het uitvoeren van een controle op updates wordt verbinding gemaakt met de website Butterfly om de informatie te krijgen.';

  @override
  String get usingLatestStable => 'U gebruikt de laatste stabiele versie';

  @override
  String get usingLatestNightly => 'U gebruikt de laatste nightly versie';

  @override
  String get currentVersion => 'Huidige versie';

  @override
  String get updateNow => 'Nu bijwerken';

  @override
  String get shape => 'Vorm';

  @override
  String get circle => 'Cirkel';

  @override
  String get rectangle => 'Rechthoek';

  @override
  String get triangle => 'Driehoek';

  @override
  String get line => 'Lijn';

  @override
  String get cornerRadius => 'Corner radius';

  @override
  String get topLeft => 'Boven links';

  @override
  String get topRight => 'Boven rechts';

  @override
  String get bottomLeft => 'Links onder';

  @override
  String get bottomRight => 'Onder rechts';

  @override
  String get caches => 'Caches';

  @override
  String get manage => 'Beheren';

  @override
  String get clearCaches => 'Caches wissen';

  @override
  String get createCache => 'Maak cache';

  @override
  String get thirdPartyLicenses => 'Licenties van derden';

  @override
  String get syncing => 'Synchroniseren...';

  @override
  String get synced => 'Gesynchroniseerd';

  @override
  String get notSynced => 'Niet gesynchroniseerd';

  @override
  String get conflict => 'Conflict';

  @override
  String get keepLocal => 'Lokaal behouden';

  @override
  String get keepConnection => 'Connectie behouden';

  @override
  String get keepBoth => 'Houd beide';

  @override
  String get forAll => 'Voor alle';

  @override
  String fileConflict(String file, String connection) {
    return '$file in $connection heeft een conflict';
  }

  @override
  String get offline => 'Offline';

  @override
  String get localLatest => 'Lokale nieuwste';

  @override
  String get connectionLatest => 'Laatste verbinding';

  @override
  String get path => 'Pad';

  @override
  String get folderSynced => 'Map gesynchroniseerd';

  @override
  String get syncRootDirectory => 'Synchroniseer hoofdmap';

  @override
  String get penOnlyInput => 'Alleen invoer pen';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Oorspronkelijke titelbalk';

  @override
  String get syncMode => 'Synchronisatie modus';

  @override
  String get connection => 'Verbindingsinstellingen';

  @override
  String get always => 'altijd';

  @override
  String get noMobile => 'Geen mobiel';

  @override
  String get manual => 'Handleiding';

  @override
  String get search => 'Zoeken';

  @override
  String get properties => 'Eigenschappen';

  @override
  String get pin => 'Vastzetten';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Element';

  @override
  String get painter => 'Schilder';

  @override
  String get position => 'Positie';

  @override
  String get note => 'Notitie';

  @override
  String get packs => 'Pakketten';

  @override
  String get pack => 'Pakket';

  @override
  String get more => 'Meer';

  @override
  String get askForName => 'Vraag om naam';

  @override
  String areaIndex(int index) {
    return 'Gebied $index';
  }

  @override
  String get startInFullScreen => 'Start op volledig scherm';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Muis';

  @override
  String get touch => 'Aanraking';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Snelkoppelingen';

  @override
  String get middle => 'Midden';

  @override
  String get first => 'Eerste';

  @override
  String get second => 'Tweede';

  @override
  String get tools => 'Hulpmiddelen';

  @override
  String get showGrid => 'Raster weergeven';

  @override
  String get grid => 'Rooster';

  @override
  String get ruler => 'Liniaal';

  @override
  String get angle => 'Hoek';

  @override
  String get report => 'Rapporteren';

  @override
  String get newFolder => 'Nieuwe map';

  @override
  String get createPack => 'Pakket aanmaken';

  @override
  String get editPack => 'Pakket bewerken';

  @override
  String get packsDirectory => 'Pakketten map';

  @override
  String get stamp => 'Zegel';

  @override
  String get addToPack => 'Voeg toe aan pakket';

  @override
  String get sureImportPack => 'Weet u zeker dat u het pakket wilt importeren?';

  @override
  String byAuthor(String author) {
    return 'door $author';
  }

  @override
  String get author => 'Auteur';

  @override
  String get addAsset => 'Bestand toevoegen';

  @override
  String get editAsset => 'Bestand bewerken';

  @override
  String get scope => 'Bereik';

  @override
  String get noPacks => 'Er zijn momenteel geen pakketten beschikbaar';

  @override
  String get components => 'Onderdelen';

  @override
  String get waypoint => 'Routepunt';

  @override
  String get actions => 'acties';

  @override
  String get painters => 'Schilders';

  @override
  String get breakingChangesTitle => 'Wijzigingen breken';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Er zijn onvolledige wijzigingen in deze versie. Lees alstublieft de changelog voordat u het update. De huidige bestandsversie is $version, de nieuwe versie is $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Paragraaf';

  @override
  String get fontFamily => 'Lettertype familie';

  @override
  String get smoothing => 'Vloeiend';

  @override
  String get streamline => 'Stroomlijn';

  @override
  String get presentation => 'Presentatie';

  @override
  String get selectAsset => 'Selecteer een asset';

  @override
  String get clearStyle => 'Opmaak wissen';

  @override
  String get unknownImportType => 'Onbekend importtype';

  @override
  String get sureImportTemplate =>
      'Weet u zeker dat u de template wilt importeren?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Afspelen';

  @override
  String get video => 'Video';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Breekpunt';

  @override
  String get presentationControls => 'Presentatie besturing';

  @override
  String get nextSlide => 'Volgende slide';

  @override
  String get nextSlideDescription =>
      'Swipe naar rechts of druk op de rechter pijltjestoets om naar de volgende slide te gaan';

  @override
  String get previousSlide => 'Vorige slide';

  @override
  String get previousSlideDescription =>
      'Swipe naar links of druk op de linker pijltjestoets om naar de vorige slide te gaan';

  @override
  String get exitPresentation => 'Aanbieding afsluiten';

  @override
  String get exitPresentationDescription =>
      'Druk op de ontsnappingsknop of veeg naar beneden om de presentatie te verlaten';

  @override
  String get pausePresentation => 'Presentatie pauzeren';

  @override
  String get pausePresentationDescription =>
      'Tik op het scherm of druk op de spatiebalk om de presentatie te pauzeren of te hervatten';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation =>
      'Je bent aan het einde van de presentatie gekomen';

  @override
  String get startOfPresentation =>
      'U bent aan het begin van de presentatie gekomen';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Kop $index';
  }

  @override
  String get code => 'Code';

  @override
  String get quote => 'Offerte';

  @override
  String get link => 'Koppeling';

  @override
  String get checkbox => 'Selectievakje';

  @override
  String get deleted => 'Verwijderd';

  @override
  String get emphasis => 'Nadruk';

  @override
  String get listBullet => 'Lijst opsommingsteken';

  @override
  String get strong => 'Sterk';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Startpagina';

  @override
  String get files => 'Bestanden';

  @override
  String get sortBy => 'Sorteren op';

  @override
  String get location => 'Locatie';

  @override
  String get whatsNew => 'Wat is nieuw?';

  @override
  String get unstar => 'Ontster';

  @override
  String get star => 'Ster';

  @override
  String get goUp => 'Ga omhoog';

  @override
  String get created => 'Aangemaakt';

  @override
  String get modified => 'Gewijzigd';

  @override
  String get quickstart => 'Snelstart';

  @override
  String get noTemplates => 'Er zijn momenteel geen sjablonen beschikbaar';

  @override
  String get importCorePack => 'Importeer core pakket';

  @override
  String get importCorePackDescription =>
      'Importeer het core pakket dat alle basisassets bevat om aan de slag te gaan. Dit zal het huidige core pakket overschrijven.';

  @override
  String get never => 'Nooit';

  @override
  String get onlyOnUpdates => 'Alleen op updates';

  @override
  String get visibility => 'Zichtbaarheid';

  @override
  String get captureThumbnail => 'Thumbnail opnemen';

  @override
  String get capturedThumbnail => 'Miniatuurweergave succesvol vastgelegd';

  @override
  String get chooseLabelMode => 'Kies labelmodus';

  @override
  String get foreground => 'Voorgrond';

  @override
  String get version => 'Versie';

  @override
  String get repository => 'Bewaarplaats';

  @override
  String get pages => 'Pagina\'s';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Ordenen';

  @override
  String get bringToFront => 'Naar voren brengen';

  @override
  String get sendToBack => 'Stuur naar achterkant';

  @override
  String get bringForward => 'Breng naar voren';

  @override
  String get sendBackward => 'Stuur achteruit';

  @override
  String get rotation => 'Rotatie';

  @override
  String get onlyAvailableLargerScreen =>
      'Alleen beschikbaar op grotere schermen';

  @override
  String get toolbarPosition => 'Werkbalk positie';

  @override
  String get rotate => 'Draaien';

  @override
  String get spacer => 'Afstandshouder';

  @override
  String get navigationRail => 'Navigatie spoor';

  @override
  String get cut => 'Knippen';

  @override
  String get insertBefore => 'Voordat invoegen';

  @override
  String get insertAfter => 'Voeg toe na';

  @override
  String get insertFirst => 'Eerst invoegen';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Plakken';

  @override
  String get ascending => 'Oplopend';

  @override
  String get descending => 'Aflopend';

  @override
  String get imageScale => 'Afbeelding schaal';

  @override
  String get select => 'Selecteren';

  @override
  String get tool => 'Gereedschap';

  @override
  String get texture => 'Textuur';

  @override
  String get platformTheme => 'Platform thema';

  @override
  String get desktop => 'Startscherm';

  @override
  String get mobile => 'Mobiel';

  @override
  String get pdfQuality => 'PDF kwaliteit';

  @override
  String get surface => 'Oppervlak';

  @override
  String get pattern => 'Patroon';

  @override
  String get sureClose => 'Weet u zeker dat u het document wilt sluiten?';

  @override
  String get thereAreUnsavedChanges => 'Er zijn niet-opgeslagen wijzigingen';

  @override
  String get page => 'Pagina';

  @override
  String get iceServers => 'ICE servers';

  @override
  String get collaboration => 'Samenwerken';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Web Socket';

  @override
  String get iceServer => 'ICE server';

  @override
  String get port => 'Poort';

  @override
  String get type => 'Type';

  @override
  String get side => 'Zijde';

  @override
  String get client => 'Klant';

  @override
  String get server => 'Server';

  @override
  String get switchView => 'Wissel weergave';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'Verberg UI';

  @override
  String get density => 'Dichtheid';

  @override
  String get compact => 'Compacte';

  @override
  String get comfortable => 'Comfortabel';

  @override
  String get standard => 'Standaard';

  @override
  String get lock => 'Vergrendelen';

  @override
  String get addElement => 'Element toevoegen';

  @override
  String get notDefaultConnection => 'Niet standaard verbinding';

  @override
  String get defaultConnection => 'Standaard connectie';

  @override
  String get hide => 'Verbergen';

  @override
  String get show => 'Weergeven';

  @override
  String get pause => 'Onderbreken';

  @override
  String get stop => 'Stoppen';

  @override
  String get refresh => 'Vernieuwen';

  @override
  String get print => 'Afdrukken';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Oog dropper';

  @override
  String get users => 'Gebruikers';

  @override
  String get experiments => 'Experimenten';

  @override
  String get address => 'Adres:';

  @override
  String get spreadToPages => 'Verspreid naar pagina\'s';

  @override
  String get rootDirectorySpecifiedDescription =>
      'De hoofdmap is opgegeven. Alle geavanceerde mappen zullen relatief zijn ten opzichte van deze map. Laat het leeg om dit maptype uit te schakelen.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'De hoofdmap is niet opgegeven. Een naam is vereist. Alle geavanceerde directory paden zullen absoluut zijn. Leeg houden om dit type map uit te schakelen.';

  @override
  String get unsecureConnectionTitle => 'Onveilige verbinding';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'De verbinding is niet beveiligd. Dit kan een beveiligingsrisico zijn. Ga alleen verder als je de verbinding vertrouwt. De sha1 vingerafdruk is $fingerprint.';
  }

  @override
  String get continueAnyway => 'Toch doorgaan';

  @override
  String get zoomControl => 'Zoom beheer';

  @override
  String get highContrast => 'Hoog contrast';

  @override
  String get shouldANumber => 'Deze waarde moet een geldig nummer zijn';

  @override
  String get createAreas => 'Maak gebieden';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Bewerkingen';

  @override
  String get medium => 'Middelgroot';

  @override
  String get large => 'groot';

  @override
  String get toolbarSize => 'Werkbalk grootte';

  @override
  String get addAll => 'Alles toevoegen';

  @override
  String get onlyCurrentPage => 'Alleen huidige pagina';

  @override
  String get smoothNavigation => 'Vloeiende navigatie';

  @override
  String get exact => 'Exacte';

  @override
  String get inline => 'Inline';

  @override
  String get toolbarRows => 'Werkbalk rijen';

  @override
  String get pointerTest => 'Testen van aanwijzer';

  @override
  String get pressure => 'Drukdruk';

  @override
  String get small => 'Klein';

  @override
  String get tiny => 'Klein';

  @override
  String get selectAll => 'Alles selecteren';

  @override
  String get overrideTools => 'Hulpmiddelen vervangen';

  @override
  String get hideCursorWhileDrawing => 'Verberg cursor tijdens tekenen';

  @override
  String get installed => 'Geinstalleerd';

  @override
  String get install => 'Installeren';

  @override
  String get deselect => 'Deselecteer';

  @override
  String get changeCollection => 'Verzameling wijzigen';

  @override
  String get collections => 'Collecties';

  @override
  String get fullSelection => 'Volledige selectie';

  @override
  String get fullSelectionDescription =>
      'Vereist elementen om volledig in het selectievakje te zijn voor selectie.';

  @override
  String get collection => 'Collectie';

  @override
  String get defaultCollection => 'Standaard collectie';

  @override
  String get scroll => 'Scrollen';

  @override
  String get onStartup => 'Bij het opstarten';

  @override
  String get homeScreen => 'Startscherm';

  @override
  String get lastNote => 'Laatste opmerking';

  @override
  String get newNote => 'Nieuwe notitie';

  @override
  String get convertToLayer => 'Converteren naar laag';

  @override
  String get merge => 'Samenvoegen';

  @override
  String get up => 'Omhoog';

  @override
  String get down => 'Omlaag';

  @override
  String get other => 'anders';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementen',
      one: '1 element',
      zero: 'Geen elementen',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Kleur werkbalk';

  @override
  String get yesButShowButtons => 'Ja, maar toon knoppen';

  @override
  String get optionsPanelPosition => 'Opties paneel positie';

  @override
  String get hideDuration => 'Duur verbergen';

  @override
  String get animation => 'Animatie';

  @override
  String get performance => 'Prestaties';

  @override
  String get performanceDescription =>
      'Geoptimaliseerd voor snelheid en geheugengebruik. Alleen het zichtbare deel van de notitie wordt in de afbeelding gebakken.';

  @override
  String get normalDescription =>
      'Geeft een balans van kwaliteit en prestaties. Maakt een afbeelding die 1,5 keer het zichtbare gebied beslaat en biedt betere overgangen bij het scrollen.';

  @override
  String get high => 'hoog';

  @override
  String get highDescription =>
      'Omschrijving: maximaliseert kwaliteit ten koste van de prestaties. Neemt een afbeelding die 2 keer het zichtbare gebied beslaat, waardoor naadloos wordt weergegeven, zelfs tijdens snel scrollen of zoomen';

  @override
  String get renderResolution => 'Resolutie weergeven';

  @override
  String get translate => 'Vertalen';

  @override
  String get unencrypted => 'Onversleuteld';

  @override
  String get encrypted => 'Versleuteld';

  @override
  String get encryptDocumentMessage => 'Klik om het document te coderen';

  @override
  String get unencryptDocumentMessage => 'Klik om het document te ontsleutelen';

  @override
  String get unencrypt => 'Onversleutelen';

  @override
  String get encrypt => 'Versleutelen';

  @override
  String get encryptWarning =>
      'Dit zal het document versleutelen. U moet het wachtwoord onthouden om het te ontsleutelen.';

  @override
  String get unencryptWarning =>
      'Dit zal het document decoderen. Het wachtwoord zal worden verwijderd en iedereen met toegang zal het kunnen openen.';

  @override
  String get confirmPassword => 'Bevestig wachtwoord';

  @override
  String get passwordMismatch => 'De wachtwoorden komen niet overeen';

  @override
  String get action => 'actie';

  @override
  String get svgText => 'SVG tekst';

  @override
  String get offset => 'Verschuiving';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
