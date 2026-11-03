import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/settings/connection.dart';
import 'package:butterfly/settings/home.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:lw_file_system/lw_file_system.dart';
import 'package:material_leap/material_leap.dart';
import 'package:material_ui/material_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _storage = LocalStorage(name: 'Studio', paths: {'': '/notes'});

Future<SettingsCubit> _openConnections(
  WidgetTester tester, {
  List<ExternalStorage> connections = const [],
}) async {
  const size = Size(1000, 900);
  tester.view.devicePixelRatio = 1;
  tester.view.physicalSize = size;
  addTearDown(tester.view.resetDevicePixelRatio);
  addTearDown(tester.view.resetPhysicalSize);
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  FlutterSecureStorage.setMockInitialValues({});
  SharedPreferences.setMockInitialValues({
    'connections': connections.map((storage) => storage.toJson()).toList(),
  });
  final cubit = SettingsCubit(await SharedPreferences.getInstance());
  addTearDown(cubit.close);
  final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (_, _) =>
            const SettingsDetailsPage(id: 'connections', inView: true),
      ),
      GoRoute(
        path: '/connection/:id',
        name: 'connection',
        builder: (_, state) => ConnectionSettingsPage(
          remote: state.pathParameters['id']!,
          inView: true,
        ),
      ),
    ],
  );
  addTearDown(router.dispose);
  await tester.pumpWidget(
    BlocProvider<SettingsCubit>.value(
      value: cubit,
      child: MaterialApp.router(
        routerConfig: router,
        locale: const Locale('en'),
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          LeapLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ),
  );
  await tester.pumpAndSettle();
  return cubit;
}

void main() {
  testWidgets('swiping a connection deletes it only after confirmation', (
    tester,
  ) async {
    final cubit = await _openConnections(tester, connections: [_storage]);
    final originalConnections = cubit.state.connections;
    await tester.drag(find.text('Studio'), const Offset(-800, 0));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Files stored in this connection'),
      findsOneWidget,
    );
    expect(cubit.state.connections, originalConnections);
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(cubit.state.connections, originalConnections);
    expect(find.text('Studio'), findsOneWidget);

    await tester.drag(find.text('Studio'), const Offset(-800, 0));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpAndSettle();
    expect(cubit.state.connections, isEmpty);
    expect(find.text('No connections'), findsOneWidget);
  });

  testWidgets('deletion from connection details can be cancelled', (
    tester,
  ) async {
    final cubit = await _openConnections(tester, connections: [_storage]);
    final originalConnections = cubit.state.connections;
    await tester.tap(find.text('Studio'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();
    expect(find.byType(ConnectionSettingsPage), findsOneWidget);
    expect(cubit.state.connections, originalConnections);

    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Delete'));
    await tester.pumpAndSettle();
    expect(cubit.state.connections, isEmpty);
    expect(find.byType(ConnectionSettingsPage), findsNothing);
  });
}
