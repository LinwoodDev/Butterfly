// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get open => 'Abertas';

  @override
  String get settings => 'Confirgurações';

  @override
  String get personalization => 'Personalização';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Tema escuro';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get systemTheme => 'Usar tema padrão do sistema';

  @override
  String get view => 'Visualizar';

  @override
  String get edit => 'Alterar';

  @override
  String get export => 'Exportação';

  @override
  String get save => 'Guardar';

  @override
  String get zoom => 'Ampliar';

  @override
  String get zoomIn => 'Aumentar zoom';

  @override
  String get zoomOut => 'Diminuir zoom';

  @override
  String get resetZoom => 'Reset zoom';

  @override
  String get strokeWidth => 'Largura do traço';

  @override
  String get includeEraser => 'Incluir borracha?';

  @override
  String get thinning => 'Pensamento';

  @override
  String get pen => 'Caneta';

  @override
  String get eraser => 'Eraser';

  @override
  String get pathEraser => 'Erro de caminho';

  @override
  String get label => 'Descrição';

  @override
  String get delete => 'excluir';

  @override
  String get areYouSure => 'Você tem certeza?';

  @override
  String get reallyDelete => 'Você realmente deseja excluir este item?';

  @override
  String get no => 'Não';

  @override
  String get yes => 'sim';

  @override
  String get undo => 'Desfazer';

  @override
  String get redo => 'Refazer';

  @override
  String get general => 'Gerais';

  @override
  String get copyTitle => 'Copiado para o clipboard';

  @override
  String get loading => 'Carregandochar@@0';

  @override
  String get enterText => 'Digite o texto';

  @override
  String get size => 'Tamanho';

  @override
  String get width => 'Width';

  @override
  String get height => 'Altura';

  @override
  String get count => 'Quantidade';

  @override
  String get space => 'Sala';

  @override
  String get background => 'Fundo';

  @override
  String get box => 'Cx';

  @override
  String get locale => 'Localidade';

  @override
  String get systemLocale => 'Localização do sistema';

  @override
  String get information => 'Informacao';

  @override
  String get license => 'Tipo:';

  @override
  String get imprint => 'Imprimir';

  @override
  String get privacypolicy => 'Política de privacidade';

  @override
  String get source => 'fonte';

  @override
  String get documentation => 'Documentação';

  @override
  String get changelog => 'Mudanças';

  @override
  String get existOverride => 'Este elemento já existe. Sobrescrever?';

  @override
  String get description => 'Descrição:';

  @override
  String get fill => 'Preencher';

  @override
  String get defaultPalette => 'Paleta padrão';

  @override
  String get highlighter => 'Destaque';

  @override
  String get add => 'Adicionar';

  @override
  String get remove => 'Excluir';

  @override
  String get removeConfirm => 'Você realmente deseja remover isto?';

  @override
  String get resetPalette => 'Reset palette';

  @override
  String get custom => 'Personalizado';

  @override
  String get decoration => 'Decoração';

  @override
  String get underline => 'Sublinhar';

  @override
  String get overline => 'Sobrenome';

  @override
  String get strikethrough => 'Riscado';

  @override
  String get thickness => 'Espessura';

  @override
  String get style => 'Estilo';

  @override
  String get solid => 'Solid';

  @override
  String get double => 'Duplo';

  @override
  String get dotted => 'Pontilhado';

  @override
  String get dashed => 'Tracejado';

  @override
  String get wavy => 'Onda';

  @override
  String get fontWeight => 'Peso da fonte';

  @override
  String get normal => 'normal';

  @override
  String get bold => 'Bold';

  @override
  String get italic => 'Italic';

  @override
  String get clipboard => 'Área';

  @override
  String get file => 'Arquivo';

  @override
  String get data => 'Dado';

  @override
  String get share => 'Compartilhar';

  @override
  String get spacing => 'Espaçamento';

  @override
  String get image => 'Imagem:';

  @override
  String get enterUrl => 'Digite a URL';

  @override
  String get scale => 'Escala';

  @override
  String get help => 'Socorro';

  @override
  String get reallyReset => 'Você realmente quer redefini-lo?';

  @override
  String get whatToDo => 'O que você quer fazer?';

  @override
  String get ignore => 'Ignorar';

  @override
  String get backup => 'Backup';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'O arquivo $fileName foi criado em uma versão mais recente ($fileVersion). O que deve ser feito com esse arquivo?';
  }

  @override
  String get waypoints => 'Pontos';

  @override
  String get origin => 'Origem';

  @override
  String get import => 'Importação';

  @override
  String get newContent => 'Novidades';

  @override
  String get selectElement => 'Selecionar elemento';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Turno';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Copiar versão';

  @override
  String get input => 'Input';

  @override
  String get behaviors => 'Comportamentos';

  @override
  String get dataDirectory => 'Diretório de dados';

  @override
  String get defaultPath => 'Caminho padrão';

  @override
  String get dateFormat => 'Formato da Data';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Atualizado em: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Criado em: $dateTimeString';
  }

  @override
  String get rename => 'Renomear';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get hand => 'Mão';

  @override
  String get folder => 'pasta';

  @override
  String get move => 'Mover-se';

  @override
  String get copy => 'copiar';

  @override
  String get back => 'Anterior';

  @override
  String get zoomDependent => 'Dependendo do zoom';

  @override
  String get shapeDetection => 'Detecção de forma';

  @override
  String get delay => 'Atraso';

  @override
  String get defaultLayer => 'Camada padrão';

  @override
  String get layer => 'Camada';

  @override
  String get layers => 'Camadas';

  @override
  String get notSet => 'Não definido';

  @override
  String get enterLayer => 'Digite o nome da camada';

  @override
  String get selectElements => 'Selecione elementos';

  @override
  String get deleteElements => 'Excluir elementos';

  @override
  String get deleteElementsConfirm =>
      'Você realmente deseja excluir os elementos selecionados?';

  @override
  String get selectCustomCollection => 'Selecione uma coleção personalizada';

  @override
  String get svg => 'Svg';

  @override
  String get sensitivity => 'Sensibilidade';

  @override
  String get sensitivityHint =>
      'Quanto maior o valor, mais sensível o valor de entrada';

  @override
  String get horizontal => 'Horizontal';

  @override
  String get vertical => 'Vertical';

  @override
  String get plain => 'Simples';

  @override
  String get light => 'Fino';

  @override
  String get ruled => 'Roubado';

  @override
  String get quad => 'Quadriciclo';

  @override
  String get music => 'Música';

  @override
  String get dark => 'Escuro';

  @override
  String get plainDark => 'Escuro';

  @override
  String get ruledDark => 'Ruído das Trevas';

  @override
  String get quadDark => 'Quadriciclo escuro';

  @override
  String get musicDark => 'Música escura';

  @override
  String get templates => 'Modelos';

  @override
  String get untitled => 'Sem Título';

  @override
  String get createTemplate => 'Criar modelo';

  @override
  String get createTemplateContent =>
      'Você realmente deseja criar um template a partir deste documento? O documento original será excluído.';

  @override
  String get replace => 'Substituir';

  @override
  String get reallyReplace =>
      'Você realmente quer substituir o template? Esta operação não pode ser desfeita!';

  @override
  String get defaultTemplate => 'Modelo padrão';

  @override
  String get insert => 'Insert';

  @override
  String get document => 'Documento';

  @override
  String get camera => 'Câmera';

  @override
  String get printout => 'Imprimir';

  @override
  String get selectCamera => 'Selecione uma câmera';

  @override
  String get changeDocumentPath => 'Alterar caminho do documento';

  @override
  String get deleteWholeStroke => 'Excluir o traço inteiro';

  @override
  String get alpha => 'Transparência';

  @override
  String get area => 'área';

  @override
  String get selectArea => 'Selecione uma área';

  @override
  String get aspectRatio => 'Proporção da imagem';

  @override
  String get presets => 'Predefinições';

  @override
  String get pagePortrait => 'Retrato da página';

  @override
  String get pageLandscape => 'Paisagem da página';

  @override
  String get square => 'Quadrado';

  @override
  String get areas => 'Áreas';

  @override
  String get enterArea => 'Entre na área';

  @override
  String get exitArea => 'Saia da área';

  @override
  String get currentArea => 'Área atual';

  @override
  String get design => 'Projetar';

  @override
  String get text => 'texto';

  @override
  String welcome(String codeName) {
    return 'Ei, esta é a Borboleta Linwood';
  }

  @override
  String get welcomeContent =>
      'Um espaço de desenho gratuito e de código-aberto!';

  @override
  String updated(String version) {
    return 'Aplicativo atualizado para a versão $version';
  }

  @override
  String get releaseNotes => 'Notas da versão';

  @override
  String get constraints => 'Restrições';

  @override
  String get scaled => 'Escalado';

  @override
  String get fixed => 'Corrigido';

  @override
  String get dynamicContent => 'Dinâmico';

  @override
  String get none => 'Nenhuma';

  @override
  String get includeArea => 'Incluir área';

  @override
  String get verticalAlignment => 'Alinhamento vertical';

  @override
  String get horizontalAlignment => 'Alinhamento horizontal';

  @override
  String get top => 'Superior';

  @override
  String get center => 'Centralizar';

  @override
  String get bottom => 'Inferior';

  @override
  String get left => 'Esquerda';

  @override
  String get right => 'Direita';

  @override
  String get justify => 'Justificar';

  @override
  String get constraint => 'Restrição';

  @override
  String get length => 'Comprimento';

  @override
  String get exportSvg => 'Exportar para SVG';

  @override
  String get pdf => 'Pdf';

  @override
  String get selectPages => 'Selecionar páginas';

  @override
  String get recentFiles => 'Arquivos recentes';

  @override
  String get start => 'Iniciar';

  @override
  String get noRecentFiles => 'Nenhum arquivo recente';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count páginas',
      one: '1 página',
      zero: 'Sem páginas',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Página $index';
  }

  @override
  String get exit => 'Sair';

  @override
  String get noElements => 'Nenhum elemento';

  @override
  String get invertSelection => 'Inverter seleção';

  @override
  String get errorWhileImporting => 'Erro ao importar';

  @override
  String get errorWhileImportingContent =>
      'Ocorreu um erro ao importar o arquivo';

  @override
  String get showDetails => 'Exibir detalhes';

  @override
  String get hideDetails => 'Ocultar detalhes';

  @override
  String get error => 'ERRO';

  @override
  String get stackTrace => 'Rastreamento de pilha';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Duração';

  @override
  String get quality => 'Qualidade';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get local => 'Localização';

  @override
  String get addConnection => 'Adicionar conexão';

  @override
  String get connections => 'Conexões';

  @override
  String get noConnections => 'Sem conexões';

  @override
  String get url => 'URL:';

  @override
  String get connect => 'Conectar';

  @override
  String get username => 'Usuário:';

  @override
  String get password => 'Palavra-passe';

  @override
  String get webNotSupported => 'Web não suportado';

  @override
  String get advanced => 'Avançado';

  @override
  String get directory => 'Diretório';

  @override
  String get documentsDirectory => 'Diretório de documentos';

  @override
  String get templatesDirectory => 'Diretório de templates';

  @override
  String get errorWhileCreatingConnection => 'Erro ao criar a conexão';

  @override
  String get cannotConnect => 'Impossível conectar';

  @override
  String get urlNotValid => 'URL não é válida';

  @override
  String get icon => 'Ícone';

  @override
  String get update => 'Atualização';

  @override
  String get updateAvailable => 'Atualização disponível';

  @override
  String get stable => 'Estável';

  @override
  String get nightly => 'Noturno';

  @override
  String get checkForUpdates => 'Verificar se há atualizações';

  @override
  String get checkForUpdatesWarning =>
      'Ao realizar uma verificação se há atualizações você conectará ao site Butterfly para obter as informações.';

  @override
  String get usingLatestStable => 'Você está usando a última versão estável';

  @override
  String get usingLatestNightly => 'Você está usando a última versão noturna';

  @override
  String get currentVersion => 'Versão atual';

  @override
  String get updateNow => 'Atualizar agora';

  @override
  String get shape => 'Forma';

  @override
  String get circle => 'Círculo';

  @override
  String get rectangle => 'Retângulo';

  @override
  String get triangle => 'Triângulo';

  @override
  String get line => 'Linha';

  @override
  String get cornerRadius => 'Corner radius';

  @override
  String get topLeft => 'Canto superior esquerdo';

  @override
  String get topRight => 'Canto superior direito';

  @override
  String get bottomLeft => 'Canto inferior esquerdo';

  @override
  String get bottomRight => 'Canto inferior direito';

  @override
  String get caches => 'Caches';

  @override
  String get manage => 'Administrar';

  @override
  String get clearCaches => 'Limpar caches';

  @override
  String get createCache => 'Criar cache';

  @override
  String get thirdPartyLicenses => 'Licenças de terceiros';

  @override
  String get syncing => 'Sincronizando...';

  @override
  String get synced => 'Sincronizado';

  @override
  String get notSynced => 'Não sincronizado';

  @override
  String get conflict => 'Conflito';

  @override
  String get keepLocal => 'Manter localmente';

  @override
  String get keepConnection => 'Manter conexão';

  @override
  String get keepBoth => 'Manter ambos';

  @override
  String get forAll => 'Para todos';

  @override
  String fileConflict(String file, String connection) {
    return '$file em $connection tem um conflito';
  }

  @override
  String get offline => 'Desconectado';

  @override
  String get localLatest => 'Recente local';

  @override
  String get connectionLatest => 'Conexão mais recente';

  @override
  String get path => 'Caminho';

  @override
  String get folderSynced => 'Pasta sincronizada';

  @override
  String get syncRootDirectory => 'Sincronizar diretório raiz';

  @override
  String get penOnlyInput => 'Pen apenas entrada';

  @override
  String get inputGestures => 'Input gestures';

  @override
  String get nativeTitleBar => 'Barra de título nativa';

  @override
  String get syncMode => 'Modo de sincronização';

  @override
  String get connection => 'Ligação';

  @override
  String get always => 'sempre';

  @override
  String get noMobile => 'Sem celular';

  @override
  String get manual => 'Manualmente';

  @override
  String get search => 'Pesquisa';

  @override
  String get properties => 'propriedades';

  @override
  String get pin => 'PIN';

  @override
  String get unpin => 'Unpin';

  @override
  String get element => 'Elemento';

  @override
  String get painter => 'Pintor';

  @override
  String get position => 'Posição';

  @override
  String get note => 'Observação';

  @override
  String get packs => 'Pacotes';

  @override
  String get pack => 'Pct';

  @override
  String get more => 'MAIS';

  @override
  String get askForName => 'Pergunte o nome';

  @override
  String areaIndex(int index) {
    return 'Área $index';
  }

  @override
  String get startInFullScreen => 'Iniciar em tela cheia';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Mouse';

  @override
  String get touch => 'Toque';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Atalhos';

  @override
  String get middle => 'Meio';

  @override
  String get first => 'Primeiro';

  @override
  String get second => 'Segundo';

  @override
  String get tools => 'Ferramentas';

  @override
  String get showGrid => 'Mostrar grade';

  @override
  String get grid => 'Grade';

  @override
  String get ruler => 'Régua';

  @override
  String get angle => 'Ângulo';

  @override
  String get report => 'Denunciar';

  @override
  String get newFolder => 'Adicionar Pasta';

  @override
  String get createPack => 'Criar pacote';

  @override
  String get editPack => 'Editar pacote';

  @override
  String get packsDirectory => 'Diretório dos pacotes';

  @override
  String get stamp => 'Selo';

  @override
  String get addToPack => 'Adicionar aos pacotes';

  @override
  String get sureImportPack => 'Tem certeza de que deseja importar o pacote?';

  @override
  String byAuthor(String author) {
    return 'por $author';
  }

  @override
  String get author => 'Autor';

  @override
  String get addAsset => 'Adicionar conteúdo';

  @override
  String get editAsset => 'Editar mídia';

  @override
  String get scope => 'Escopo';

  @override
  String get noPacks => 'Não existem pacotes disponíveis no momento';

  @override
  String get components => 'Componentes';

  @override
  String get waypoint => 'Ponto';

  @override
  String get actions => 'Ações.';

  @override
  String get painters => 'Pintores';

  @override
  String get breakingChangesTitle => 'Quebrar alterações';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Há quebras de alterações nesta versão. Por favor, leia o log de mudanças antes de atualizar. A versão atual do arquivo é $version, a nova versão é $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Parágrafo';

  @override
  String get fontFamily => 'Família da fonte';

  @override
  String get smoothing => 'Suavização';

  @override
  String get streamline => 'Simplificar';

  @override
  String get presentation => 'Apresentação';

  @override
  String get selectAsset => 'Selecionar arquivo';

  @override
  String get clearStyle => 'Limpar estilo';

  @override
  String get unknownImportType => 'Tipo de importação desconhecido';

  @override
  String get sureImportTemplate =>
      'Você tem certeza que deseja importar o modelo?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Reproduzir';

  @override
  String get video => 'Vídeo';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Breakpoint';

  @override
  String get presentationControls => 'Controles de apresentação';

  @override
  String get nextSlide => 'Próximo slide';

  @override
  String get nextSlideDescription =>
      'Deslize para a direita ou pressione a tecla de seta para a direita para ir para o próximo slide';

  @override
  String get previousSlide => 'Slide anterior';

  @override
  String get previousSlideDescription =>
      'Deslize para a esquerda ou pressione a tecla de seta para a esquerda para ir ao slide anterior';

  @override
  String get exitPresentation => 'Sair da apresentação';

  @override
  String get exitPresentationDescription =>
      'Pressione a tecla de escape ou deslize para baixo para sair da apresentação';

  @override
  String get pausePresentation => 'Pausar apresentação';

  @override
  String get pausePresentationDescription =>
      'Toque na tela ou pressione a barra de espaço para pausar ou continuar a apresentação';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'Você chegou ao final da apresentação';

  @override
  String get startOfPresentation => 'Você chegou ao início da apresentação';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Título $index';
  }

  @override
  String get code => 'Código';

  @override
  String get quote => 'Cotação';

  @override
  String get link => 'Vincular';

  @override
  String get checkbox => 'Checkbox';

  @override
  String get deleted => 'Excluído';

  @override
  String get emphasis => 'Enxofre';

  @override
  String get listBullet => 'Lista de marcadores';

  @override
  String get strong => 'Forte';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Residencial';

  @override
  String get files => 'arquivos';

  @override
  String get sortBy => 'Classificar por';

  @override
  String get location => 'Local:';

  @override
  String get whatsNew => 'Quais as novidades?';

  @override
  String get unstar => 'Desmarcar';

  @override
  String get star => 'Estrela';

  @override
  String get goUp => 'Ir para cima';

  @override
  String get created => 'Criado';

  @override
  String get modified => 'Modificado';

  @override
  String get quickstart => 'Acesso Rápido';

  @override
  String get noTemplates => 'Atualmente, não há modelos disponíveis';

  @override
  String get importCorePack => 'Importar pacote de núcleo';

  @override
  String get importCorePackDescription =>
      'Importe o pacote central que contém todos os recursos básicos para começar. Isto irá substituir o pacote principal atual.';

  @override
  String get never => 'nunca';

  @override
  String get onlyOnUpdates => 'Somente em atualizações';

  @override
  String get visibility => 'Visibilidade';

  @override
  String get captureThumbnail => 'Capturar miniatura';

  @override
  String get capturedThumbnail => 'Miniatura capturada com sucesso';

  @override
  String get chooseLabelMode => 'Escolher modo de rótulo';

  @override
  String get foreground => 'Primeiro plano';

  @override
  String get version => 'Versão';

  @override
  String get repository => 'Repositório';

  @override
  String get pages => 'páginas';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Organizar';

  @override
  String get bringToFront => 'Trazer para frente';

  @override
  String get sendToBack => 'Enviar para trás';

  @override
  String get bringForward => 'Trazer para frente';

  @override
  String get sendBackward => 'Enviar para trás';

  @override
  String get rotation => 'Rotação';

  @override
  String get onlyAvailableLargerScreen => 'Disponível apenas em telas maiores';

  @override
  String get toolbarPosition => 'Posição da barra';

  @override
  String get rotate => 'Rotacionar';

  @override
  String get spacer => 'Espaçador';

  @override
  String get navigationRail => 'Trilho de navegação';

  @override
  String get cut => 'Recortar';

  @override
  String get insertBefore => 'Inserir antes';

  @override
  String get insertAfter => 'Inserir depois';

  @override
  String get insertFirst => 'Insira primeiro';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Colar';

  @override
  String get ascending => 'Ascendente';

  @override
  String get descending => 'Descendente';

  @override
  String get imageScale => 'Escala de imagem';

  @override
  String get select => 'Selecionar';

  @override
  String get tool => 'Ferramenta';

  @override
  String get texture => 'Textura';

  @override
  String get platformTheme => 'Tema da plataforma';

  @override
  String get desktop => 'Computadores';

  @override
  String get mobile => 'Celular';

  @override
  String get pdfQuality => 'Qualidade PDF';

  @override
  String get surface => 'Superfície';

  @override
  String get pattern => 'Padrão';

  @override
  String get sureClose => 'Tem certeza de que deseja fechar o documento?';

  @override
  String get thereAreUnsavedChanges => 'Há alterações não salvas';

  @override
  String get page => 'Página';

  @override
  String get iceServers => 'Servidores ICE';

  @override
  String get collaboration => 'Colaboração';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Encaixe Web';

  @override
  String get iceServer => 'Servidor ICE';

  @override
  String get port => 'Porta';

  @override
  String get type => 'tipo';

  @override
  String get side => 'Lado';

  @override
  String get client => 'Cliente';

  @override
  String get server => 'Servidor';

  @override
  String get switchView => 'Mudar Visualização';

  @override
  String get lasso => 'Lasso';

  @override
  String get hideUI => 'Ocultar interface';

  @override
  String get density => 'Densidade';

  @override
  String get compact => 'Compacta';

  @override
  String get comfortable => 'Confortável';

  @override
  String get standard => 'Padrão';

  @override
  String get lock => 'Bloquear';

  @override
  String get addElement => 'Adicionar elemento';

  @override
  String get notDefaultConnection => 'Conexão não padrão';

  @override
  String get defaultConnection => 'Conexão padrão';

  @override
  String get hide => 'Esconder';

  @override
  String get show => 'Apresentar';

  @override
  String get pause => 'Suspender';

  @override
  String get stop => 'Interromper';

  @override
  String get refresh => 'atualizar';

  @override
  String get print => 'Impressão';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Gota de olho';

  @override
  String get users => 'Utilizadores';

  @override
  String get experiments => 'Experimentos';

  @override
  String get address => 'Endereço';

  @override
  String get spreadToPages => 'Espalhar em páginas';

  @override
  String get rootDirectorySpecifiedDescription =>
      'O diretório raiz é especificado. Todos os caminhos avançados do diretório serão relativos a este diretório. Mantenha-o vazio para desativar este tipo de diretório.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'O diretório raiz não foi especificado. Um nome é necessário. Todos os caminhos de diretório avançados serão absolutos. Mantenha vazio para desativar este tipo de diretório.';

  @override
  String get unsecureConnectionTitle => 'Conexão insegura';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'A conexão não é segura. Isto pode ser um risco à segurança. Por favor, só continue se confiar na conexão. A impressão digital sha1 é $fingerprint.';
  }

  @override
  String get continueAnyway => 'Continuar mesmo assim';

  @override
  String get zoomControl => 'Controle de zoom';

  @override
  String get highContrast => 'Alto contraste';

  @override
  String get shouldANumber => 'Este valor deve ser um número válido';

  @override
  String get createAreas => 'Criar áreas';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Operações';

  @override
  String get medium => 'Média';

  @override
  String get large => 'grande';

  @override
  String get toolbarSize => 'Tamanho da barra';

  @override
  String get addAll => 'Adicionar tudo';

  @override
  String get onlyCurrentPage => 'Somente a página atual';

  @override
  String get smoothNavigation => 'Navegação suave';

  @override
  String get exact => 'Exato';

  @override
  String get inline => 'Embutido';

  @override
  String get toolbarRows => 'Barra de ferramentas';

  @override
  String get pointerTest => 'Teste de ponteiro';

  @override
  String get pressure => 'Pressão';

  @override
  String get small => 'Pequeno';

  @override
  String get tiny => 'Minúsculo';

  @override
  String get selectAll => 'Selecionar todos';

  @override
  String get overrideTools => 'Sobrescrever ferramentas';

  @override
  String get hideCursorWhileDrawing => 'Ocultar cursor durante o desenho';

  @override
  String get installed => 'Instalado';

  @override
  String get install => 'Instale';

  @override
  String get deselect => 'Desselecionar';

  @override
  String get changeCollection => 'Alterar Coleção';

  @override
  String get collections => 'Coleções';

  @override
  String get fullSelection => 'Seleção completa';

  @override
  String get fullSelectionDescription =>
      'Requer elementos para estar totalmente dentro da caixa de seleção para a seleção.';

  @override
  String get collection => 'Coleção';

  @override
  String get defaultCollection => 'Coleção Padrão';

  @override
  String get scroll => 'Percorrer';

  @override
  String get onStartup => 'Na inicialização';

  @override
  String get homeScreen => 'Tela inicial';

  @override
  String get lastNote => 'Última anotação';

  @override
  String get newNote => 'Nova nota';

  @override
  String get convertToLayer => 'Converter para camada';

  @override
  String get merge => 'Mesclar';

  @override
  String get up => 'Acima';

  @override
  String get down => 'Abaixo';

  @override
  String get other => 'Outros';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementos',
      one: '1 elemento',
      zero: 'Sem elementos',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Barra de cores';

  @override
  String get yesButShowButtons => 'Sim, mas mostrar botões';

  @override
  String get optionsPanelPosition => 'Posição do painel de opções';

  @override
  String get hideDuration => 'Duração do ocultamento';

  @override
  String get animation => 'Animação';

  @override
  String get performance => 'Desempenho';

  @override
  String get performanceDescription =>
      'Otimizado para uso de velocidade e memória. Apenas a parte visível da nota está assada na imagem.';

  @override
  String get normalDescription =>
      'Saldos de qualidade e desempenho. Cobre uma imagem cobrindo 1,5 vezes a área visível, proporcionando transições mais suaves ao rolar.';

  @override
  String get high => 'alta';

  @override
  String get highDescription =>
      'Descrição: Maximiza a qualidade ao custo de desempenho. Cobre uma imagem cobrindo 2 vezes a área visível, garantindo a renderização contínua mesmo durante a rolagem rápida ou o zoom.';

  @override
  String get renderResolution => 'Resolução de renderização';

  @override
  String get translate => 'Traduzir';

  @override
  String get unencrypted => 'Descriptografado';

  @override
  String get encrypted => 'Criptografado';

  @override
  String get encryptDocumentMessage => 'Clique para criptografar o documento';

  @override
  String get unencryptDocumentMessage =>
      'Clique para descriptografar o documento';

  @override
  String get unencrypt => 'Descriptografar';

  @override
  String get encrypt => 'Criptografar';

  @override
  String get encryptWarning =>
      'Isso criptografará o documento. Você precisará lembrar a senha para descriptografá-la.';

  @override
  String get unencryptWarning =>
      'Isto irá descriptografar o documento. A senha será removida e todos com acesso poderão abri-lo.';

  @override
  String get confirmPassword => 'Confirmar a senha';

  @override
  String get passwordMismatch => 'As senhas não coincidem';

  @override
  String get action => 'Acão';

  @override
  String get svgText => 'Texto SVG';

  @override
  String get offset => 'Deslocamento';

  @override
  String get positionDependent => 'Position dependent';

  @override
  String get flipHorizontal => 'Flip horizontal';

  @override
  String get flipVertical => 'Flip vertical';

  @override
  String get grayscale => 'Grayscale';
}

