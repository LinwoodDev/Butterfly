import 'dart:io';
import 'dart:ui' as ui;

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/current_index.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/dialogs/import/add.dart';
import 'package:butterfly/dialogs/template.dart';
import 'package:butterfly/main.dart';
import 'package:butterfly/services/import.dart';
import 'package:butterfly/views/navigator/view.dart';
import 'package:butterfly/views/property.dart';
import 'package:butterfly/views/view.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  final screenshotBoundaryKey = GlobalKey();
  final defaultFlutterError = FlutterError.onError;
  const openingDocumentName = 'study.tbfly';
  const propertiesDocumentName = 'todo.tbfly';
  const screenshotDocumentNames = [
    'Butterfly.tbfly',
    'butterfly design.tbfly',
    openingDocumentName,
    propertiesDocumentName,
  ];
  final sizes = {
    'phoneScreenshots': const Size(360, 800),
    'sevenInchScreenshots': const Size(600, 1024),
    'tenInchScreenshots': const Size(1920, 1080),
  };

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 8; i++) {
      await tester.pump(const Duration(milliseconds: 100));
      final exception = tester.takeException();
      if (exception != null &&
          !exception.toString().contains('RenderFlex overflowed')) {
        throw exception;
      }
    }
  }

  Future<void> takeScreenshot(WidgetTester tester, String name) async {
    if (!kIsWeb && Platform.isAndroid) {
      await binding.convertFlutterSurfaceToImage();
      await tester.pumpAndSettle();
      await binding.takeScreenshot(name);
      return;
    }
    final boundary =
        screenshotBoundaryKey.currentContext!.findRenderObject()!
            as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 1);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    final screenshot = File('../metadata/en-US/images/$name.png');
    await screenshot.create(recursive: true);
    await screenshot.writeAsBytes(data!.buffer.asUint8List());
  }

  Map<String, Object> screenshotPreferences() => {
    'design': 'Classic',
    'locale': 'en',
    'theme_mode': ThemeMode.light.name,
    'banner_visibility': BannerVisibility.never.name,
    'history': screenshotDocumentNames
        .map((name) => AssetLocation(path: name).toJson())
        .toList(),
    'sort_by': SortBy.name.name,
    'sort_order': SortOrder.ascending.name,
    // needed to remove the inline window controls
    'native_title_bar': true,
  };

  Future<Directory> createScreenshotDataDirectory() async {
    final root = await Directory.systemTemp.createTemp(
      'butterfly_screenshots_',
    );
    final documents = Directory('${root.path}/Documents');
    await documents.create(recursive: true);
    for (final name in screenshotDocumentNames) {
      final sourceName = name == 'Butterfly.tbfly' ? 'butterfly.tbfly' : name;
      final source = File('../api/test/assets/$sourceName').absolute;
      if (!source.existsSync()) {
        throw StateError('Missing screenshot document: ${source.path}');
      }
      final document = await source.copy('${documents.path}/$name');
      await document.setLastModified(DateTime.utc(2024));
    }
    return root;
  }

  Future<void> pumpApp(
    WidgetTester tester,
    Size size, {
    String initialLocation = '/',
    Object? initialExtra,
  }) async {
    await binding.setSurfaceSize(size);
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(() => binding.setSurfaceSize(null));
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    SharedPreferences.setMockInitialValues(screenshotPreferences());
    final prefs = await SharedPreferences.getInstance();
    final settingsCubit = SettingsCubit(prefs);
    final clipboardManager = await SysAPI.getClipboardManager();
    await tester.pumpWidget(
      RepositoryProvider<ClipboardManager>(
        create: (context) => clipboardManager,
        child: RepaintBoundary(
          key: screenshotBoundaryKey,
          child: ButterflyApp(
            settingsCubit: settingsCubit,
            initialLocation: initialLocation,
            initialExtra: initialExtra,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
    await settle(tester);
  }

  Future<void> pumpDocument(
    WidgetTester tester,
    Size size, {
    String documentName = openingDocumentName,
  }) async {
    final file = File('${overrideButterflyDirectory!}/Documents/$documentName');
    await pumpApp(
      tester,
      size,
      initialLocation: Uri(
        path: '/native',
        queryParameters: {'path': documentName, 'type': 'note'},
      ).toString(),
      initialExtra: await file.readAsBytes(),
    );
    await tester.pumpUntilFound(find.byType(MainViewViewport));
    await settle(tester);
  }

  Future<void> frameOpeningDocument(
    WidgetTester tester,
    Size size,
    TransformCubit transformCubit,
  ) async {
    final isDesktop = size.width >= 840;
    final scale = switch (size.width) {
      >= 840 => 0.58,
      >= 600 => 0.48,
      _ => 0.34,
    };
    final position = switch (size.width) {
      >= 840 => const Offset(-130, -110),
      >= 600 => const Offset(100, -130),
      _ => const Offset(120, -150),
    };
    transformCubit.teleport(
      isDesktop ? position.translate(-160, 0) : position,
      scale,
    );
    await settle(tester);
  }

  Future<void> revealHomeDocuments(WidgetTester tester) async {
    final requestedDocuments = screenshotDocumentNames.map(find.text).toList();
    for (var i = 0; i < 6; i++) {
      if (requestedDocuments.every(tester.any)) return;
      final scrollables = find.byType(Scrollable);
      if (!tester.any(scrollables)) return;
      await tester.drag(scrollables.first, const Offset(0, -220));
      await settle(tester);
    }
  }

  group('screenshots', () {
    setUpAll(() {
      FlutterError.onError = (details) {
        if (details.exceptionAsString().contains('A RenderFlex overflowed')) {
          return;
        }
        defaultFlutterError?.call(details);
      };
    });

    tearDownAll(() {
      FlutterError.onError = defaultFlutterError;
    });

    for (final entry in sizes.entries) {
      final directory = entry.key;
      final size = entry.value;

      testWidgets(directory, (tester) async {
        final dataDirectory = await createScreenshotDataDirectory();
        overrideButterflyDirectory = dataDirectory.path;
        addTearDown(() {
          overrideButterflyDirectory = null;
          if (dataDirectory.existsSync()) {
            dataDirectory.deleteSync(recursive: true);
          }
        });

        await pumpApp(tester, size);
        await revealHomeDocuments(tester);
        await takeScreenshot(tester, '$directory/1-home');

        await pumpDocument(tester, size);
        var viewportContext = tester.element(find.byType(MainViewViewport));
        var currentIndexCubit = viewportContext.read<CurrentIndexCubit>();
        var transformCubit = viewportContext.read<TransformCubit>();
        var bloc = viewportContext.read<DocumentBloc>();
        var pen = bloc.state.info?.tools.whereType<PenTool>().firstOrNull;
        final isDesktop = size.width >= 840;

        if (isDesktop) {
          currentIndexCubit.setNavigatorPage(NavigatorPage.pages);
          currentIndexCubit.setNavigatorEnabled(true);
          await settle(tester);
        }
        await frameOpeningDocument(tester, size, transformCubit);
        await takeScreenshot(tester, '$directory/2-main');

        await settle(tester);
        var templateDialogOpened = false;
        if (!tester.any(find.byType(TemplateDialog))) {
          templateDialogOpened = true;
          showDialog<void>(
            context: viewportContext,
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: bloc),
                BlocProvider.value(value: currentIndexCubit),
                BlocProvider.value(value: transformCubit),
              ],
              child: const TemplateDialog(),
            ),
          );
          await tester.pumpAndSettle();
        }
        expect(find.byType(TemplateDialog), findsOneWidget);
        await takeScreenshot(tester, '$directory/3-templates');
        if (templateDialogOpened) {
          Navigator.of(tester.element(find.byType(TemplateDialog))).pop();
          await settle(tester);
        }

        if (pen == null) {
          throw StateError(
            'The screenshot document does not contain a pen tool',
          );
        }

        await pumpDocument(tester, size, documentName: propertiesDocumentName);
        viewportContext = tester.element(find.byType(MainViewViewport));
        currentIndexCubit = viewportContext.read<CurrentIndexCubit>();
        transformCubit = viewportContext.read<TransformCubit>();
        bloc = viewportContext.read<DocumentBloc>();
        pen = bloc.state.info?.tools.whereType<PenTool>().firstOrNull;
        if (pen == null) {
          throw StateError(
            'The properties screenshot document does not contain a pen tool',
          );
        }
        await frameOpeningDocument(tester, size, transformCubit);
        currentIndexCubit.setNavigatorEnabled(false);
        currentIndexCubit.changeSelection(pen, false);
        await settle(tester);
        expect(find.byType(PropertyView), findsOneWidget);
        await takeScreenshot(tester, '$directory/4-properties');

        await pumpDocument(tester, size);
        viewportContext = tester.element(find.byType(MainViewViewport));
        currentIndexCubit = viewportContext.read<CurrentIndexCubit>();
        transformCubit = viewportContext.read<TransformCubit>();
        bloc = viewportContext.read<DocumentBloc>();
        await frameOpeningDocument(tester, size, transformCubit);

        currentIndexCubit.changeSelection(currentIndexCubit, false);
        await settle(tester);
        await takeScreenshot(tester, '$directory/5-tools');

        currentIndexCubit.resetSelection(force: true);
        await settle(tester);
        final importService = viewportContext.read<ImportService>();
        showGeneralDialog(
          context: viewportContext,
          pageBuilder: (context, _, _) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: bloc),
              BlocProvider.value(value: currentIndexCubit),
            ],
            child: RepositoryProvider.value(
              value: importService,
              child: const AddDialog(),
            ),
          ),
          barrierDismissible: true,
          barrierLabel: MaterialLocalizations.of(
            viewportContext,
          ).modalBarrierDismissLabel,
          transitionDuration: Duration.zero,
        );
        await settle(tester);
        expect(find.byType(AddDialog), findsOneWidget);
        await takeScreenshot(tester, '$directory/6-add');
      });
    }
  });
}

extension on WidgetTester {
  Future<void> pumpUntilFound(
    Finder finder, {
    Duration timeout = const Duration(seconds: 20),
    Future<void> Function()? onPump,
  }) async {
    final end = binding.clock.fromNowBy(timeout);
    while (binding.clock.now().isBefore(end)) {
      await pump(const Duration(milliseconds: 100));
      final exception = takeException();
      if (exception != null &&
          !exception.toString().contains('RenderFlex overflowed')) {
        throw exception;
      }
      if (any(finder)) return;
      await onPump?.call();
    }
    throw TestFailure('Timed out waiting for $finder');
  }
}
