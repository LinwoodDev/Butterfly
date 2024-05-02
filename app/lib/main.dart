import 'dart:io';

import 'package:args/args.dart';
import 'package:butterfly/api/file_system/googledrive_system.dart';
import 'package:butterfly/api/intent.dart';
import 'package:butterfly/services/sync.dart';
import 'package:butterfly/settings/behaviors/mouse.dart';
import 'package:butterfly/settings/experiments.dart';
import 'package:butterfly_api/butterfly_api.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_sysapi/lw_sysapi.dart';
import 'package:material_leap/l10n/leap_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';

import 'api/file_system/file_system.dart';
import 'api/full_screen.dart';
import 'cubits/settings.dart';
import 'embed/embedding.dart';
import 'settings/behaviors/home.dart';
import 'settings/behaviors/keyboard.dart';
import 'settings/behaviors/pen.dart';
import 'settings/behaviors/touch.dart';
import 'settings/data.dart';
import 'settings/general.dart';
import 'settings/home.dart';
import 'settings/personalization.dart';
import 'settings/connection.dart';
import 'settings/connections.dart';
import 'setup.dart' if (dart.library.html) 'setup_web.dart';
import 'theme.dart';
import 'views/error.dart';
import 'views/home.dart';
import 'views/main.dart';
import 'widgets/window.dart';

const kMobileWidth = 600.0;
const kLargeWidth = 1200.0;

const platform = MethodChannel('linwood.dev/butterfly');

Future<void> main([List<String> args = const []]) async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  await setup();

   // App directory
  String directory = await DocumentFileSystem.fromPlatform().getDirectory();
  // Google Drive Directory
  String remoteFolderName = 'Butterfly';

  // Initialize Google Drive client
  var googleDriveClient = GoogleDriveFileSystem();
  await googleDriveClient.init(); // Inizializza il client con autenticazione

  // Upload file
  try {
    await googleDriveClient.syncFile(directory, remoteFolderName);
  } catch (e) {
    print('Error syncing with Google Drive: $e');
  }


  var initialLocation = '/';
  final argParser = ArgParser();
  argParser.addOption('path', abbr: 'p');
  final result = argParser.parse(args);
  final prefs = await SharedPreferences.getInstance();
  if (result.arguments.isNotEmpty && !kIsWeb) {
    var path = result.arguments[0].replaceAll('\\', '/');
    var file = File(path);
    if (await file.exists()) {
      var directory =
          Directory(await DocumentFileSystem.fromPlatform().getDirectory());

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
        initialLocation = Uri(pathSegments: [
          '',
          'native',
        ], queryParameters: {
          'path': file.path,
        }).toString();
      }
    }
  }
  Object? initialExtra;
  if (!kIsWeb && Platform.isAndroid) {
    final intentType = await getIntentType();
    if (intentType != null) {
      initialLocation = Uri(
        pathSegments: [
          '',
          'native',
        ],
        queryParameters: {
          'type': 'note',
        },
      ).toString();
      initialExtra = await getIntentData();
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
  GeneralFileSystem.dataPath = result['path'];
  final isFullscreen = await isFullScreen();
  runApp(
    MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => DocumentFileSystem.fromPlatform()),
          RepositoryProvider(
              create: (context) => TemplateFileSystem.fromPlatform()),
          RepositoryProvider<ClipboardManager>(
              create: (context) => clipboardManager),
        ],
        child: ButterflyApp(
          prefs: prefs,
          initialLocation: initialLocation,
          initialExtra: initialExtra,
          isFullScreen: isFullscreen,
        )),
  );
}

const kUnsupportedLanguages = [];

List<Locale> getLocales() => AppLocalizations.supportedLocales;

class ButterflyApp extends StatelessWidget {
  final String initialLocation;
  final String importedLocation;
  final SharedPreferences prefs;
  final bool isFullScreen;
  final Object? initialExtra;

