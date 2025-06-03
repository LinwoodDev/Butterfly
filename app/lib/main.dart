import 'dart:io';

import 'package:args/args.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/intent.dart';
import 'package:butterfly/services/sync.dart';
import 'package:butterfly/settings/behaviors.dart';
import 'package:butterfly/settings/inputs/mouse.dart';
import 'package:butterfly/settings/experiments.dart';
import 'package:butterfly/settings/view.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/material_leap.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'cubits/settings.dart';
import 'embed/embedding.dart';
import 'settings/inputs/home.dart';
import 'settings/inputs/keyboard.dart';
import 'settings/inputs/pen.dart';
import 'settings/inputs/touch.dart';
import 'settings/data.dart';
import 'settings/general.dart';
import 'settings/home.dart';
import 'settings/personalization.dart';
import 'settings/connection.dart';
import 'settings/connections.dart';
import 'setup.dart' if (dart.library.js_interop) 'setup_web.dart';
import 'theme.dart';
import 'views/error.dart';
import 'views/home/page.dart';
import 'views/main.dart';

const platform = MethodChannel('linwood.dev/butterfly');

Future<void> main([List<String> args = const []]) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await setup();
  var initialLocation = '/';
  final argParser = ArgParser();
  argParser.addOption('path', abbr: 'p');
  final result = argParser.parse(args);
  final prefs = await SharedPreferences.getInstance();
  final settingsCubit = SettingsCubit(prefs);
  Object? initialExtra;
  if (result.arguments.isNotEmpty && !kIsWeb) {
    var path = result.arguments[0].replaceAll('\\', '/');
    final file = File(path);
    if (await file.exists()) {
      final directory = Directory(await getButterflyDocumentsDirectory());
      // Test if file is in directory
      if (file.path.startsWith(directory.path)) {
        // Relative path
        initialLocation = Uri(
          pathSegments: [
            '',
            'local',
            ...file.path.replaceFirst(directory.path, '').split('/').sublist(1),
          ],
        ).toString();
      } else {
        initialLocation = Uri(
          pathSegments: ['', 'native'],
          queryParameters: {'path': file.path},
        ).toString();
      }
    }
  }
  if (initialLocation == '/') {
    final settings = settingsCubit.state;
    switch (settings.onStartup) {
      case StartupBehavior.openHomeScreen:
        break;
      case StartupBehavior.openLastNote:
        final lastNote = settings.history.firstOrNull;
        if (lastNote == null) break;
        initialLocation = Uri(
          path: '/new',
          queryParameters: {'remote': lastNote.remote, 'path': lastNote.path},
        ).toString();
      case StartupBehavior.openNewNote:
        initialLocation = '/new';
    }
  }

  if (!kIsWeb && isWindow) {
    await windowManager.ensureInitialized();
    const kWindowOptions = WindowOptions(
      minimumSize: Size(410, 300),
      title: applicationName,
      backgroundColor: Colors.transparent,
    );

    // Use it only after calling `hiddenWindowAtLaunch`
    await windowManager.waitUntilReadyToShow(kWindowOptions).then((_) async {
      await windowManager.setResizable(true);
      await windowManager.setPreventClose(false);
    });
  }
  final clipboardManager = await SysAPI.getClipboardManager();
  overrideButterflyDirectory = result['path'];
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ClipboardManager>(
          create: (context) => clipboardManager,
        ),
      ],
      child: ButterflyApp(
        settingsCubit: settingsCubit,
        initialLocation: initialLocation,
        initialExtra: initialExtra,
        fullScreen: await isFullScreen(),
      ),
    ),
  );
}

const kUnsupportedLanguages = [];

List<Locale> getLocales() => AppLocalizations.supportedLocales;

class ButterflyApp extends StatelessWidget {
  final String initialLocation;
  final SettingsCubit settingsCubit;
  final Object? initialExtra;
  final bool fullScreen;

  ButterflyApp({
    super.key,
    required this.settingsCubit,
    this.fullScreen = false,
    this.initialLocation = '/',
    this.initialExtra,
  });

