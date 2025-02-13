// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get open => 'Abrir';

  @override
  String get settings => 'Ajustes';

  @override
  String get personalization => 'Personalización';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Tema oscuro';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get systemTheme => 'Usar tema de sistema por defecto';

  @override
  String get view => 'Ver';

  @override
  String get edit => 'Editar';

  @override
  String get export => 'Exportar';

  @override
  String get save => 'Guardar';

  @override
  String get zoom => 'Aceros';

  @override
  String get zoomIn => 'Acercarse en';

  @override
  String get zoomOut => 'Apagar';

  @override
  String get resetZoom => 'Reset zoom';

  @override
  String get strokeWidth => 'Ancho del trazo';

  @override
  String get includeEraser => '¿Incluye borrador?';

  @override
  String get thinning => 'Lanzamiento';

  @override
  String get pen => 'Pen';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Borrador de ruta';

  @override
  String get label => 'Etiqueta';

  @override
  String get delete => 'Eliminar';

  @override
  String get areYouSure => '¿Estás seguro?';

  @override
  String get reallyDelete => '¿Realmente desea eliminar este elemento?';

  @override
  String get no => 'Nu';

  @override
  String get yes => 'Sí';

  @override
  String get undo => 'Deshacer';

  @override
  String get redo => 'Rehacer';

  @override
  String get general => 'General';

  @override
  String get copyTitle => 'Copiado al portapapeles';

  @override
  String get loading => 'Cargando...';

  @override
  String get enterText => 'Introduzca el texto';

  @override
  String get size => 'Tamaño';

  @override
  String get width => 'Width';

  @override
  String get height => 'Altura';

  @override
  String get count => 'Contador';

  @override
  String get space => 'Espacio';

  @override
  String get background => 'Fondo';

  @override
  String get box => 'Caja';

  @override
  String get locale => 'Local';

  @override
  String get systemLocale => 'Localización del sistema';

  @override
  String get information => 'Información';

  @override
  String get license => 'Licencia';

  @override
  String get imprint => 'Aviso';

  @override
  String get privacypolicy => 'Política de privacidad';

  @override
  String get source => 'Fuente';

  @override
  String get documentation => 'Documentación';

  @override
  String get changelog => 'Cambios';

  @override
  String get existOverride => 'Este elemento ya existe. ¿Sobrescribir?';

  @override
  String get description => 'Descripción';

  @override
  String get fill => 'Rellenar';

  @override
  String get defaultPalette => 'Paleta por defecto';

  @override
  String get highlighter => 'Resaltado';

  @override
  String get add => 'Añadir';

  @override
  String get remove => 'Eliminar';

  @override
  String get removeConfirm => '¿Realmente quieres eliminar esto?';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => 'Personalizado';

  @override
  String get decoration => 'Decoración';

  @override
  String get underline => 'Bajo línea';

  @override
  String get overline => 'Superlínea';

  @override
  String get strikethrough => 'Tachado';

  @override
  String get thickness => 'Grosor';

  @override
  String get style => 'Estilo';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Doble';

  @override
  String get dotted => 'Punteado';

  @override
  String get dashed => 'Limpiado';

  @override
  String get wavy => 'Onda';

  @override
  String get fontWeight => 'Peso de fuente';

  @override
  String get normal => 'Normal';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Portapapeles';

  @override
  String get file => 'Fichero';

  @override
  String get data => 'Datos';

  @override
  String get share => 'Compartir';

  @override
  String get spacing => 'Espaciado';

  @override
  String get image => 'Imagen';

  @override
  String get enterUrl => 'Introduzca la url';

  @override
  String get scale => 'Escala';

  @override
  String get help => 'Ayuda';

  @override
  String get reallyReset => '¿Realmente desea restablecerlo?';

  @override
  String get whatToDo => '¿Qué quieres hacer?';

  @override
  String get ignore => 'Ignorar';

  @override
  String get backup => 'Respaldo';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'El archivo $fileName fue creado en una versión más reciente ($fileVersion). ¿Qué se debe hacer con este archivo?';
  }

  @override
  String get waypoints => 'Waypoints';

  @override
  String get origin => 'Origen';

  @override
  String get import => 'Importar';

  @override
  String get newContent => 'Nuevo';

  @override
  String get selectElement => 'Seleccionar elemento';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Cambio';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Copiar versión';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Comportamientos';

  @override
  String get dataDirectory => 'Directorio de datos';

  @override
  String get defaultPath => 'Ruta por defecto';

  @override
  String get dateFormat => 'Formato de fecha';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Actualizado en: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Creado el: $dateTimeString';
  }

  @override
  String get rename => 'Renombrar';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => 'Mano';

  @override
  String get folder => 'Carpeta';

  @override
  String get move => 'Mover';

  @override
  String get copy => 'Copiar';

  @override
  String get back => 'Atrás';

  @override
  String get zoomDependent => 'Dependiente de zoom';

  @override
  String get shapeDetection => 'Detección de forma';

  @override
  String get delay => 'Retraso';

  @override
  String get defaultLayer => 'Capa por defecto';

  @override
  String get layer => 'Capa';

  @override
  String get layers => 'Capas';

  @override
  String get notSet => 'No establecido';

  @override
  String get enterLayer => 'Introduzca el nombre de la capa';

  @override
  String get selectElements => 'Seleccionar elementos';

  @override
  String get deleteElements => 'Eliminar elementos';

  @override
  String get deleteElementsConfirm =>
      '¿Realmente desea eliminar los elementos seleccionados?';

  @override
  String get selectCustomCollection => 'Seleccione una colección personalizada';

  @override
  String get svg => 'SVG';

  @override
  String get sensitivity => 'Sensibilidad';

  @override
  String get sensitivityHint =>
      'Cuanto más alto sea el valor, más sensible será la entrada';

  @override
  String get horizontal => 'Horizontal';

  @override
  String get vertical => 'Vertical';

  @override
  String get plain => 'Simple';

  @override
  String get light => 'Claro';

  @override
  String get ruled => 'Reglas';

  @override
  String get quad => 'Cuádruple';

  @override
  String get music => 'Música';

  @override
  String get dark => 'Oscuro';

  @override
  String get plainDark => 'Oscuro';

  @override
  String get ruledDark => 'Reglas oscuras';

  @override
  String get quadDark => 'Cuadro oscuro';

  @override
  String get musicDark => 'Música oscura';

  @override
  String get templates => 'Plantillas';

  @override
  String get untitled => 'Sin título';

  @override
  String get createTemplate => 'Crear plantilla';

  @override
  String get createTemplateContent =>
      '¿Realmente desea crear una plantilla de este documento? Se eliminará el documento original.';

  @override
  String get replace => 'Reemplazar';

  @override
  String get reallyReplace =>
      '¿Realmente desea reemplazar la plantilla? ¡Esta operación no se puede deshacer!';

  @override
  String get defaultTemplate => 'Plantilla por defecto';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'Documento';

  @override
  String get camera => 'Cámara';

  @override
  String get printout => 'Imprimir';

  @override
  String get selectCamera => 'Seleccione una cámara';

  @override
  String get changeDocumentPath => 'Cambiar ruta del documento';

  @override
  String get deleteWholeStroke => 'Borrar todo el trazo';

  @override
  String get alpha => 'Alfa';

  @override
  String get area => 'Área';

  @override
  String get selectArea => 'Seleccione un área';

  @override
  String get aspectRatio => 'Relación de aspecto';

  @override
  String get presets => 'Preajustes';

  @override
  String get pagePortrait => 'Retrato de página';

  @override
  String get pageLandscape => 'Paisaje de página';

  @override
  String get square => 'Cuadrado';

  @override
  String get areas => 'Áreas';

  @override
  String get enterArea => 'Entrar en el área';

  @override
  String get exitArea => 'Salir del área';

  @override
  String get currentArea => 'Área actual';

  @override
  String get design => 'Diseño';

  @override
  String get text => 'Texto';

  @override
  String welcome(String codeName) {
    return 'Hola, esta es la mariposa de Linwood';
  }

  @override
  String get welcomeContent =>
      'Un espacio de dibujo libre y de código abierto!';

  @override
  String updated(String version) {
    return 'Aplicación actualizada a la versión $version';
  }

  @override
  String get releaseNotes => 'Notas de lanzamiento';

  @override
  String get constraints => 'Restricciones';

  @override
  String get scaled => 'Escalado';

  @override
  String get fixed => 'Fijado';

  @override
  String get dynamicContent => 'Dinámica';

  @override
  String get none => 'Ninguna';

  @override
  String get includeArea => 'Incluye área';

  @override
  String get verticalAlignment => 'Alineación vertical';

  @override
  String get horizontalAlignment => 'Alineación horizontal';

  @override
  String get top => 'Subir';

  @override
  String get center => 'Centrar';

  @override
  String get bottom => 'Abajo';

  @override
  String get left => 'Queda';

  @override
  String get right => 'Derecha';

  @override
  String get justify => 'Justificar';

  @override
  String get constraint => 'Restricción';

  @override
  String get length => 'Longitud';

  @override
  String get exportSvg => 'Exportar SVG';

  @override
  String get pdf => 'DF';

  @override
  String get selectPages => 'Seleccionar páginas';

  @override
  String get recentFiles => 'Archivos recientes';

  @override
  String get start => 'Comenzar';

  @override
  String get noRecentFiles => 'No hay archivos recientes';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count páginas',
      one: '1 página',
      zero: 'No hay páginas',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Página $index';
  }

  @override
  String get exit => 'Salir';

  @override
  String get noElements => 'No hay elementos';

  @override
  String get invertSelection => 'Invertir selección';

  @override
  String get errorWhileImporting => 'Error al importar';

  @override
  String get errorWhileImportingContent =>
      'Se ha producido un error al importar el archivo';

  @override
  String get showDetails => 'Mostrar detalles';

  @override
  String get hideDetails => 'Ocultar detalles';

  @override
  String get error => 'Error';

  @override
  String get stackTrace => 'Traza de la pila';

  @override
  String get laser => 'Láser';

  @override
  String get duration => 'Duración';

  @override
  String get quality => 'Calidad';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get local => 'Local';

  @override
  String get addConnection => 'Añadir conexión';

  @override
  String get connections => 'Conexiones';

  @override
  String get noConnections => 'No hay conexiones';

  @override
  String get url => 'URL';

  @override
  String get connect => 'Conectar';

  @override
  String get username => 'Usuario';

  @override
  String get password => 'Contraseña';

  @override
  String get webNotSupported => 'Web no soportada';

  @override
  String get advanced => 'Avanzado';

  @override
  String get directory => 'Directorio';

  @override
  String get documentsDirectory => 'Directorio de documentos';

  @override
  String get templatesDirectory => 'Directorio de plantillas';

  @override
  String get errorWhileCreatingConnection => 'Error al crear la conexión';

  @override
  String get cannotConnect => 'No se puede conectar';

  @override
  String get urlNotValid => 'URL no válida';

  @override
  String get icon => 'Icono';

  @override
  String get update => 'Actualizar';

  @override
  String get updateAvailable => 'Actualización disponible';

  @override
  String get stable => 'Estable';

  @override
  String get nightly => 'Noche';

  @override
  String get checkForUpdates => 'Buscar actualizaciones';

  @override
  String get checkForUpdatesWarning =>
      'Realizar una comprobación de actualizaciones se conectará al sitio web de Butterfly para obtener la información.';

  @override
  String get usingLatestStable => 'Estás usando la última versión estable';

  @override
  String get usingLatestNightly => 'Estás usando la última versión nocturna';

  @override
  String get currentVersion => 'Versión actual';

  @override
  String get updateNow => 'Actualizar ahora';

  @override
  String get shape => 'Forma';

  @override
  String get circle => 'Círculo';

  @override
  String get rectangle => 'Rectángulo';

  @override
  String get triangle => 'Triángulo';

  @override
  String get line => 'Línea';

  @override
  String get cornerRadius => 'Radio de esquina';

  @override
  String get topLeft => 'Arriba izquierda';

  @override
  String get topRight => 'Arriba derecha';

  @override
  String get bottomLeft => 'Bottom izquierdo';

  @override
  String get bottomRight => 'Botón derecho';

  @override
  String get caches => 'Cachés';

  @override
  String get manage => 'Gestionar';

  @override
  String get clearCaches => 'Borrar cachés';

  @override
  String get createCache => 'Crear caché';

  @override
  String get thirdPartyLicenses => 'Licencias de terceros';

  @override
  String get syncing => 'Sincronizando...';

  @override
  String get synced => 'Sincronizado';

  @override
  String get notSynced => 'No sincronizado';

  @override
  String get conflict => 'Conflicto';

  @override
  String get keepLocal => 'Mantener local';

  @override
  String get keepConnection => 'Mantener conexión';

  @override
  String get keepBoth => 'Mantener ambos';

  @override
  String get forAll => 'Para todos';

  @override
  String fileConflict(String file, String connection) {
    return '$file en $connection tiene un conflicto';
  }

  @override
  String get offline => 'Desconectado';

  @override
  String get localLatest => 'Último local';

  @override
  String get connectionLatest => 'Conexión última';

  @override
  String get path => 'Ruta';

  @override
  String get folderSynced => 'Carpeta sincronizada';

  @override
  String get syncRootDirectory => 'Directorio raíz de sincronización';

  @override
  String get penOnlyInput => 'Entrada de Pen sólo';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Barra de título nativa';

  @override
  String get syncMode => 'Modo de sincronización';

  @override
  String get connection => 'Conexión';

  @override
  String get always => 'Siempre';

  @override
  String get noMobile => 'Sin móvil';

  @override
  String get manual => 'Manual';

  @override
  String get search => 'Buscar';

  @override
  String get properties => 'Propiedades';

  @override
  String get pin => 'Fijar';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Elemento';

  @override
  String get painter => 'Pintor';

  @override
  String get position => 'Posición';

  @override
  String get note => 'Nota';

  @override
  String get packs => 'Paquetes';

  @override
  String get pack => 'Pack';

  @override
  String get more => 'Más';

  @override
  String get askForName => 'Solicitar nombre';

  @override
  String areaIndex(int index) {
    return 'Área $index';
  }

  @override
  String get startInFullScreen => 'Iniciar en pantalla completa';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Ratón';

  @override
  String get touch => 'Pulsar';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Atajos';

  @override
  String get middle => 'Medio';

  @override
  String get first => 'Primero';

  @override
  String get second => 'Segundo';

  @override
  String get tools => 'Herramientas';

  @override
  String get showGrid => 'Mostrar cuadrícula';

  @override
  String get grid => 'Rejilla';

  @override
  String get ruler => 'Regla';

  @override
  String get angle => 'Ángulo';

  @override
  String get report => 'Reporte';

  @override
  String get newFolder => 'Nueva carpeta';

  @override
  String get createPack => 'Crear paquete';

  @override
  String get editPack => 'Editar pack';

  @override
  String get packsDirectory => 'Directorio de paquetes';

  @override
  String get stamp => 'Sello';

  @override
  String get addToPack => 'Añadir al paquete';

  @override
  String get sureImportPack =>
      '¿Estás seguro de que quieres importar el paquete?';

  @override
  String byAuthor(String author) {
    return 'por $author';
  }

  @override
  String get author => 'Autor';

  @override
  String get addAsset => 'Añadir recurso';

  @override
  String get editAsset => 'Editar recurso';

  @override
  String get scope => 'Alcance';

  @override
  String get noPacks => 'Actualmente no hay paquetes disponibles';

  @override
  String get components => 'Componentes';

  @override
  String get waypoint => 'Waypoint';

  @override
  String get actions => 'Acciones';

  @override
  String get painters => 'Pintores';

  @override
  String get breakingChangesTitle => 'Cambios de ruptura';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Hay cambios que se están rompiendo en esta versión. Por favor, lea el registro de cambios antes de actualizar. La versión actual del archivo es $version, la nueva versión es $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Párrafo';

  @override
  String get fontFamily => 'Familia de fuente';

  @override
  String get smoothing => 'Suavizado';

  @override
  String get streamline => 'Streamline';

  @override
  String get presentation => 'Presentación';

  @override
  String get selectAsset => 'Seleccionar recurso';

  @override
  String get clearStyle => 'Borrar estilo';

  @override
  String get unknownImportType => 'Tipo de importación desconocido';

  @override
  String get sureImportTemplate =>
      '¿Está seguro que desea importar la plantilla?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Jugar';

  @override
  String get video => 'Vídeo';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Breakpoint';

  @override
  String get presentationControls => 'Controles de presentación';

  @override
  String get nextSlide => 'Siguiente diapositiva';

  @override
  String get nextSlideDescription =>
      'Deslice a la derecha o presione la tecla de la flecha derecha para ir a la siguiente diapositiva';

  @override
  String get previousSlide => 'Diapositiva anterior';

  @override
  String get previousSlideDescription =>
      'Deslice hacia la izquierda o presione la tecla de la flecha izquierda para ir a la diapositiva anterior';

  @override
  String get exitPresentation => 'Salir de la presentación';

  @override
  String get exitPresentationDescription =>
      'Pulsa la tecla de escape o desliza hacia abajo para salir de la presentación';

  @override
  String get pausePresentation => 'Pausar presentación';

  @override
  String get pausePresentationDescription =>
      'Toca la pantalla o presiona la barra espaciadora para pausar o reanudar la presentación';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'Ha llegado al final de la presentación';

  @override
  String get startOfPresentation => 'Ha llegado al inicio de la presentación';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Encabezado $index';
  }

  @override
  String get code => 'Código';

  @override
  String get quote => 'Cotización';

  @override
  String get link => 'Enlace';

  @override
  String get checkbox => 'Casilla';

  @override
  String get deleted => 'Eliminado';

  @override
  String get emphasis => 'Vacío';

  @override
  String get listBullet => 'Lista de bala';

  @override
  String get strong => 'Fuerte';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Inicio';

  @override
  String get files => 'Archivos';

  @override
  String get sortBy => 'Ordenar por';

  @override
  String get location => 'Ubicación';

  @override
  String get whatsNew => '¿Qué hay de nuevo?';

  @override
  String get unstar => 'No estrella';

  @override
  String get star => 'Estrella';

  @override
  String get goUp => 'Subir';

  @override
  String get created => 'Creado';

  @override
  String get modified => 'Modificado';

  @override
  String get quickstart => 'Inicio rápido';

  @override
  String get noTemplates => 'Actualmente no hay plantillas disponibles';

  @override
  String get importCorePack => 'Importar paquete del núcleo';

  @override
  String get importCorePackDescription =>
      'Importar el paquete base que contiene todos los activos básicos para empezar. Esto anulará el paquete del núcleo actual.';

  @override
  String get never => 'Nunca';

  @override
  String get onlyOnUpdates => 'Sólo en actualizaciones';

  @override
  String get visibility => 'Visibilidad';

  @override
  String get captureThumbnail => 'Capturar miniatura';

  @override
  String get capturedThumbnail => 'Miniatura capturada con éxito';

  @override
  String get chooseLabelMode => 'Elegir modo de etiqueta';

  @override
  String get foreground => 'Primer plano';

  @override
  String get version => 'Versión';

  @override
  String get repository => 'Repositorio';

  @override
  String get pages => 'Páginas';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Ordenar';

  @override
  String get bringToFront => 'Traer al frente';

  @override
  String get sendToBack => 'Enviar al reverso';

  @override
  String get bringForward => 'Avanzar';

  @override
  String get sendBackward => 'Enviar atrás';

  @override
  String get rotation => 'Rotación';

  @override
  String get onlyAvailableLargerScreen =>
      'Sólo disponible en pantallas más grandes';

  @override
  String get toolbarPosition => 'Posición de barra de herramientas';

  @override
  String get rotate => 'Rotar';

  @override
  String get spacer => 'Espaciador';

  @override
  String get navigationRail => 'Raíl de navegación';

  @override
  String get cut => 'Cortar';

  @override
  String get insertBefore => 'Insertar antes';

  @override
  String get insertAfter => 'Insertar después';

  @override
  String get insertFirst => 'Insertar primero';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Pegar';

  @override
  String get ascending => 'Ascendente';

  @override
  String get descending => 'Descendente';

  @override
  String get imageScale => 'Escala de imagen';

  @override
  String get select => 'Seleccionar';

  @override
  String get tool => 'Herramienta';

  @override
  String get texture => 'Textura';

  @override
  String get platformTheme => 'Tema de la plataforma';

  @override
  String get desktop => 'Escritorio';

  @override
  String get mobile => 'Móvil';

  @override
  String get pdfQuality => 'Calidad PDF';

  @override
  String get surface => 'Superficie';

  @override
  String get pattern => 'Patrón';

  @override
  String get sureClose => '¿Está seguro que desea cerrar el documento?';

  @override
  String get thereAreUnsavedChanges => 'Hay cambios sin guardar';

  @override
  String get page => 'Pgina';

  @override
  String get iceServers => 'Servidores ICE';

  @override
  String get collaboration => 'Colaboración';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Socket Web';

  @override
  String get iceServer => 'Servidor ICE';

  @override
  String get port => 'Puerto';

  @override
  String get type => 'Tipo';

  @override
  String get side => 'Lado';

  @override
  String get client => 'Cliente';

  @override
  String get server => 'Servidor';

  @override
  String get switchView => 'Cambiar vista';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'Ocultar IU';

  @override
  String get density => 'Densidad';

  @override
  String get compact => 'Compacto';

  @override
  String get comfortable => 'Confortable';

  @override
  String get standard => 'Estándar';

  @override
  String get lock => 'Bloquear';

  @override
  String get addElement => 'Añadir elemento';

  @override
  String get notDefaultConnection => 'Conexión por defecto';

  @override
  String get defaultConnection => 'Conexión por defecto';

  @override
  String get hide => 'Ocultar';

  @override
  String get show => 'Mostrar';

  @override
  String get pause => 'Pausa';

  @override
  String get stop => 'Parar';

  @override
  String get refresh => 'Refrescar';

  @override
  String get print => 'Imprimir';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Soltador de ojos';

  @override
  String get users => 'Usuarios';

  @override
  String get experiments => 'Experimentos';

  @override
  String get address => 'Dirección';

  @override
  String get spreadToPages => 'Difundir en páginas';

  @override
  String get rootDirectorySpecifiedDescription =>
      'Se ha especificado el directorio raíz. Todas las rutas de directorios avanzados serán relativas a este directorio. Manténgalo vacío para desactivar este tipo de directorio.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'No se ha especificado el directorio raíz. Se requiere un nombre. Todas las rutas de directorio avanzadas serán absolutas. Manténgalo vacío para desactivar este tipo de directorio.';

  @override
  String get unsecureConnectionTitle => 'Conexión no segura';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'La conexión no es segura. Esto puede ser un riesgo de seguridad. Por favor, continúa solo si confías en la conexión. La huella dactilar sha1 es $fingerprint.';
  }

  @override
  String get continueAnyway => 'Continuar de todos modos';

  @override
  String get zoomControl => 'Control de zoom';

  @override
  String get highContrast => 'Alto contraste';

  @override
  String get shouldANumber => 'Este valor debe ser un número válido';

  @override
  String get createAreas => 'Crear áreas';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Operaciones';

  @override
  String get medium => 'Medio';

  @override
  String get large => 'Grande';

  @override
  String get toolbarSize => 'Tamaño de barra de herramientas';

  @override
  String get addAll => 'Añadir todo';

  @override
  String get onlyCurrentPage => 'Sólo página actual';

  @override
  String get smoothNavigation => 'Navegación suave';

  @override
  String get exact => 'Exacto';

  @override
  String get inline => 'En línea';

  @override
  String get toolbarRows => 'Filas de herramienta';

  @override
  String get pointerTest => 'Prueba de puntero';

  @override
  String get pressure => 'Presión';

  @override
  String get small => 'Pequeño';

  @override
  String get tiny => 'Pequeño';

  @override
  String get selectAll => 'Seleccionar todo';

  @override
  String get overrideTools => 'Anular herramientas';

  @override
  String get hideCursorWhileDrawing => 'Ocultar cursor al dibujar';

  @override
  String get installed => 'Instalado';

  @override
  String get install => 'Instalar';

  @override
  String get deselect => 'Deseleccionar';

  @override
  String get changeCollection => 'Cambiar colección';

  @override
  String get collections => 'Colecciones';

  @override
  String get fullSelection => 'Selección completa';

  @override
  String get fullSelectionDescription =>
      'Requiere que los elementos estén completamente dentro del cuadro de selección para la selección.';

  @override
  String get collection => 'Colección';

  @override
  String get defaultCollection => 'Colección por defecto';

  @override
  String get scroll => 'Desplazar';

  @override
  String get onStartup => 'Al iniciar';

  @override
  String get homeScreen => 'Pantalla de inicio';

  @override
  String get lastNote => 'Última nota';

  @override
  String get newNote => 'Nueva nota';

  @override
  String get convertToLayer => 'Convertir a capa';

  @override
  String get merge => 'Combinar';

  @override
  String get up => 'Subir';

  @override
  String get down => 'Abajo';

  @override
  String get other => 'Otro';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Elementos',
      one: '1 elemento',
      zero: 'No hay elementos',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Barra de colores';

  @override
  String get yesButShowButtons => 'Sí, pero mostrar botones';

  @override
  String get optionsPanelPosition => 'Posición del panel de opciones';

  @override
  String get hideDuration => 'Ocultar duración';

  @override
  String get animation => 'Animación';

  @override
  String get performance => 'Rendimiento';

  @override
  String get performanceDescription =>
      'Optimizada para el uso de velocidad y memoria.';

  @override
  String get normalDescription =>
      'Equilibra calidad y rendimiento. Toma una imagen cubriendo 1,5 veces la zona visible, proporcionando transiciones más suaves cuando se desplaza.';

  @override
  String get high => 'Alta';

  @override
  String get highDescription =>
      'Descripción: Maximiza la calidad al coste del rendimiento. Hace una imagen cubriendo 2 veces la zona visible, asegurando un renderizado sin costuras incluso durante un desplazamiento rápido o zooming.';

  @override
  String get renderResolution => 'Procesar resolución';

  @override
  String get translate => 'Traducir';

  @override
  String get unencrypted => 'Sin cifrar';

  @override
  String get encrypted => 'Cifrado';

  @override
  String get encryptDocumentMessage => 'Haga clic para cifrar el documento';

  @override
  String get unencryptDocumentMessage =>
      'Haga clic para descifrar el documento';

  @override
  String get unencrypt => 'Descifrar';

  @override
  String get encrypt => 'Cifrar';

  @override
  String get encryptWarning =>
      'Esto cifrará el documento. Necesitará recordar la contraseña para descifrarlo.';

  @override
  String get unencryptWarning =>
      'Esto descifrará el documento. La contraseña se eliminará y todos los que tengan acceso podrán abrirla.';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get passwordMismatch => 'Las contraseñas no coinciden';

  @override
  String get action => 'Accin';

  @override
  String get svgText => 'Texto SVG';

  @override
  String get offset => 'Desplazamiento';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}
