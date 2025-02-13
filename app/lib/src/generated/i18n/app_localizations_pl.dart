// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get open => 'Otwórz';

  @override
  String get settings => 'Ustawienia';

  @override
  String get personalization => 'Personalizacja';

  @override
  String get theme => 'Motyw';

  @override
  String get darkTheme => 'Ciemny motyw';

  @override
  String get lightTheme => 'Jasny motyw';

  @override
  String get systemTheme => 'Użyj domyślnego motywu systemowego';

  @override
  String get view => 'Widok';

  @override
  String get edit => 'Edytuj';

  @override
  String get export => 'Eksportuj';

  @override
  String get save => 'Zapisz';

  @override
  String get zoom => 'Powiększ';

  @override
  String get zoomIn => 'Powiększ';

  @override
  String get zoomOut => 'Pomniejsz';

  @override
  String get resetZoom => 'Resetuj powiększenie';

  @override
  String get strokeWidth => 'Szerokość obrysu';

  @override
  String get includeEraser => 'Dołącz wymazywanie?';

  @override
  String get thinning => 'Miażdżenie';

  @override
  String get pen => 'Długopis';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Wymaż linię';

  @override
  String get label => 'Etykieta';

  @override
  String get delete => 'Usuń';

  @override
  String get areYouSure => 'Jesteś pewien?';

  @override
  String get reallyDelete => 'Czy na pewno chcesz usunąć ten element?';

  @override
  String get no => 'Nie';

  @override
  String get yes => 'Tak';

  @override
  String get undo => 'Cofnij';

  @override
  String get redo => 'Ponów';

  @override
  String get general => 'Ogólny';

  @override
  String get copyTitle => 'Skopiowano do schowka';

  @override
  String get loading => 'Ładowanie...';

  @override
  String get enterText => 'Wprowadź tekst';

  @override
  String get size => 'Rozmiar';

  @override
  String get width => 'Width';

  @override
  String get height => 'Wysokość';

  @override
  String get count => 'Liczba';

  @override
  String get space => 'Przestrzeń';

  @override
  String get background => 'Kontekst';

  @override
  String get box => 'Pudełko';

  @override
  String get locale => 'Język';

  @override
  String get systemLocale => 'Ustawienia regionalne systemu';

  @override
  String get information => 'Informacje';

  @override
  String get license => 'Licencja';

  @override
  String get imprint => 'Nadruk';

  @override
  String get privacypolicy => 'Polityka prywatności';

  @override
  String get source => 'Źródło';

  @override
  String get documentation => 'Dokumentacja';

  @override
  String get changelog => 'Lista zmian';

  @override
  String get existOverride => 'Ten element już istnieje. Nadpisać?';

  @override
  String get description => 'Opis';

  @override
  String get fill => 'Wypełnij';

  @override
  String get defaultPalette => 'Domyślna paleta';

  @override
  String get highlighter => 'Podświetlenie';

  @override
  String get add => 'Dodaj';

  @override
  String get remove => 'Usuń';

  @override
  String get removeConfirm => 'Czy na pewno chcesz to usunąć?';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => 'Własny';

  @override
  String get decoration => 'Dekoracja';

  @override
  String get underline => 'Podkreślenie';

  @override
  String get overline => 'Obiekt';

  @override
  String get strikethrough => 'Przekreślenie';

  @override
  String get thickness => 'Grubość';

  @override
  String get style => 'Styl';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Podwójny';

  @override
  String get dotted => 'Kropkowy';

  @override
  String get dashed => 'Kreskowane';

  @override
  String get wavy => 'Fala';

  @override
  String get fontWeight => 'Waga czcionki';

  @override
  String get normal => 'Normalny';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Schowek';

  @override
  String get file => 'Plik';

  @override
  String get data => 'Dane';

  @override
  String get share => 'Udostępnij';

  @override
  String get spacing => 'Odstępy';

  @override
  String get image => 'Obraz';

  @override
  String get enterUrl => 'Wprowadź adres URL';

  @override
  String get scale => 'Skala';

  @override
  String get help => 'Pomoc';

  @override
  String get reallyReset => 'Czy na pewno chcesz to zresetować?';

  @override
  String get whatToDo => 'Co chcesz zrobić?';

  @override
  String get ignore => 'Ignoruj';

  @override
  String get backup => 'Kopia zapasowa';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'Plik $fileName został utworzony w nowszej wersji ($fileVersion). Co należy zrobić z tym plikiem?';
  }

  @override
  String get waypoints => 'Punkty drogi';

  @override
  String get origin => 'Pochodzenie';

  @override
  String get import => 'Importuj';

  @override
  String get newContent => 'Nowy';

  @override
  String get selectElement => 'Wybierz element';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Zmiana';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Kopiuj wersję';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Zachowania';

  @override
  String get dataDirectory => 'Katalog danych';

  @override
  String get defaultPath => 'Domyślna ścieżka';

  @override
  String get dateFormat => 'Format daty';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Zaktualizowano: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Utworzono w: $dateTimeString';
  }

  @override
  String get rename => 'Zmień nazwę';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => 'Dłoń';

  @override
  String get folder => 'Folder';

  @override
  String get move => 'Przenieś';

  @override
  String get copy => 'Kopiuj';

  @override
  String get back => 'Powrót';

  @override
  String get zoomDependent => 'Zależny od powiększenia';

  @override
  String get shapeDetection => 'Wykrywanie kształtu';

  @override
  String get delay => 'Opóźnienie';

  @override
  String get defaultLayer => 'Warstwa domyślna';

  @override
  String get layer => 'Warstwa';

  @override
  String get layers => 'Warstwa';

  @override
  String get notSet => 'Nie ustawiono';

  @override
  String get enterLayer => 'Wprowadź nazwę warstwy';

  @override
  String get selectElements => 'Wybierz elementy';

  @override
  String get deleteElements => 'Usuń elementy';

  @override
  String get deleteElementsConfirm =>
      'Czy na pewno chcesz usunąć wybrane elementy?';

  @override
  String get selectCustomCollection => 'Wybierz własną kolekcję';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => 'Czułość';

  @override
  String get sensitivityHint =>
      'Im wyższa wartość, tym bardziej wrażliwe dane wejściowe';

  @override
  String get horizontal => 'Poziomy';

  @override
  String get vertical => 'Pionowo';

  @override
  String get plain => 'Zwykłe';

  @override
  String get light => 'Światło';

  @override
  String get ruled => 'Otoczone';

  @override
  String get quad => 'Poczwórny';

  @override
  String get music => 'Muzyka';

  @override
  String get dark => 'Ciemny';

  @override
  String get plainDark => 'Ciemny';

  @override
  String get ruledDark => 'Ciemny wieszak';

  @override
  String get quadDark => 'Czterociemny';

  @override
  String get musicDark => 'Ciemna muzyka';

  @override
  String get templates => 'Szablony';

  @override
  String get untitled => 'Bez tytułu';

  @override
  String get createTemplate => 'Utwórz szablon';

  @override
  String get createTemplateContent =>
      'Czy na pewno chcesz utworzyć szablon z tego dokumentu? Oryginalny dokument zostanie usunięty.';

  @override
  String get replace => 'Zamień';

  @override
  String get reallyReplace =>
      'Czy na pewno chcesz zastąpić szablon? Tej operacji nie można cofnąć!';

  @override
  String get defaultTemplate => 'Domyślny szablon';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'Dokument';

  @override
  String get camera => 'Aparat';

  @override
  String get printout => 'Wydruk';

  @override
  String get selectCamera => 'Wybierz kamerę';

  @override
  String get changeDocumentPath => 'Zmień ścieżkę dokumentu';

  @override
  String get deleteWholeStroke => 'Usuń całą kreskę';

  @override
  String get alpha => 'Alfa';

  @override
  String get area => 'Obszar';

  @override
  String get selectArea => 'Wybierz obszar';

  @override
  String get aspectRatio => 'Współczynnik proporcji';

  @override
  String get presets => 'Ustawienia';

  @override
  String get pagePortrait => 'Strona pionowa';

  @override
  String get pageLandscape => 'Strona pozioma';

  @override
  String get square => 'Kwadratowy';

  @override
  String get areas => 'Obszary';

  @override
  String get enterArea => 'Wejdź do obszaru';

  @override
  String get exitArea => 'Wyjdź z obszaru';

  @override
  String get currentArea => 'Bieżący obszar';

  @override
  String get design => 'Projekt';

  @override
  String get text => 'Tekst';

  @override
  String welcome(String codeName) {
    return 'Hej, to jest Łuskowy Motyw';
  }

  @override
  String get welcomeContent => 'Wolne i otwarte miejsce na rysowanie!';

  @override
  String updated(String version) {
    return 'Aplikacja zaktualizowana do wersji $version';
  }

  @override
  String get releaseNotes => 'Informacje o wydaniu';

  @override
  String get constraints => 'Ograniczenia';

  @override
  String get scaled => 'Skala';

  @override
  String get fixed => 'Naprawione';

  @override
  String get dynamicContent => 'Dynamiczny';

  @override
  String get none => 'Brak';

  @override
  String get includeArea => 'Dołącz obszar';

  @override
  String get verticalAlignment => 'Wyrównanie pionowe';

  @override
  String get horizontalAlignment => 'Wyrównanie poziome';

  @override
  String get top => 'Góra';

  @override
  String get center => 'Środkowy';

  @override
  String get bottom => 'Dolny';

  @override
  String get left => 'W lewo';

  @override
  String get right => 'Prawy';

  @override
  String get justify => 'Wyrównaj';

  @override
  String get constraint => 'Ograniczenie';

  @override
  String get length => 'Długość';

  @override
  String get exportSvg => 'Eksportuj SVG';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => 'Wybierz strony';

  @override
  String get recentFiles => 'Ostatnie pliki';

  @override
  String get start => 'Rozpocznij';

  @override
  String get noRecentFiles => 'Brak ostatnich plików';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count strony',
      one: '1 strona',
      zero: 'Brak stron',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Strona $index';
  }

  @override
  String get exit => 'Wyjście';

  @override
  String get noElements => 'Brak elementów';

  @override
  String get invertSelection => 'Odwróć zaznaczenie';

  @override
  String get errorWhileImporting => 'Błąd podczas importowania';

  @override
  String get errorWhileImportingContent =>
      'Wystąpił błąd podczas importowania pliku';

  @override
  String get showDetails => 'Pokaż szczegóły';

  @override
  String get hideDetails => 'Ukryj szczegóły';

  @override
  String get error => 'Błąd';

  @override
  String get stackTrace => 'Ślad stosu';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Czas trwania';

  @override
  String get quality => 'Jakość';

  @override
  String get exportPdf => 'Eksportuj PDF';

  @override
  String get local => 'Lokalny';

  @override
  String get addConnection => 'Dodaj połączenie';

  @override
  String get connections => 'Połączenia';

  @override
  String get noConnections => 'Brak połączeń';

  @override
  String get url => 'Adres URL';

  @override
  String get connect => 'Połącz';

  @override
  String get username => 'Nazwa użytkownika';

  @override
  String get password => 'Hasło';

  @override
  String get webNotSupported => 'Sieć nie jest obsługiwana';

  @override
  String get advanced => 'Zaawansowane';

  @override
  String get directory => 'Katalog';

  @override
  String get documentsDirectory => 'Katalog dokumentów';

  @override
  String get templatesDirectory => 'Katalog szablonów';

  @override
  String get errorWhileCreatingConnection =>
      'Błąd podczas tworzenia połączenia';

  @override
  String get cannotConnect => 'Nie można połączyć';

  @override
  String get urlNotValid => 'Nieprawidłowy adres URL';

  @override
  String get icon => 'Ikona';

  @override
  String get update => 'Aktualizuj';

  @override
  String get updateAvailable => 'Dostępna aktualizacja';

  @override
  String get stable => 'Stabilność';

  @override
  String get nightly => 'Nocny';

  @override
  String get checkForUpdates => 'Sprawdź aktualizacje';

  @override
  String get checkForUpdatesWarning =>
      'Sprawdzanie aktualizacji połączy się ze stroną Motyl, aby uzyskać informacje.';

  @override
  String get usingLatestStable => 'Używasz najnowszej stabilnej wersji';

  @override
  String get usingLatestNightly => 'Używasz najnowszej wersji nocnej';

  @override
  String get currentVersion => 'Aktualna wersja';

  @override
  String get updateNow => 'Aktualizuj teraz';

  @override
  String get shape => 'Kształt';

  @override
  String get circle => 'Okręg';

  @override
  String get rectangle => 'Prostokąt';

  @override
  String get triangle => 'Trójkąt';

  @override
  String get line => 'Linia';

  @override
  String get cornerRadius => 'Corner radius';

  @override
  String get topLeft => 'Lewy górny róg';

  @override
  String get topRight => 'Prawy górny róg';

  @override
  String get bottomLeft => 'Lewy dolny róg';

  @override
  String get bottomRight => 'Dolny prawy róg';

  @override
  String get caches => 'Skrzynki';

  @override
  String get manage => 'Zarządzaj';

  @override
  String get clearCaches => 'Wyczyść skrzynki';

  @override
  String get createCache => 'Utwórz skrzynkę';

  @override
  String get thirdPartyLicenses => 'Licencje firm trzecich';

  @override
  String get syncing => 'Synchronizacja...';

  @override
  String get synced => 'Zsynchronizowano';

  @override
  String get notSynced => 'Nie zsynchronizowano';

  @override
  String get conflict => 'Konflikt';

  @override
  String get keepLocal => 'Zachowaj lokalnie';

  @override
  String get keepConnection => 'Zachowaj połączenie';

  @override
  String get keepBoth => 'Zachowaj oba';

  @override
  String get forAll => 'Dla wszystkich';

  @override
  String fileConflict(String file, String connection) {
    return '$file w $connection ma konflikt';
  }

  @override
  String get offline => 'Offline';

  @override
  String get localLatest => 'Najnowsze lokalne';

  @override
  String get connectionLatest => 'Najnowsze połączenie';

  @override
  String get path => 'Ścieżka';

  @override
  String get folderSynced => 'Folder zsynchronizowany';

  @override
  String get syncRootDirectory => 'Synchronizuj główny katalog';

  @override
  String get penOnlyInput => 'Wprowadzanie tylko pióra';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Natywny pasek tytułu';

  @override
  String get syncMode => 'Tryb synchronizacji';

  @override
  String get connection => 'Połączenie';

  @override
  String get always => 'Zawsze';

  @override
  String get noMobile => 'Brak mobilnych';

  @override
  String get manual => 'Ręcznie';

  @override
  String get search => 'Szukaj';

  @override
  String get properties => 'Właściwości';

  @override
  String get pin => 'Przypnij';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Element';

  @override
  String get painter => 'Bażant';

  @override
  String get position => 'Położenie';

  @override
  String get note => 'Uwaga';

  @override
  String get packs => 'Pakiety';

  @override
  String get pack => 'Paczka';

  @override
  String get more => 'Więcej';

  @override
  String get askForName => 'Zapytaj o nazwę';

  @override
  String areaIndex(int index) {
    return 'Obszar $index';
  }

  @override
  String get startInFullScreen => 'Uruchom na pełnym ekranie';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Mysz';

  @override
  String get touch => 'Dotknij';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Skróty';

  @override
  String get middle => 'Środkowy';

  @override
  String get first => 'Pierwszy';

  @override
  String get second => 'Drugi';

  @override
  String get tools => 'Narzędzia';

  @override
  String get showGrid => 'Pokaż siatkę';

  @override
  String get grid => 'Siatka';

  @override
  String get ruler => 'Rywalizacja';

  @override
  String get angle => 'Kąt';

  @override
  String get report => 'Zgłoszenie';

  @override
  String get newFolder => 'Nowy folder';

  @override
  String get createPack => 'Utwórz pakiet';

  @override
  String get editPack => 'Edytuj paczkę';

  @override
  String get packsDirectory => 'Katalog pakietów';

  @override
  String get stamp => 'Pieczęć';

  @override
  String get addToPack => 'Dodaj do paczki';

  @override
  String get sureImportPack => 'Czy na pewno chcesz zaimportować paczkę?';

  @override
  String byAuthor(String author) {
    return 'przez $author';
  }

  @override
  String get author => 'Autor';

  @override
  String get addAsset => 'Dodaj zasób';

  @override
  String get editAsset => 'Edytuj zasób';

  @override
  String get scope =>
      'Niniejsze rozporządzenie stosuje się od dnia 1 stycznia 2018 r.';

  @override
  String get noPacks => 'Obecnie nie ma dostępnych pakietów';

  @override
  String get components => 'Składniki';

  @override
  String get waypoint => 'Punkt drogi';

  @override
  String get actions => 'Akcje';

  @override
  String get painters => 'Pasty do malowania';

  @override
  String get breakingChangesTitle => 'Przerażające zmiany';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'W tej wersji zachodzą zmiany. Przeczytaj dziennik zmian przed aktualizacją. Aktualna wersja pliku to $version, nowa wersja to $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Paragraf';

  @override
  String get fontFamily => 'Rodzina czcionek';

  @override
  String get smoothing => 'Wygładzanie';

  @override
  String get streamline => 'Streamline';

  @override
  String get presentation => 'Prezentacja';

  @override
  String get selectAsset => 'Wybierz zasób';

  @override
  String get clearStyle => 'Wyczyść styl';

  @override
  String get unknownImportType => 'Nieznany typ importu';

  @override
  String get sureImportTemplate => 'Czy na pewno chcesz zaimportować szablon?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Odtwórz';

  @override
  String get video => 'Wideo';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Przerwanie';

  @override
  String get presentationControls => 'Sterowanie prezentacją';

  @override
  String get nextSlide => 'Następny slajd';

  @override
  String get nextSlideDescription =>
      'Przesuń palcem w prawo lub naciśnij strzałkę w prawo, aby przejść do następnego przesunięcia';

  @override
  String get previousSlide => 'Poprzedni slajd';

  @override
  String get previousSlideDescription =>
      'Przesuń palcem w lewo lub naciśnij strzałkę w lewo, aby przejść do poprzedniego slajdu';

  @override
  String get exitPresentation => 'Prezentacja wyjścia';

  @override
  String get exitPresentationDescription =>
      'Naciśnij klawisz ucieczki lub przesuń palcem w dół, aby wyjść z prezentacji';

  @override
  String get pausePresentation => 'Wstrzymaj prezentację';

  @override
  String get pausePresentationDescription =>
      'Dotknij ekranu lub naciśnij spację, aby wstrzymać lub wznowić prezentację';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'Osiągnąłeś koniec prezentacji';

  @override
  String get startOfPresentation => 'Osiągnąłeś początek prezentacji';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Nagłówek $index';
  }

  @override
  String get code => 'Kod';

  @override
  String get quote => 'Oferta';

  @override
  String get link => 'Link';

  @override
  String get checkbox => 'Pole wyboru';

  @override
  String get deleted => 'Usunięto';

  @override
  String get emphasis => 'Nacisk';

  @override
  String get listBullet => 'Lista punktowa';

  @override
  String get strong => 'Silny';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Strona główna';

  @override
  String get files => 'Pliki';

  @override
  String get sortBy => 'Sortuj według';

  @override
  String get location => 'Lokalizacja';

  @override
  String get whatsNew => 'Co nowego?';

  @override
  String get unstar => 'Usuń gwiazdkę';

  @override
  String get star => 'Gwiazdka';

  @override
  String get goUp => 'Idź w górę';

  @override
  String get created => 'Utworzono';

  @override
  String get modified => 'Zmodyfikowane';

  @override
  String get quickstart => 'Szybki start';

  @override
  String get noTemplates => 'Obecnie nie ma dostępnych szablonów';

  @override
  String get importCorePack => 'Importuj pakiet rdzeniowy';

  @override
  String get importCorePackDescription =>
      'Importuj pakiet główny, który zawiera wszystkie podstawowe zasoby aby rozpocząć. To zastąpi bieżący pakiet główny.';

  @override
  String get never => 'Nigdy';

  @override
  String get onlyOnUpdates => 'Tylko przy aktualizacjach';

  @override
  String get visibility => 'Widoczność';

  @override
  String get captureThumbnail => 'Przechwyć miniaturę';

  @override
  String get capturedThumbnail => 'Pomyślnie przechwycono miniaturę';

  @override
  String get chooseLabelMode => 'Wybierz tryb etykiety';

  @override
  String get foreground => 'Pierwszy plan';

  @override
  String get version => 'Wersja';

  @override
  String get repository => 'Repozytorium';

  @override
  String get pages => 'Strony';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Rozmieść';

  @override
  String get bringToFront => 'Przenieś na przód';

  @override
  String get sendToBack => 'Wyślij do powrotu';

  @override
  String get bringForward => 'Przenieś do przodu';

  @override
  String get sendBackward => 'Wyślij do tyłu';

  @override
  String get rotation => 'Obrót';

  @override
  String get onlyAvailableLargerScreen =>
      'Dostępne tylko na większych ekranach';

  @override
  String get toolbarPosition => 'Pozycja paska narzędzi';

  @override
  String get rotate => 'Obróć';

  @override
  String get spacer => 'Odstęp';

  @override
  String get navigationRail => 'Kolej nawigacyjna';

  @override
  String get cut => 'Wytnij';

  @override
  String get insertBefore => 'Wstaw przed';

  @override
  String get insertAfter => 'Wstaw po';

  @override
  String get insertFirst => 'Wstaw najpierw';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Wklej';

  @override
  String get ascending => 'Rosnąco';

  @override
  String get descending => 'Malejąco';

  @override
  String get imageScale => 'Skala obrazu';

  @override
  String get select => 'Wybierz';

  @override
  String get tool => 'Narzędzie';

  @override
  String get texture => 'Tekstura';

  @override
  String get platformTheme => 'Motyw platformy';

  @override
  String get desktop => 'Pulpit';

  @override
  String get mobile => 'Komórka';

  @override
  String get pdfQuality => 'Jakość PDF';

  @override
  String get surface => 'Powierzchnia';

  @override
  String get pattern => 'Wzorzec';

  @override
  String get sureClose => 'Czy na pewno chcesz zamknąć dokument?';

  @override
  String get thereAreUnsavedChanges => 'Istnieją niezapisane zmiany';

  @override
  String get page => 'Strona';

  @override
  String get iceServers => 'Serwery ICE';

  @override
  String get collaboration => 'Współpraca';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Web Socket';

  @override
  String get iceServer => 'Serwer ICE';

  @override
  String get port => 'Port';

  @override
  String get type => 'Typ';

  @override
  String get side => 'Bok';

  @override
  String get client => 'Klient';

  @override
  String get server => 'Serwer';

  @override
  String get switchView => 'Przełącz widok';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'Ukryj interfejs użytkownika';

  @override
  String get density => 'Gęstość';

  @override
  String get compact => 'Kompaktowy';

  @override
  String get comfortable => 'Komfortowalne';

  @override
  String get standard => 'Standardowy';

  @override
  String get lock => 'Blokada';

  @override
  String get addElement => 'Dodaj element';

  @override
  String get notDefaultConnection => 'Połączenie niedomyślne';

  @override
  String get defaultConnection => 'Domyślne połączenie';

  @override
  String get hide => 'Ukryj';

  @override
  String get show => 'Pokaż';

  @override
  String get pause => 'Wstrzymaj';

  @override
  String get stop => 'Zatrzymaj';

  @override
  String get refresh => 'Odśwież';

  @override
  String get print => 'Drukuj';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Krople do oczu';

  @override
  String get users => 'Użytkownicy';

  @override
  String get experiments => 'Eksperymenty';

  @override
  String get address => 'Adres';

  @override
  String get spreadToPages => 'Rozpowszechnij na strony';

  @override
  String get rootDirectorySpecifiedDescription =>
      'Katalog główny jest określony. Wszystkie zaawansowane ścieżki katalogu będą relatywne do tego katalogu. Pozostaw puste, aby wyłączyć ten typ katalogu.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'Katalog główny nie jest określony. Nazwa jest wymagana. Wszystkie zaawansowane ścieżki katalogu będą bezwzględne. Pozostaw puste, aby wyłączyć ten typ katalogu.';

  @override
  String get unsecureConnectionTitle => 'Niezabezpieczone połączenie';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'Połączenie nie jest bezpieczne. To może być ryzyko bezpieczeństwa. Kontynuuj tylko, jeśli ufasz połączeniu. Odcisk palca sha1 to $fingerprint.';
  }

  @override
  String get continueAnyway => 'Kontynuuj mimo to';

  @override
  String get zoomControl => 'Kontrola powiększenia';

  @override
  String get highContrast => 'Wysoki kontrast';

  @override
  String get shouldANumber => 'Ta wartość powinna być poprawnym numerem';

  @override
  String get createAreas => 'Utwórz obszary';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Operacje';

  @override
  String get medium => 'Średni';

  @override
  String get large => 'Duży';

  @override
  String get toolbarSize => 'Rozmiar paska narzędzi';

  @override
  String get addAll => 'Dodaj wszystkie';

  @override
  String get onlyCurrentPage => 'Tylko bieżąca strona';

  @override
  String get smoothNavigation => 'Gładka nawigacja';

  @override
  String get exact => 'Dokładny';

  @override
  String get inline => 'Wbudowany';

  @override
  String get toolbarRows => 'Wiersze paska narzędzi';

  @override
  String get pointerTest => 'Badanie wskaźnika';

  @override
  String get pressure => 'Ciśnienie';

  @override
  String get small => 'Mały';

  @override
  String get tiny => 'Małe';

  @override
  String get selectAll => 'Zaznacz wszystkie';

  @override
  String get overrideTools => 'Zastąp narzędzia';

  @override
  String get hideCursorWhileDrawing => 'Ukryj kursor podczas rysowania';

  @override
  String get installed => 'Zainstalowane';

  @override
  String get install => 'Zainstaluj';

  @override
  String get deselect => 'Odznacz';

  @override
  String get changeCollection => 'Zmień kolekcję';

  @override
  String get collections => 'Kolekcje';

  @override
  String get fullSelection => 'Pełny wybór';

  @override
  String get fullSelectionDescription =>
      'Wymaga, aby elementy znajdowały się w całości w polu wyboru do wyboru.';

  @override
  String get collection => 'Kolekcja';

  @override
  String get defaultCollection => 'Domyślna kolekcja';

  @override
  String get scroll => 'Przewiń';

  @override
  String get onStartup => 'Przy starcie';

  @override
  String get homeScreen => 'Ekran główny';

  @override
  String get lastNote => 'Ostatnia notatka';

  @override
  String get newNote => 'Nowa nota';

  @override
  String get convertToLayer => 'Konwertuj na warstwę';

  @override
  String get merge => 'Połącz';

  @override
  String get up => 'Góra';

  @override
  String get down => 'W dół';

  @override
  String get other => 'Inne';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementy',
      one: '1 element',
      zero: 'Brak elementów',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Kolor paska narzędzi';

  @override
  String get yesButShowButtons => 'Tak, ale pokaż przyciski';

  @override
  String get optionsPanelPosition => 'Pozycja panelu opcji';

  @override
  String get hideDuration => 'Ukryj czas trwania';

  @override
  String get animation => 'Animacja';

  @override
  String get performance => 'Efektywność';

  @override
  String get performanceDescription =>
      'Zoptymalizowany pod kątem prędkości i wykorzystania pamięci. Tylko widoczna część notatki jest upieczona na obrazie.';

  @override
  String get normalDescription =>
      'Równowaga jakości i wydajności. Tworzy obraz pokrywający 1,5 razy większy od widocznego obszaru, zapewniając płynniejsze przejścia podczas przewijania.';

  @override
  String get high => 'Wysoka';

  @override
  String get highDescription =>
      'Opis: Maksymalizuje jakość kosztem wyników. Upieka obraz pokrywający 2-krotnie widoczny obszar, zapewniając płynne renderowanie nawet podczas szybkiego przewijania lub powiększenia.';

  @override
  String get renderResolution => 'Rozdzielczość renderowania';

  @override
  String get translate => 'Przetłumacz';

  @override
  String get unencrypted => 'Niezaszyfrowane';

  @override
  String get encrypted => 'Zaszyfrowane';

  @override
  String get encryptDocumentMessage => 'Kliknij, aby zaszyfrować dokument';

  @override
  String get unencryptDocumentMessage => 'Kliknij, aby odszyfrować dokument';

  @override
  String get unencrypt => 'Nieszyfrowane';

  @override
  String get encrypt => 'Szyfruj';

  @override
  String get encryptWarning =>
      'Spowoduje to zaszyfrowanie dokumentu. Będziesz musiał zapamiętać hasło, aby go odszyfrować.';

  @override
  String get unencryptWarning =>
      'Spowoduje to odszyfrowanie dokumentu. Hasło zostanie usunięte, a każdy z dostępem będzie mógł go otworzyć.';

  @override
  String get confirmPassword => 'Potwierdź hasło';

  @override
  String get passwordMismatch => 'Hasła nie pasują';

  @override
  String get action => 'Akcja';

  @override
  String get svgText => 'Tekst SVG';

  @override
  String get offset => 'Przesunięcie';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
