// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get open => 'Ouvert';

  @override
  String get settings => 'Réglages';

  @override
  String get personalization => 'Personnalisation';

  @override
  String get theme => 'Thème';

  @override
  String get darkTheme => 'Thème sombre';

  @override
  String get lightTheme => 'Thème clair';

  @override
  String get systemTheme => 'Utiliser le thème système par défaut';

  @override
  String get view => 'Voir';

  @override
  String get edit => 'Editer';

  @override
  String get export => 'Exportation';

  @override
  String get save => 'Enregistrer';

  @override
  String get zoom => 'Zoom';

  @override
  String get zoomIn => 'Zoom avant';

  @override
  String get zoomOut => 'Zoom arrière';

  @override
  String get resetZoom => 'Réinitialiser le zoom';

  @override
  String get strokeWidth => 'Largeur du trait';

  @override
  String get includeEraser => 'Inclure la gomme ?';

  @override
  String get thinning => 'Amincissement';

  @override
  String get pen => 'Stylo';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Effacer le chemin d\'accès';

  @override
  String get label => 'Étiquette';

  @override
  String get delete => 'Supprimez';

  @override
  String get areYouSure => 'Êtes-vous sûr(e) ?';

  @override
  String get reallyDelete => 'Voulez-vous vraiment supprimer cet élément ?';

  @override
  String get no => 'Non';

  @override
  String get yes => 'Oui';

  @override
  String get undo => 'Annuler';

  @override
  String get redo => 'Refaire';

  @override
  String get general => 'Généraux';

  @override
  String get copyTitle => 'Copié dans le presse-papiers';

  @override
  String get loading => 'Chargement en cours...';

  @override
  String get enterText => 'Entrez le texte';

  @override
  String get size => 'Taille';

  @override
  String get width => 'Largeur';

  @override
  String get height => 'Hauteur';

  @override
  String get count => 'Compter';

  @override
  String get space => 'Espace libre';

  @override
  String get background => 'Arrière-plan';

  @override
  String get box => 'Boîte';

  @override
  String get locale => 'Langue';

  @override
  String get systemLocale => 'Paramètres régionaux du système';

  @override
  String get information => 'Information';

  @override
  String get license => 'Licence';

  @override
  String get imprint => 'Mentions légales';

  @override
  String get privacypolicy => 'Politique de confidentialité';

  @override
  String get source => 'Source';

  @override
  String get documentation => 'Documentation';

  @override
  String get changelog => 'Historique des modifications';

  @override
  String get existOverride => 'Cet élément existe déjà. Écraser ?';

  @override
  String get description => 'Libellé';

  @override
  String get fill => 'Remplir';

  @override
  String get defaultPalette => 'Palette par défaut';

  @override
  String get highlighter => 'Surligneur';

  @override
  String get add => 'Ajouter';

  @override
  String get remove => 'Retirer';

  @override
  String get removeConfirm => 'Voulez-vous vraiment supprimer cela ?';

  @override
  String get resetPalette => 'Réinitialiser la palette';

  @override
  String get custom => 'Personnalisé';

  @override
  String get decoration => 'Décoration';

  @override
  String get underline => 'Souligné';

  @override
  String get overline => 'Surligne';

  @override
  String get strikethrough => 'Barré';

  @override
  String get thickness => 'Épaisseur';

  @override
  String get style => 'Style';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Double';

  @override
  String get dotted => 'Pointillé';

  @override
  String get dashed => 'Tiret';

  @override
  String get wavy => 'Vague';

  @override
  String get fontWeight => 'Poids de la police';

  @override
  String get normal => 'Normale';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Presse-papiers';

  @override
  String get file => 'Fichier';

  @override
  String get data => 'Donnée';

  @override
  String get share => 'Partager';

  @override
  String get spacing => 'Espacement';

  @override
  String get image => 'Image';

  @override
  String get enterUrl => 'Entrez l\'url';

  @override
  String get scale => 'Échelle';

  @override
  String get help => 'Aide';

  @override
  String get reallyReset => 'Voulez-vous vraiment le réinitialiser ?';

  @override
  String get whatToDo => 'Que voulez-vous faire ?';

  @override
  String get ignore => 'Ignorer';

  @override
  String get backup => 'Sauvegarde';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'Le fichier $fileName a été créé dans une version plus récente ($fileVersion). Que faire de ce fichier ?';
  }

  @override
  String get waypoints => 'Waypoints';

  @override
  String get origin => 'Origine';

  @override
  String get import => 'Importation';

  @override
  String get newContent => 'Nouveau';

  @override
  String get selectElement => 'Sélectionner un élément';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Shift';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Copier la version';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Comportements';

  @override
  String get dataDirectory => 'Répertoire des données';

  @override
  String get defaultPath => 'Chemin par défaut';

  @override
  String get dateFormat => 'Format de la date';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Mis à jour le : $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Créé le : $dateTimeString';
  }

  @override
  String get rename => 'Renommer';

  @override
  String get duplicate => 'Dupliquer';

  @override
  String get hand => 'Main';

  @override
  String get folder => 'Répertoire';

  @override
  String get move => 'Déplacer';

  @override
  String get copy => 'Copie';

  @override
  String get back => 'Précédent';

  @override
  String get zoomDependent => 'Dépendant du zoom';

  @override
  String get shapeDetection => 'Détection de forme';

  @override
  String get delay => 'Délai';

  @override
  String get defaultLayer => 'Couche par défaut';

  @override
  String get layer => 'Couche';

  @override
  String get layers => 'Couches';

  @override
  String get notSet => 'Non défini';

  @override
  String get enterLayer => 'Entrez le nom de la couche';

  @override
  String get selectElements => 'Sélectionner les éléments';

  @override
  String get deleteElements => 'Supprimer les éléments';

  @override
  String get deleteElementsConfirm =>
      'Voulez-vous vraiment supprimer les éléments sélectionnés ?';

  @override
  String get selectCustomCollection =>
      'Sélectionnez une collection personnalisée';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => 'Sensibilité';

  @override
  String get sensitivityHint =>
      'Plus la valeur est élevée, plus l\'entrée est sensible';

  @override
  String get horizontal => 'Horizontal';

  @override
  String get vertical => 'Vertical';

  @override
  String get plain => 'Plaine';

  @override
  String get light => 'Lumière';

  @override
  String get ruled => 'Recommandé';

  @override
  String get quad => 'Quadruple';

  @override
  String get music => 'Musique';

  @override
  String get dark => 'Sombre';

  @override
  String get plainDark => 'Sombre';

  @override
  String get ruledDark => 'Sombre en ruine';

  @override
  String get quadDark => 'Quad sombre';

  @override
  String get musicDark => 'Musique sombre';

  @override
  String get templates => 'Modèles';

  @override
  String get untitled => 'Sans titre';

  @override
  String get createTemplate => 'Créer un modèle';

  @override
  String get createTemplateContent =>
      'Voulez-vous vraiment créer un modèle à partir de ce document ? Le document original sera supprimé.';

  @override
  String get replace => 'Remplacer';

  @override
  String get reallyReplace =>
      'Voulez-vous vraiment remplacer le modèle ? Cette opération ne peut pas être annulée !';

  @override
  String get defaultTemplate => 'Modèle par défaut';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'Document';

  @override
  String get camera => 'Appareil photo';

  @override
  String get printout => 'Impression';

  @override
  String get selectCamera => 'Sélectionnez une caméra';

  @override
  String get changeDocumentPath => 'Changer le chemin d\'accès du document';

  @override
  String get deleteWholeStroke => 'Supprimer tout le tracé';

  @override
  String get alpha => 'Alphabétisation';

  @override
  String get area => 'Zone';

  @override
  String get selectArea => 'Sélectionnez une zone';

  @override
  String get aspectRatio => 'Ratio d\'aspect';

  @override
  String get presets => 'Préréglages';

  @override
  String get pagePortrait => 'Portrait de la page';

  @override
  String get pageLandscape => 'Paysage des pages';

  @override
  String get square => 'Carré';

  @override
  String get areas => 'Zones';

  @override
  String get enterArea => 'Entrez la zone';

  @override
  String get exitArea => 'Quitter la zone';

  @override
  String get currentArea => 'Zone actuelle';

  @override
  String get design => 'Conception';

  @override
  String get text => 'Texte du texte';

  @override
  String welcome(String codeName) {
    return 'Hé, voici Linwood Butterfly';
  }

  @override
  String get welcomeContent => 'Un espace de dessin libre et open-source !';

  @override
  String updated(String version) {
    return 'Application mise à jour vers la version $version';
  }

  @override
  String get releaseNotes => 'Notes de version';

  @override
  String get constraints => 'Contraintes';

  @override
  String get scaled => 'Mise à l\'échelle';

  @override
  String get fixed => 'Fixe';

  @override
  String get dynamicContent => 'Dynamique';

  @override
  String get none => 'Aucun';

  @override
  String get includeArea => 'Inclure la zone';

  @override
  String get verticalAlignment => 'Alignement vertical';

  @override
  String get horizontalAlignment => 'Alignement horizontal';

  @override
  String get top => 'En haut';

  @override
  String get center => 'Centrer';

  @override
  String get bottom => 'Bas';

  @override
  String get left => 'Gauche';

  @override
  String get right => 'Droite';

  @override
  String get justify => 'Justifier';

  @override
  String get constraint => 'Contrainte';

  @override
  String get length => 'Longueur';

  @override
  String get exportSvg => 'Exporter SVG';

  @override
  String get pdf => 'PDF';

  @override
  String get selectPages => 'Sélectionner les pages';

  @override
  String get recentFiles => 'Fichiers récents';

  @override
  String get start => 'Début';

  @override
  String get noRecentFiles => 'Aucun fichier récent';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '1 page',
      zero: 'Aucune page',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Page $index';
  }

  @override
  String get exit => 'Quitter';

  @override
  String get noElements => 'Aucun élément';

  @override
  String get invertSelection => 'Inverser la sélection';

  @override
  String get errorWhileImporting => 'Erreur lors de l\'importation';

  @override
  String get errorWhileImportingContent =>
      'Une erreur s\'est produite lors de l\'importation du fichier';

  @override
  String get showDetails => 'Afficher les détails';

  @override
  String get hideDetails => 'Cacher les détails';

  @override
  String get error => 'Erreur';

  @override
  String get stackTrace => 'Trace de pile';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Durée';

  @override
  String get quality => 'Qualité';

  @override
  String get exportPdf => 'Exporter en PDF';

  @override
  String get local => 'Locale';

  @override
  String get addConnection => 'Ajouter une connexion';

  @override
  String get connections => 'Connexions';

  @override
  String get noConnections => 'Aucune connexion';

  @override
  String get url => 'URL';

  @override
  String get connect => 'Connecter';

  @override
  String get username => 'Nom d\'utilisateur';

  @override
  String get password => 'Mot de passe';

  @override
  String get webNotSupported => 'Web non pris en charge';

  @override
  String get advanced => 'Avancé';

  @override
  String get directory => 'Répertoire';

  @override
  String get documentsDirectory => 'Répertoire des documents';

  @override
  String get templatesDirectory => 'Répertoire des modèles';

  @override
  String get errorWhileCreatingConnection =>
      'Erreur lors de la création de la connexion';

  @override
  String get cannotConnect => 'Impossible de se connecter';

  @override
  String get urlNotValid => 'URL non valide';

  @override
  String get icon => 'Icône';

  @override
  String get update => 'Mise à jour';

  @override
  String get updateAvailable => 'Mise à jour disponible';

  @override
  String get stable => 'Stable';

  @override
  String get nightly => 'Nuit';

  @override
  String get checkForUpdates => 'Vérifier les mises à jour';

  @override
  String get checkForUpdatesWarning =>
      'Vérifier l\'état des mises à jour initiera une connexion au site internet de Linwood Butterfly pour recueillir les informations.';

  @override
  String get usingLatestStable => 'Vous utilisez la dernière version stable';

  @override
  String get usingLatestNightly =>
      'Vous utilisez la dernière version \"Nightly\" (en cours de développement) de Linwood Butterfly';

  @override
  String get currentVersion => 'Version actuelle';

  @override
  String get updateNow => 'Mettre à jour maintenant';

  @override
  String get shape => 'Forme';

  @override
  String get circle => 'Cercle';

  @override
  String get rectangle => 'Rectangle';

  @override
  String get triangle => 'Triangle';

  @override
  String get line => 'Lignes';

  @override
  String get cornerRadius => 'Rayon du coin';

  @override
  String get topLeft => 'En haut à gauche';

  @override
  String get topRight => 'En haut à droite';

  @override
  String get bottomLeft => 'En bas à gauche';

  @override
  String get bottomRight => 'En bas à droite';

  @override
  String get caches => 'Caches';

  @override
  String get manage => 'Gérer';

  @override
  String get clearCaches => 'Vider les caches';

  @override
  String get createCache => 'Créer une cache';

  @override
  String get thirdPartyLicenses => 'Licences tierces';

  @override
  String get syncing => 'Synchronisation en cours...';

  @override
  String get synced => 'Synchronisé';

  @override
  String get notSynced => 'Non synchronisé';

  @override
  String get conflict => 'Conflit';

  @override
  String get keepLocal => 'Garder en local';

  @override
  String get keepConnection => 'Garder la connexion';

  @override
  String get keepBoth => 'Garder les deux';

  @override
  String get forAll => 'Pour tous';

  @override
  String fileConflict(String file, String connection) {
    return '$file dans $connection a un conflit';
  }

  @override
  String get offline => 'Hors ligne';

  @override
  String get localLatest => 'Dernier jour local';

  @override
  String get connectionLatest => 'Dernière connexion';

  @override
  String get path => 'Chemin d\'accès';

  @override
  String get folderSynced => 'Dossier synchronisé';

  @override
  String get syncRootDirectory => 'Synchroniser le répertoire racine';

  @override
  String get penOnlyInput => 'Seules les entrées du stylet';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Barre de titre native';

  @override
  String get syncMode => 'Mode de synchronisation';

  @override
  String get connection => 'Raccordement';

  @override
  String get always => 'Toujours';

  @override
  String get noMobile => 'Aucun mobile';

  @override
  String get manual => 'Manuelle';

  @override
  String get search => 'Chercher';

  @override
  String get properties => 'Propriétés';

  @override
  String get pin => 'Épingler';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Élément';

  @override
  String get painter => 'Peintre';

  @override
  String get position => 'Position';

  @override
  String get note => 'Note';

  @override
  String get packs => 'Packs';

  @override
  String get pack => 'Paquet';

  @override
  String get more => 'En savoir plus';

  @override
  String get askForName => 'Demander le nom';

  @override
  String areaIndex(int index) {
    return 'Zone $index';
  }

  @override
  String get startInFullScreen => 'Démarrer en plein écran';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Souris';

  @override
  String get touch => 'Toucher';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Raccourcis';

  @override
  String get middle => 'Milieu';

  @override
  String get first => 'Premier';

  @override
  String get second => 'Seconde';

  @override
  String get tools => 'Outils';

  @override
  String get showGrid => 'Afficher la grille';

  @override
  String get grid => 'Grille';

  @override
  String get ruler => 'Règle';

  @override
  String get angle => 'Angle';

  @override
  String get report => 'Rapporter';

  @override
  String get newFolder => 'Nouveau dossier';

  @override
  String get createPack => 'Créer un pack';

  @override
  String get editPack => 'Modifier le pack';

  @override
  String get packsDirectory => 'Répertoire des paquets';

  @override
  String get stamp => 'Médaille';

  @override
  String get addToPack => 'Ajouter au pack';

  @override
  String get sureImportPack => 'Êtes-vous sûr de vouloir importer le pack ?';

  @override
  String byAuthor(String author) {
    return 'par $author';
  }

  @override
  String get author => 'Auteur';

  @override
  String get addAsset => 'Ajouter une ressource';

  @override
  String get editAsset => 'Modifier la ressource';

  @override
  String get scope => 'Périmètre d\'application';

  @override
  String get noPacks => 'Il n\'y a actuellement aucun pack disponible';

  @override
  String get components => 'Composants';

  @override
  String get waypoint => 'Point de repère';

  @override
  String get actions => 'Actions';

  @override
  String get painters => 'Peintres';

  @override
  String get breakingChangesTitle => 'Changements en cours';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Il y a des modifications cassées dans cette version. Veuillez lire le journal des modifications avant de mettre à jour. La version actuelle du fichier est $version, la nouvelle version est $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Paragraphe';

  @override
  String get fontFamily => 'Famille de police';

  @override
  String get smoothing => 'Lissage';

  @override
  String get streamline => 'Streamline';

  @override
  String get presentation => 'Présentation';

  @override
  String get selectAsset => 'Sélectionner une ressource';

  @override
  String get clearStyle => 'Vider le style';

  @override
  String get unknownImportType => 'Type d\'import inconnu';

  @override
  String get sureImportTemplate =>
      'Êtes-vous sûr de vouloir importer le modèle ?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Jouer';

  @override
  String get video => 'Vidéo';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Point d’arrêt';

  @override
  String get presentationControls => 'Contrôles de présentation';

  @override
  String get nextSlide => 'Diapositive suivante';

  @override
  String get nextSlideDescription =>
      'Glissez vers la droite ou appuyez sur la flèche droite pour aller à la diapositive suivante';

  @override
  String get previousSlide => 'Diapositive précédente';

  @override
  String get previousSlideDescription =>
      'Glissez vers la gauche ou appuyez sur la touche fléchée gauche pour aller à la diapositive précédente';

  @override
  String get exitPresentation => 'Quitter la présentation';

  @override
  String get exitPresentationDescription =>
      'Appuyez sur la touche d\'échappement ou glissez vers le bas pour quitter la présentation';

  @override
  String get pausePresentation => 'Mettre en pause la présentation';

  @override
  String get pausePresentationDescription =>
      'Appuyez sur l\'écran ou appuyez sur la barre d\'espace pour mettre en pause ou reprendre la présentation';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'Vous avez atteint la fin de la présentation';

  @override
  String get startOfPresentation =>
      'Vous avez atteint le début de la présentation';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Titre $index';
  }

  @override
  String get code => 'Code';

  @override
  String get quote => 'Devis';

  @override
  String get link => 'Lier';

  @override
  String get checkbox => 'Case à cocher';

  @override
  String get deleted => 'Supprimé';

  @override
  String get emphasis => 'Emphasis';

  @override
  String get listBullet => 'Lister les puces';

  @override
  String get strong => 'Forte';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Domicile';

  @override
  String get files => 'Fichiers';

  @override
  String get sortBy => 'Trier par';

  @override
  String get location => 'Localisation';

  @override
  String get whatsNew => 'Quoi de neuf ?';

  @override
  String get unstar => 'Retirer des favoris';

  @override
  String get star => 'Étoiles';

  @override
  String get goUp => 'Monter';

  @override
  String get created => 'Créé';

  @override
  String get modified => 'Modifié';

  @override
  String get quickstart => 'Démarrage rapide';

  @override
  String get noTemplates => 'Il n\'y a actuellement aucun modèle disponible';

  @override
  String get importCorePack => 'Importer le pack core';

  @override
  String get importCorePackDescription =>
      'Importez le pack du noyau qui contient toutes les ressources de base pour commencer. Cela remplacera le pack du noyau actuel.';

  @override
  String get never => 'Jamais';

  @override
  String get onlyOnUpdates => 'Uniquement sur les mises à jour';

  @override
  String get visibility => 'Visibilité';

  @override
  String get captureThumbnail => 'Capture miniature';

  @override
  String get capturedThumbnail => 'La vignette a été capturée avec succès';

  @override
  String get chooseLabelMode => 'Choisir le mode d\'étiquette';

  @override
  String get foreground => 'Premier plan';

  @override
  String get version => 'Version';

  @override
  String get repository => 'Dépôt';

  @override
  String get pages => 'Pages';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Arranger';

  @override
  String get bringToFront => 'Amener au premier plan';

  @override
  String get sendToBack => 'Envoyer à l\'arrière';

  @override
  String get bringForward => 'Avancer';

  @override
  String get sendBackward => 'Envoyer vers l\'arrière';

  @override
  String get rotation => 'Rotation';

  @override
  String get onlyAvailableLargerScreen =>
      'Disponible uniquement sur les écrans plus grands';

  @override
  String get toolbarPosition => 'Position de la barre d\'outils';

  @override
  String get rotate => 'Faire pivoter';

  @override
  String get spacer => 'Espaceur';

  @override
  String get navigationRail => 'Rail de navigation';

  @override
  String get cut => 'Couper';

  @override
  String get insertBefore => 'Insérer avant';

  @override
  String get insertAfter => 'Insérer après';

  @override
  String get insertFirst => 'Insérer d\'abord';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Coller';

  @override
  String get ascending => 'Ascendant';

  @override
  String get descending => 'Descendant';

  @override
  String get imageScale => 'Echelle de l\'image';

  @override
  String get select => 'Sélectionner';

  @override
  String get tool => 'Outil';

  @override
  String get texture => 'Texture';

  @override
  String get platformTheme => 'Thème de la plateforme';

  @override
  String get desktop => 'Bureau';

  @override
  String get mobile => 'Téléphone mobile';

  @override
  String get pdfQuality => 'Qualité PDF';

  @override
  String get surface => 'Surface';

  @override
  String get pattern => 'Schéma';

  @override
  String get sureClose => 'Êtes-vous sûr de vouloir fermer le document ?';

  @override
  String get thereAreUnsavedChanges =>
      'Il y a des modifications non enregistrées';

  @override
  String get page => 'Page';

  @override
  String get iceServers => 'Serveur ICE';

  @override
  String get collaboration => 'Collaboration';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Web Socket';

  @override
  String get iceServer => 'Serveur ICE';

  @override
  String get port => 'Port';

  @override
  String get type => 'Type de texte';

  @override
  String get side => 'Côté';

  @override
  String get client => 'Client';

  @override
  String get server => 'Serveur';

  @override
  String get switchView => 'Changer de vue';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'Cacher l\'interface utilisateur';

  @override
  String get density => 'Densité';

  @override
  String get compact => 'Compact';

  @override
  String get comfortable => 'Confortable';

  @override
  String get standard => 'Standard';

  @override
  String get lock => 'Verrouiller';

  @override
  String get addElement => 'Ajouter un élément';

  @override
  String get notDefaultConnection => 'Pas de connexion par défaut';

  @override
  String get defaultConnection => 'Connexion par défaut';

  @override
  String get hide => 'Cacher';

  @override
  String get show => 'Afficher';

  @override
  String get pause => 'Mettre en pause';

  @override
  String get stop => 'Arrêter';

  @override
  String get refresh => 'Rafraîchir';

  @override
  String get print => 'Imprimer';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Goutteur d\'yeux';

  @override
  String get users => 'Utilisateurs';

  @override
  String get experiments => 'Expériences';

  @override
  String get address => 'Adresse';

  @override
  String get spreadToPages => 'Diffuser vers les pages';

  @override
  String get rootDirectorySpecifiedDescription =>
      'Le répertoire racine est spécifié. Tous les répertoires avancés seront relatifs à ce répertoire. Laissez vide pour désactiver ce type de répertoire.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'Le répertoire racine n\'est pas spécifié. Un nom est requis. Tous les répertoires avancés seront absolus. Gardez-le vide pour désactiver ce type de répertoire.';

  @override
  String get unsecureConnectionTitle => 'Connexion non sécurisée';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'La connexion n\'est pas sécurisée. Cela peut être un risque de sécurité. Veuillez continuer uniquement si vous faites confiance à la connexion. L\'empreinte sha1 est $fingerprint.';
  }

  @override
  String get continueAnyway => 'Continuer quand même';

  @override
  String get zoomControl => 'Contrôle du zoom';

  @override
  String get highContrast => 'Contraste élevé';

  @override
  String get shouldANumber => 'Cette valeur doit être un nombre valide';

  @override
  String get createAreas => 'Créer des zones';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Opérations';

  @override
  String get medium => 'Moyenne';

  @override
  String get large => 'Gros';

  @override
  String get toolbarSize => 'Taille de la barre d\'outils';

  @override
  String get addAll => 'Ajouter tout';

  @override
  String get onlyCurrentPage => 'Uniquement la page courante';

  @override
  String get smoothNavigation => 'Navigation fluide';

  @override
  String get exact => 'Exactement';

  @override
  String get inline => 'En ligne';

  @override
  String get toolbarRows => 'Lignes de barre d\'outils';

  @override
  String get pointerTest => 'Test du pointeur';

  @override
  String get pressure => 'Pression';

  @override
  String get small => 'Petit';

  @override
  String get tiny => 'Petit';

  @override
  String get selectAll => 'Tout sélectionner';

  @override
  String get overrideTools => 'Remplacer les outils';

  @override
  String get hideCursorWhileDrawing => 'Masquer le curseur pendant le dessin';

  @override
  String get installed => 'Installé';

  @override
  String get install => 'Installer';

  @override
  String get deselect => 'Désélectionner';

  @override
  String get changeCollection => 'Changer de collection';

  @override
  String get collections => 'Collections';

  @override
  String get fullSelection => 'Sélection complète';

  @override
  String get fullSelectionDescription =>
      'Nécessite que les éléments soient entièrement dans la zone de sélection pour la sélection.';

  @override
  String get collection => 'Collecte';

  @override
  String get defaultCollection => 'Collection par défaut';

  @override
  String get scroll => 'Défilement';

  @override
  String get onStartup => 'Au démarrage';

  @override
  String get homeScreen => 'Écran d\'accueil';

  @override
  String get lastNote => 'Dernière note';

  @override
  String get newNote => 'Nouvelle note';

  @override
  String get convertToLayer => 'Convertir en calque';

  @override
  String get merge => 'Fusionner';

  @override
  String get up => 'Monter';

  @override
  String get down => 'Bas';

  @override
  String get other => 'Autres';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count éléments',
      one: '1 élément',
      zero: 'Aucun élément',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Barre d\'outils de couleur';

  @override
  String get yesButShowButtons => 'Oui, mais afficher les boutons';

  @override
  String get optionsPanelPosition => 'Position du panneau des options';

  @override
  String get hideDuration => 'Cacher la durée';

  @override
  String get animation => 'Animation';

  @override
  String get performance => 'Performances';

  @override
  String get performanceDescription =>
      'Optimisé pour l\'utilisation de la vitesse et de la mémoire. Seule la partie visible de la note est cuite dans l\'image.';

  @override
  String get normalDescription =>
      'Balance la qualité et les performances. Passe une image couvrant 1,5 fois la zone visible, fournissant des transitions plus fluides lors du défilement.';

  @override
  String get high => 'Élevé';

  @override
  String get highDescription =>
      'Description : Maximise la qualité au prix de la performance. Passe une image couvrant 2 fois la zone visible, assurant un rendu transparent même lors du défilement rapide ou du zoom.';

  @override
  String get renderResolution => 'Résolution du rendu';

  @override
  String get translate => 'Traduire';

  @override
  String get unencrypted => 'Non chiffré';

  @override
  String get encrypted => 'Chiffré';

  @override
  String get encryptDocumentMessage => 'Cliquez pour chiffrer le document';

  @override
  String get unencryptDocumentMessage => 'Cliquez pour déchiffrer le document';

  @override
  String get unencrypt => 'Déchiffrer';

  @override
  String get encrypt => 'Chiffrer';

  @override
  String get encryptWarning =>
      'Cela va chiffrer le document. Vous devrez vous souvenir du mot de passe pour le déchiffrer.';

  @override
  String get unencryptWarning =>
      'Cela déchiffrera le document. Le mot de passe sera supprimé et toutes les personnes ayant un accès pourront l\'ouvrir.';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get passwordMismatch => 'Les mots de passe ne correspondent pas';

  @override
  String get action => 'Action';

  @override
  String get svgText => 'Texte SVG';

  @override
  String get offset => 'Décalage';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