  late final GoRouter _router = GoRouter(
    initialLocation: initialLocation,
    initialExtra: initialExtra,
    errorBuilder: (context, state) =>
        ErrorPage(message: state.error.toString()),
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) {
          return const HomePage();
        },
        routes: [
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SettingsPage(),
            routes: [
              GoRoute(
                path: 'general',
                builder: (context, state) => const GeneralSettingsPage(),
              ),
              GoRoute(
                path: 'inputs',
                builder: (context, state) => const InputsSettingsPage(),
                routes: [
                  GoRoute(
                    path: 'mouse',
                    builder: (context, state) => const MouseInputSettings(),
                  ),
                  GoRoute(
                    path: 'pen',
                    builder: (context, state) => const PenInputSettings(),
                  ),
                  GoRoute(
                    path: 'keyboard',
                    builder: (context, state) => const KeyboardInputSettings(),
                  ),
                  GoRoute(
                    path: 'touch',
                    builder: (context, state) => const TouchInputSettings(),
                  ),
                ],
              ),
              GoRoute(
                path: 'behaviors',
                builder: (context, state) => const BehaviorsSettingsPage(),
              ),
              GoRoute(
                path: 'personalization',
                builder: (context, state) =>
                    const PersonalizationSettingsPage(),
              ),
              GoRoute(
                path: 'view',
                builder: (context, state) => const ViewSettingsPage(),
              ),
              GoRoute(
                path: 'data',
                builder: (context, state) => const DataSettingsPage(),
              ),
              GoRoute(
                path: 'experiments',
                builder: (context, state) => const ExperimentsSettingsPage(),
              ),
              GoRoute(
                path: 'connections',
                builder: (context, state) => const ConnectionsSettingsPage(),
                routes: [
                  GoRoute(
                    path: ':id',
                    name: 'connection',
                    builder: (context, state) => ConnectionSettingsPage(
                      remote: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            name: 'new',
            path: 'new',
            builder: (context, state) {
              final defaultRemote = context
                  .read<SettingsCubit>()
                  .state
                  .defaultRemote;
              return ProjectPage(
                data: state.extra,
                location: AssetLocation(
                  remote: state.uri.queryParameters['remote'] ?? defaultRemote,
                  path: state.uri.queryParameters['path'] ?? '',
                ),
              );
            },
          ),
          GoRoute(
            name: 'connect',
            path: 'connect',
            builder: (context, state) {
              final url = state.uri.queryParameters['url'];
              return ProjectPage(data: state.extra, uri: url);
            },
          ),
          GoRoute(
            name: 'local',
            path: 'local/:path(.*)',
            builder: (context, state) {
              final path = state.pathParameters['path'];
              return ProjectPage(
                data: state.extra,
                type: state.uri.queryParameters['type'] ?? '',
                location: AssetLocation.local(path ?? ''),
              );
            },
          ),
          GoRoute(
            name: 'remote',
            path: 'remote/:remote/:path(.*)',
            builder: (context, state) {
              final remote = Uri.decodeComponent(
                state.pathParameters['remote'] ?? '',
              );
              final path = state.pathParameters['path'];
              return ProjectPage(
                data: state.extra,
                type: state.uri.queryParameters['type'] ?? '',
                location: AssetLocation(remote: remote, path: path ?? ''),
              );
            },
          ),
          GoRoute(
            path: 'native',
            name: 'native',
            builder: (context, state) {
              final type = state.uri.queryParameters['type'] ?? '';
              final path = state.uri.queryParameters['path'] ?? '';
              final data = state.extra;
              return ProjectPage(
                location: AssetLocation.local(path),
                absolute: true,
                type: type,
                data: data,
              );
            },
          ),
          GoRoute(
            path: 'native/:path(.*)',
            name: 'native-path',
            builder: (context, state) {
              final path = state.pathParameters['path'] ?? '';
              return ProjectPage(location: AssetLocation.local(path, true));
            },
          ),
        ],
      ),
      GoRoute(
        name: 'embed',
        path: '/embed',
        builder: (context, state) {
          return ProjectPage(
            embedding: Embedding.fromQuery(state.uri.queryParameters),
          );
        },
      ),
      GoRoute(
        path: '/intent',
        builder: (context, state) {
          Future<(String, Object)?>? intent;
          if (!kIsWeb && Platform.isAndroid) {
            intent = () async {
              final type = await getIntentType();
              final data = await getIntentData();
              if (type == null || data == null) return null;
              return (type, data);
            }();
          }
          return FutureBuilder<(String, Object)?>(
            future: intent,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final type = snapshot.data?.$1;
                final data = snapshot.data?.$2;
                return ProjectPage(
                  location: AssetLocation.local(
                    state.pathParameters['path'] ?? '',
                  ),
                  type: type ?? '',
                  data: data,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    ],
    redirect: (context, state) =>
        (state.uri.scheme == 'content') ? '/intent' : null,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              if (!kIsWeb && isWindow) {
                windowManager.waitUntilReadyToShow(null, () async {
                  settingsCubit.setTheme(MediaQuery.of(context));
                  settingsCubit.setNativeTitleBar();
                  await windowManager.show();
                });
              }
              return settingsCubit;
            },
          ),
          BlocProvider(
            create: (context) => WindowCubit(fullScreen: fullScreen),
          ),
        ],
        child: _buildApp(lightDynamic, darkDynamic),
      ),
    );
  }

  Widget _buildApp(ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    final virtualWindowFrameBuilder = VirtualWindowFrameInit();
    return BlocBuilder<SettingsCubit, ButterflySettings>(
      buildWhen: (previous, current) =>
          previous.theme != current.theme ||
          previous.localeTag != current.localeTag ||
          previous.design != current.design ||
          previous.density != current.density ||
          previous.highContrast != current.highContrast,
      builder: (context, state) => MaterialApp.router(
        locale: state.locale,
        title: applicationName,
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          LocaleNamesLocalizationsDelegate(),
          LeapLocalizations.delegate,
        ],
        builder: (context, child) {
          if (!state.nativeTitleBar) {
            child = virtualWindowFrameBuilder(context, child);
          }
          return RepositoryProvider(
            create: ButterflyFileSystem.build,
            child: RepositoryProvider(
              create: (context) =>
                  SyncService(context, context.read<ButterflyFileSystem>()),
              lazy: false,
              child: child ?? Container(),
            ),
          );
        },
        supportedLocales: getLocales(),
        themeMode: state.theme,
        theme: getThemeData(
          state.design,
          false,
          state.density.toFlutter(),
          lightDynamic,
          state.highContrast,
        ),
        darkTheme: getThemeData(
          state.design,
          true,
          state.density.toFlutter(),
          darkDynamic,
          state.highContrast,
        ),
      ),
    );
  }
}

const flavor = String.fromEnvironment('flavor');
const isNightly =
    flavor == 'nightly' || flavor == 'dev' || flavor == 'development';
const applicationVersionName = 'Black Hairstreak';
const shortApplicationName = isNightly ? 'Butterfly Nightly' : 'Butterfly';
const applicationName = 'Linwood $shortApplicationName';
const applicationMinorVersion = '2.4';

Future<String> getCurrentVersion() async {
  const envVersion = String.fromEnvironment('version');
  if (envVersion.isNotEmpty) return envVersion;
  final info = await PackageInfo.fromPlatform();
  return info.version;
}