/// The translations for Portuguese, as used in Brazil (`pt_BR`).
class AppLocalizationsPtBr extends AppLocalizationsPt {
  AppLocalizationsPtBr() : super('pt_BR');

  @override
  String get open => 'Abrir';

  @override
  String get settings => 'Configurações';

  @override
  String get personalization => 'Personalização';

  @override
  String get theme => 'Tema';

  @override
  String get darkTheme => 'Tema escuro';

  @override
  String get lightTheme => 'Tema claro';

  @override
  String get systemTheme => 'Usar tema padrão do sistema';

  @override
  String get view => 'Visualizar';

  @override
  String get edit => 'Editar';

  @override
  String get export => 'Exportar';

  @override
  String get save => 'Salvar';

  @override
  String get zoom => 'Ampliar/Reduzir';

  @override
  String get zoomIn => 'Ampliar';

  @override
  String get zoomOut => 'Reduzir';

  @override
  String get resetZoom => 'Redefinir o zoom';

  @override
  String get strokeWidth => 'Espessura do traço';

  @override
  String get includeEraser => 'Incluir borracha?';

  @override
  String get thinning => 'Diluição';

  @override
  String get pen => 'Caneta';

  @override
  String get eraser => 'Borracha';

  @override
  String get pathEraser => 'Apagador de linha';

