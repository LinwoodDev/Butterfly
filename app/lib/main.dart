import 'dart:io';

import 'package:args/args.dart';
import 'package:butterfly/api/close.dart';
import 'package:butterfly/api/file_system.dart';
import 'package:butterfly/api/intent.dart';
import 'package:butterfly/services/sync.dart';
import 'package:butterfly/settings/connection.dart';
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
import 'package:settings_leap/settings_leap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:keybinder/keybinder.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'cubits/settings.dart';
import 'embed/embedding.dart';
import 'settings/home.dart';
import 'setup.dart' if (dart.library.js_interop) 'setup_web.dart';
import 'theme.dart';
import 'views/error.dart';
import 'views/home/page.dart';
import 'views/main.dart';
import 'services/logger.dart';
import 'services/font.dart';

const platform = MethodChannel('linwood.dev/butterfly');

Future<void> main([List<String> args = const []]) async {
  WidgetsFlutterBinding.ensureInitialized();
  initLogger();
  await rotatePersistedLogs();
  talker.info('App started');
  usePathUrlStrategy();

  final prefs = await SharedPreferences.getInstance();
  final settingsCubit = SettingsCubit(prefs);
  await setup(nativeTitleBar: settingsCubit.state.nativeTitleBar);
  var initialLocation = '/';
  final argParser = ArgParser();
  argParser.addOption('path', abbr: 'p');
  final result = argParser.parse(args);
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
  final bool debugShowCheckedModeBanner;

  ButterflyApp({
    super.key,
    required this.settingsCubit,
    this.fullScreen = false,
    this.initialLocation = '/',
    this.initialExtra,
    this.debugShowCheckedModeBanner = true,
  });

  List<RouteBase> _buildSettingsRoutes(
    SettingsLeapTree<ButterflySettings> tree,
  ) {
    Iterable<RouteBase> buildEntries(
      Map<String, SettingsLeapPage<ButterflySettings>> entries, [
      String? parentPath,
      String? parentId,
    ]) sync* {
      for (final entry in entries.entries) {
        final id = entry.key;
        final path = parentPath == null ? id : '$parentPath/$id';
        final fullId = parentId == null ? id : '$parentId.$id';
        final page = entry.value;
        yield GoRoute(
          path: 'settings/$path',
          builder: (context, state) => SettingsDetailsPage(
            id: fullId,
            focusedId: state.extra is String ? state.extra as String : null,
          ),
        );
        yield* buildEntries(page.children, path, fullId);
        if (id == 'connections') {
          yield GoRoute(
            path: 'settings/$path/:id',
            name: 'connection',
            builder: (context, state) =>
                ConnectionSettingsPage(remote: state.pathParameters['id']!),
          );
        }
      }
    }

    return buildEntries(tree.pages).toList();
  }

  late final GoRouter _router = GoRouter(
    initialLocation: initialLocation,
    initialExtra: initialExtra,
    restorationScopeId: 'router',
    observers: [TalkerRouteObserver(talker)],
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
          ),
          ..._buildSettingsRoutes(settingsTree),
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
              final path = state.uri.queryParameters['path'] ?? getNativeType();
              final data = state.extra ?? getNativeData();
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
              return ProjectPage(
                location: AssetLocation.local(
                  path.startsWith('/') ? path : '/$path',
                ),
                absolute: true,
              );
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
            data: state.extra,
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
                  settingsCubit.setTheme(context);
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
        debugShowCheckedModeBanner: debugShowCheckedModeBanner,
        locale: state.locale,
        title: applicationName,
        restorationScopeId: 'app',
        routeInformationProvider: _router.routeInformationProvider,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          LocaleNamesLocalizationsDelegate(),
          LeapLocalizations.delegate,
          KeybinderLocalizations.delegate,
        ],
        builder: (context, child) {
          if (!state.nativeTitleBar) {
            child = virtualWindowFrameBuilder(context, child);
          }
          return RepositoryProvider(
            create: ButterflyFileSystem.build,
            dispose: (fileSystem) => fileSystem.dispose(),
            child: RepositoryProvider(
              create: (context) =>
                  FontService(context.read<ButterflyFileSystem>()),
              child: RepositoryProvider(
                create: (context) =>
                    SyncService(context, context.read<ButterflyFileSystem>()),
                dispose: (service) => service.dispose(),
                lazy: false,
                child: _WindowCloseGuard(child: child ?? Container()),
              ),
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

class _WindowCloseGuard extends StatefulWidget {
  final Widget child;

  const _WindowCloseGuard({required this.child});

  @override
  State<_WindowCloseGuard> createState() => _WindowCloseGuardState();
}

class _WindowCloseGuardState extends State<_WindowCloseGuard> {
  late final CloseSubscription _closeSubscription;

  @override
  void initState() {
    super.initState();
    _closeSubscription = onPreventClose(context, () => null);
  }

  @override
  void dispose() {
    _closeSubscription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

const flavor = String.fromEnvironment('flavor');
const isNightly =
    flavor == 'nightly' || flavor == 'dev' || flavor == 'development';
const shortApplicationName = isNightly ? 'Butterfly Nightly' : 'Butterfly';
const applicationName = 'Linwood $shortApplicationName';
const logoAsset = isNightly ? 'images/nightly.png' : 'images/logo.png';

const applicationVersionName = 'Dreamy Duskywing';
const applicationMinorVersion = '2.6';

Future<String> getCurrentVersion() async {
  const envVersion = String.fromEnvironment('version');
  if (envVersion.isNotEmpty) return envVersion;
  final info = await PackageInfo.fromPlatform();
  return info.version;
}
