// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get open => 'Apri';

  @override
  String get settings => 'Impostazioni';

  @override
  String get personalization => 'Personalizzazione';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Tema scuro';

  @override
  String get lightTheme => 'Tema chiaro';

  @override
  String get systemTheme => 'Usa tema di sistema predefinito';

  @override
  String get view => 'Visualizza';

  @override
  String get edit => 'Modifica';

  @override
  String get export => 'Esporta';

  @override
  String get save => 'Salva';

  @override
  String get zoom => 'Zoom';

  @override
  String get zoomIn => 'Aumenta zoom';

  @override
  String get zoomOut => 'Riduci zoom';

  @override
  String get resetZoom => 'Reimposta zoom';

  @override
  String get strokeWidth => 'Spessore tratto';

  @override
  String get includeEraser => 'Includere la gomma?';

  @override
  String get thinning => 'Sottigliezza';

  @override
  String get pen => 'Penna';

  @override
  String get eraser => 'Gomma';

  @override
  String get pathEraser => 'Cancella tratto';

  @override
  String get label => 'Etichetta';

  @override
  String get delete => 'Elimina';

  @override
  String get areYouSure => 'Sei sicuro?';

  @override
  String get reallyDelete => 'Vuoi davvero eliminare questo elemento?';

  @override
  String get no => 'No';

  @override
  String get yes => 'Sì';

  @override
  String get undo => 'Annulla';

  @override
  String get redo => 'Ripristina';

  @override
  String get general => 'Generale';

  @override
  String get copyTitle => 'Copiato negli appunti';

  @override
  String get loading => 'Caricamento...';

  @override
  String get enterText => 'Inserisci il testo';

  @override
  String get size => 'Dimensione';

  @override
  String get width => 'Larghezza';

  @override
  String get height => 'Altezza';

  @override
  String get count => 'Conta';

  @override
  String get space => 'Spazio';

  @override
  String get background => 'Sfondo';

  @override
  String get box => 'Riquadro';

  @override
  String get locale => 'Lingua';

  @override
  String get systemLocale => 'Localizzazione di sistema';

  @override
  String get information => 'Informazioni';

  @override
  String get license => 'Licenza';

  @override
  String get imprint => 'Contatti';

  @override
  String get privacypolicy => 'Informativa privacy';

  @override
  String get source => 'Fonte';

  @override
  String get documentation => 'Documentazione';

  @override
  String get changelog => 'Novità';

  @override
  String get existOverride => 'Questo elemento esiste già. Sovrascrivere?';

  @override
  String get description => 'Descrizione';

  @override
  String get fill => 'Riempi';

  @override
  String get defaultPalette => 'Palette predefinita';

  @override
  String get highlighter => 'Evidenziatore';

  @override
  String get add => 'Aggiungi';

  @override
  String get remove => 'Rimuovi';

  @override
  String get removeConfirm => 'Vuoi davvero rimuoverlo?';

  @override
  String get resetPalette => 'Reimposta palette';

  @override
  String get custom => 'Personalizza';

  @override
  String get decoration => 'Decorazione';

  @override
  String get underline => 'Sottolinea';

  @override
  String get overline => 'Sopralinea';

  @override
  String get strikethrough => 'Barrato';

  @override
  String get thickness => 'Spessore';

  @override
  String get style => 'Stile';

  @override
  String get solid => 'Solido';

  @override
  String get double => 'Doppio';

  @override
  String get dotted => 'Punteggiato';

  @override
  String get dashed => 'Tratteggiato';

  @override
  String get wavy => 'Ondulato';

  @override
  String get fontWeight => 'Dimensione carattere';

  @override
  String get normal => 'Normale';

  @override
  String get bold => 'Grassetto';

  @override
  String get italic => 'Corsivo';

  @override
  String get clipboard => 'Appunti';

  @override
  String get file => 'File';

  @override
  String get data => 'Dati';

  @override
  String get share => 'Condividi';

  @override
  String get spacing => 'Spaziatura';

  @override
  String get image => 'Immagine';

  @override
  String get enterUrl => 'Inserisci l\'url';

  @override
  String get scale => 'Scala';

  @override
  String get help => 'Aiuto';

  @override
  String get reallyReset => 'Vuoi davvero reimpostarlo?';

  @override
  String get whatToDo => 'Che cosa vuoi fare?';

  @override
  String get ignore => 'Ignora';

  @override
  String get backup => 'Backup';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'Il file $fileName è stato creato in una versione più recente ($fileVersion). Cosa fare di questo file?';
  }

  @override
  String get waypoints => 'Segnaposti';

  @override
  String get origin => 'Origine';

  @override
  String get import => 'Importa';

  @override
  String get newContent => 'Nuovo';

  @override
  String get selectElement => 'Seleziona elemento';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Shift';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Copia versione';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Comportamenti';

  @override
  String get dataDirectory => 'Cartella dati';

  @override
  String get defaultPath => 'Percorso predefinito';

  @override
  String get dateFormat => 'Formato data';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Aggiornato a: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Creato a: $dateTimeString';
  }

  @override
  String get rename => 'Rinomina';

  @override
  String get duplicate => 'Duplica';

  @override
  String get hand => 'Mano';

  @override
  String get folder => 'Cartella';

  @override
  String get move => 'Sposta';

  @override
  String get copy => 'Copia';

  @override
  String get back => 'Indietro';

  @override
  String get zoomDependent => 'Dipendente dallo zoom';

  @override
  String get shapeDetection => 'Rilevamento Forme';

  @override
  String get delay => 'Ritardo';

  @override
  String get defaultLayer => 'Layer predefinito';

  @override
  String get layer => 'Layer';

  @override
  String get layers => 'Layers';

  @override
  String get notSet => 'Non impostato';

  @override
  String get enterLayer => 'Inserisci il nome del layer';

  @override
  String get selectElements => 'Seleziona elementi';

  @override
  String get deleteElements => 'Elimina elementi';

  @override
  String get deleteElementsConfirm =>
      'Vuoi davvero eliminare gli elementi selezionati?';

  @override
  String get selectCustomCollection =>
      'Seleziona una collezione personalizzata';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => 'Sensibilità';

  @override
  String get sensitivityHint =>
      'Più alto è il valore, più sensibile è l\'input';

  @override
  String get horizontal => 'Orizzontale';

  @override
  String get vertical => 'Verticale';

  @override
  String get plain => 'Semplice';

  @override
  String get light => 'Chiaro';

  @override
  String get ruled => 'Righe';

  @override
  String get quad => 'Quadretti';

  @override
  String get music => 'Spartito';

  @override
  String get dark => 'Scuro';

  @override
  String get plainDark => 'Scuro';

  @override
  String get ruledDark => 'Scuro a righe';

  @override
  String get quadDark => 'Scuro a quadretti';

  @override
  String get musicDark => 'Spartito scuro';

  @override
  String get templates => 'Template';

  @override
  String get untitled => 'Senza titolo';

  @override
  String get createTemplate => 'Crea template';

  @override
  String get createTemplateContent =>
      'Vuoi davvero creare un template da questo documento? Il documento originale verrà eliminato.';

  @override
  String get replace => 'Sostituisci';

  @override
  String get reallyReplace =>
      'Vuoi davvero sostituire il template? Questa operazione non può essere annullata!';

  @override
  String get defaultTemplate => 'Modello predefinito';

  @override
  String get insert => 'Inserisci';

  @override
  String get document => 'Documento';

  @override
  String get camera => 'Fotocamera';

  @override
  String get printout => 'Stampa';

  @override
  String get selectCamera => 'Seleziona una fotocamera';

  @override
  String get changeDocumentPath => 'Cambia percorso documento';

  @override
  String get deleteWholeStroke => 'Elimina tutto il tratto';

  @override
  String get alpha => 'Alfa';

  @override
  String get area => 'Area';

  @override
  String get selectArea => 'Seleziona un\'area';

  @override
  String get aspectRatio => 'Rapporto dimensioni';

  @override
  String get presets => 'Predefiniti';

  @override
  String get pagePortrait => 'Pagina verticale';

  @override
  String get pageLandscape => 'Pagina orizzontale';

  @override
  String get square => 'Quadrato';

  @override
  String get areas => 'Aree';

  @override
  String get enterArea => 'Inserisci l\'area';

  @override
  String get exitArea => 'Esci dall\'area';

  @override
  String get currentArea => 'Area attuale';

  @override
  String get design => 'Design';

  @override
  String get text => 'Testo';

  @override
  String welcome(String codeName) {
    return 'Hey, questa è farfalla di linwood';
  }

  @override
  String get welcomeContent => 'Uno spazio di disegno libero e open-source!';

  @override
  String updated(String version) {
    return 'App aggiornata alla versione $version';
  }

  @override
  String get releaseNotes => 'Note di rilascio';

  @override
  String get constraints => 'Vincoli';

  @override
  String get scaled => 'Scalato';

  @override
  String get fixed => 'Fisso';

  @override
  String get dynamicContent => 'Dinamico';

  @override
  String get none => 'Nessuno';

  @override
  String get includeArea => 'Includi area';

  @override
  String get verticalAlignment => 'Allineamento verticale';

  @override
  String get horizontalAlignment => 'Allineamento orizzontale';

  @override
  String get top => 'Alto';

  @override
  String get center => 'Centro';

  @override
  String get bottom => 'Basso';

  @override
  String get left => 'Sinistra';

  @override
  String get right => 'Destra';

  @override
  String get justify => 'Giustifica';

  @override
  String get constraint => 'Vincolo';

  @override
  String get length => 'Lunghezza';

  @override
  String get exportSvg => 'Esporta SVG';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => 'Seleziona pagine';

  @override
  String get recentFiles => 'File recenti';

  @override
  String get start => 'Inizia';

  @override
  String get noRecentFiles => 'Nessun file recente';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pagine',
      one: '1 pagina',
      zero: 'Nessuna pagina',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Pagina $index';
  }

  @override
  String get exit => 'Esci';

  @override
  String get noElements => 'Nessun elemento';

  @override
  String get invertSelection => 'Inverti selezione';

  @override
  String get errorWhileImporting => 'Errore durante l\'importazione';

  @override
  String get errorWhileImportingContent =>
      'Si è verificato un errore durante l\'importazione del file';

  @override
  String get showDetails => 'Mostra dettagli';

  @override
  String get hideDetails => 'Nascondi dettagli';

  @override
  String get error => 'Errore';

  @override
  String get stackTrace => 'Stack trace';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Durata';

  @override
  String get quality => 'Qualità';

  @override
  String get exportPdf => 'Esporta PDF';

  @override
  String get local => 'Locale';

  @override
  String get addConnection => 'Aggiungi connessione';

  @override
  String get connections => 'Connessioni';

  @override
  String get noConnections => 'Nessuna connessione';

  @override
  String get url => 'URL';

  @override
  String get connect => 'Connetti';

  @override
  String get username => 'Username';

  @override
  String get password => 'Password';

  @override
  String get webNotSupported => 'Web non supportato';

  @override
  String get advanced => 'Avanzate';

  @override
  String get directory => 'Directory';

  @override
  String get documentsDirectory => 'Percorso documenti';

  @override
  String get templatesDirectory => 'Cartella modelli';

  @override
  String get errorWhileCreatingConnection =>
      'Errore durante la creazione della connessione';

  @override
  String get cannotConnect => 'Impossibile connettersi';

  @override
  String get urlNotValid => 'URL non valido';

  @override
  String get icon => 'Icona';

  @override
  String get update => 'Aggiorna';

  @override
  String get updateAvailable => 'Aggiornamento disponibile';

  @override
  String get stable => 'Stabile';

  @override
  String get nightly => 'Notte';

  @override
  String get checkForUpdates => 'Controlla aggiornamenti';

  @override
  String get checkForUpdatesWarning =>
      'Effettuando un controllo per gli aggiornamenti si collegherà al sito web di Butterfly per ottenere le informazioni.';

  @override
  String get usingLatestStable => 'Stai usando l\'ultima versione stabile';

  @override
  String get usingLatestNightly => 'Stai usando l\'ultima versione nightly';

  @override
  String get currentVersion => 'Versione attuale';

  @override
  String get updateNow => 'Aggiorna ora';

  @override
  String get shape => 'Forma';

  @override
  String get circle => 'Cerchio';

  @override
  String get rectangle => 'Rettangolo';

  @override
  String get triangle => 'Triangolo';

  @override
  String get line => 'Linea';

  @override
  String get cornerRadius => 'Raggio del bordo';

  @override
  String get topLeft => 'Alto a sinistra';

  @override
  String get topRight => 'Alto a destra';

  @override
  String get bottomLeft => 'Basso a sinistra';

  @override
  String get bottomRight => 'Basso a destra';

  @override
  String get caches => 'Cache';

  @override
  String get manage => 'Gestisci';

  @override
  String get clearCaches => 'Cancella cache';

  @override
  String get createCache => 'Crea cache';

  @override
  String get thirdPartyLicenses => 'Licenze di terze parti';

  @override
  String get syncing => 'Sincronizzazione...';

  @override
  String get synced => 'Sincronizzato';

  @override
  String get notSynced => 'Non sincronizzato';

  @override
  String get conflict => 'Conflitto';

  @override
  String get keepLocal => 'Mantieni locale';

  @override
  String get keepConnection => 'Mantieni connessione';

  @override
  String get keepBoth => 'Mantieni entrambi';

  @override
  String get forAll => 'Per tutti';

  @override
  String fileConflict(String file, String connection) {
    return '$file in $connection ha un conflitto';
  }

  @override
  String get offline => 'Offline';

  @override
  String get localLatest => 'Più recente locale';

  @override
  String get connectionLatest => 'Connessione più recente';

  @override
  String get path => 'Percorso';

  @override
  String get folderSynced => 'Cartella sincronizzata';

  @override
  String get syncRootDirectory => 'Sincronizza directory root';

  @override
  String get penOnlyInput => 'Input solo penna';

  @override
  String get inputGestures => 'Gestures di input';

  @override
  String get nativeTitleBar => 'Barra del titolo nativo';

  @override
  String get syncMode => 'Modalità sincronizzazione';

  @override
  String get connection => 'Connessione';

  @override
  String get always => 'Sempre';

  @override
  String get noMobile => 'Nessun cellulare';

  @override
  String get manual => 'Manuale';

  @override
  String get search => 'Cerca';

  @override
  String get properties => 'Proprietà';

  @override
  String get pin => 'Pin';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Elemento';

  @override
  String get painter => 'Pittore';

  @override
  String get position => 'Posizione';

  @override
  String get note => 'Nota';

  @override
  String get packs => 'Pacchetti';

  @override
  String get pack => 'Pacchetto';

  @override
  String get more => 'Altro';

  @override
  String get askForName => 'Chiedi nome';

  @override
  String areaIndex(int index) {
    return 'Area $index';
  }

  @override
  String get startInFullScreen => 'Avvia a schermo intero';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Mouse';

  @override
  String get touch => 'Tocco';

  @override
  String get keyboard => 'Tastiera';

  @override
  String get shortcuts => 'Scorciatoie';

  @override
  String get middle => 'Centrale';

  @override
  String get first => 'Primo';

  @override
  String get second => 'Secondo';

  @override
  String get tools => 'Strumenti';

  @override
  String get showGrid => 'Mostra griglia';

  @override
  String get grid => 'Griglia';

  @override
  String get ruler => 'Righello';

  @override
  String get angle => 'Angolo';

  @override
  String get report => 'Segnala';

  @override
  String get newFolder => 'Nuova cartella';

  @override
  String get createPack => 'Crea pacchetto';

  @override
  String get editPack => 'Modifica pacchetto';

  @override
  String get packsDirectory => 'Cartella pacchetti';

  @override
  String get stamp => 'Timbro';

  @override
  String get addToPack => 'Aggiungi al pacchetto';

  @override
  String get sureImportPack => 'Sei sicuro di voler importare il pacchetto?';

  @override
  String byAuthor(String author) {
    return 'da $author';
  }

  @override
  String get author => 'Autore';

  @override
  String get addAsset => 'Aggiungi risorsa';

  @override
  String get editAsset => 'Modifica asset';

  @override
  String get scope => 'Ambito';

  @override
  String get noPacks => 'Al momento non ci sono pacchetti disponibili';

  @override
  String get components => 'Componenti';

  @override
  String get waypoint => 'Segnaposto';

  @override
  String get actions => 'Azioni';

  @override
  String get painters => 'Pittori';

  @override
  String get breakingChangesTitle => 'Cambiamenti di rottura';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Ci sono modifiche in corso in questa versione. Si prega di leggere il changelog prima di aggiornare. La versione corrente del file è $version, la nuova versione è $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Paragrafo';

  @override
  String get fontFamily => 'Famiglia di caratteri';

  @override
  String get smoothing => 'Smussatura';

  @override
  String get streamline => 'Flusso d\' inchiostro';

  @override
  String get presentation => 'Presentazione';

  @override
  String get selectAsset => 'Seleziona asset';

  @override
  String get clearStyle => 'Cancella stile';

  @override
  String get unknownImportType => 'Tipo di importazione sconosciuto';

  @override
  String get sureImportTemplate => 'Sei sicuro di voler importare il modello?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Gioca';

  @override
  String get video => 'Video';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Breakpoint';

  @override
  String get presentationControls => 'Controlli di presentazione';

  @override
  String get nextSlide => 'Diapositiva successiva';

  @override
  String get nextSlideDescription =>
      'Scorri verso destra o premi il tasto freccia destra per andare alla diapositiva successiva';

  @override
  String get previousSlide => 'Diapositive precedente';

  @override
  String get previousSlideDescription =>
      'Scorri verso sinistra o premi il tasto freccia sinistra per andare alla diapositiva precedente';

  @override
  String get exitPresentation => 'Esci dalla presentazione';

  @override
  String get exitPresentationDescription =>
      'Premi il tasto di escape o scorri verso il basso per uscire dalla presentazione';

  @override
  String get pausePresentation => 'Pausa presentazione';

  @override
  String get pausePresentationDescription =>
      'Toccare lo schermo o premere la barra spaziatrice per mettere in pausa o riprendere la presentazione';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'Hai raggiunto la fine della presentazione';

  @override
  String get startOfPresentation =>
      'Hai raggiunto l\'inizio della presentazione';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Titolo $index';
  }

  @override
  String get code => 'Codice';

  @override
  String get quote => 'Preventivo';

  @override
  String get link => 'Link';

  @override
  String get checkbox => 'Checkbox';

  @override
  String get deleted => 'Eliminato';

  @override
  String get emphasis => 'Enfasi';

  @override
  String get listBullet => 'Elenco proiettile';

  @override
  String get strong => 'Forte';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Home';

  @override
  String get files => 'File';

  @override
  String get sortBy => 'Ordina per';

  @override
  String get location => 'Posizione';

  @override
  String get whatsNew => 'Cosa c\'è di nuovo?';

  @override
  String get unstar => 'Unstar';

  @override
  String get star => 'Stella';

  @override
  String get goUp => 'Vai su';

  @override
  String get created => 'Creato';

  @override
  String get modified => 'Modificato';

  @override
  String get quickstart => 'Avvio Rapido';

  @override
  String get noTemplates => 'Al momento non ci sono modelli disponibili';

  @override
  String get importCorePack => 'Importa pacchetto core';

  @override
  String get importCorePackDescription =>
      'Importa il core pack che contiene tutte le risorse di base per iniziare. Questo sovrascriverà l\'attuale core pack.';

  @override
  String get never => 'Mai';

  @override
  String get onlyOnUpdates => 'Solo sugli aggiornamenti';

  @override
  String get visibility => 'Visibilità';

  @override
  String get captureThumbnail => 'Cattura miniatura';

  @override
  String get capturedThumbnail => 'Miniatura catturata con successo';

  @override
  String get chooseLabelMode => 'Scegli la modalità etichetta';

  @override
  String get foreground => 'Primo Piano';

  @override
  String get version => 'Versione';

  @override
  String get repository => 'Repository';

  @override
  String get pages => 'Pagine';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Disporre';

  @override
  String get bringToFront => 'Porta avanti';

  @override
  String get sendToBack => 'Invia al retro';

  @override
  String get bringForward => 'Avanti';

  @override
  String get sendBackward => 'Invia indietro';

  @override
  String get rotation => 'Rotazione';

  @override
  String get onlyAvailableLargerScreen =>
      'Disponibile solo su schermi più grandi';

  @override
  String get toolbarPosition => 'Posizione barra strumenti';

  @override
  String get rotate => 'Ruota';

  @override
  String get spacer => 'Spaziatore';

  @override
  String get navigationRail => 'Barra di navigazione';

  @override
  String get cut => 'Taglia';

  @override
  String get insertBefore => 'Inserisci prima';

  @override
  String get insertAfter => 'Inserisci dopo';

  @override
  String get insertFirst => 'Inserisci prima';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Incolla';

  @override
  String get ascending => 'Crescente';

  @override
  String get descending => 'Decrescente';

  @override
  String get imageScale => 'Scala immagine';

  @override
  String get select => 'Seleziona';

  @override
  String get tool => 'Strumento';

  @override
  String get texture => 'Texture';

  @override
  String get platformTheme => 'Tema piattaforma';

  @override
  String get desktop => 'Desktop';

  @override
  String get mobile => 'Cellulare';

  @override
  String get pdfQuality => 'Qualità PDF';

  @override
  String get surface => 'Superficie';

  @override
  String get pattern => 'Sequenza';

  @override
  String get sureClose => 'Sei sicuro di voler chiudere il documento?';

  @override
  String get thereAreUnsavedChanges => 'Ci sono modifiche non salvate';

  @override
  String get page => 'Pagina';

  @override
  String get iceServers => 'Server ICE';

  @override
  String get collaboration => 'Collaborazione';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Web Socket';

  @override
  String get iceServer => 'Server ICE';

  @override
  String get port => 'Porta';

  @override
  String get type => 'Tipo';

  @override
  String get side => 'Lato';

  @override
  String get client => 'Client';

  @override
  String get server => 'Server';

  @override
  String get switchView => 'Cambia Vista';

  @override
  String get lasso => 'Lazzo';

  @override
  String get hideUI => 'Nascondi UI';

  @override
  String get density => 'Densità';

  @override
  String get compact => 'Compatto';

  @override
  String get comfortable => 'Confortevole';

  @override
  String get standard => 'Standard';

  @override
  String get lock => 'Blocca';

  @override
  String get addElement => 'Aggiungi elemento';

  @override
  String get notDefaultConnection => 'Connessione non predefinita';

  @override
  String get defaultConnection => 'Connessione predefinita';

  @override
  String get hide => 'Nascondi';

  @override
  String get show => 'Mostra';

  @override
  String get pause => 'Pausa';

  @override
  String get stop => 'Ferma';

  @override
  String get refresh => 'Aggiorna';

  @override
  String get print => 'Stampa';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Selettore Colore';

  @override
  String get users => 'Utenti';

  @override
  String get experiments => 'Esperimenti';

  @override
  String get address => 'Indirizzo';

  @override
  String get spreadToPages => 'Dividi in pagine';

  @override
  String get rootDirectorySpecifiedDescription =>
      'La directory radice è specificata. Tutti i percorsi di directory avanzati saranno relativi a questa directory. Tienila vuota per disabilitare questo tipo di directory.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'La directory radice non è specificata. È richiesto un nome. Tutti i percorsi di directory avanzati saranno assoluti. Mantieni vuoto per disabilitare questo tipo di directory.';

  @override
  String get unsecureConnectionTitle => 'Connessione non sicura';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'La connessione non è sicura. Questo può essere un rischio per la sicurezza. Continua solo se ritieni attendibile la connessione. L\'impronta digitale sha1 è $fingerprint.';
  }

  @override
  String get continueAnyway => 'Continua comunque';

  @override
  String get zoomControl => 'Controllo zoom';

  @override
  String get highContrast => 'Alto contrasto';

  @override
  String get shouldANumber => 'Questo valore deve essere valido';

  @override
  String get createAreas => 'Crea Area';

  @override
  String get autosave => 'Salvataggio automatico';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Operazioni';

  @override
  String get medium => 'Medio';

  @override
  String get large => 'Largo';

  @override
  String get toolbarSize => 'Dimensione barra strumenti';

  @override
  String get addAll => 'Aggiungi tutto';

  @override
  String get onlyCurrentPage => 'Solo la pagina corrente';

  @override
  String get smoothNavigation => 'Navigazione fluida';

  @override
  String get exact => 'Esatto';

  @override
  String get inline => 'Incorporato';

  @override
  String get toolbarRows => 'Righe barra strumenti';

  @override
  String get pointerTest => 'Test puntatore';

  @override
  String get pressure => 'Pressione';

  @override
  String get small => 'Piccolo';

  @override
  String get tiny => 'Minuscolo';

  @override
  String get selectAll => 'Seleziona tutto';

  @override
  String get overrideTools => 'Sovrascrivi strumenti';

  @override
  String get hideCursorWhileDrawing => 'Nascondi il cursore durante il disegno';

  @override
  String get installed => 'Installato';

  @override
  String get install => 'Installa';

  @override
  String get deselect => 'Deseleziona';

  @override
  String get changeCollection => 'Cambia collezione';

  @override
  String get collections => 'Collezioni';

  @override
  String get fullSelection => 'Selezione completa';

  @override
  String get fullSelectionDescription =>
      'Richiede elementi per essere completamente all\'interno della casella di selezione per la selezione.';

  @override
  String get collection => 'Collezione';

  @override
  String get defaultCollection => 'Collezione predefinita';

  @override
  String get scroll => 'Scorrimento';

  @override
  String get onStartup => 'All\'avvio';

  @override
  String get homeScreen => 'Schermata home';

  @override
  String get lastNote => 'Ultima nota';

  @override
  String get newNote => 'Nuova nota';

  @override
  String get convertToLayer => 'Converti in livello';

  @override
  String get merge => 'Unisci';

  @override
  String get up => 'Su';

  @override
  String get down => 'Giù';

  @override
  String get other => 'Altro';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementi',
      one: '1 elemento',
      zero: 'Nessun elemento',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Barra dei colori';

  @override
  String get yesButShowButtons => 'Sì, ma mostra i pulsanti';

  @override
  String get optionsPanelPosition => 'Posizione pannello opzioni';

  @override
  String get hideDuration => 'Nascondi durata';

  @override
  String get animation => 'Animazione';

  @override
  String get performance => 'Prestazioni';

  @override
  String get performanceDescription =>
      'Ottimizzato per la velocità e l\'utilizzo della memoria. Solo la parte visibile della nota viene cotta nell\'immagine.';

  @override
  String get normalDescription =>
      'Bilancia qualità e prestazioni. Cuoce un\'immagine che copre 1,5 volte l\'area visibile, fornendo transizioni più fluide durante lo scorrimento.';

  @override
  String get high => 'Alto';

  @override
  String get highDescription =>
      'Descrizione: Massimizza la qualità al costo delle prestazioni. Cuoce un\'immagine che copre 2 volte l\'area visibile, garantendo un rendering senza soluzione di continuità anche durante uno scorrimento rapido o ingrandimento.';

  @override
  String get renderResolution => 'Risoluzione del rendering';

  @override
  String get translate => 'Trasla';

  @override
  String get unencrypted => 'Non Crittografato';

  @override
  String get encrypted => 'Criptato';

  @override
  String get encryptDocumentMessage => 'Fare clic per cifrare il documento';

  @override
  String get unencryptDocumentMessage =>
      'Fare clic per non cifrare il documento';

  @override
  String get unencrypt => 'Unencrypt';

  @override
  String get encrypt => 'Cifra';

  @override
  String get encryptWarning =>
      'Questo cifrerà il documento. Dovrai ricordare la password per decifrarlo.';

  @override
  String get unencryptWarning =>
      'Questo non cifrerà il documento. La password verrà rimossa e chiunque abbia accesso sarà in grado di aprirla.';

  @override
  String get confirmPassword => 'Conferma password';

  @override
  String get passwordMismatch => 'Le password non corrispondono';

  @override
  String get action => 'Azione';

  @override
  String get svgText => 'Testo SVG';

  @override
  String get offset => 'Scostamento';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