  @override
  String get label => 'Descrição';

  @override
  String get delete => 'Excluir';

  @override
  String get areYouSure => 'Você tem certeza?';

  @override
  String get reallyDelete => 'Você realmente deseja excluir este item?';

  @override
  String get no => 'Não';

  @override
  String get yes => 'Sim';

  @override
  String get undo => 'Desfazer';

  @override
  String get redo => 'Refazer';

  @override
  String get general => 'Gerais';

  @override
  String get copyTitle => 'Copiado para área de transferência';

  @override
  String get loading => 'Carregando...';

  @override
  String get enterText => 'Digite o texto';

  @override
  String get size => 'Tamanho';

  @override
  String get width => 'Largura';

  @override
  String get height => 'Altura';

  @override
  String get count => 'Quantidade';

  @override
  String get space => 'Sala';

  @override
  String get background => 'Plano de fundo';

  @override
  String get box => 'Caixa';

  @override
  String get locale => 'Idioma';

  @override
  String get systemLocale => 'Idioma do sistema';

  @override
  String get information => 'Informação';

  @override
  String get license => 'Licença';

  @override
  String get imprint => 'Aviso legal';

  @override
  String get privacypolicy => 'Política de privacidade';

  @override
  String get source => 'Fonte';

  @override
  String get documentation => 'Documentação';

