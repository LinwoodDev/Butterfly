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
  const screenshotDocumentName = 'Butterfly.tbfly';
  final sizes = {
    'phoneScreenshots': const Size(360, 800),
    'sevenInchScreenshots': const Size(600, 1024),
    'tenInchScreenshots': const Size(1280, 800),
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
    'history': [const AssetLocation(path: screenshotDocumentName).toJson()],
    'sort_by': SortBy.name.name,
    'sort_order': SortOrder.ascending.name,
    // needed to remove the inline window controls
    'native_title_bar': true,
  };

  Future<Directory> createScreenshotDataDirectory() async {
    final source = File('../api/test/assets/butterfly.tbfly').absolute;
    if (!source.existsSync()) {
      throw StateError('Missing screenshot document: ${source.path}');
    }
    final root = await Directory.systemTemp.createTemp(
      'butterfly_screenshots_',
    );
    final documents = Directory('${root.path}/Documents');
    await documents.create(recursive: true);
    final document = await source.copy(
      '${documents.path}/$screenshotDocumentName',
    );
    await document.setLastModified(DateTime.utc(2024));
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

  Future<void> pumpDocument(WidgetTester tester, Size size) async {
    final file = File(
      '${overrideButterflyDirectory!}/Documents/$screenshotDocumentName',
    );
    await pumpApp(
      tester,
      size,
      initialLocation: Uri(
        path: '/native',
        queryParameters: {'path': screenshotDocumentName, 'type': 'note'},
      ).toString(),
      initialExtra: await file.readAsBytes(),
    );
    await tester.pumpUntilFound(find.byType(MainViewViewport));
    await settle(tester);
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
        expect(find.text(screenshotDocumentName), findsWidgets);
        await takeScreenshot(tester, '$directory/home');

        await pumpDocument(tester, size);
        await takeScreenshot(tester, '$directory/main');

        final viewportContext = tester.element(find.byType(MainViewViewport));
        final currentIndexCubit = viewportContext.read<CurrentIndexCubit>();
        final transformCubit = viewportContext.read<TransformCubit>();
        final bloc = viewportContext.read<DocumentBloc>();
        final pen = bloc.state.info?.tools.whereType<PenTool>().firstOrNull;

        await settle(tester);
        var templateDialogOpened = false;
        if (!tester.any(find.byType(TemplateDialog))) {
          templateDialogOpened = true;
          showDialog(
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
          await settle(tester);
        }
        expect(find.byType(TemplateDialog), findsOneWidget);
        await takeScreenshot(tester, '$directory/templates');
        if (templateDialogOpened) {
          Navigator.of(tester.element(find.byType(TemplateDialog))).pop();
          await settle(tester);
        }

        if (pen == null) {
          throw StateError(
            'The screenshot document does not contain a pen tool',
          );
        }
        currentIndexCubit.setNavigatorEnabled(false);
        currentIndexCubit.changeSelection(pen, false);
        await settle(tester);
        expect(find.byType(PropertyView), findsOneWidget);
        await takeScreenshot(tester, '$directory/properties');

        currentIndexCubit.changeSelection(currentIndexCubit, false);
        await settle(tester);
        await takeScreenshot(tester, '$directory/tools');

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
        await takeScreenshot(tester, '$directory/add');
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
