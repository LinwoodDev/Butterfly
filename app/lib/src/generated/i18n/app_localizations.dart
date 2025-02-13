import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_af.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_ca.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_no.dart';
import 'app_localizations_or.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_th.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_uk.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'i18n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('af'),
    Locale('ar'),
    Locale('ca'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('fi'),
    Locale('fr'),
    Locale('he'),
    Locale('hi'),
    Locale('hu'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('nl'),
    Locale('no'),
    Locale('or'),
    Locale('pl'),
    Locale('pt'),
    Locale('pt', 'BR'),
    Locale('ro'),
    Locale('ru'),
    Locale('sr'),
    Locale('sv'),
    Locale('th'),
    Locale('tr'),
    Locale('uk'),
    Locale('vi'),
    Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
    Locale('zh')
  ];

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @personalization.
  ///
  /// In en, this message translates to:
  /// **'Personalization'**
  String get personalization;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark theme'**
  String get darkTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light theme'**
  String get lightTheme;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'Use default system theme'**
  String get systemTheme;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @zoom.
  ///
  /// In en, this message translates to:
  /// **'Zoom'**
  String get zoom;

  /// No description provided for @zoomIn.
  ///
  /// In en, this message translates to:
  /// **'Zoom in'**
  String get zoomIn;

  /// No description provided for @zoomOut.
  ///
  /// In en, this message translates to:
  /// **'Zoom out'**
  String get zoomOut;

  /// No description provided for @resetZoom.
  ///
  /// In en, this message translates to:
  /// **'Reset zoom'**
  String get resetZoom;

  /// No description provided for @strokeWidth.
  ///
  /// In en, this message translates to:
  /// **'Stroke width'**
  String get strokeWidth;

  /// No description provided for @includeEraser.
  ///
  /// In en, this message translates to:
  /// **'Include eraser?'**
  String get includeEraser;

  /// No description provided for @thinning.
  ///
  /// In en, this message translates to:
  /// **'Thinning'**
  String get thinning;

  /// No description provided for @pen.
  ///
  /// In en, this message translates to:
  /// **'Pen'**
  String get pen;

  /// No description provided for @eraser.
  ///
  /// In en, this message translates to:
  /// **'Eraser'**
  String get eraser;

  /// No description provided for @pathEraser.
  ///
  /// In en, this message translates to:
  /// **'Path eraser'**
  String get pathEraser;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// No description provided for @reallyDelete.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete this item?'**
  String get reallyDelete;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @redo.
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get redo;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @copyTitle.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copyTitle;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @enterText.
  ///
  /// In en, this message translates to:
  /// **'Enter the text'**
  String get enterText;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @width.
  ///
  /// In en, this message translates to:
  /// **'Width'**
  String get width;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get height;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @space.
  ///
  /// In en, this message translates to:
  /// **'Space'**
  String get space;

  /// No description provided for @background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get background;

  /// No description provided for @box.
  ///
  /// In en, this message translates to:
  /// **'Box'**
  String get box;

  /// No description provided for @locale.
  ///
  /// In en, this message translates to:
  /// **'Locale'**
  String get locale;

  /// No description provided for @systemLocale.
  ///
  /// In en, this message translates to:
  /// **'System locale'**
  String get systemLocale;

  /// No description provided for @information.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get information;

  /// No description provided for @license.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get license;

  /// No description provided for @imprint.
  ///
  /// In en, this message translates to:
  /// **'Imprint'**
  String get imprint;

  /// No description provided for @privacypolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacypolicy;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @documentation.
  ///
  /// In en, this message translates to:
  /// **'Documentation'**
  String get documentation;

  /// No description provided for @changelog.
  ///
  /// In en, this message translates to:
  /// **'Changelog'**
  String get changelog;

  /// No description provided for @existOverride.
  ///
  /// In en, this message translates to:
  /// **'This element already exist. Overwrite?'**
  String get existOverride;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @fill.
  ///
  /// In en, this message translates to:
  /// **'Fill'**
  String get fill;

  /// No description provided for @defaultPalette.
  ///
  /// In en, this message translates to:
  /// **'Default palette'**
  String get defaultPalette;

  /// No description provided for @highlighter.
  ///
  /// In en, this message translates to:
  /// **'Highlighter'**
  String get highlighter;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @removeConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to remove this?'**
  String get removeConfirm;

  /// No description provided for @resetPalette.
  ///
  /// In en, this message translates to:
  /// **'Reset palette'**
  String get resetPalette;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @decoration.
  ///
  /// In en, this message translates to:
  /// **'Decoration'**
  String get decoration;

  /// No description provided for @underline.
  ///
  /// In en, this message translates to:
  /// **'Underline'**
  String get underline;

  /// No description provided for @overline.
  ///
  /// In en, this message translates to:
  /// **'Overline'**
  String get overline;

  /// No description provided for @strikethrough.
  ///
  /// In en, this message translates to:
  /// **'Strikethrough'**
  String get strikethrough;

  /// No description provided for @thickness.
  ///
  /// In en, this message translates to:
  /// **'Thickness'**
  String get thickness;

  /// No description provided for @style.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get style;

  /// No description provided for @solid.
  ///
  /// In en, this message translates to:
  /// **'Solid'**
  String get solid;

  /// No description provided for @double.
  ///
  /// In en, this message translates to:
  /// **'Double'**
  String get double;

  /// No description provided for @dotted.
  ///
  /// In en, this message translates to:
  /// **'Dotted'**
  String get dotted;

  /// No description provided for @dashed.
  ///
  /// In en, this message translates to:
  /// **'Dashed'**
  String get dashed;

  /// No description provided for @wavy.
  ///
  /// In en, this message translates to:
  /// **'Wavy'**
  String get wavy;

  /// No description provided for @fontWeight.
  ///
  /// In en, this message translates to:
  /// **'Font weight'**
  String get fontWeight;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @bold.
  ///
  /// In en, this message translates to:
  /// **'Bold'**
  String get bold;

  /// No description provided for @italic.
  ///
  /// In en, this message translates to:
  /// **'Italic'**
  String get italic;

  /// No description provided for @clipboard.
  ///
  /// In en, this message translates to:
  /// **'Clipboard'**
  String get clipboard;

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// No description provided for @data.
  ///
  /// In en, this message translates to:
  /// **'Data'**
  String get data;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @spacing.
  ///
  /// In en, this message translates to:
  /// **'Spacing'**
  String get spacing;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @enterUrl.
  ///
  /// In en, this message translates to:
  /// **'Enter the url'**
  String get enterUrl;

  /// No description provided for @scale.
  ///
  /// In en, this message translates to:
  /// **'Scale'**
  String get scale;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @reallyReset.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to reset it?'**
  String get reallyReset;

  /// No description provided for @whatToDo.
  ///
  /// In en, this message translates to:
  /// **'What do you want to do?'**
  String get whatToDo;

  /// No description provided for @ignore.
  ///
  /// In en, this message translates to:
  /// **'Ignore'**
  String get ignore;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @createdInNewerVersion.
  ///
  /// In en, this message translates to:
  /// **'The file {fileName} was created in a newer version ({fileVersion}). What should be done with this file?'**
  String createdInNewerVersion(String fileName, int fileVersion);

  /// No description provided for @waypoints.
  ///
  /// In en, this message translates to:
  /// **'Waypoints'**
  String get waypoints;

  /// No description provided for @origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get origin;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @newContent.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get newContent;

  /// No description provided for @selectElement.
  ///
  /// In en, this message translates to:
  /// **'Select element'**
  String get selectElement;

  /// No description provided for @ctrlKey.
  ///
  /// In en, this message translates to:
  /// **'Ctrl'**
  String get ctrlKey;

  /// No description provided for @shiftKey.
  ///
  /// In en, this message translates to:
  /// **'Shift'**
  String get shiftKey;

  /// No description provided for @altKey.
  ///
  /// In en, this message translates to:
  /// **'Alt'**
  String get altKey;

  /// No description provided for @copyVersion.
  ///
  /// In en, this message translates to:
  /// **'Copy version'**
  String get copyVersion;

  /// No description provided for @input.
  ///
  /// In en, this message translates to:
  /// **'Input'**
  String get input;

  /// No description provided for @behaviors.
  ///
  /// In en, this message translates to:
  /// **'Behaviors'**
  String get behaviors;

  /// No description provided for @dataDirectory.
  ///
  /// In en, this message translates to:
  /// **'Data directory'**
  String get dataDirectory;

  /// No description provided for @defaultPath.
  ///
  /// In en, this message translates to:
  /// **'Default path'**
  String get defaultPath;

  /// No description provided for @dateFormat.
  ///
  /// In en, this message translates to:
  /// **'Date format'**
  String get dateFormat;

  /// No description provided for @updatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated at: {dateTime}'**
  String updatedAt(DateTime dateTime);

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created at: {dateTime}'**
  String createdAt(DateTime dateTime);

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicate;

  /// No description provided for @hand.
  ///
  /// In en, this message translates to:
  /// **'Hand'**
  String get hand;

  /// No description provided for @folder.
  ///
  /// In en, this message translates to:
  /// **'Folder'**
  String get folder;

  /// No description provided for @move.
  ///
  /// In en, this message translates to:
  /// **'Move'**
  String get move;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @zoomDependent.
  ///
  /// In en, this message translates to:
  /// **'Zoom dependent'**
  String get zoomDependent;

  /// No description provided for @shapeDetection.
  ///
  /// In en, this message translates to:
  /// **'Shape Detection'**
  String get shapeDetection;

  /// No description provided for @delay.
  ///
  /// In en, this message translates to:
  /// **'Delay'**
  String get delay;

  /// No description provided for @defaultLayer.
  ///
  /// In en, this message translates to:
  /// **'Default layer'**
  String get defaultLayer;

  /// No description provided for @layer.
  ///
  /// In en, this message translates to:
  /// **'Layer'**
  String get layer;

  /// No description provided for @layers.
  ///
  /// In en, this message translates to:
  /// **'Layers'**
  String get layers;

  /// No description provided for @notSet.
  ///
  /// In en, this message translates to:
  /// **'Not set'**
  String get notSet;

  /// No description provided for @enterLayer.
  ///
  /// In en, this message translates to:
  /// **'Enter the layer name'**
  String get enterLayer;

  /// No description provided for @selectElements.
  ///
  /// In en, this message translates to:
  /// **'Select elements'**
  String get selectElements;

  /// No description provided for @deleteElements.
  ///
  /// In en, this message translates to:
  /// **'Delete elements'**
  String get deleteElements;

  /// No description provided for @deleteElementsConfirm.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to delete the selected elements?'**
  String get deleteElementsConfirm;

  /// No description provided for @selectCustomCollection.
  ///
  /// In en, this message translates to:
  /// **'Select a custom collection'**
  String get selectCustomCollection;

  /// No description provided for @svg.
  ///
  /// In en, this message translates to:
  /// **'SVG'**
  String get svg;

  /// No description provided for @sensitivity.
  ///
  /// In en, this message translates to:
  /// **'Sensitivity'**
  String get sensitivity;

  /// No description provided for @sensitivityHint.
  ///
  /// In en, this message translates to:
  /// **'The higher the value, the more sensitive the input'**
  String get sensitivityHint;

  /// No description provided for @horizontal.
  ///
  /// In en, this message translates to:
  /// **'Horizontal'**
  String get horizontal;

  /// No description provided for @vertical.
  ///
  /// In en, this message translates to:
  /// **'Vertical'**
  String get vertical;

  /// No description provided for @plain.
  ///
  /// In en, this message translates to:
  /// **'Plain'**
  String get plain;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @ruled.
  ///
  /// In en, this message translates to:
  /// **'Ruled'**
  String get ruled;

  /// No description provided for @quad.
  ///
  /// In en, this message translates to:
  /// **'Quad'**
  String get quad;

  /// No description provided for @music.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get music;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @plainDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get plainDark;

  /// No description provided for @ruledDark.
  ///
  /// In en, this message translates to:
  /// **'Ruled dark'**
  String get ruledDark;

  /// No description provided for @quadDark.
  ///
  /// In en, this message translates to:
  /// **'Quad dark'**
  String get quadDark;

  /// No description provided for @musicDark.
  ///
  /// In en, this message translates to:
  /// **'Music dark'**
  String get musicDark;

  /// No description provided for @templates.
  ///
  /// In en, this message translates to:
  /// **'Templates'**
  String get templates;

  /// No description provided for @untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitled;

  /// No description provided for @createTemplate.
  ///
  /// In en, this message translates to:
  /// **'Create template'**
  String get createTemplate;

  /// No description provided for @createTemplateContent.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to create a template from this document? The original document will get deleted.'**
  String get createTemplateContent;

  /// No description provided for @replace.
  ///
  /// In en, this message translates to:
  /// **'Replace'**
  String get replace;

  /// No description provided for @reallyReplace.
  ///
  /// In en, this message translates to:
  /// **'Do you really want to replace the template? This operation can be not undone!'**
  String get reallyReplace;

  /// No description provided for @defaultTemplate.
  ///
  /// In en, this message translates to:
  /// **'Default template'**
  String get defaultTemplate;

  /// No description provided for @insert.
  ///
  /// In en, this message translates to:
  /// **'Insert'**
  String get insert;

  /// No description provided for @document.
  ///
  /// In en, this message translates to:
  /// **'Document'**
  String get document;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @printout.
  ///
  /// In en, this message translates to:
  /// **'Printout'**
  String get printout;

  /// No description provided for @selectCamera.
  ///
  /// In en, this message translates to:
  /// **'Select a camera'**
  String get selectCamera;

  /// No description provided for @changeDocumentPath.
  ///
  /// In en, this message translates to:
  /// **'Change document path'**
  String get changeDocumentPath;

  /// No description provided for @deleteWholeStroke.
  ///
  /// In en, this message translates to:
  /// **'Delete whole stroke'**
  String get deleteWholeStroke;

  /// No description provided for @alpha.
  ///
  /// In en, this message translates to:
  /// **'Alpha'**
  String get alpha;

  /// No description provided for @area.
  ///
  /// In en, this message translates to:
  /// **'Area'**
  String get area;

  /// No description provided for @selectArea.
  ///
  /// In en, this message translates to:
  /// **'Select an area'**
  String get selectArea;

  /// No description provided for @aspectRatio.
  ///
  /// In en, this message translates to:
  /// **'Aspect ratio'**
  String get aspectRatio;

  /// No description provided for @presets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get presets;

  /// No description provided for @pagePortrait.
  ///
  /// In en, this message translates to:
  /// **'Page portrait'**
  String get pagePortrait;

  /// No description provided for @pageLandscape.
  ///
  /// In en, this message translates to:
  /// **'Page landscape'**
  String get pageLandscape;

  /// No description provided for @square.
  ///
  /// In en, this message translates to:
  /// **'Square'**
  String get square;

  /// No description provided for @areas.
  ///
  /// In en, this message translates to:
  /// **'Areas'**
  String get areas;

  /// No description provided for @enterArea.
  ///
  /// In en, this message translates to:
  /// **'Enter the area'**
  String get enterArea;

  /// No description provided for @exitArea.
  ///
  /// In en, this message translates to:
  /// **'Exit the area'**
  String get exitArea;

  /// No description provided for @currentArea.
  ///
  /// In en, this message translates to:
  /// **'Current area'**
  String get currentArea;

  /// No description provided for @design.
  ///
  /// In en, this message translates to:
  /// **'Design'**
  String get design;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get text;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Hey, this is Linwood Butterfly {codeName}'**
  String welcome(String codeName);

  /// No description provided for @welcomeContent.
  ///
  /// In en, this message translates to:
  /// **'A free and open-source drawing space!'**
  String get welcomeContent;

  /// This message is shown when the app is updated
  ///
  /// In en, this message translates to:
  /// **'App updated to version {version}'**
  String updated(String version);

  /// No description provided for @releaseNotes.
  ///
  /// In en, this message translates to:
  /// **'Release notes'**
  String get releaseNotes;

  /// No description provided for @constraints.
  ///
  /// In en, this message translates to:
  /// **'Constraints'**
  String get constraints;

  /// No description provided for @scaled.
  ///
  /// In en, this message translates to:
  /// **'Scaled'**
  String get scaled;

  /// No description provided for @fixed.
  ///
  /// In en, this message translates to:
  /// **'Fixed'**
  String get fixed;

  /// No description provided for @dynamicContent.
  ///
  /// In en, this message translates to:
  /// **'Dynamic'**
  String get dynamicContent;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @includeArea.
  ///
  /// In en, this message translates to:
  /// **'Include area'**
  String get includeArea;

  /// No description provided for @verticalAlignment.
  ///
  /// In en, this message translates to:
  /// **'Vertical alignment'**
  String get verticalAlignment;

  /// No description provided for @horizontalAlignment.
  ///
  /// In en, this message translates to:
  /// **'Horizontal alignment'**
  String get horizontalAlignment;

  /// No description provided for @top.
  ///
  /// In en, this message translates to:
  /// **'Top'**
  String get top;

  /// No description provided for @center.
  ///
  /// In en, this message translates to:
  /// **'Center'**
  String get center;

  /// No description provided for @bottom.
  ///
  /// In en, this message translates to:
  /// **'Bottom'**
  String get bottom;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get left;

  /// No description provided for @right.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get right;

  /// No description provided for @justify.
  ///
  /// In en, this message translates to:
  /// **'Justify'**
  String get justify;

  /// No description provided for @constraint.
  ///
  /// In en, this message translates to:
  /// **'Constraint'**
  String get constraint;

  /// No description provided for @length.
  ///
  /// In en, this message translates to:
  /// **'Length'**
  String get length;

  /// No description provided for @exportSvg.
  ///
  /// In en, this message translates to:
  /// **'Export SVG'**
  String get exportSvg;

  /// No description provided for @pdf.
  ///
  /// In en, this message translates to:
  /// **'PDF'**
  String get pdf;

  /// No description provided for @selectPages.
  ///
  /// In en, this message translates to:
  /// **'Select pages'**
  String get selectPages;

  /// No description provided for @recentFiles.
  ///
  /// In en, this message translates to:
  /// **'Recent files'**
  String get recentFiles;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @noRecentFiles.
  ///
  /// In en, this message translates to:
  /// **'No recent files'**
  String get noRecentFiles;

  /// No description provided for @countPages.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{No pages} =1{1 page} other{{count} pages}}'**
  String countPages(int count);

  /// No description provided for @pageIndex.
  ///
  /// In en, this message translates to:
  /// **'Page {index}'**
  String pageIndex(int index);

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @noElements.
  ///
  /// In en, this message translates to:
  /// **'No elements'**
  String get noElements;

  /// No description provided for @invertSelection.
  ///
  /// In en, this message translates to:
  /// **'Invert selection'**
  String get invertSelection;

  /// No description provided for @errorWhileImporting.
  ///
  /// In en, this message translates to:
  /// **'Error while importing'**
  String get errorWhileImporting;

  /// No description provided for @errorWhileImportingContent.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while importing the file'**
  String get errorWhileImportingContent;

  /// No description provided for @showDetails.
  ///
  /// In en, this message translates to:
  /// **'Show details'**
  String get showDetails;

  /// No description provided for @hideDetails.
  ///
  /// In en, this message translates to:
  /// **'Hide details'**
  String get hideDetails;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @stackTrace.
  ///
  /// In en, this message translates to:
  /// **'Stack trace'**
  String get stackTrace;

  /// No description provided for @laser.
  ///
  /// In en, this message translates to:
  /// **'Laser'**
  String get laser;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @quality.
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get quality;

  /// No description provided for @exportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get exportPdf;

  /// No description provided for @local.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get local;

  /// No description provided for @addConnection.
  ///
  /// In en, this message translates to:
  /// **'Add connection'**
  String get addConnection;

  /// No description provided for @connections.
  ///
  /// In en, this message translates to:
  /// **'Connections'**
  String get connections;

  /// No description provided for @noConnections.
  ///
  /// In en, this message translates to:
  /// **'No connections'**
  String get noConnections;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get connect;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @webNotSupported.
  ///
  /// In en, this message translates to:
  /// **'Web not supported'**
  String get webNotSupported;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @directory.
  ///
  /// In en, this message translates to:
  /// **'Directory'**
  String get directory;

  /// No description provided for @documentsDirectory.
  ///
  /// In en, this message translates to:
  /// **'Documents directory'**
  String get documentsDirectory;

  /// No description provided for @templatesDirectory.
  ///
  /// In en, this message translates to:
  /// **'Templates directory'**
  String get templatesDirectory;

  /// No description provided for @errorWhileCreatingConnection.
  ///
  /// In en, this message translates to:
  /// **'Error while creating connection'**
  String get errorWhileCreatingConnection;

  /// No description provided for @cannotConnect.
  ///
  /// In en, this message translates to:
  /// **'Cannot connect'**
  String get cannotConnect;

  /// No description provided for @urlNotValid.
  ///
  /// In en, this message translates to:
  /// **'URL not valid'**
  String get urlNotValid;

  /// No description provided for @icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get icon;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @updateAvailable.
  ///
  /// In en, this message translates to:
  /// **'Update available'**
  String get updateAvailable;

  /// No description provided for @stable.
  ///
  /// In en, this message translates to:
  /// **'Stable'**
  String get stable;

  /// No description provided for @nightly.
  ///
  /// In en, this message translates to:
  /// **'Nightly'**
  String get nightly;

  /// No description provided for @checkForUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check for updates'**
  String get checkForUpdates;

  /// No description provided for @checkForUpdatesWarning.
  ///
  /// In en, this message translates to:
  /// **'Performing a check for updates will connect to the Butterfly website to get the information.'**
  String get checkForUpdatesWarning;

  /// No description provided for @usingLatestStable.
  ///
  /// In en, this message translates to:
  /// **'You are using the latest stable version'**
  String get usingLatestStable;

  /// No description provided for @usingLatestNightly.
  ///
  /// In en, this message translates to:
  /// **'You are using the latest nightly version'**
  String get usingLatestNightly;

  /// No description provided for @currentVersion.
  ///
  /// In en, this message translates to:
  /// **'Current version'**
  String get currentVersion;

  /// No description provided for @updateNow.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get updateNow;

  /// No description provided for @shape.
  ///
  /// In en, this message translates to:
  /// **'Shape'**
  String get shape;

  /// No description provided for @circle.
  ///
  /// In en, this message translates to:
  /// **'Circle'**
  String get circle;

  /// No description provided for @rectangle.
  ///
  /// In en, this message translates to:
  /// **'Rectangle'**
  String get rectangle;

  /// No description provided for @triangle.
  ///
  /// In en, this message translates to:
  /// **'Triangle'**
  String get triangle;

  /// No description provided for @line.
  ///
  /// In en, this message translates to:
  /// **'Line'**
  String get line;

  /// No description provided for @cornerRadius.
  ///
  /// In en, this message translates to:
  /// **'Corner radius'**
  String get cornerRadius;

  /// No description provided for @topLeft.
  ///
  /// In en, this message translates to:
  /// **'Top left'**
  String get topLeft;

  /// No description provided for @topRight.
  ///
  /// In en, this message translates to:
  /// **'Top right'**
  String get topRight;

  /// No description provided for @bottomLeft.
  ///
  /// In en, this message translates to:
  /// **'Bottom left'**
  String get bottomLeft;

  /// No description provided for @bottomRight.
  ///
  /// In en, this message translates to:
  /// **'Bottom right'**
  String get bottomRight;

  /// No description provided for @caches.
  ///
  /// In en, this message translates to:
  /// **'Caches'**
  String get caches;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @clearCaches.
  ///
  /// In en, this message translates to:
  /// **'Clear caches'**
  String get clearCaches;

  /// No description provided for @createCache.
  ///
  /// In en, this message translates to:
  /// **'Create cache'**
  String get createCache;

  /// No description provided for @thirdPartyLicenses.
  ///
  /// In en, this message translates to:
  /// **'Third party licenses'**
  String get thirdPartyLicenses;

  /// No description provided for @syncing.
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get syncing;

  /// No description provided for @synced.
  ///
  /// In en, this message translates to:
  /// **'Synced'**
  String get synced;

  /// No description provided for @notSynced.
  ///
  /// In en, this message translates to:
  /// **'Not synced'**
  String get notSynced;

  /// No description provided for @conflict.
  ///
  /// In en, this message translates to:
  /// **'Conflict'**
  String get conflict;

  /// No description provided for @keepLocal.
  ///
  /// In en, this message translates to:
  /// **'Keep local'**
  String get keepLocal;

  /// No description provided for @keepConnection.
  ///
  /// In en, this message translates to:
  /// **'Keep connection'**
  String get keepConnection;

  /// No description provided for @keepBoth.
  ///
  /// In en, this message translates to:
  /// **'Keep both'**
  String get keepBoth;

  /// No description provided for @forAll.
  ///
  /// In en, this message translates to:
  /// **'For all'**
  String get forAll;

  /// No description provided for @fileConflict.
  ///
  /// In en, this message translates to:
  /// **'{file} in {connection} has a conflict'**
  String fileConflict(String file, String connection);

  /// No description provided for @offline.
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// No description provided for @localLatest.
  ///
  /// In en, this message translates to:
  /// **'Local latest'**
  String get localLatest;

  /// No description provided for @connectionLatest.
  ///
  /// In en, this message translates to:
  /// **'Connection latest'**
  String get connectionLatest;

  /// No description provided for @path.
  ///
  /// In en, this message translates to:
  /// **'Path'**
  String get path;

  /// No description provided for @folderSynced.
  ///
  /// In en, this message translates to:
  /// **'Folder synced'**
  String get folderSynced;

  /// No description provided for @syncRootDirectory.
  ///
  /// In en, this message translates to:
  /// **'Sync root directory'**
  String get syncRootDirectory;

  /// No description provided for @penOnlyInput.
  ///
  /// In en, this message translates to:
  /// **'Pen only input'**
  String get penOnlyInput;

  /// No description provided for @inputGestures.
  ///
  /// In en, this message translates to:
  /// **'Input gestures'**
  String get inputGestures;

  /// No description provided for @nativeTitleBar.
  ///
  /// In en, this message translates to:
  /// **'Native title bar'**
  String get nativeTitleBar;

  /// No description provided for @syncMode.
  ///
  /// In en, this message translates to:
  /// **'Sync mode'**
  String get syncMode;

  /// No description provided for @connection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get connection;

  /// No description provided for @always.
  ///
  /// In en, this message translates to:
  /// **'Always'**
  String get always;

  /// No description provided for @noMobile.
  ///
  /// In en, this message translates to:
  /// **'No mobile'**
  String get noMobile;

  /// No description provided for @manual.
  ///
  /// In en, this message translates to:
  /// **'Manual'**
  String get manual;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @properties.
  ///
  /// In en, this message translates to:
  /// **'Properties'**
  String get properties;

  /// No description provided for @pin.
  ///
  /// In en, this message translates to:
  /// **'Pin'**
  String get pin;

  /// No description provided for @unpin.
  ///
  /// In en, this message translates to:
  /// **'Unpin'**
  String get unpin;

  /// No description provided for @element.
  ///
  /// In en, this message translates to:
  /// **'Element'**
  String get element;

  /// No description provided for @painter.
  ///
  /// In en, this message translates to:
  /// **'Painter'**
  String get painter;

  /// No description provided for @position.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get position;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @packs.
  ///
  /// In en, this message translates to:
  /// **'Packs'**
  String get packs;

  /// No description provided for @pack.
  ///
  /// In en, this message translates to:
  /// **'Pack'**
  String get pack;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @askForName.
  ///
  /// In en, this message translates to:
  /// **'Ask for name'**
  String get askForName;

  /// No description provided for @areaIndex.
  ///
  /// In en, this message translates to:
  /// **'Area {index}'**
  String areaIndex(int index);

  /// No description provided for @startInFullScreen.
  ///
  /// In en, this message translates to:
  /// **'Start in full screen'**
  String get startInFullScreen;

  /// No description provided for @inputs.
  ///
  /// In en, this message translates to:
  /// **'Inputs'**
  String get inputs;

  /// No description provided for @mouse.
  ///
  /// In en, this message translates to:
  /// **'Mouse'**
  String get mouse;

  /// No description provided for @touch.
  ///
  /// In en, this message translates to:
  /// **'Touch'**
  String get touch;

  /// No description provided for @keyboard.
  ///
  /// In en, this message translates to:
  /// **'Keyboard'**
  String get keyboard;

  /// No description provided for @shortcuts.
  ///
  /// In en, this message translates to:
  /// **'Shortcuts'**
  String get shortcuts;

  /// No description provided for @middle.
  ///
  /// In en, this message translates to:
  /// **'Middle'**
  String get middle;

  /// No description provided for @first.
  ///
  /// In en, this message translates to:
  /// **'First'**
  String get first;

  /// No description provided for @second.
  ///
  /// In en, this message translates to:
  /// **'Second'**
  String get second;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @showGrid.
  ///
  /// In en, this message translates to:
  /// **'Show grid'**
  String get showGrid;

  /// No description provided for @grid.
  ///
  /// In en, this message translates to:
  /// **'Grid'**
  String get grid;

  /// No description provided for @ruler.
  ///
  /// In en, this message translates to:
  /// **'Ruler'**
  String get ruler;

  /// No description provided for @angle.
  ///
  /// In en, this message translates to:
  /// **'Angle'**
  String get angle;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @newFolder.
  ///
  /// In en, this message translates to:
  /// **'New folder'**
  String get newFolder;

  /// No description provided for @createPack.
  ///
  /// In en, this message translates to:
  /// **'Create pack'**
  String get createPack;

  /// No description provided for @editPack.
  ///
  /// In en, this message translates to:
  /// **'Edit pack'**
  String get editPack;

  /// No description provided for @packsDirectory.
  ///
  /// In en, this message translates to:
  /// **'Packs directory'**
  String get packsDirectory;

  /// No description provided for @stamp.
  ///
  /// In en, this message translates to:
  /// **'Stamp'**
  String get stamp;

  /// No description provided for @addToPack.
  ///
  /// In en, this message translates to:
  /// **'Add to pack'**
  String get addToPack;

  /// No description provided for @sureImportPack.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to import the pack?'**
  String get sureImportPack;

  /// No description provided for @byAuthor.
  ///
  /// In en, this message translates to:
  /// **'by {author}'**
  String byAuthor(String author);

  /// No description provided for @author.
  ///
  /// In en, this message translates to:
  /// **'Author'**
  String get author;

  /// No description provided for @addAsset.
  ///
  /// In en, this message translates to:
  /// **'Add asset'**
  String get addAsset;

  /// No description provided for @editAsset.
  ///
  /// In en, this message translates to:
  /// **'Edit asset'**
  String get editAsset;

  /// No description provided for @scope.
  ///
  /// In en, this message translates to:
  /// **'Scope'**
  String get scope;

  /// No description provided for @noPacks.
  ///
  /// In en, this message translates to:
  /// **'There are currently no packs available'**
  String get noPacks;

  /// No description provided for @components.
  ///
  /// In en, this message translates to:
  /// **'Components'**
  String get components;

  /// No description provided for @waypoint.
  ///
  /// In en, this message translates to:
  /// **'Waypoint'**
  String get waypoint;

  /// No description provided for @actions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get actions;

  /// No description provided for @painters.
  ///
  /// In en, this message translates to:
  /// **'Painters'**
  String get painters;

  /// No description provided for @breakingChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Breaking changes'**
  String get breakingChangesTitle;

  /// No description provided for @breakingChangesMessage.
  ///
  /// In en, this message translates to:
  /// **'There are breaking changes in this version. Please read the changelog before updating. The current file version is {version}, the new version is {newVersion}.'**
  String breakingChangesMessage(int version, int newVersion);

  /// No description provided for @styles.
  ///
  /// In en, this message translates to:
  /// **'Styles'**
  String get styles;

  /// No description provided for @paragraph.
  ///
  /// In en, this message translates to:
  /// **'Paragraph'**
  String get paragraph;

  /// No description provided for @fontFamily.
  ///
  /// In en, this message translates to:
  /// **'Font family'**
  String get fontFamily;

  /// No description provided for @smoothing.
  ///
  /// In en, this message translates to:
  /// **'Smoothing'**
  String get smoothing;

  /// No description provided for @streamline.
  ///
  /// In en, this message translates to:
  /// **'Streamline'**
  String get streamline;

  /// No description provided for @presentation.
  ///
  /// In en, this message translates to:
  /// **'Presentation'**
  String get presentation;

  /// No description provided for @selectAsset.
  ///
  /// In en, this message translates to:
  /// **'Select asset'**
  String get selectAsset;

  /// No description provided for @clearStyle.
  ///
  /// In en, this message translates to:
  /// **'Clear style'**
  String get clearStyle;

  /// No description provided for @unknownImportType.
  ///
  /// In en, this message translates to:
  /// **'Unknown import type'**
  String get unknownImportType;

  /// No description provided for @sureImportTemplate.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to import the template?'**
  String get sureImportTemplate;

  /// No description provided for @frame.
  ///
  /// In en, this message translates to:
  /// **'Frame'**
  String get frame;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @fps.
  ///
  /// In en, this message translates to:
  /// **'FPS'**
  String get fps;

  /// No description provided for @breakpoint.
  ///
  /// In en, this message translates to:
  /// **'Breakpoint'**
  String get breakpoint;

  /// No description provided for @presentationControls.
  ///
  /// In en, this message translates to:
  /// **'Presentation controls'**
  String get presentationControls;

  /// No description provided for @nextSlide.
  ///
  /// In en, this message translates to:
  /// **'Next slide'**
  String get nextSlide;

  /// No description provided for @nextSlideDescription.
  ///
  /// In en, this message translates to:
  /// **'Swipe to the right or press the right arrow key to go to the next slide'**
  String get nextSlideDescription;

  /// No description provided for @previousSlide.
  ///
  /// In en, this message translates to:
  /// **'Previous slide'**
  String get previousSlide;

  /// No description provided for @previousSlideDescription.
  ///
  /// In en, this message translates to:
  /// **'Swipe to the left or press the left arrow key to go to the previous slide'**
  String get previousSlideDescription;

  /// No description provided for @exitPresentation.
  ///
  /// In en, this message translates to:
  /// **'Exit presentation'**
  String get exitPresentation;

  /// No description provided for @exitPresentationDescription.
  ///
  /// In en, this message translates to:
  /// **'Press the escape key or swipe down to exit the presentation'**
  String get exitPresentationDescription;

  /// No description provided for @pausePresentation.
  ///
  /// In en, this message translates to:
  /// **'Pause presentation'**
  String get pausePresentation;

  /// No description provided for @pausePresentationDescription.
  ///
  /// In en, this message translates to:
  /// **'Tap the screen or press the space bar to pause or resume the presentation'**
  String get pausePresentationDescription;

  /// No description provided for @keyframe.
  ///
  /// In en, this message translates to:
  /// **'Keyframe'**
  String get keyframe;

  /// No description provided for @endOfPresentation.
  ///
  /// In en, this message translates to:
  /// **'You have reached the end of the presentation'**
  String get endOfPresentation;

  /// No description provided for @startOfPresentation.
  ///
  /// In en, this message translates to:
  /// **'You have reached the start of the presentation'**
  String get startOfPresentation;

  /// No description provided for @palettes.
  ///
  /// In en, this message translates to:
  /// **'Palettes'**
  String get palettes;

  /// No description provided for @headline.
  ///
  /// In en, this message translates to:
  /// **'Headline {index}'**
  String headline(int index);

  /// No description provided for @code.
  ///
  /// In en, this message translates to:
  /// **'Code'**
  String get code;

  /// No description provided for @quote.
  ///
  /// In en, this message translates to:
  /// **'Quote'**
  String get quote;

  /// No description provided for @link.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get link;

  /// No description provided for @checkbox.
  ///
  /// In en, this message translates to:
  /// **'Checkbox'**
  String get checkbox;

  /// No description provided for @deleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get deleted;

  /// No description provided for @emphasis.
  ///
  /// In en, this message translates to:
  /// **'Emphasis'**
  String get emphasis;

  /// No description provided for @listBullet.
  ///
  /// In en, this message translates to:
  /// **'List bullet'**
  String get listBullet;

  /// No description provided for @strong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get strong;

  /// No description provided for @markdown.
  ///
  /// In en, this message translates to:
  /// **'Markdown'**
  String get markdown;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get files;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get sortBy;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @whatsNew.
  ///
  /// In en, this message translates to:
  /// **'What\'s new?'**
  String get whatsNew;

  /// No description provided for @unstar.
  ///
  /// In en, this message translates to:
  /// **'Unstar'**
  String get unstar;

  /// No description provided for @star.
  ///
  /// In en, this message translates to:
  /// **'Star'**
  String get star;

  /// No description provided for @goUp.
  ///
  /// In en, this message translates to:
  /// **'Go up'**
  String get goUp;

  /// No description provided for @created.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get created;

  /// No description provided for @modified.
  ///
  /// In en, this message translates to:
  /// **'Modified'**
  String get modified;

  /// No description provided for @quickstart.
  ///
  /// In en, this message translates to:
  /// **'Quickstart'**
  String get quickstart;

  /// No description provided for @noTemplates.
  ///
  /// In en, this message translates to:
  /// **'There are currently no templates available'**
  String get noTemplates;

  /// No description provided for @importCorePack.
  ///
  /// In en, this message translates to:
  /// **'Import core pack'**
  String get importCorePack;

  /// No description provided for @importCorePackDescription.
  ///
  /// In en, this message translates to:
  /// **'Import the core pack that contains all basic assets to get started. This will override the current core pack.'**
  String get importCorePackDescription;

  /// No description provided for @never.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get never;

  /// No description provided for @onlyOnUpdates.
  ///
  /// In en, this message translates to:
  /// **'Only on updates'**
  String get onlyOnUpdates;

  /// No description provided for @visibility.
  ///
  /// In en, this message translates to:
  /// **'Visibility'**
  String get visibility;

  /// No description provided for @captureThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Capture thumbnail'**
  String get captureThumbnail;

  /// No description provided for @capturedThumbnail.
  ///
  /// In en, this message translates to:
  /// **'Successfully captured thumbnail'**
  String get capturedThumbnail;

  /// No description provided for @chooseLabelMode.
  ///
  /// In en, this message translates to:
  /// **'Choose label mode'**
  String get chooseLabelMode;

  /// No description provided for @foreground.
  ///
  /// In en, this message translates to:
  /// **'Foreground'**
  String get foreground;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// No description provided for @repository.
  ///
  /// In en, this message translates to:
  /// **'Repository'**
  String get repository;

  /// No description provided for @pages.
  ///
  /// In en, this message translates to:
  /// **'Pages'**
  String get pages;

  /// No description provided for @navigator.
  ///
  /// In en, this message translates to:
  /// **'Navigator'**
  String get navigator;

  /// No description provided for @arrange.
  ///
  /// In en, this message translates to:
  /// **'Arrange'**
  String get arrange;

  /// No description provided for @bringToFront.
  ///
  /// In en, this message translates to:
  /// **'Bring to front'**
  String get bringToFront;

  /// No description provided for @sendToBack.
  ///
  /// In en, this message translates to:
  /// **'Send to back'**
  String get sendToBack;

  /// No description provided for @bringForward.
  ///
  /// In en, this message translates to:
  /// **'Bring forward'**
  String get bringForward;

  /// No description provided for @sendBackward.
  ///
  /// In en, this message translates to:
  /// **'Send backward'**
  String get sendBackward;

  /// No description provided for @rotation.
  ///
  /// In en, this message translates to:
  /// **'Rotation'**
  String get rotation;

  /// No description provided for @onlyAvailableLargerScreen.
  ///
  /// In en, this message translates to:
  /// **'Only available on larger screens'**
  String get onlyAvailableLargerScreen;

  /// No description provided for @toolbarPosition.
  ///
  /// In en, this message translates to:
  /// **'Toolbar position'**
  String get toolbarPosition;

  /// No description provided for @rotate.
  ///
  /// In en, this message translates to:
  /// **'Rotate'**
  String get rotate;

  /// No description provided for @spacer.
  ///
  /// In en, this message translates to:
  /// **'Spacer'**
  String get spacer;

  /// No description provided for @navigationRail.
  ///
  /// In en, this message translates to:
  /// **'Navigation rail'**
  String get navigationRail;

  /// No description provided for @cut.
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get cut;

  /// No description provided for @insertBefore.
  ///
  /// In en, this message translates to:
  /// **'Insert before'**
  String get insertBefore;

  /// No description provided for @insertAfter.
  ///
  /// In en, this message translates to:
  /// **'Insert after'**
  String get insertAfter;

  /// No description provided for @insertFirst.
  ///
  /// In en, this message translates to:
  /// **'Insert first'**
  String get insertFirst;

  /// No description provided for @insertLast.
  ///
  /// In en, this message translates to:
  /// **'Insert last'**
  String get insertLast;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @ascending.
  ///
  /// In en, this message translates to:
  /// **'Ascending'**
  String get ascending;

  /// No description provided for @descending.
  ///
  /// In en, this message translates to:
  /// **'Descending'**
  String get descending;

  /// No description provided for @imageScale.
  ///
  /// In en, this message translates to:
  /// **'Image scale'**
  String get imageScale;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @tool.
  ///
  /// In en, this message translates to:
  /// **'Tool'**
  String get tool;

  /// No description provided for @texture.
  ///
  /// In en, this message translates to:
  /// **'Texture'**
  String get texture;

  /// No description provided for @platformTheme.
  ///
  /// In en, this message translates to:
  /// **'Platform theme'**
  String get platformTheme;

  /// No description provided for @desktop.
  ///
  /// In en, this message translates to:
  /// **'Desktop'**
  String get desktop;

  /// No description provided for @mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get mobile;

  /// No description provided for @pdfQuality.
  ///
  /// In en, this message translates to:
  /// **'PDF quality'**
  String get pdfQuality;

  /// No description provided for @surface.
  ///
  /// In en, this message translates to:
  /// **'Surface'**
  String get surface;

  /// No description provided for @pattern.
  ///
  /// In en, this message translates to:
  /// **'Pattern'**
  String get pattern;

  /// No description provided for @sureClose.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to close the document?'**
  String get sureClose;

  /// No description provided for @thereAreUnsavedChanges.
  ///
  /// In en, this message translates to:
  /// **'There are unsaved changes'**
  String get thereAreUnsavedChanges;

  /// No description provided for @page.
  ///
  /// In en, this message translates to:
  /// **'Page'**
  String get page;

  /// No description provided for @iceServers.
  ///
  /// In en, this message translates to:
  /// **'ICE Servers'**
  String get iceServers;

  /// No description provided for @collaboration.
  ///
  /// In en, this message translates to:
  /// **'Collaboration'**
  String get collaboration;

  /// No description provided for @webRtc.
  ///
  /// In en, this message translates to:
  /// **'Web RTC'**
  String get webRtc;

  /// No description provided for @webSocket.
  ///
  /// In en, this message translates to:
  /// **'Web Socket'**
  String get webSocket;

  /// No description provided for @iceServer.
  ///
  /// In en, this message translates to:
  /// **'ICE Server'**
  String get iceServer;

  /// No description provided for @port.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get port;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @side.
  ///
  /// In en, this message translates to:
  /// **'Side'**
  String get side;

  /// No description provided for @client.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get client;

  /// No description provided for @server.
  ///
  /// In en, this message translates to:
  /// **'Server'**
  String get server;

  /// No description provided for @switchView.
  ///
  /// In en, this message translates to:
  /// **'Switch View'**
  String get switchView;

  /// No description provided for @lasso.
  ///
  /// In en, this message translates to:
  /// **'Lasso'**
  String get lasso;

  /// No description provided for @hideUI.
  ///
  /// In en, this message translates to:
  /// **'Hide UI'**
  String get hideUI;

  /// No description provided for @density.
  ///
  /// In en, this message translates to:
  /// **'Density'**
  String get density;

  /// No description provided for @compact.
  ///
  /// In en, this message translates to:
  /// **'Compact'**
  String get compact;

  /// No description provided for @comfortable.
  ///
  /// In en, this message translates to:
  /// **'Comfortable'**
  String get comfortable;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standard;

  /// No description provided for @lock.
  ///
  /// In en, this message translates to:
  /// **'Lock'**
  String get lock;

  /// No description provided for @addElement.
  ///
  /// In en, this message translates to:
  /// **'Add element'**
  String get addElement;

  /// No description provided for @notDefaultConnection.
  ///
  /// In en, this message translates to:
  /// **'Not default connection'**
  String get notDefaultConnection;

  /// No description provided for @defaultConnection.
  ///
  /// In en, this message translates to:
  /// **'Default connection'**
  String get defaultConnection;

  /// No description provided for @hide.
  ///
  /// In en, this message translates to:
  /// **'Hide'**
  String get hide;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @dav.
  ///
  /// In en, this message translates to:
  /// **'DAV'**
  String get dav;

  /// No description provided for @eyeDropper.
  ///
  /// In en, this message translates to:
  /// **'Eye dropper'**
  String get eyeDropper;

  /// No description provided for @users.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get users;

  /// No description provided for @experiments.
  ///
  /// In en, this message translates to:
  /// **'Experiments'**
  String get experiments;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @spreadToPages.
  ///
  /// In en, this message translates to:
  /// **'Spread to pages'**
  String get spreadToPages;

  /// No description provided for @rootDirectorySpecifiedDescription.
  ///
  /// In en, this message translates to:
  /// **'The root directory is specified. All advanced directory paths will be relative to this directory. Keep it empty to disable this directory type.'**
  String get rootDirectorySpecifiedDescription;

  /// No description provided for @rootDirectoryNotSpecifiedDescription.
  ///
  /// In en, this message translates to:
  /// **'The root directory is not specified. A name is required. All advanced directory paths will be absolute. Keep it empty to disable this directory type.'**
  String get rootDirectoryNotSpecifiedDescription;

  /// No description provided for @unsecureConnectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Unsecure connection'**
  String get unsecureConnectionTitle;

  /// No description provided for @unsecureConnectionMessage.
  ///
  /// In en, this message translates to:
  /// **'The connection is not secure. This can be a security risk. Please only continue if you trust the connection. The sha1 fingerprint is {fingerprint}.'**
  String unsecureConnectionMessage(String fingerprint);

  /// No description provided for @continueAnyway.
  ///
  /// In en, this message translates to:
  /// **'Continue anyway'**
  String get continueAnyway;

  /// No description provided for @zoomControl.
  ///
  /// In en, this message translates to:
  /// **'Zoom control'**
  String get zoomControl;

  /// No description provided for @highContrast.
  ///
  /// In en, this message translates to:
  /// **'High contrast'**
  String get highContrast;

  /// No description provided for @shouldANumber.
  ///
  /// In en, this message translates to:
  /// **'This value should be valid number'**
  String get shouldANumber;

  /// No description provided for @createAreas.
  ///
  /// In en, this message translates to:
  /// **'Create areas'**
  String get createAreas;

  /// No description provided for @autosave.
  ///
  /// In en, this message translates to:
  /// **'Autosave'**
  String get autosave;

  /// No description provided for @invert.
  ///
  /// In en, this message translates to:
  /// **'Invert'**
  String get invert;

  /// No description provided for @operations.
  ///
  /// In en, this message translates to:
  /// **'Operations'**
  String get operations;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get large;

  /// No description provided for @toolbarSize.
  ///
  /// In en, this message translates to:
  /// **'Toolbar size'**
  String get toolbarSize;

  /// No description provided for @addAll.
  ///
  /// In en, this message translates to:
  /// **'Add all'**
  String get addAll;

  /// No description provided for @onlyCurrentPage.
  ///
  /// In en, this message translates to:
  /// **'Only current page'**
  String get onlyCurrentPage;

  /// No description provided for @smoothNavigation.
  ///
  /// In en, this message translates to:
  /// **'Smooth navigation'**
  String get smoothNavigation;

  /// No description provided for @exact.
  ///
  /// In en, this message translates to:
  /// **'Exact'**
  String get exact;

  /// No description provided for @inline.
  ///
  /// In en, this message translates to:
  /// **'Inline'**
  String get inline;

  /// No description provided for @toolbarRows.
  ///
  /// In en, this message translates to:
  /// **'Toolbar rows'**
  String get toolbarRows;

  /// No description provided for @pointerTest.
  ///
  /// In en, this message translates to:
  /// **'Pointer test'**
  String get pointerTest;

  /// No description provided for @pressure.
  ///
  /// In en, this message translates to:
  /// **'Pressure'**
  String get pressure;

  /// No description provided for @small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get small;

  /// No description provided for @tiny.
  ///
  /// In en, this message translates to:
  /// **'Tiny'**
  String get tiny;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// No description provided for @overrideTools.
  ///
  /// In en, this message translates to:
  /// **'Override tools'**
  String get overrideTools;

  /// No description provided for @hideCursorWhileDrawing.
  ///
  /// In en, this message translates to:
  /// **'Hide cursor while drawing'**
  String get hideCursorWhileDrawing;

  /// No description provided for @installed.
  ///
  /// In en, this message translates to:
  /// **'Installed'**
  String get installed;

  /// No description provided for @install.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get install;

  /// No description provided for @deselect.
  ///
  /// In en, this message translates to:
  /// **'Deselect'**
  String get deselect;

  /// No description provided for @changeCollection.
  ///
  /// In en, this message translates to:
  /// **'Change collection'**
  String get changeCollection;

  /// No description provided for @collections.
  ///
  /// In en, this message translates to:
  /// **'Collections'**
  String get collections;

  /// No description provided for @fullSelection.
  ///
  /// In en, this message translates to:
  /// **'Full selection'**
  String get fullSelection;

  /// No description provided for @fullSelectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Requires elements to be fully within the selection box for selection.'**
  String get fullSelectionDescription;

  /// No description provided for @collection.
  ///
  /// In en, this message translates to:
  /// **'Collection'**
  String get collection;

  /// No description provided for @defaultCollection.
  ///
  /// In en, this message translates to:
  /// **'Default collection'**
  String get defaultCollection;

  /// No description provided for @scroll.
  ///
  /// In en, this message translates to:
  /// **'Scroll'**
  String get scroll;

  /// No description provided for @onStartup.
  ///
  /// In en, this message translates to:
  /// **'On startup'**
  String get onStartup;

  /// No description provided for @homeScreen.
  ///
  /// In en, this message translates to:
  /// **'Home screen'**
  String get homeScreen;

  /// No description provided for @lastNote.
  ///
  /// In en, this message translates to:
  /// **'Last note'**
  String get lastNote;

  /// No description provided for @newNote.
  ///
  /// In en, this message translates to:
  /// **'New note'**
  String get newNote;

  /// No description provided for @convertToLayer.
  ///
  /// In en, this message translates to:
  /// **'Convert to layer'**
  String get convertToLayer;

  /// No description provided for @merge.
  ///
  /// In en, this message translates to:
  /// **'Merge'**
  String get merge;

  /// No description provided for @up.
  ///
  /// In en, this message translates to:
  /// **'Up'**
  String get up;

  /// No description provided for @down.
  ///
  /// In en, this message translates to:
  /// **'Down'**
  String get down;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @countElements.
  ///
  /// In en, this message translates to:
  /// **'{count,plural, =0{No elements} =1{1 element} other{{count} elements}}'**
  String countElements(int count);

  /// No description provided for @colorToolbar.
  ///
  /// In en, this message translates to:
  /// **'Color toolbar'**
  String get colorToolbar;

  /// No description provided for @yesButShowButtons.
  ///
  /// In en, this message translates to:
  /// **'Yes, but show buttons'**
  String get yesButShowButtons;

  /// No description provided for @optionsPanelPosition.
  ///
  /// In en, this message translates to:
  /// **'Options panel position'**
  String get optionsPanelPosition;

  /// No description provided for @hideDuration.
  ///
  /// In en, this message translates to:
  /// **'Hide duration'**
  String get hideDuration;

  /// No description provided for @animation.
  ///
  /// In en, this message translates to:
  /// **'Animation'**
  String get animation;

  /// No description provided for @performance.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performance;

  /// No description provided for @performanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Optimized for speed and memory usage. Only the visible portion of the note is baked into the image.'**
  String get performanceDescription;

  /// No description provided for @normalDescription.
  ///
  /// In en, this message translates to:
  /// **'Balances quality and performance. Bakes an image covering 1.5 times the visible area, providing smoother transitions when scrolling.'**
  String get normalDescription;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @highDescription.
  ///
  /// In en, this message translates to:
  /// **'Description: Maximizes quality at the cost of performance. Bakes an image covering 2 times the visible area, ensuring seamless rendering even during rapid scrolling or zooming.'**
  String get highDescription;

  /// No description provided for @renderResolution.
  ///
  /// In en, this message translates to:
  /// **'Render resolution'**
  String get renderResolution;

  /// No description provided for @translate.
  ///
  /// In en, this message translates to:
  /// **'Translate'**
  String get translate;

  /// No description provided for @unencrypted.
  ///
  /// In en, this message translates to:
  /// **'Unencrypted'**
  String get unencrypted;

  /// No description provided for @encrypted.
  ///
  /// In en, this message translates to:
  /// **'Encrypted'**
  String get encrypted;

  /// No description provided for @encryptDocumentMessage.
  ///
  /// In en, this message translates to:
  /// **'Click to encrypt the document'**
  String get encryptDocumentMessage;

  /// No description provided for @unencryptDocumentMessage.
  ///
  /// In en, this message translates to:
  /// **'Click to unencrypt the document'**
  String get unencryptDocumentMessage;

  /// No description provided for @unencrypt.
  ///
  /// In en, this message translates to:
  /// **'Unencrypt'**
  String get unencrypt;

  /// No description provided for @encrypt.
  ///
  /// In en, this message translates to:
  /// **'Encrypt'**
  String get encrypt;

  /// No description provided for @encryptWarning.
  ///
  /// In en, this message translates to:
  /// **'This will encrypt the document. You will need to remember the password to decrypt it.'**
  String get encryptWarning;

  /// No description provided for @unencryptWarning.
  ///
  /// In en, this message translates to:
  /// **'This will unencrypt the document. The password will be removed and everyone with access will be able to open it.'**
  String get unencryptWarning;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmPassword;

  /// No description provided for @passwordMismatch.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match'**
  String get passwordMismatch;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @svgText.
  ///
  /// In en, this message translates to:
  /// **'SVG Text'**
  String get svgText;

  /// No description provided for @offset.
  ///
  /// In en, this message translates to:
  /// **'Offset'**
  String get offset;

  /// No description provided for @positionDependent.
  ///
  /// In en, this message translates to:
  /// **'Position dependent'**
  String get positionDependent;

  /// No description provided for @flipHorizontal.
  ///
  /// In en, this message translates to:
  /// **'Flip horizontal'**
  String get flipHorizontal;

  /// No description provided for @flipVertical.
  ///
  /// In en, this message translates to:
  /// **'Flip vertical'**
  String get flipVertical;

  /// No description provided for @grayscale.
  ///
  /// In en, this message translates to:
  /// **'Grayscale'**
  String get grayscale;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
        'af',
        'ar',
        'ca',
        'cs',
        'da',
        'de',
        'el',
        'en',
        'es',
        'fi',
        'fr',
        'he',
        'hi',
        'hu',
        'it',
        'ja',
        'ko',
        'nl',
        'no',
        'or',
        'pl',
        'pt',
        'ro',
        'ru',
        'sr',
        'sv',
        'th',
        'tr',
        'uk',
        'vi',
        'zh'
      ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+script codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.scriptCode) {
          case 'Hant':
            return AppLocalizationsZhHant();
        }
        break;
      }
  }

  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'pt':
      {
        switch (locale.countryCode) {
          case 'BR':
            return AppLocalizationsPtBr();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return AppLocalizationsAf();
    case 'ar':
      return AppLocalizationsAr();
    case 'ca':
      return AppLocalizationsCa();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'hi':
      return AppLocalizationsHi();
    case 'hu':
      return AppLocalizationsHu();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
    case 'nl':
      return AppLocalizationsNl();
    case 'no':
      return AppLocalizationsNo();
    case 'or':
      return AppLocalizationsOr();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'ru':
      return AppLocalizationsRu();
    case 'sr':
      return AppLocalizationsSr();
    case 'sv':
      return AppLocalizationsSv();
    case 'th':
      return AppLocalizationsTh();
    case 'tr':
      return AppLocalizationsTr();
    case 'uk':
      return AppLocalizationsUk();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
