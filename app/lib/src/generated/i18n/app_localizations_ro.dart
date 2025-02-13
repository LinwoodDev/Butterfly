// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Romanian Moldavian Moldovan (`ro`).
class AppLocalizationsRo extends AppLocalizations {
  AppLocalizationsRo([String locale = 'ro']) : super(locale);

  @override
  String get open => 'Deschideți';

  @override
  String get settings => 'Setări';

  @override
  String get personalization => 'Personalizare';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Temă întunecată';

  @override
  String get lightTheme => 'Temă luminoasă';

  @override
  String get systemTheme => 'Foloseste tema de sistem implicita';

  @override
  String get view => 'Vizualizare';

  @override
  String get edit => 'Editare';

  @override
  String get export => 'Exportă';

  @override
  String get save => 'Salvează';

  @override
  String get zoom => 'Mareste';

  @override
  String get zoomIn => 'Zoom in';

  @override
  String get zoomOut => 'Zoom out';

  @override
  String get resetZoom => 'Reset zoom';

  @override
  String get strokeWidth => 'Lățimea conturului';

  @override
  String get includeEraser => 'Includeți ștergerea?';

  @override
  String get thinning => 'Thinning';

  @override
  String get pen => 'Stiloul';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Ștergere cale';

  @override
  String get label => 'Etichetă';

  @override
  String get delete => 'Ștergere';

  @override
  String get areYouSure => 'Ești sigur?';

  @override
  String get reallyDelete =>
      'Sunteţi sigur că doriţi să ştergeţi acest element?';

  @override
  String get no => 'Nr';

  @override
  String get yes => 'Da';

  @override
  String get undo => 'Anulează';

  @override
  String get redo => 'Reface';

  @override
  String get general => 'Generalități';

  @override
  String get copyTitle => 'Copiat în clipboard';

  @override
  String get loading => 'Încărcare...';

  @override
  String get enterText => 'Introduceți textul';

  @override
  String get size => 'Dimensiune';

  @override
  String get width => 'Width';

  @override
  String get height => 'Înălțime';

  @override
  String get count => 'Număr';

  @override
  String get space => 'Spațiu';

  @override
  String get background => 'Context';

  @override
  String get box => 'Cutie';

  @override
  String get locale => 'Localizare';

  @override
  String get systemLocale => 'Localizare sistem';

  @override
  String get information => 'Informare';

  @override
  String get license => 'Licenta';

  @override
  String get imprint => 'Amprentă';

  @override
  String get privacypolicy => 'Politica de confidenţialitate';

  @override
  String get source => 'Sursa';

  @override
  String get documentation => 'Documentație';

  @override
  String get changelog => 'Jurnal modificări';

  @override
  String get existOverride => 'Acest element există deja. Suprascrieți?';

  @override
  String get description => 'Descriere';

  @override
  String get fill => 'Completează';

  @override
  String get defaultPalette => 'Paletă implicită';

  @override
  String get highlighter => 'Evidențiere';

  @override
  String get add => 'Adăugare';

  @override
  String get remove => 'Elimină';

  @override
  String get removeConfirm => 'Sigur doriți să eliminați acest lucru?';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => 'Personalizat';

  @override
  String get decoration => 'Decorațiune';

  @override
  String get underline => 'Subliniere';

  @override
  String get overline => 'Subliniere';

  @override
  String get strikethrough => 'Tăiat';

  @override
  String get thickness => 'Grosime';

  @override
  String get style => 'Stil';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Dublu';

  @override
  String get dotted => 'Punctat';

  @override
  String get dashed => 'Oprită';

  @override
  String get wavy => 'Vrăjitor';

  @override
  String get fontWeight => 'Greutate font';

  @override
  String get normal => 'Normală';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Clipboard';

  @override
  String get file => 'Fişier';

  @override
  String get data => 'Date';

  @override
  String get share => 'Distribuie';

  @override
  String get spacing => 'Spațiere';

  @override
  String get image => 'Imagine';

  @override
  String get enterUrl => 'Introduceți adresa URL';

  @override
  String get scale => 'Scala';