  @override
  String get changelog => 'Mudanças';

  @override
  String get existOverride => 'Este elemento já existe. Sobrescrever?';

  @override
  String get description => 'Descrição';

  @override
  String get fill => 'Preencher';

  @override
  String get defaultPalette => 'Paleta padrão';

  @override
  String get highlighter => 'Destaque';

  @override
  String get add => 'Adicionar';

  @override
  String get remove => 'Excluir';

  @override
  String get removeConfirm => 'Você realmente deseja remover isto?';

  @override
  String get resetPalette => 'Redefinir paleta';

  @override
  String get custom => 'Personalizado';

  @override
  String get decoration => 'Decoração';

  @override
  String get underline => 'Sublinhar';

  @override
  String get overline => 'Sobrenome';

  @override
  String get strikethrough => 'Riscado';

  @override
  String get thickness => 'Espessura';

  @override
  String get style => 'Estilo';

  @override
  String get solid => 'Sólido';

  @override
  String get double => 'Duplo';

  @override
  String get dotted => 'Pontilhado';

  @override
  String get dashed => 'Tracejado';

  @override
  String get wavy => 'Onda';

  @override
  String get fontWeight => 'Peso da fonte';

  @override
  String get normal => 'Normal';

  @override
  String get bold => 'Negrito';