  ButterflyApp(
      {super.key,
      required this.prefs,
      required this.isFullScreen,
      this.initialLocation = '/',
      this.initialExtra,
      this.importedLocation = ''})
      : _router = GoRouter(
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
                      path: 'behaviors',
                      builder: (context, state) =>
                          const BehaviorsSettingsPage(),
                      routes: [
                        GoRoute(
                          path: 'mouse',
                          builder: (context, state) =>
                              const MouseBehaviorSettings(),
                        ),
                        GoRoute(
                          path: 'pen',
                          builder: (context, state) =>
                              const PenBehaviorSettings(),
                        ),
                        GoRoute(
                          path: 'keyboard',
                          builder: (context, state) =>
                              const KeyboardBehaviorSettings(),
                        ),
                        GoRoute(
                          path: 'touch',
                          builder: (context, state) =>
                              const TouchBehaviorSettings(),
                        ),
                      ],
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
                    GoRoute(
                      path: 'experiments',
                      builder: (context, state) =>
                          const ExperimentsSettingsPage(),
                    ),
                    GoRoute(
                      path: 'connections',
                      builder: (context, state) =>
                          const ConnectionsSettingsPage(),
                      routes: [
                        GoRoute(
                          path: ':id',
                          name: 'connection',
                          builder: (context, state) => ConnectionSettingsPage(
                              remote: state.pathParameters['id']!),
                        )
                      ],
                    ),
                  ],
                ),
                GoRoute(
                  name: 'new',
                  path: 'new',
                  builder: (context, state) {
                    final defaultRemote =
                        context.read<SettingsCubit>().state.defaultRemote;
                    return ProjectPage(
                      data: state.extra,
                      location: AssetLocation(
                        remote: state.uri.queryParameters['remote'] ??
                            defaultRemote,
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
                    return ProjectPage(
                      data: state.extra,
                      uri: url,
                    );
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
                        location: AssetLocation.local(path ?? ''));
                  },
                ),
                GoRoute(
                  name: 'remote',
                  path: 'remote/:remote/:path(.*)',
                  builder: (context, state) {
                    final remote = Uri.decodeComponent(
                        state.pathParameters['remote'] ?? '');
                    final path = state.pathParameters['path'];
                    return ProjectPage(
                        data: state.extra,
                        type: state.uri.queryParameters['type'] ?? '',
                        location:
                            AssetLocation(remote: remote, path: path ?? ''));
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
                      location: AssetLocation.local(path, true),
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
                        location: AssetLocation.local(path, true));
                  },
                ),
              ],
            ),
            GoRoute(
              name: 'embed',
              path: '/embed',
              builder: (context, state) {
                return ProjectPage(
                    embedding: Embedding.fromQuery(state.uri.queryParameters));
              },
            ),
          ],
        );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => BlocProvider(
        create: (context) {
          final cubit = SettingsCubit(prefs, isFullScreen);
          if (!kIsWeb && isWindow) {
            windowManager.waitUntilReadyToShow().then((_) async {
              cubit.setFullScreen(cubit.state.startInFullScreen);
              cubit.setTheme(MediaQuery.of(context));
              cubit.setNativeTitleBar();
              windowManager.show();
            });
          }
          return cubit;
        },
        lazy: false,
        child: RepositoryProvider(
          create: (context) =>
              SyncService(context, context.read<SettingsCubit>()),
          lazy: false,
          child: _buildApp(lightDynamic, darkDynamic),
        ),
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
                return child ?? Container();
              },
              supportedLocales: getLocales(),
              themeMode: state.theme,
              theme: getThemeData(state.design, false,
                  state.density.toFlutter(), lightDynamic, state.highContrast),
              darkTheme: getThemeData(state.design, true,
                  state.density.toFlutter(), darkDynamic, state.highContrast),
            ));
  }

  final GoRouter _router;
}

const flavor = String.fromEnvironment('flavor');
const isNightly =
    flavor == 'nightly' || flavor == 'dev' || flavor == 'development';
const shortApplicationName = isNightly ? 'Butterfly Nightly' : 'Butterfly';
const applicationName = 'Linwood $shortApplicationName';
const applicationMinorVersion = '2.1';
