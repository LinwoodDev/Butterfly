import 'dart:convert';
import 'dart:io';

import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/settings/behaviors.dart';
import 'package:butterfly/settings/data.dart';
import 'package:butterfly/settings/home.dart';
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
    var primaryColor = const Color(0xFFF2B138);
    var primarySwatch = createMaterialColor(primaryColor);
    var accentColor = const Color(0xFF00469E);
    buildThemeData(context) => ThemeData(
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        dialogTheme: DialogTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        cardTheme: CardTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        // Modern appbar
        appBarTheme: AppBarTheme(
            color: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
            titleTextStyle: Theme.of(context).textTheme.headline6),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: primarySwatch,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: primarySwatch[200],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        colorScheme:
            ColorScheme.light(primary: primaryColor, secondary: accentColor));
    buildDarkThemeData(context) => ThemeData(
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
        dialogTheme: DialogTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        cardTheme: CardTheme(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        // Modern appbar
        appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white)),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: primarySwatch,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: primarySwatch[200],
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        colorScheme:
            ColorScheme.dark(primary: primaryColor, secondary: accentColor));
    return BlocBuilder<SettingsCubit, ButterflySettings>(
        buildWhen: (previous, current) =>
            previous.theme != current.theme ||
            previous.localeTag != current.localeTag,
        builder: (context, state) {
          return MaterialApp.router(
            key: _appKey,
            locale: state.locale,
            title: 'Butterfly',
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            theme: buildThemeData(context),
            themeMode: state.theme,
            darkTheme: buildDarkThemeData(context),
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