  @override
  String get italic => 'Itálico';

  @override
  String get clipboard => 'Área';

  @override
  String get file => 'Arquivo';

  @override
  String get data => 'Dado';

  @override
  String get share => 'Compartilhar';

  @override
  String get spacing => 'Espaçamento';

  @override
  String get image => 'Imagem';

  @override
  String get enterUrl => 'Digite a URL';

  @override
  String get scale => 'Escala';

  @override
  String get help => 'Socorro';

  @override
  String get reallyReset => 'Você realmente quer redefini-lo?';

  @override
  String get whatToDo => 'O que você quer fazer?';

  @override
  String get ignore => 'Ignorar';

  @override
  String get backup => 'Backup';

  @override
  String createdInNewerVersion(String fileName, int fileVersion) {
    return 'O arquivo $fileName foi criado em uma versão mais recente ($fileVersion). O que deve ser feito com esse arquivo?';
  }

  @override
  String get waypoints => 'Pontos';

  @override
  String get origin => 'Origem';

  @override
  String get import => 'Importação';

  @override
  String get newContent => 'Novidades';

  @override
  String get selectElement => 'Selecionar elemento';

  @override
  String get ctrlKey => 'Ctrl';

  @override
  String get shiftKey => 'Turno';

  @override
  String get altKey => 'Alt';

  @override
  String get copyVersion => 'Copiar versão';

  @override
  String get input => 'Entrada';

  @override
  String get behaviors => 'Comportamentos';

  @override
  String get dataDirectory => 'Diretório de dados';

  @override
  String get defaultPath => 'Caminho padrão';

  @override
  String get dateFormat => 'Formato da Data';

