import 'dart:convert';
import 'dart:io';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/settings/behaviors.dart';
import 'package:butterfly/settings/data.dart';
import 'package:butterfly/settings/home.dart';
import 'package:butterfly/theme/manager.dart';
import 'package:butterfly/views/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/document.dart';
import 'settings/personalization.dart';
import 'package:window_manager/window_manager.dart';
import 'setup.dart' if (dart.library.html) 'setup_web.dart';

const fileVersion = 4;

Future<void> main([List<String> args = const []]) async {
  WidgetsFlutterBinding.ensureInitialized();

  GetIt.I.registerSingleton<int>(fileVersion, instanceName: 'fileVersion');
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  await setup();
  var prefs = await SharedPreferences.getInstance();
  var initialLocation = '/';
  if (args.isNotEmpty && !kIsWeb) {
    var path = args[0];
    var file = File(path);
    if (await file.exists()) {
      var data = await file.readAsString();
      var json = jsonDecode(data);
      var document = AppDocument.fromJson(json);
      var newFile =
          await DocumentFileSystem.fromPlatform().importDocument(document);
      initialLocation = newFile.path;
    }
  }

  if (isWindow()) {
    await windowManager.ensureInitialized();

    // Use it only after calling `hiddenWindowAtLaunch`
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setMinimumSize(const Size(400, 300));
      await windowManager.setSize(const Size(400, 600));
      await windowManager.setTitle('Butterfly');
      await windowManager.setTitleBarStyle('hidden');
      await windowManager.setResizable(true);
      await windowManager.center();
      await windowManager.show();
      await windowManager.focus();
    });
  }
  runApp(ButterflyApp(prefs: prefs, initialLocation: initialLocation));
}

class ButterflyApp extends StatelessWidget {
  final String initialLocation;
  final SharedPreferences prefs;
  final GlobalKey _appKey = GlobalKey();

  ButterflyApp({Key? key, required this.prefs, this.initialLocation = '/'})
      : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => SettingsCubit.fromPrefs(prefs), child: _buildApp());
  }

  Widget _buildApp() {
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.theme != current.theme ||
            previous.localeTag != current.localeTag ||
            previous.design != current.design,
        builder: (context, state) {
          return MaterialApp.router(
            key: _appKey,
            locale: state.locale,
            title: 'Butterfly',
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: ThemeManager.getThemeByName(state.design),
            themeMode: state.theme,
            darkTheme: ThemeManager.getThemeByName(state.design, dark: true),
          );
        });
  }

  get router => GoRouter(
        initialLocation: initialLocation,
        routes: [
          GoRoute(
              path: '/',
              builder: (context, state) {
                final path = state.queryParams['path']; // may be null
                return ProjectPage(path: path);
              },
              routes: [
                GoRoute(
                  path: 'settings',
                  builder: (context, state) => const SettingsPage(),
                  routes: [
                    GoRoute(
                      path: 'behaviors',
                      builder: (context, state) =>
                          const BehaviorsSettingsPage(),
                    ),
                    GoRoute(
                      path: 'personalization',
                      builder: (context, state) =>
                          const PersonalizationSettingsPage(),
                    ),
                    GoRoute(
                      path: 'data',
                      builder: (context, state) => const DataSettingsPage(),
                    ),
                  ],
                ),
              ]),
        ],
      );

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}