  @override
  String get help => 'Ajutor';

  @override
  String get reallyReset => 'Sunteți sigur că doriți să resetați?';

  @override
  String get whatToDo => 'Ce vrei să faci?';

  @override
  String get ignore => 'Ignoră';

  @override
  String get backup => 'Backup';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'Fișierul $fileName a fost creat într-o versiune mai nouă ($fileVersion). Ce ar trebui să facă cu acest fișier?';
  }

  @override
  String get waypoints => 'Puncte';

  @override
  String get origin => 'Origine';

  @override
  String get import => 'Importă';

  @override
  String get newContent => 'Nou';

  @override
  String get selectElement => 'Selectaţi elementul';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Schimb';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Copiază versiunea';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Comportamente';

  @override
  String get dataDirectory => 'Director de date';

  @override
  String get defaultPath => 'Calea implicită';

  @override
  String get dateFormat => 'Formatul datei';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Actualizat la: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Creat la: $dateTimeString';
  }

  @override
  String get rename => 'Redenumire';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => 'Mână';

  @override
  String get folder => 'Dosar';

  @override
  String get move => 'Mutare';

  @override
  String get copy => 'Copiază';

  @override
  String get back => 'Înapoi';

  @override
  String get zoomDependent => 'Depinde de zoom';

  @override
  String get shapeDetection => 'Detectare Formă';

  @override
  String get delay => 'Întârziere';

  @override
  String get defaultLayer => 'Stratul implicit';

  @override
  String get layer => 'Stratul';

  @override
  String get layers => 'Straturi';

  @override
  String get notSet => 'Nu este setat';

  @override
  String get enterLayer => 'Introduceți numele stratului';

  @override
  String get selectElements => 'Selectare elemente';

  @override
  String get deleteElements => 'Ștergere elemente';

  @override
  String get deleteElementsConfirm =>
      'Eşti sigur că vrei să ştergi elementele selectate?';

  @override
  String get selectCustomCollection => 'Selectează o colecție personalizată';

  @override
  String get svg => 'VSG';

  @override
  String get sensitivity => 'Sensibilitate';

  @override
  String get sensitivityHint =>
      'Cu cât este mai mare valoarea, cu atât mai sensibilă este aportul';

  @override
  String get horizontal => 'Orizontal';

  @override
  String get vertical => 'Verticală';

  @override
  String get plain => 'Simplu';

  @override
  String get light => 'Lumină';

  @override
  String get ruled => 'Regulat';

  @override
  String get quad => 'Quad';

  @override
  String get music => 'Muzică';

  @override
  String get dark => 'Întunecat';

  @override
  String get plainDark => 'Întunecat';

  @override
  String get ruledDark => 'Normal întunecat';

  @override
  String get quadDark => 'Quad întunecat';

  @override
  String get musicDark => 'Muzică întunecată';

  @override
  String get templates => 'Şabloane';

  @override
  String get untitled => 'Fără titlu';

  @override
  String get createTemplate => 'Creează șablon';

  @override
  String get createTemplateContent =>
      'Sigur doriți să creați un șablon din acest document? Documentul original va fi șters.';

  @override
  String get replace => 'Înlocuiește';

  @override
  String get reallyReplace =>
      'Sigur doriți să înlocuiți șablonul? Această operațiune nu poate fi anulată!';

  @override
  String get defaultTemplate => 'Șablon implicit';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'Document';

  @override
  String get camera => 'Cameră';

  @override
  String get printout => 'Printare';

  @override
  String get selectCamera => 'Selectează o cameră foto';

  @override
  String get changeDocumentPath => 'Schimbă calea documentului';

  @override
  String get deleteWholeStroke => 'Ștergeți întregul strop';

  @override
  String get alpha => 'Alfa';

  @override
  String get area => 'Suprafață';

  @override
  String get selectArea => 'Selectează o zonă';

  @override
  String get aspectRatio => 'Raport de aspect';

  @override
  String get presets => 'Presetări';

  @override
  String get pagePortrait => 'Portret pagină';

  @override
  String get pageLandscape => 'Pagina peisaj';

  @override
  String get square => 'Patrat';

  @override
  String get areas => 'Domenii';

  @override
  String get enterArea => 'Intră în zonă';

  @override
  String get exitArea => 'Ieșiți din zonă';

  @override
  String get currentArea => 'Zona curentă';

  @override
  String get design => 'Proiectare';

  @override
  String get text => 'Text';

  @override
  String welcome(String codeName) {
    return 'Hei, acesta este Linwood Butterfly';
  }

  @override
  String get welcomeContent => 'Un spaţiu de desenare gratuit şi open-source!';

  @override
  String updated(String version) {
    return 'Aplicație actualizată la versiunea $version';
  }

  @override
  String get releaseNotes => 'Note de lansare';

  @override
  String get constraints => 'Constrângeri';

  @override
  String get scaled => 'Scalat';

  @override
  String get fixed => 'Fixat';

  @override
  String get dynamicContent => 'Dinamic';

  @override
  String get none => 'Niciunul';

  @override
  String get includeArea => 'Include zona';

  @override
  String get verticalAlignment => 'Aliniere verticală';

  @override
  String get horizontalAlignment => 'Aliniere orizontală';

  @override
  String get top => 'Sus';

  @override
  String get center => 'Centru';

  @override
  String get bottom => 'Jos';

  @override
  String get left => 'Stânga';

  @override
  String get right => 'Dreapta';

  @override
  String get justify => 'Aliniere';

  @override
  String get constraint => 'Constrângere';

  @override
  String get length => 'Lungime';

  @override
  String get exportSvg => 'Exportă SVG';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => 'Selecteaza pagini';

  @override
  String get recentFiles => 'Fișiere recente';

  @override
  String get start => 'Pornire';

  @override
  String get noRecentFiles => 'Nu există fișiere recente';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pagini',
      one: '1 pagină',
      zero: 'Nici o pagină',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Pagina $index';
  }

  @override
  String get exit => 'Ieșire';

  @override
  String get noElements => 'Niciun element';

  @override
  String get invertSelection => 'Inversează selecția';

  @override
  String get errorWhileImporting => 'Eroare la importare';

  @override
  String get errorWhileImportingContent =>
      'A apărut o eroare la importarea fișierului';

  @override
  String get showDetails => 'Afișare detalii';

  @override
  String get hideDetails => 'Ascundeți detaliile';

  @override
  String get error => 'Eroare';

  @override
  String get stackTrace => 'Urmărire stivă';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Durată';

  @override
  String get quality => 'Calitate';

  @override
  String get exportPdf => 'Exportă PDF';

  @override
  String get local => 'Local';

  @override
  String get addConnection => 'Adăugați conexiune';

  @override
  String get connections => 'Conexiuni';

  @override
  String get noConnections => 'Nicio conexiune';

  @override
  String get url => 'URL';

  @override
  String get connect => 'Conectează-te';

  @override
  String get username => 'Nume';

  @override
  String get password => 'Parolă';

  @override
  String get webNotSupported => 'Web neacceptat';

  @override
  String get advanced => 'Avansat';

  @override
  String get directory => 'Director';

  @override
  String get documentsDirectory => 'Dosar documente';

  @override
  String get templatesDirectory => 'Directorul de șabloane';

  @override
  String get errorWhileCreatingConnection => 'Eroare la crearea conexiunii';

  @override
  String get cannotConnect => 'Nu se poate conecta';

  @override
  String get urlNotValid => 'URL incorect';

  @override
  String get icon => 'Iconiță';

  @override
  String get update => 'Actualizare';

  @override
  String get updateAvailable => 'Actualizare disponibilă';

  @override
  String get stable => 'Stabil';

  @override
  String get nightly => 'Noptez';

  @override
  String get checkForUpdates => 'Verifică pentru actualizări';

  @override
  String get checkForUpdatesWarning =>
      'Verificarea actualizărilor se va conecta la site-ul Butterfly pentru a obţine informaţiile.';

  @override
  String get usingLatestStable => 'Folosești cea mai recentă versiune stabilă';

  @override
  String get usingLatestNightly => 'Folosești ultima versiune nocturnă';

  @override
  String get currentVersion => 'Versiunea curentă';

  @override
  String get updateNow => 'Actualizează acum';

  @override
  String get shape => 'Formă';

  @override
  String get circle => 'Cerc';

  @override
  String get rectangle => 'Dreptunghi';

  @override
  String get triangle => 'Triunghi';

  @override
  String get line => 'Linie';

  @override
  String get cornerRadius => 'Corner radius';

  @override
  String get topLeft => 'Sus stânga';

  @override
  String get topRight => 'Dreapta sus';

  @override
  String get bottomLeft => 'Stânga jos';

  @override
  String get bottomRight => 'Jos dreapta';

  @override
  String get caches => 'Geocutii';

  @override
  String get manage => 'Gestionează';

  @override
  String get clearCaches => 'Șterge geocutiile';

  @override
  String get createCache => 'Crează geocutie';

  @override
  String get thirdPartyLicenses => 'Licențe terțe';

  @override
  String get syncing => 'Sincronizare...';

  @override
  String get synced => 'Sincronizat';

  @override
  String get notSynced => 'Nu este sincronizat';

  @override
  String get conflict => 'Conflict';

  @override
  String get keepLocal => 'Păstrați local';

  @override
  String get keepConnection => 'Păstrează conexiunea';

  @override
  String get keepBoth => 'Păstrați ambele';

  @override
  String get forAll => 'Pentru toți';

  @override
  String fileConflict(String file, String connection) {
    return '$file în $connection are un conflict';
  }

  @override
  String get offline => 'Offline';

  @override
  String get localLatest => 'Ultimul local';

  @override
  String get connectionLatest => 'Conexiune recentă';

  @override
  String get path => 'Cale';

  @override
  String get folderSynced => 'Dosar sincronizat';

  @override
  String get syncRootDirectory => 'Sincronizare director rădăcină';

  @override
  String get penOnlyInput => 'Numai introducerea stiloului injector';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Bară titlu nativ';

  @override
  String get syncMode => 'Mod sincronizare';

  @override
  String get connection => 'Conexiune';

  @override
  String get always => 'Întotdeauna';

  @override
  String get noMobile => 'Niciun mobil';

  @override
  String get manual => 'Manual';

  @override
  String get search => 'Caută';

  @override
  String get properties => 'Proprietăți';

  @override
  String get pin => 'Fixează';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Element';

  @override
  String get painter => 'Pictor';

  @override
  String get position => 'Poziție';

  @override
  String get note => 'Notă';

  @override
  String get packs => 'Pachete';

  @override
  String get pack => 'Pachet';

  @override
  String get more => 'Mai';

  @override
  String get askForName => 'Cere nume';

  @override
  String areaIndex(int index) {
    return 'Suprafață $index';
  }

  @override
  String get startInFullScreen => 'Pornește în ecran complet';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Șoricel';

  @override
  String get touch => 'Atingere';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Scurtături';

  @override
  String get middle => 'Mijloc';

  @override
  String get first => 'Primul';

  @override
  String get second => 'Al doilea';

  @override
  String get tools => 'Unelte';

  @override
  String get showGrid => 'Arată grila';

  @override
  String get grid => 'Grilă';

  @override
  String get ruler => 'Regulă';

  @override
  String get angle => 'Unghiul';

  @override
  String get report => 'Raport';

  @override
  String get newFolder => 'Dosar nou';

  @override
  String get createPack => 'Creare pachet';

  @override
  String get editPack => 'Editare pachet';

  @override
  String get packsDirectory => 'Directorul de pachete';

  @override
  String get stamp => 'Timbru';

  @override
  String get addToPack => 'Adaugă la pachet';

  @override
  String get sureImportPack => 'Sunteţi sigur că doriţi să importați pachetul?';

  @override
  String byAuthor(String author) {
    return 'până la $author';
  }

  @override
  String get author => 'Autor';

  @override
  String get addAsset => 'Adăugare activ';

  @override
  String get editAsset => 'Editare activ';

  @override
  String get scope => 'Domeniu';

  @override
  String get noPacks => 'În acest moment nu există pachete disponibile';

  @override
  String get components => 'Componente';

  @override
  String get waypoint => 'Punct';

  @override
  String get actions => 'Acțiuni';

  @override
  String get painters => 'Pași';

  @override
  String get breakingChangesTitle => 'Ruperea modificărilor';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Există modificări de rupere în această versiune. Vă rugăm să citiţi jurnalul modificărilor înainte de actualizare. Versiunea curentă a fișierului este $version, noua versiune este $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Paragraful';

  @override
  String get fontFamily => 'Familia de fonturi';

  @override
  String get smoothing => 'Amortizor';

  @override
  String get streamline => 'Raţionalizare';

  @override
  String get presentation => 'Prezentare';

  @override
  String get selectAsset => 'Selecteaza activ';

  @override
  String get clearStyle => 'Sterge stil';

  @override
  String get unknownImportType => 'Tip de import necunoscut';

  @override
  String get sureImportTemplate =>
      'Sunteți sigur că doriți să importați șablonul?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Redare';

  @override
  String get video => 'Video';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Breakpoint';

  @override
  String get presentationControls => 'Controale de prezentare';

  @override
  String get nextSlide => 'Următorul diapozitiv';

  @override
  String get nextSlideDescription =>
      'Glisați spre dreapta sau apăsați tasta săgeată dreapta pentru a merge la următorul slide';

  @override
  String get previousSlide => 'Diapozitivul anterior';

  @override
  String get previousSlideDescription =>
      'Glisați spre stânga sau apăsați tasta săgeată stânga pentru a merge la slide-ul anterior';

  @override
  String get exitPresentation => 'Ieșire din prezentare';

  @override
  String get exitPresentationDescription =>
      'Apăsați tasta de evacuare sau glisați în jos pentru a ieși din prezentare';

  @override
  String get pausePresentation => 'Întrerupeți prezentarea';

  @override
  String get pausePresentationDescription =>
      'Atingeți ecranul sau apăsați bara de spațiu pentru a întrerupe sau pentru a relua prezentarea';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'Ați ajuns la sfârșitul prezentării';

  @override
  String get startOfPresentation => 'Ați ajuns la începutul prezentării';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Titlu $index';
  }

  @override
  String get code => 'Cod';

  @override
  String get quote => 'Ofertă';

  @override
  String get link => 'Link-ul';

  @override
  String get checkbox => 'Casuta';

  @override
  String get deleted => 'Șters';

  @override
  String get emphasis => 'Accentuarea';

  @override
  String get listBullet => 'Listă marcaje';

  @override
  String get strong => 'Puternic';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Acasă';

  @override
  String get files => 'Fișiere';

  @override
  String get sortBy => 'Sortează după';

  @override
  String get location => 'Locaţie';

  @override
  String get whatsNew => 'Ce este nou?';

  @override
  String get unstar => 'Nerestea';

  @override
  String get star => 'Stea';

  @override
  String get goUp => 'Mergi mai sus';

  @override
  String get created => 'Creat';

  @override
  String get modified => 'Modificat';

  @override
  String get quickstart => 'Quickstart';

  @override
  String get noTemplates => 'În acest moment nu există șabloane disponibile';

  @override
  String get importCorePack => 'Importă pachetul de nucleu';

  @override
  String get importCorePackDescription =>
      'Importați pachetul de nucleu care conține toate activele de bază pentru a începe. Acest lucru va suprascrie actualul nucleu pachet.';

  @override
  String get never => 'Niciodată';

  @override
  String get onlyOnUpdates => 'Numai la actualizări';

  @override
  String get visibility => 'Vizibilitate';

  @override
  String get captureThumbnail => 'Capturează miniatura';

  @override
  String get capturedThumbnail => 'Miniatură captată cu succes';

  @override
  String get chooseLabelMode => 'Alege modul etichetă';

  @override
  String get foreground => 'prim-plan';

  @override
  String get version => 'Versiune';

  @override
  String get repository => 'Depozit';

  @override
  String get pages => 'Pagini';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Aranjare';

  @override
  String get bringToFront => 'Aduce în față';

  @override
  String get sendToBack => 'Trimite înapoi';

  @override
  String get bringForward => 'Adu înainte';

  @override
  String get sendBackward => 'Trimite înapoi';

  @override
  String get rotation => 'Rotație';

  @override
  String get onlyAvailableLargerScreen => 'Disponibil doar pe ecrane mai mari';

  @override
  String get toolbarPosition => 'Poziția barei de instrumente';

  @override
  String get rotate => 'Rotire';

  @override
  String get spacer => 'Spatier';

  @override
  String get navigationRail => 'Cale de navigare';

  @override
  String get cut => 'Taie';

  @override
  String get insertBefore => 'Inserare înainte';

  @override
  String get insertAfter => 'Inserare după';

  @override
  String get insertFirst => 'Inserare prima';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Lipește';

  @override
  String get ascending => 'Crescător';

  @override
  String get descending => 'Descrescător';

  @override
  String get imageScale => 'Scala imaginii';

  @override
  String get select => 'Selectare';

  @override
  String get tool => 'Unelte';

  @override
  String get texture => 'Textură';

  @override
  String get platformTheme => 'Tema platformei';

  @override
  String get desktop => 'Birou';

  @override
  String get mobile => 'Mobil';

  @override
  String get pdfQuality => 'Calitate PDF';

  @override
  String get surface => 'Suprafață';

  @override
  String get pattern => 'Model';

  @override
  String get sureClose => 'Ești sigur că vrei să închizi documentul?';

  @override
  String get thereAreUnsavedChanges => 'Există modificări nesalvate';

  @override
  String get page => 'Pagină';

  @override
  String get iceServers => 'Servere ICE';

  @override
  String get collaboration => 'Colaborare';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Socket web';

  @override
  String get iceServer => 'Server ICE';

  @override
  String get port => 'Portul';

  @override
  String get type => 'Tip';

  @override
  String get side => 'Lateral';

  @override
  String get client => 'Client';

  @override
  String get server => 'Server';

  @override
  String get switchView => 'Comutare vizualizare';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'Ascunde UI';

  @override
  String get density => 'Densitate';

  @override
  String get compact => 'Compact';

  @override
  String get comfortable => 'Comfortable';

  @override
  String get standard => 'Standard';

  @override
  String get lock => 'Blocare';

  @override
  String get addElement => 'Adaugă element';

  @override
  String get notDefaultConnection => 'Conexiune neimplicită';

  @override
  String get defaultConnection => 'Conexiune implicită';

  @override
  String get hide => 'Ascunde';

  @override
  String get show => 'Afișare';

  @override
  String get pause => 'Întrerupeți';

  @override
  String get stop => 'Oprește';

  @override
  String get refresh => 'Împrospătează';

  @override
  String get print => 'Tipărește';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Picături oftalmice';

  @override
  String get users => 'Utilizatori';

  @override
  String get experiments => 'Experimente';

  @override
  String get address => 'Adresa';

  @override
  String get spreadToPages => 'Răspândește la pagini';

  @override
  String get rootDirectorySpecifiedDescription =>
      'Directorul rădăcină este specificat. Toate directoarele avansate vor fi relative la acest director. Păstrați-l gol pentru a dezactiva acest tip de directoriu.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'Directorul rădăcină nu este specificat. Este necesar un nume. Toate directoarele avansate vor fi absolute. Păstrați gol pentru a dezactiva acest tip de director.';

  @override
  String get unsecureConnectionTitle => 'Conexiune nesigură';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'Conexiunea nu este securizată. Aceasta poate fi un risc de securitate. Vă rugăm să continuați numai dacă aveți încredere în conexiune. Amprenta sha1 este $fingerprint.';
  }

  @override
  String get continueAnyway => 'Continuă oricum';

  @override
  String get zoomControl => 'Comandă mărire';

  @override
  String get highContrast => 'Contrast mare';

  @override
  String get shouldANumber => 'Această valoare trebuie să fie un număr valid';

  @override
  String get createAreas => 'Creează zone';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Operațiuni';

  @override
  String get medium => 'Medie';

  @override
  String get large => 'Mare';

  @override
  String get toolbarSize => 'Dimensiunea barei de instrumente';

  @override
  String get addAll => 'Adaugă toate';

  @override
  String get onlyCurrentPage => 'Doar pagina curentă';

  @override
  String get smoothNavigation => 'Navigare lină';

  @override
  String get exact => 'Exact';

  @override
  String get inline => 'Inline';

  @override
  String get toolbarRows => 'Rânduri din bara de instrumente';

  @override
  String get pointerTest => 'Testul indicatorului';

  @override
  String get pressure => 'Presiune';

  @override
  String get small => 'Mică';

  @override
  String get tiny => 'Mică';

  @override
  String get selectAll => 'Selectează tot';

  @override
  String get overrideTools => 'Suprascrie uneltele';

  @override
  String get hideCursorWhileDrawing => 'Ascunde cursorul în timpul desenării';

  @override
  String get installed => 'Instalat';

  @override
  String get install => 'Instalează';

  @override
  String get deselect => 'Deselectează';

  @override
  String get changeCollection => 'Schimbă colecția';

  @override
  String get collections => 'Colecții';

  @override
  String get fullSelection => 'Selecţie completă';

  @override
  String get fullSelectionDescription =>
      'Necesită ca elementele să fie complet în caseta de selecție pentru selecție.';

  @override
  String get collection => 'Colectare';

  @override
  String get defaultCollection => 'Colectare implicită';

  @override
  String get scroll => 'Derulează';

  @override
  String get onStartup => 'La pornire';

  @override
  String get homeScreen => 'Ecranul principal';

  @override
  String get lastNote => 'Ultima notă';

  @override
  String get newNote => 'Notă nouă';

  @override
  String get convertToLayer => 'Convertește la nivel';

  @override
  String get merge => 'Îmbinare';

  @override
  String get up => 'Sus';

  @override
  String get down => 'Jos';

  @override
  String get other => 'Altele';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elemente',
      one: '1 element',
      zero: 'Niciun element',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Bară de culori';

  @override
  String get yesButShowButtons => 'Da, dar arată butoanele';

  @override
  String get optionsPanelPosition => 'Poziția panoului de opțiuni';

  @override
  String get hideDuration => 'Ascunde durata';

  @override
  String get animation => 'Animaţie';

  @override
  String get performance => 'Performanță';

  @override
  String get performanceDescription =>
      'Optimizat pentru viteză și utilizarea memoriei. Numai partea vizibilă a notei este copită în imagine.';

  @override
  String get normalDescription =>
      'Echilibrează calitatea și performanța. Bake o imagine care acoperă de 1,5 ori zona vizibilă, oferind tranziții mai ușoare atunci când derulează.';

  @override
  String get high => 'Ridicat';

  @override
  String get highDescription =>
      'Descriere: Maximizează calitatea la costul performanței. Prinde o imagine care acoperă de 2 ori suprafaţa vizibilă, asigurând redarea fără întreruperi chiar şi în timpul derulării rapide sau al zooming-ului.';

  @override
  String get renderResolution => 'Rezoluție de randare';

  @override
  String get translate => 'Tradu';

  @override
  String get unencrypted => 'Necriptat';

  @override
  String get encrypted => 'Criptat';

  @override
  String get encryptDocumentMessage => 'Click pentru a cripta documentul';

  @override
  String get unencryptDocumentMessage => 'Click pentru a dezcripta documentul';

  @override
  String get unencrypt => 'Necriptare';

  @override
  String get encrypt => 'Criptează';

  @override
  String get encryptWarning =>
      'Aceasta va cripta documentul. Va trebui să reamintiți parola pentru a o decripta.';

  @override
  String get unencryptWarning =>
      'Acest lucru va decripta documentul. Parola va fi eliminată și toată lumea cu acces îl va putea deschide.';

  @override
  String get confirmPassword => 'Confirmă parola';

  @override
  String get passwordMismatch => 'Parolele nu se potrivesc';

  @override
  String get action => 'Acțiune';

  @override
  String get svgText => 'Text SVG';

  @override
  String get offset => 'Decalaj';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