  @override
  String updatedAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Atualizado em: $dateTimeString';
  }

  @override
  String createdAt(DateTime dateTime) {
    final intl.DateFormat dateTimeDateFormat =
        intl.DateFormat('yy-MM-dd H:mm', localeName);
    final String dateTimeString = dateTimeDateFormat.format(dateTime);

    return 'Criado em: $dateTimeString';
  }

  @override
  String get rename => 'Renomear';

  @override
  String get duplicate => 'Duplicar';

  @override
  String get hand => 'Mão';

  @override
  String get folder => 'Pasta';

  @override
  String get move => 'Mover-se';

  @override
  String get copy => 'Copiar';

  @override
  String get back => 'Anterior';

  @override
  String get zoomDependent => 'Dependendo do zoom';

  @override
  String get shapeDetection => 'Detecção de forma';

  @override
  String get delay => 'Atraso';

  @override
  String get defaultLayer => 'Camada padrão';

  @override
  String get layer => 'Camada';

  @override
  String get layers => 'Camadas';

  @override
  String get notSet => 'Não definido';

  @override
  String get enterLayer => 'Digite o nome da camada';

  @override
  String get selectElements => 'Selecione elementos';

  @override
  String get deleteElements => 'Excluir elementos';

  @override
  String get deleteElementsConfirm =>
      'Você realmente deseja excluir os elementos selecionados?';

  @override
  String get selectCustomCollection => 'Selecione uma coleção personalizada';

  @override
  String get svg => 'Svg';

  @override
  String get sensitivity => 'Sensibilidade';

  @override
  String get sensitivityHint =>
      'Quanto maior o valor, mais sensível o valor de entrada';

  @override
  String get horizontal => 'Horizontal';

  @override
  String get vertical => 'Vertical';

  @override
  String get plain => 'Simples';

  @override
  String get light => 'Claro';

  @override
  String get ruled => 'Linhas';

  @override
  String get quad => 'Quadriculado';

  @override
  String get music => 'Música';

  @override
  String get dark => 'Escuro';

  @override
  String get plainDark => 'Escuro';

  @override
  String get ruledDark => 'Linhas escuro';

  @override
  String get quadDark => 'Quadriculado escuro';

  @override
  String get musicDark => 'Música escura';

  @override
  String get templates => 'Modelos';

  @override
  String get untitled => 'Sem Título';

  @override
  String get createTemplate => 'Criar modelo';

  @override
  String get createTemplateContent =>
      'Você realmente quer criar um modelo a partir dos elementos selecionados? O arquivo original será excluído.';

  @override
  String get replace => 'Substituir';

  @override
  String get reallyReplace =>
      'Você realmente quer substituir o template? Esta operação não pode ser desfeita!';

  @override
  String get defaultTemplate => 'Modelo padrão';

  @override
  String get insert => 'Inserir';

  @override
  String get document => 'Documento';

  @override
  String get camera => 'Câmera';

  @override
  String get printout => 'Imprimir';

  @override
  String get selectCamera => 'Selecione uma câmera';

  @override
  String get changeDocumentPath => 'Alterar caminho do documento';

  @override
  String get deleteWholeStroke => 'Excluir o traço inteiro';

  @override
  String get alpha => 'Transparência';

  @override
  String get area => 'Área';

  @override
  String get selectArea => 'Selecione uma área';

  @override
  String get aspectRatio => 'Proporção da imagem';

  @override
  String get presets => 'Predefinições';

  @override
  String get pagePortrait => 'Retrato da página';

  @override
  String get pageLandscape => 'Paisagem da página';

  @override
  String get square => 'Quadrado';

  @override
  String get areas => 'Áreas';

  @override
  String get enterArea => 'Entre na área';

  @override
  String get exitArea => 'Saia da área';

  @override
  String get currentArea => 'Área atual';

  @override
  String get design => 'Projetar';

  @override
  String get text => 'Texto';

  @override
  String welcome(String codeName) {
    return 'Ei, esta é a Borboleta Linwood';
  }

  @override
  String get welcomeContent =>
      'Um espaço de desenho gratuito e de código-aberto!';

  @override
  String updated(String version) {
    return 'Aplicativo atualizado para a versão $version';
  }

  @override
  String get releaseNotes => 'Notas da versão';

  @override
  String get constraints => 'Restrições';

  @override
  String get scaled => 'Escalado';

  @override
  String get fixed => 'Corrigido';

  @override
  String get dynamicContent => 'Dinâmico';

  @override
  String get none => 'Nenhuma';

  @override
  String get includeArea => 'Incluir área';

  @override
  String get verticalAlignment => 'Alinhamento vertical';

  @override
  String get horizontalAlignment => 'Alinhamento horizontal';

  @override
  String get top => 'Superior';

  @override
  String get center => 'Centralizar';

  @override
  String get bottom => 'Inferior';

  @override
  String get left => 'Esquerda';

  @override
  String get right => 'Direita';

  @override
  String get justify => 'Justificar';

  @override
  String get constraint => 'Restrição';

  @override
  String get length => 'Comprimento';

  @override
  String get exportSvg => 'Exportar para SVG';

  @override
  String get pdf => 'Pdf';

  @override
  String get selectPages => 'Selecionar páginas';

  @override
  String get recentFiles => 'Arquivos recentes';

  @override
  String get start => 'Iniciar';

  @override
  String get noRecentFiles => 'Nenhum arquivo recente';

  @override
  String countPages(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count páginas',
      one: '1 página',
      zero: 'Sem páginas',
    );
    return '$_temp0';
  }

  @override
  String pageIndex(int index) {
    return 'Página $index';
  }

  @override
  String get exit => 'Sair';

  @override
  String get noElements => 'Nenhum elemento';

  @override
  String get invertSelection => 'Inverter seleção';

  @override
  String get errorWhileImporting => 'Erro ao importar';

  @override
  String get errorWhileImportingContent =>
      'Ocorreu um erro ao importar o arquivo';

  @override
  String get showDetails => 'Exibir detalhes';

  @override
  String get hideDetails => 'Ocultar detalhes';

  @override
  String get error => 'Erro';

  @override
  String get stackTrace => 'Rastreamento de pilha';

  @override
  String get laser => 'Laser';

  @override
  String get duration => 'Duração';

  @override
  String get quality => 'Qualidade';

  @override
  String get exportPdf => 'Exportar PDF';

  @override
  String get local => 'Localização';

  @override
  String get addConnection => 'Adicionar conexão';

  @override
  String get connections => 'Conexões';

  @override
  String get noConnections => 'Sem conexões';

  @override
  String get url => 'URL:';

  @override
  String get connect => 'Conectar';

  @override
  String get username => 'Usuário:';

  @override
  String get password => 'Palavra-passe';

  @override
  String get webNotSupported => 'Web não suportado';

  @override
  String get advanced => 'Avançado';

  @override
  String get directory => 'Diretório';

  @override
  String get documentsDirectory => 'Diretório de documentos';

  @override
  String get templatesDirectory => 'Diretório de modelos';

  @override
  String get errorWhileCreatingConnection => 'Erro ao criar a conexão';

  @override
  String get cannotConnect => 'Impossível conectar';

  @override
  String get urlNotValid => 'URL não é válida';

  @override
  String get icon => 'Ícone';

  @override
  String get update => 'Atualização';

  @override
  String get updateAvailable => 'Atualização disponível';

  @override
  String get stable => 'Estável';

  @override
  String get nightly => 'Noturno';

  @override
  String get checkForUpdates => 'Verificar se há atualizações';

  @override
  String get checkForUpdatesWarning =>
      'Ao realizar uma verificação se há atualizações você conectará ao site Butterfly para obter as informações.';

  @override
  String get usingLatestStable => 'Você está usando a última versão estável';

  @override
  String get usingLatestNightly => 'Você está usando a última versão noturna';

  @override
  String get currentVersion => 'Versão atual';

  @override
  String get updateNow => 'Atualizar agora';

  @override
  String get shape => 'Forma';

  @override
  String get circle => 'Círculo';

  @override
  String get rectangle => 'Retângulo';

  @override
  String get triangle => 'Triângulo';

  @override
  String get line => 'Linha';

  @override
  String get cornerRadius => 'Raio das bordas';

  @override
  String get topLeft => 'Canto superior esquerdo';

  @override
  String get topRight => 'Canto superior direito';

  @override
  String get bottomLeft => 'Canto inferior esquerdo';

  @override
  String get bottomRight => 'Canto inferior direito';

  @override
  String get caches => 'Caches';

  @override
  String get manage => 'Administrar';

  @override
  String get clearCaches => 'Limpar caches';

  @override
  String get createCache => 'Criar cache';

  @override
  String get thirdPartyLicenses => 'Licenças de terceiros';

  @override
  String get syncing => 'Sincronizando...';

  @override
  String get synced => 'Sincronizado';

  @override
  String get notSynced => 'Não sincronizado';

  @override
  String get conflict => 'Conflito';

  @override
  String get keepLocal => 'Manter localmente';

  @override
  String get keepConnection => 'Manter conexão';

  @override
  String get keepBoth => 'Manter ambos';

  @override
  String get forAll => 'Para todos';

  @override
  String fileConflict(String file, String connection) {
    return '$file em $connection tem um conflito';
  }

  @override
  String get offline => 'Desconectado';

  @override
  String get localLatest => 'Recente local';

  @override
  String get connectionLatest => 'Conexão mais recente';

  @override
  String get path => 'Caminho';

  @override
  String get folderSynced => 'Pasta sincronizada';

  @override
  String get syncRootDirectory => 'Sincronizar diretório raiz';

  @override
  String get penOnlyInput => 'Entrada somente por caneta';

  @override
  String get inputGestures => 'Gestos de entrada';

  @override
  String get nativeTitleBar => 'Barra de título nativa';

  @override
  String get syncMode => 'Modo de sincronização';

  @override
  String get connection => 'Ligação';

  @override
  String get always => 'Sempre';

  @override
  String get noMobile => 'Sem celular';

  @override
  String get manual => 'Manualmente';

  @override
  String get search => 'Pesquisa';

  @override
  String get properties => 'Propriedades';

  @override
  String get pin => 'PIN';

  @override
  String get unpin => 'Desafixar';

  @override
  String get element => 'Elemento';

  @override
  String get painter => 'Pintor';

  @override
  String get position => 'Posição';

  @override
  String get note => 'Observação';

  @override
  String get packs => 'Pacotes';

  @override
  String get pack => 'Pacote';

  @override
  String get more => 'Mais';

  @override
  String get askForName => 'Pergunte o nome';

  @override
  String areaIndex(int index) {
    return 'Área $index';
  }

  @override
  String get startInFullScreen => 'Iniciar em tela cheia';

  @override
  String get inputs => 'Inputs';

  @override
  String get mouse => 'Mouse';

  @override
  String get touch => 'Toque';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get shortcuts => 'Atalhos';

  @override
  String get middle => 'Meio';

  @override
  String get first => 'Primeiro';

  @override
  String get second => 'Segundo';

  @override
  String get tools => 'Ferramentas';

  @override
  String get showGrid => 'Mostrar grade';

  @override
  String get grid => 'Grade';

  @override
  String get ruler => 'Régua';

  @override
  String get angle => 'Ângulo';

  @override
  String get report => 'Denunciar';

  @override
  String get newFolder => 'Adicionar Pasta';

  @override
  String get createPack => 'Criar pacote';

  @override
  String get editPack => 'Editar pacote';

  @override
  String get packsDirectory => 'Diretório dos pacotes';

  @override
  String get stamp => 'Selo';

  @override
  String get addToPack => 'Adicionar aos pacotes';

  @override
  String get sureImportPack => 'Tem certeza de que deseja importar o pacote?';

  @override
  String byAuthor(String author) {
    return 'por $author';
  }

  @override
  String get author => 'Autor';

  @override
  String get addAsset => 'Adicionar conteúdo';

  @override
  String get editAsset => 'Editar mídia';

  @override
  String get scope => 'Escopo';

  @override
  String get noPacks => 'Não existem pacotes disponíveis no momento';

  @override
  String get components => 'Componentes';

  @override
  String get waypoint => 'Ponto';

  @override
  String get actions => 'Ações.';

  @override
  String get painters => 'Pintores';

  @override
  String get breakingChangesTitle => 'Quebrar alterações';

  @override
  String breakingChangesMessage(int version, int newVersion) {
    return 'Há quebras de alterações nesta versão. Por favor, leia o log de mudanças antes de atualizar. A versão atual do arquivo é $version, a nova versão é $newVersion.';
  }

  @override
  String get styles => 'Styles';

  @override
  String get paragraph => 'Parágrafo';

  @override
  String get fontFamily => 'Família da fonte';

  @override
  String get smoothing => 'Suavização';

  @override
  String get streamline => 'Simplificar';

  @override
  String get presentation => 'Apresentação';

  @override
  String get selectAsset => 'Selecionar arquivo';

  @override
  String get clearStyle => 'Limpar estilo';

  @override
  String get unknownImportType => 'Tipo de importação desconhecido';

  @override
  String get sureImportTemplate =>
      'Você tem certeza que deseja importar o modelo?';

  @override
  String get frame => 'Frame';

  @override
  String get play => 'Reproduzir';

  @override
  String get video => 'Vídeo';

  @override
  String get fps => 'FPS';

  @override
  String get breakpoint => 'Breakpoint';

  @override
  String get presentationControls => 'Controles de apresentação';

  @override
  String get nextSlide => 'Próximo slide';

  @override
  String get nextSlideDescription =>
      'Deslize para a direita ou pressione a tecla de seta para a direita para ir para o próximo slide';

  @override
  String get previousSlide => 'Slide anterior';

  @override
  String get previousSlideDescription =>
      'Deslize para a esquerda ou pressione a tecla de seta para a esquerda para ir ao slide anterior';

  @override
  String get exitPresentation => 'Sair da apresentação';

  @override
  String get exitPresentationDescription =>
      'Pressione a tecla de escape ou deslize para baixo para sair da apresentação';

  @override
  String get pausePresentation => 'Pausar apresentação';

  @override
  String get pausePresentationDescription =>
      'Toque na tela ou pressione a barra de espaço para pausar ou continuar a apresentação';

  @override
  String get keyframe => 'Keyframe';

  @override
  String get endOfPresentation => 'Você chegou ao final da apresentação';

  @override
  String get startOfPresentation => 'Você chegou ao início da apresentação';

  @override
  String get palettes => 'Palettes';

  @override
  String headline(int index) {
    return 'Título $index';
  }

  @override
  String get code => 'Código';

  @override
  String get quote => 'Cotação';

  @override
  String get link => 'Vincular';

  @override
  String get checkbox => 'Checkbox';

  @override
  String get deleted => 'Excluído';

  @override
  String get emphasis => 'Enxofre';

  @override
  String get listBullet => 'Lista de marcadores';

  @override
  String get strong => 'Forte';

  @override
  String get markdown => 'Markdown';

  @override
  String get home => 'Página inicial';

  @override
  String get files => 'Arquivos';

  @override
  String get sortBy => 'Classificar por';

  @override
  String get location => 'Local:';

  @override
  String get whatsNew => 'Quais as novidades?';

  @override
  String get unstar => 'Desmarcar';

  @override
  String get star => 'Estrela';

  @override
  String get goUp => 'Ir para cima';

  @override
  String get created => 'Criado';

  @override
  String get modified => 'Modificado';

  @override
  String get quickstart => 'Acesso Rápido';

  @override
  String get noTemplates => 'Atualmente, não há modelos disponíveis';

  @override
  String get importCorePack => 'Importar pacote de núcleo';

  @override
  String get importCorePackDescription =>
      'Importe o pacote central que contém todos os recursos básicos para começar. Isto irá substituir o pacote principal atual.';

  @override
  String get never => 'nunca';

  @override
  String get onlyOnUpdates => 'Somente em atualizações';

  @override
  String get visibility => 'Visibilidade';

  @override
  String get captureThumbnail => 'Capturar miniatura';

  @override
  String get capturedThumbnail => 'Miniatura capturada com sucesso';

  @override
  String get chooseLabelMode => 'Escolher modo de rótulo';

  @override
  String get foreground => 'Primeiro plano';

  @override
  String get version => 'Versão';

  @override
  String get repository => 'Repositório';

  @override
  String get pages => 'Páginas';

  @override
  String get navigator => 'Navigator';

  @override
  String get arrange => 'Organizar';

  @override
  String get bringToFront => 'Trazer para frente';

  @override
  String get sendToBack => 'Enviar para trás';

  @override
  String get bringForward => 'Trazer para frente';

  @override
  String get sendBackward => 'Enviar para trás';

  @override
  String get rotation => 'Rotação';

  @override
  String get onlyAvailableLargerScreen => 'Disponível apenas em telas maiores';

  @override
  String get toolbarPosition => 'Posição da barra';

  @override
  String get rotate => 'Rotacionar';

  @override
  String get spacer => 'Espaçador';

  @override
  String get navigationRail => 'Trilho de navegação';

  @override
  String get cut => 'Recortar';

  @override
  String get insertBefore => 'Inserir antes';

  @override
  String get insertAfter => 'Inserir depois';

  @override
  String get insertFirst => 'Insira primeiro';

  @override
  String get insertLast => 'Insert last';

  @override
  String get paste => 'Colar';

  @override
  String get ascending => 'Ascendente';

  @override
  String get descending => 'Descendente';

  @override
  String get imageScale => 'Escala de imagem';

  @override
  String get select => 'Selecionar';

  @override
  String get tool => 'Ferramenta';

  @override
  String get texture => 'Textura';

  @override
  String get platformTheme => 'Tema da plataforma';

  @override
  String get desktop => 'Computadores';

  @override
  String get mobile => 'Celular';

  @override
  String get pdfQuality => 'Qualidade PDF';

  @override
  String get surface => 'Superfície';

  @override
  String get pattern => 'Padrão';

  @override
  String get sureClose => 'Tem certeza de que deseja fechar o documento?';

  @override
  String get thereAreUnsavedChanges => 'Há alterações não salvas';

  @override
  String get page => 'Página';

  @override
  String get iceServers => 'Servidores ICE';

  @override
  String get collaboration => 'Colaboração';

  @override
  String get webRtc => 'Web RTC';

  @override
  String get webSocket => 'Encaixe Web';

  @override
  String get iceServer => 'Servidor ICE';

  @override
  String get port => 'Porta';

  @override
  String get type => 'tipo';

  @override
  String get side => 'Lado';

  @override
  String get client => 'Cliente';

  @override
  String get server => 'Servidor';

  @override
  String get switchView => 'Mudar Visualização';

  @override
  String get lasso => 'Laço';

  @override
  String get hideUI => 'Ocultar interface';

  @override
  String get density => 'Densidade';

  @override
  String get compact => 'Compacta';

  @override
  String get comfortable => 'Confortável';

  @override
  String get standard => 'Padrão';

  @override
  String get lock => 'Bloquear';

  @override
  String get addElement => 'Adicionar elemento';

  @override
  String get notDefaultConnection => 'Conexão não padrão';

  @override
  String get defaultConnection => 'Conexão padrão';

  @override
  String get hide => 'Esconder';

  @override
  String get show => 'Apresentar';

  @override
  String get pause => 'Suspender';

  @override
  String get stop => 'Interromper';

  @override
  String get refresh => 'atualizar';

  @override
  String get print => 'Impressão';

  @override
  String get dav => 'DAV';

  @override
  String get eyeDropper => 'Conta-gotas';

  @override
  String get users => 'Utilizadores';

  @override
  String get experiments => 'Experimentos';

  @override
  String get address => 'Endereço';

  @override
  String get spreadToPages => 'Espalhar em páginas';

  @override
  String get rootDirectorySpecifiedDescription =>
      'O diretório raiz é especificado. Todos os caminhos avançados do diretório serão relativos a este diretório. Mantenha-o vazio para desativar este tipo de diretório.';

  @override
  String get rootDirectoryNotSpecifiedDescription =>
      'O diretório raiz não foi especificado. Um nome é necessário. Todos os caminhos de diretório avançados serão absolutos. Mantenha vazio para desativar este tipo de diretório.';

  @override
  String get unsecureConnectionTitle => 'Conexão insegura';

  @override
  String unsecureConnectionMessage(String fingerprint) {
    return 'A conexão não é segura. Isto pode ser um risco à segurança. Por favor, só continue se confiar na conexão. A impressão digital sha1 é $fingerprint.';
  }

  @override
  String get continueAnyway => 'Continuar mesmo assim';

  @override
  String get zoomControl => 'Controle de zoom';

  @override
  String get highContrast => 'Alto contraste';

  @override
  String get shouldANumber => 'Este valor deve ser um número válido';

  @override
  String get createAreas => 'Criar áreas';

  @override
  String get autosave => 'Autosave';

  @override
  String get invert => 'Invert';

  @override
  String get operations => 'Operações';

  @override
  String get medium => 'Média';

  @override
  String get large => 'grande';

  @override
  String get toolbarSize => 'Tamanho da barra';

  @override
  String get addAll => 'Adicionar tudo';

  @override
  String get onlyCurrentPage => 'Somente a página atual';

  @override
  String get smoothNavigation => 'Navegação suave';

  @override
  String get exact => 'Exato';

  @override
  String get inline => 'Embutido';

  @override
  String get toolbarRows => 'Barra de ferramentas';

  @override
  String get pointerTest => 'Teste de ponteiro';

  @override
  String get pressure => 'Pressão';

  @override
  String get small => 'Pequeno';

  @override
  String get tiny => 'Minúsculo';

  @override
  String get selectAll => 'Selecionar todos';

  @override
  String get overrideTools => 'Sobrescrever ferramentas';

  @override
  String get hideCursorWhileDrawing => 'Ocultar cursor durante o desenho';

  @override
  String get installed => 'Instalado';

  @override
  String get install => 'Instale';

  @override
  String get deselect => 'Desselecionar';

  @override
  String get changeCollection => 'Alterar Coleção';

  @override
  String get collections => 'Coleções';

  @override
  String get fullSelection => 'Seleção completa';

  @override
  String get fullSelectionDescription =>
      'Requer elementos para estar totalmente dentro da caixa de seleção para a seleção.';

  @override
  String get collection => 'Coleção';

  @override
  String get defaultCollection => 'Coleção Padrão';

  @override
  String get scroll => 'Percorrer';

  @override
  String get onStartup => 'Na inicialização';

  @override
  String get homeScreen => 'Tela inicial';

  @override
  String get lastNote => 'Última anotação';

  @override
  String get newNote => 'Nova nota';

  @override
  String get convertToLayer => 'Converter para camada';

  @override
  String get merge => 'Mesclar';

  @override
  String get up => 'Acima';

  @override
  String get down => 'Abaixo';

  @override
  String get other => 'Outros';

  @override
  String countElements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count elementos',
      one: '1 elemento',
      zero: 'Sem elementos',
    );
    return '$_temp0';
  }

  @override
  String get colorToolbar => 'Barra de cores';

  @override
  String get yesButShowButtons => 'Sim, mas mostrar botões';

  @override
  String get optionsPanelPosition => 'Posição do painel de opções';

  @override
  String get hideDuration => 'Duração do ocultamento';

  @override
  String get animation => 'Animação';

  @override
  String get performance => 'Desempenho';

  @override
  String get performanceDescription =>
      'Otimizado para uso de velocidade e memória. Apenas a parte visível da nota está assada na imagem.';

  @override
  String get normalDescription =>
      'Saldos de qualidade e desempenho. Cobre uma imagem cobrindo 1,5 vezes a área visível, proporcionando transições mais suaves ao rolar.';

  @override
  String get high => 'alta';

  @override
  String get highDescription =>
      'Descrição: Maximiza a qualidade ao custo de desempenho. Cobre uma imagem cobrindo 2 vezes a área visível, garantindo a renderização contínua mesmo durante a rolagem rápida ou o zoom.';

  @override
  String get renderResolution => 'Resolução de renderização';

  @override
  String get translate => 'Traduzir';

  @override
  String get unencrypted => 'Descriptografado';

  @override
  String get encrypted => 'Criptografado';

  @override
  String get encryptDocumentMessage => 'Clique para criptografar o documento';

  @override
  String get unencryptDocumentMessage =>
      'Clique para descriptografar o documento';

  @override
  String get unencrypt => 'Descriptografar';

  @override
  String get encrypt => 'Criptografar';

  @override
  String get encryptWarning =>
      'Isso criptografará o documento. Você precisará lembrar a senha para descriptografá-la.';

  @override
  String get unencryptWarning =>
      'Isto irá descriptografar o documento. A senha será removida e todos com acesso poderão abri-lo.';

  @override
  String get confirmPassword => 'Confirmar a senha';

  @override
  String get passwordMismatch => 'As senhas não coincidem';

  @override
  String get action => 'Acão';

  @override
  String get svgText => 'Texto SVG';

  @override
  String get offset => 'Deslocamento';
}
