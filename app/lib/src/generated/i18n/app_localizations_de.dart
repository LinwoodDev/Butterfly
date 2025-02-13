// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get open => 'Öffnen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get personalization => 'Personalisierung';

  @override
  String get theme => 'Thema';

  @override
  String get darkTheme => 'Dunkles Design';

  @override
  String get lightTheme => 'Helles Theme';

  @override
  String get systemTheme => 'Standard-System-Theme verwenden';

  @override
  String get view => 'Ansicht';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get export => 'Exportieren';

  @override
  String get save => 'Speichern';

  @override
  String get zoom => 'Zoom';

  @override
  String get zoomIn => 'Vergrößern';

  @override
  String get zoomOut => 'Verkleinern';

  @override
  String get resetZoom => 'Vergrößerung zurücksetzen';

  @override
  String get strokeWidth => 'Strichbreite';

  @override
  String get includeEraser => 'Löschvorrichtung einbeziehen?';

  @override
  String get thinning => 'Dünnheit';

  @override
  String get pen => 'Stift';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Pfadlöscher';

  @override
  String get label => 'Label';

  @override
  String get delete => 'Löschen';

  @override
  String get areYouSure => 'Bist du sicher?';

  @override
  String get reallyDelete => 'Möchten Sie dieses Element wirklich löschen?';

  @override
  String get no => 'Nein';

  @override
  String get yes => 'Ja';

  @override
  String get undo => 'Rückgängig';

  @override
  String get redo => 'Wiederholen';

  @override
  String get general => 'Allgemein';

  @override
  String get copyTitle => 'In Zwischenablage kopiert';

  @override
  String get loading => 'Wird geladen...';

  @override
  String get enterText => 'Text eingeben';

  @override
  String get size => 'Größe';

  @override
  String get width => 'Breite';

  @override
  String get height => 'Höhe';

  @override
  String get count => 'Anzahl';

  @override
  String get space => 'Raum';

  @override
  String get background => 'Hintergrund';

  @override
  String get box => 'Box';

  @override
  String get locale => 'Sprache';

  @override
  String get systemLocale => 'Systemsprache';

  @override
  String get information => 'Informationen';

  @override
  String get license => 'Lizenz';

  @override
  String get imprint => 'Impressum';

  @override
  String get privacypolicy => 'Datenschutzerklärung';

  @override
  String get source => 'Quelle';

  @override
  String get documentation => 'Dokumentation';

  @override
  String get changelog => 'Änderungsverlauf';

  @override
  String get existOverride =>
      'Dieses Element existiert bereits. Überschreiben?';

  @override
  String get description => 'Beschreibung';

  @override
  String get fill => 'Füllen';

  @override
  String get defaultPalette => 'Standardpalette';

  @override
  String get highlighter => 'Hervorhebung';

  @override
  String get add => 'Neu';

  @override
  String get remove => 'Entfernen';

  @override
  String get removeConfirm => 'Wollen Sie das wirklich entfernen?';

  @override
  String get resetPalette => 'Palette zurücksetzen';

  @override
  String get custom => 'Eigene';

  @override
  String get decoration => 'Dekoration';

  @override
  String get underline => 'Unterstrichen';

  @override
  String get overline => 'Überzeile';

  @override
  String get strikethrough => 'Durchstreichen';

  @override
  String get thickness => 'Dicke';

  @override
  String get style => 'Stil';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Doppelt';

  @override
  String get dotted => 'Gepunktet';

  @override
  String get dashed => 'Gestattet';

  @override
  String get wavy => 'Wellen';

  @override
  String get fontWeight => 'Schriftgewicht';

  @override
  String get normal => 'Normal';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Zwischenablage';

  @override
  String get file => 'Datei';

  @override
  String get data => 'Daten';

  @override
  String get share => 'Teilen';

  @override
  String get spacing => 'Abstand';

  @override
  String get image => 'Bild';

  @override
  String get enterUrl => 'URL eingeben';

  @override
  String get scale => 'Maßstab';

  @override
  String get help => 'Hilfe';

  @override
  String get reallyReset => 'Wollen Sie wirklich zurücksetzen?';

  @override
  String get whatToDo => 'Was möchtest du tun?';

  @override
  String get ignore => 'Ignorieren';

  @override
  String get backup => 'Sichern';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'Die Datei $fileName wurde in einer neueren Version ($fileVersion) erstellt. Was soll mit dieser Datei gemacht werden?';
  }

  @override
  String get waypoints => 'Wegpunkte';

  @override
  String get origin => 'Ursprung';

  @override
  String get import => 'Importieren';

  @override
  String get newContent => 'Neu';

  @override
  String get selectElement => 'Element auswählen';

  @override
  String get ctrlKey => 'Strg';

  @override
  String get shiftKey => 'Umschalt';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Version kopieren';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Verhalten';

  @override
  String get dataDirectory => 'Datenverzeichnis';

  @override
  String get defaultPath => 'Standardpfad';

  @override
  String get dateFormat => 'Datumsformat';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Aktualisiert am: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Erstellt am: $dateTimeString';
  }

  @override
  String get rename => 'Umbenennen';

  @override
  String get duplicate => 'Duplizieren';

  @override
  String get hand => 'Hand';

  @override
  String get folder => 'Ordner';

  @override
  String get move => 'Bewegen';

  @override
  String get copy => 'Kopieren';

  @override
  String get back => 'Zurück';

  @override
  String get zoomDependent => 'Zoomabhängig';

  @override
  String get shapeDetection => 'Formerkennung';

  @override
  String get delay => 'Verzögerung';

  @override
  String get defaultLayer => 'Standard Ebene';

  @override
  String get layer => 'Ebene';

  @override
  String get layers => 'Ebenen';

  @override
  String get notSet => 'Nicht gesetzt';

  @override
  String get enterLayer => 'Ebenenname eingeben';

  @override
  String get selectElements => 'Elemente auswählen';

  @override
  String get deleteElements => 'Elemente löschen';

  @override
  String get deleteElementsConfirm =>
      'Möchten Sie die ausgewählten Elemente wirklich löschen?';

  @override
  String get selectCustomCollection => 'Wähle eine eigene Sammlung';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => 'Empfindlichkeit';

  @override
  String get sensitivityHint =>
      'Je höher der Wert, desto sensibler die Eingabe';

  @override
  String get horizontal => 'Horizontal';

  @override
  String get vertical => 'Vertikal';

  @override
  String get plain => 'Schlicht';

  @override
  String get light => 'Hell';

  @override
  String get ruled => 'Liniert';

  @override
  String get quad => 'Kariert';

  @override
  String get music => 'Musik';

  @override
  String get dark => 'Dunkel';

  @override
  String get plainDark => 'Dunkel';

  @override
  String get ruledDark => 'Liniert dunkel';

  @override
  String get quadDark => 'Kariert dunkel';

  @override
  String get musicDark => 'Musik dunkel';

  @override
  String get templates => 'Vorlagen';

  @override
  String get untitled => 'Ohne Titel';

  @override
  String get createTemplate => 'Vorlage erstellen';

  @override
  String get createTemplateContent =>
      'Möchten Sie wirklich eine Vorlage aus diesem Dokument erstellen? Das Originaldokument wird gelöscht.';

  @override
  String get replace => 'Ersetzen';

  @override
  String get reallyReplace =>
      'Wollen Sie wirklich die Vorlage ersetzen? Dieser Vorgang kann nicht rückgängig gemacht werden!';

  @override
  String get defaultTemplate => 'Standardvorlage';

  @override
  String get insert => 'Einfügen';

  @override
  String get document => 'Dokument';

  @override
  String get camera => 'Kamera';

  @override
  String get printout => 'Drucken';

  @override
  String get selectCamera => 'Kamera auswählen';

  @override
  String get changeDocumentPath => 'Dokumentpfad ändern';

  @override
  String get deleteWholeStroke => 'Den ganzen Strich löschen';

  @override
  String get alpha => 'Alpha';

  @override
  String get area => 'Fläche';

  @override
  String get selectArea => 'Wählen Sie einen Bereich';

  @override
  String get aspectRatio => 'Seitenverhältnis';

  @override
  String get presets => 'Vorlagen';

  @override
  String get pagePortrait => 'Seitenportrait';

  @override
  String get pageLandscape => 'Seitenlandschaft';

  @override
  String get square => 'Quadrat';

  @override
  String get areas => 'Flächen';

  @override
  String get enterArea => 'Geben Sie den Bereich ein';

  @override
  String get exitArea => 'Beende das Gebiet';

  @override
  String get currentArea => 'Aktueller Bereich';

  @override
  String get design => 'Design';

  @override
  String get text => 'Text';

  @override
  String welcome(String codeName) {
    return 'Hey, das ist Linwood Butterfly';
  }

  @override
  String get welcomeContent => 'Ein freier und Open-Source-Zeichnungsraum!';

  @override
  String updated(String version) {
    return 'App aktualisiert auf Version $version';
  }

  @override
  String get releaseNotes => 'Versionshinweise';

  @override
  String get constraints => 'Einschränkungen';

  @override
  String get scaled => 'Skaliert';

  @override
  String get fixed => 'Fixiert';

  @override
  String get dynamicContent => 'Dynamisch';

  @override
  String get none => 'Keine';

  @override
  String get includeArea => 'Bereich einbeziehen';

  @override
  String get verticalAlignment => 'Vertikale Ausrichtung';

  @override
  String get horizontalAlignment => 'Horizontale Ausrichtung';

  @override
  String get top => 'Oben';

  @override
  String get center => 'Zentriert';

  @override
  String get bottom => 'Unten';

  @override
  String get left => 'Links';

  @override
  String get right => 'Rechts';

  @override
  String get justify => 'Blocksatz';

  @override
  String get constraint => 'Einschränkung';

  @override
  String get length => 'Länge';

  @override
  String get exportSvg => 'SVG exportieren';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => 'Seiten auswählen';

  @override
  String get recentFiles => 'Letzte Dateien';

  @override
  String get start => 'Start';

  @override
  String get noRecentFiles => 'Keine aktuellen Dateien';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Seiten',
      one: '1 Seite',
      zero: 'Keine Seiten',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Seite $index';
  }

  @override
  String get exit => 'Beenden';

  @override
  String get noElements => 'Keine Elemente';

  @override
  String get invertSelection => 'Auswahl umkehren';

  @override
  String get errorWhileImporting => 'Fehler beim Importieren';

  @override
  String get errorWhileImportingContent => 'Fehler beim Importieren der Datei';

  @override
  String get showDetails => 'Details anzeigen';

  @override
  String get hideDetails => 'Details ausblenden';

  @override
  String get error => 'Fehler';

  @override
  String get stackTrace => 'Stapelverfolgung';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Dauer';

  @override
  String get quality => 'Qualität';

  @override
  String get exportPdf => 'PDF exportieren';

  @override
  String get local => 'Lokal';

  @override
  String get addConnection => 'Verbindung hinzufügen';

  @override
  String get connections => 'Verbindungen';

  @override
  String get noConnections => 'Keine Verbindungen';

  @override
  String get url => 'URL';

  @override
  String get connect => 'Verbinden';

  @override
  String get username => 'Benutzername';

  @override
  String get password => 'Passwort';

  @override
  String get webNotSupported => 'Web nicht unterstützt';

  @override
  String get advanced => 'Erweitert';

  @override
  String get directory => 'Verzeichnis';

  @override
  String get documentsDirectory => 'Dokumentenverzeichnis';

  @override
  String get templatesDirectory => 'Vorlagenverzeichnis';

  @override
  String get errorWhileCreatingConnection =>
      'Fehler beim Erstellen der Verbindung';

  @override
  String get cannotConnect => 'Verbindung nicht möglich';

  @override
  String get urlNotValid => 'URL ungültig';

  @override
  String get icon => 'Symbol';

  @override
  String get update => 'Aktualisieren';

  @override
  String get updateAvailable => 'Update verfügbar';

  @override
  String get stable => 'Stabil';

  @override
  String get nightly => 'Nightly';

  @override
  String get checkForUpdates => 'Nach Updates suchen';

  @override
  String get checkForUpdatesWarning =>
      'Wenn Sie nach Updates suchen, werden Sie sich mit der Butterfly-Website verbinden, um die Informationen zu erhalten.';

  @override
  String get usingLatestStable => 'Sie verwenden die neueste stabile Version';

  @override
  String get usingLatestNightly => 'Sie verwenden die neueste Nightly Version';

  @override
  String get currentVersion => 'Aktuelle Version';

  @override
  String get updateNow => 'Jetzt aktualisieren';

  @override
  String get shape => 'Form';

  @override
  String get circle => 'Kreis';

  @override
  String get rectangle => 'Rechteck';

  @override
  String get triangle => 'Dreieck';

  @override
  String get line => 'Linie';

  @override
  String get cornerRadius => 'Eckenradius';

  @override
  String get topLeft => 'Oben links';

  @override
  String get topRight => 'Oben rechts';

  @override
  String get bottomLeft => 'Unten links';

  @override
  String get bottomRight => 'Unten rechts';

  @override
  String get caches => 'Caches';

  @override
  String get manage => 'Verwalten';

  @override
  String get clearCaches => 'Caches löschen';

  @override
  String get createCache => 'Cache erstellen';

  @override
  String get thirdPartyLicenses => 'Drittlizenzen';

  @override
  String get syncing => 'Synchronisieren...';

  @override
  String get synced => 'Synchronisiert';

  @override
  String get notSynced => 'Nicht synchronisiert';

  @override
  String get conflict => 'Konflikt';

  @override
  String get keepLocal => 'Lokal behalten';

  @override
  String get keepConnection => 'Verbindung behalten';

  @override
  String get keepBoth => 'Beides behalten';

  @override
  String get forAll => 'Für alle';

  @override
  String fileConflict(String file, String connection) {
    return '$file in $connection hat einen Konflikt';
  }

  @override
  String get offline => 'Offline';

  @override
  String get localLatest => 'Lokale neueste';

  @override
  String get connectionLatest => 'Neueste Verbindung';

  @override
  String get path => 'Pfad';

  @override
  String get folderSynced => 'Ordner synchronisiert';

  @override
  String get syncRootDirectory => 'Sync-Stammverzeichnis';

  @override
  String get penOnlyInput => 'Nur-Pen-Eingabe';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Native Titelleiste';

  @override
  String get syncMode => 'Sync-Modus';

  @override
  String get connection => 'Verbindung';

  @override
  String get always => 'Immer';

  @override
  String get noMobile => 'Nicht mobil';

  @override
  String get manual => 'Manuell';

  @override
  String get search => 'Suchen';

  @override
  String get properties => 'Eigenschaften';

  @override
  String get pin => 'Anheften';

  @override
  String get unpin => 'Loslösen';

  @override
  String get element => 'Element';

  @override
  String get painter => 'Maler';

  @override
  String get position => 'Position';

  @override
  String get note => 'Notiz';

  @override
  String get packs => 'Pakete';

  @override
  String get pack => 'Paket';

  @override
  String get more => 'Mehr';

  @override
  String get askForName => 'Nach Namen fragen';

  @override
  String areaIndex(int index) {
    return 'Fläche $index';
  }

  @override
  String get startInFullScreen => 'Im Vollbild starten';

  @override
  String get inputs => 'Eingaben';

  @override
  String get mouse => 'Maus';

  @override
  String get touch => 'Berühren';

  @override
  String get keyboard => 'Tastatur';

  @override
  String get shortcuts => 'Verknüpfungen';

  @override
  String get middle => 'Mitte';

  @override
  String get first => 'Erster';

  @override
  String get second => 'Zweiter';

  @override
  String get tools => 'Werkzeuge';

  @override
  String get showGrid => 'Raster anzeigen';

  @override
  String get grid => 'Raster';

  @override
  String get ruler => 'Lineal';

  @override
  String get angle => 'Winkel';

  @override
  String get report => 'Melden';

  @override
  String get newFolder => 'Neuer Ordner';

  @override
  String get createPack => 'Paket erstellen';

  @override
  String get editPack => 'Paket bearbeiten';

  @override
  String get packsDirectory => 'Paketverzeichnis';

  @override
  String get stamp => 'Stempel';

  @override
  String get addToPack => 'Zum Paket hinzufügen';

  @override
  String get sureImportPack =>
      'Sind Sie sicher, dass Sie das Paket importieren möchten?';

  @override
  String byAuthor(String author) {
    return 'von $author';
  }

  @override
  String get author => 'Autor';

  @override
  String get addAsset => 'Asset hinzufügen';

  @override
  String get editAsset => 'Asset bearbeiten';

  @override
  String get scope => 'Bereich';

  @override
  String get noPacks => 'Derzeit sind keine Pakete verfügbar';

  @override
  String get components => 'Komponenten';

  @override
  String get waypoint => 'Wegpunkt';

  @override
  String get actions => 'Aktionen';

  @override
  String get painters => 'Maler';

  @override
  String get breakingChangesTitle => 'Änderungen brechen';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Es gibt ungültige Änderungen in dieser Version. Bitte lesen Sie das Changelog vor der Aktualisierung. Die aktuelle Dateiversion ist $version, die neue Version ist $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Absatz';

  @override
  String get fontFamily => 'Schriftfamilie';

  @override
  String get smoothing => 'Glättung';

  @override
  String get streamline => 'Streamline';

  @override
  String get presentation => 'Präsentation';

  @override
  String get selectAsset => 'Asset auswählen';

  @override
  String get clearStyle => 'Stil löschen';

  @override
  String get unknownImportType => 'Unbekannter Importtyp';

  @override
  String get sureImportTemplate =>
      'Sind Sie sicher, dass Sie die Vorlage importieren möchten?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Abspielen';

  @override
  String get video => 'Video';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Haltepunkt';

  @override
  String get presentationControls => 'Präsentations-Steuerelemente';

  @override
  String get nextSlide => 'Nächste Folie';

  @override
  String get nextSlideDescription =>
      'Nach rechts wischen oder die rechte Pfeiltaste drücken, um zur nächsten Folie zu gehen';

  @override
  String get previousSlide => 'Vorherige Folie';

  @override
  String get previousSlideDescription =>
      'Wische nach links oder drücke die linke Pfeiltaste um zur vorherigen Folie zu gehen';

  @override
  String get exitPresentation => 'Präsentation beenden';

  @override
  String get exitPresentationDescription =>
      'Drücken Sie die Esc-Taste oder wischen Sie nach unten, um die Präsentation zu beenden';

  @override
  String get pausePresentation => 'Präsentation pausieren';

  @override
  String get pausePresentationDescription =>
      'Tippen Sie auf den Bildschirm oder drücken Sie die Leertaste um die Präsentation zu pausieren oder fortsetzen';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation =>
      'Sie haben das Ende der Präsentation erreicht';

  @override
  String get startOfPresentation =>
      'Sie haben den Beginn der Präsentation erreicht';

  @override
  String get palettes => 'Paletten';

  @override
  String headline(int index) {
    return 'Überschrift $index';
  }

  @override
  String get code => 'Code';

  @override
  String get quote => 'Zitat';

  @override
  String get link => 'Link';

  @override
  String get checkbox => 'Kontrollkästchen';

  @override
  String get deleted => 'Gelöscht';

  @override
  String get emphasis => 'Hervorhebung';

  @override
  String get listBullet => 'Auflistungskugel';

  @override
  String get strong => 'Stark';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Start';

  @override
  String get files => 'Dateien';

  @override
  String get sortBy => 'Sortieren nach';

  @override
  String get location => 'Standort';

  @override
  String get whatsNew => 'Was ist neu?';

  @override
  String get unstar => 'Defavorisieren';

  @override
  String get star => 'Favorisieren';

  @override
  String get goUp => 'Nach oben';

  @override
  String get created => 'Erstellt';

  @override
  String get modified => 'Geändert';

  @override
  String get quickstart => 'Schnellstart';

  @override
  String get noTemplates => 'Derzeit sind keine Vorlagen verfügbar';

  @override
  String get importCorePack => 'Kernpaket importieren';

  @override
  String get importCorePackDescription =>
      'Importiere das Core Pack, das alle grundlegenden Assets enthält, die gestartet werden sollen. Dies wird das aktuelle Core Pack überschreiben.';

  @override
  String get never => 'Nie';

  @override
  String get onlyOnUpdates => 'Nur bei Updates';

  @override
  String get visibility => 'Sichtbarkeit';

  @override
  String get captureThumbnail => 'Thumbnail aufnehmen';

  @override
  String get capturedThumbnail => 'Thumbnail erfolgreich erfasst';

  @override
  String get chooseLabelMode => 'Labelmodus wählen';

  @override
  String get foreground => 'Vordergrund';

  @override
  String get version => 'Version';

  @override
  String get repository => 'Repository';

  @override
  String get pages => 'Seiten';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Anordnen';

  @override
  String get bringToFront => 'Nach vorne bringen';

  @override
  String get sendToBack => 'An zurück senden';

  @override
  String get bringForward => 'Vorwärts bringen';

  @override
  String get sendBackward => 'Rückwärts senden';

  @override
  String get rotation => 'Drehung';

  @override
  String get onlyAvailableLargerScreen =>
      'Nur auf größeren Bildschirmen verfügbar';

  @override
  String get toolbarPosition => 'Position der Werkzeugleiste';

  @override
  String get rotate => 'Drehen';

  @override
  String get spacer => 'Abstandhalter';

  @override
  String get navigationRail => 'Navigationsschiene';

  @override
  String get cut => 'Ausschneiden';

  @override
  String get insertBefore => 'Vorher einfügen';

  @override
  String get insertAfter => 'Einfügen nach';

  @override
  String get insertFirst => 'Zuerst einfügen';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Einfügen';

  @override
  String get ascending => 'Aufsteigend';

  @override
  String get descending => 'Absteigend';

  @override
  String get imageScale => 'Bildskala';

  @override
  String get select => 'Auswählen';

  @override
  String get tool => 'Werkzeug';

  @override
  String get texture => 'Textur';

  @override
  String get platformTheme => 'Plattform-Theme';

  @override
  String get desktop => 'Desktop';

  @override
  String get mobile => 'Mobil';

  @override
  String get pdfQuality => 'PDF-Qualität';

  @override
  String get surface => 'Oberfläche';

  @override
  String get pattern => 'Muster';

  @override
  String get sureClose =>
      'Sind Sie sicher, dass Sie das Dokument schließen möchten?';

  @override
  String get thereAreUnsavedChanges => 'Es gibt ungespeicherte Änderungen';

  @override
  String get page => 'Seite';

  @override
  String get iceServers => 'ICE-Server';

  @override
  String get collaboration => 'Zusammenarbeit';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Web-Socket';

  @override
  String get iceServer => 'ICE-Server';

  @override
  String get port => 'Port';

  @override
  String get type => 'Typ';

  @override
  String get side => 'Seite';

  @override
  String get client => 'Client';

  @override
  String get server => 'Server';

  @override
  String get switchView => 'Ansicht wechseln';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'UI ausblenden';

  @override
  String get density => 'Dichte';

  @override
  String get compact => 'Kompakt';

  @override
  String get comfortable => 'Bequemer';

  @override
  String get standard => 'Standard';

  @override
  String get lock => 'Sperren';

  @override
  String get addElement => 'Element hinzufügen';

  @override
  String get notDefaultConnection => 'Keine Standard-Verbindung';

  @override
  String get defaultConnection => 'Standardverbindung';

  @override
  String get hide => 'Verstecken';

  @override
  String get show => 'Zeigen';

  @override
  String get pause => 'Pause';

  @override
  String get stop => 'Stoppen';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get print => 'Drucken';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Pipette';

  @override
  String get users => 'Benutzer';

  @override
  String get experiments => 'Experimente';

  @override
  String get address => 'Adresse';

  @override
  String get spreadToPages => 'Auf Seiten verteilen';

  @override
  String get rootDirectorySpecifiedDescription =>
      'Das Wurzelverzeichnis ist spezifiziert. Alle erweiterten Verzeichnispfade sind relativ zu diesem Verzeichnis. Leer lassen um diesen Verzeichnistyp zu deaktivieren.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'Das Wurzelverzeichnis ist nicht spezifiziert. Ein Name ist erforderlich. Alle erweiterten Verzeichnispfade sind absolut. Lassen Sie es leer, um diesen Verzeichnistyp zu deaktivieren.';

  @override
  String get unsecureConnectionTitle => 'Unsichere Verbindung';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'Die Verbindung ist nicht sicher. Dies kann ein Sicherheitsrisiko sein. Bitte fahren Sie nur fort, wenn Sie der Verbindung vertrauen. Der sha1-Fingerabdruck ist $fingerprint.';
  }

  @override
  String get continueAnyway => 'Trotzdem fortfahren';

  @override
  String get zoomControl => 'Zoom-Steuerung';

  @override
  String get highContrast => 'Hoher Kontrast';

  @override
  String get shouldANumber => 'Dieser Wert sollte eine gültige Zahl sein';

  @override
  String get createAreas => 'Bereiche erstellen';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Operationen';

  @override
  String get medium => 'Mittel';

  @override
  String get large => 'Groß';

  @override
  String get toolbarSize => 'Größe der Werkzeugleiste';

  @override
  String get addAll => 'Alle hinzufügen';

  @override
  String get onlyCurrentPage => 'Nur aktuelle Seite';

  @override
  String get smoothNavigation => 'Glatte Navigation';

  @override
  String get exact => 'Exakt';

  @override
  String get inline => 'Inline';

  @override
  String get toolbarRows => 'Zeilen der Symbolleiste';

  @override
  String get pointerTest => 'Zeigertest';

  @override
  String get pressure => 'Druck';

  @override
  String get small => 'Klein';

  @override
  String get tiny => 'Klein';

  @override
  String get selectAll => 'Alles auswählen';

  @override
  String get overrideTools => 'Werkzeuge überschreiben';

  @override
  String get hideCursorWhileDrawing => 'Cursor während Zeichnung ausblenden';

  @override
  String get installed => 'Installiert';

  @override
  String get install => 'Installieren';

  @override
  String get deselect => 'Abwählen';

  @override
  String get changeCollection => 'Sammlung ändern';

  @override
  String get collections => 'Sammlungen';

  @override
  String get fullSelection => 'Vollständige Auswahl';

  @override
  String get fullSelectionDescription =>
      'Erfordert die vollständige Auswahl der Elemente innerhalb des Auswahlfeldes.';

  @override
  String get collection => 'Sammlung';

  @override
  String get defaultCollection => 'Standard-Sammlung';

  @override
  String get scroll => 'Scrollen';

  @override
  String get onStartup => 'Beim Start';

  @override
  String get homeScreen => 'Startbildschirm';

  @override
  String get lastNote => 'Letzte Notiz';

  @override
  String get newNote => 'Neue Notiz';

  @override
  String get convertToLayer => 'In Ebene konvertieren';

  @override
  String get merge => 'Zusammenführen';

  @override
  String get up => 'Hoch';

  @override
  String get down => 'Unten';

  @override
  String get other => 'Andere';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Elemente',
      one: '1 Element',
      zero: 'Keine Elemente',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Farb-Werkzeugleiste';

  @override
  String get yesButShowButtons => 'Ja, aber Schaltflächen anzeigen';

  @override
  String get optionsPanelPosition => 'Position des Optionen-Panels';

  @override
  String get hideDuration => 'Dauer ausblenden';

  @override
  String get animation => 'Animation';

  @override
  String get performance => 'Leistung';

  @override
  String get performanceDescription =>
      'Optimiert für Geschwindigkeit und Speicherauslastung. Nur der sichtbare Teil der Notiz wird in das Bild gebacken.';

  @override
  String get normalDescription =>
      'Balanciert Qualität und Performance. Bietet ein Bild, das das 1,5 Mal so viel wie der sichtbare Bereich abdeckt, und sorgt beim Scrollen für glattere Übergänge.';

  @override
  String get high => 'Hoch';

  @override
  String get highDescription =>
      'Beschreibung: Maximizes quality at the cost of performance. Bietet ein 2-fachen sichtbares Bild ab und garantiert eine nahtlose Darstellung auch beim schnellen Scrollen oder Zoomen.';

  @override
  String get renderResolution => 'Auflösung anzeigen';

  @override
  String get translate => 'Übersetzen';

  @override
  String get unencrypted => 'Unverschlüsselt';

  @override
  String get encrypted => 'Verschlüsselt';

  @override
  String get encryptDocumentMessage =>
      'Klicken, um das Dokument zu verschlüsseln';

  @override
  String get unencryptDocumentMessage =>
      'Zum Entschlüsseln des Dokuments klicken';

  @override
  String get unencrypt => 'Unverschlüsselt';

  @override
  String get encrypt => 'Verschlüsseln';

  @override
  String get encryptWarning =>
      'Dies verschlüsselt das Dokument. Sie müssen das Passwort speichern, um es zu entschlüsseln.';

  @override
  String get unencryptWarning =>
      'Dies wird das Dokument unverschlüsseln. Das Passwort wird entfernt und jeder mit Zugriff kann es öffnen.';

  @override
  String get confirmPassword => 'Passwort bestätigen';

  @override
  String get passwordMismatch => 'Passwörter stimmen nicht überein';

  @override
  String get action => 'Aktion';

  @override
  String get svgText => 'SVG-Text';

  @override
  String get offset => 'Versatz';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
