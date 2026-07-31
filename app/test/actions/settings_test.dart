import 'package:butterfly/actions/settings.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/settings/home.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:material_leap/material_leap.dart';
import 'package:mocktail/mocktail.dart';

import '../helpers/mocks.dart';

void main() {
  late MockSettingsCubit settingsCubit;
  late GoRouter router;

  setUp(() {
    settingsCubit = MockSettingsCubit();
    when(() => settingsCubit.state).thenReturn(const ButterflySettings());
    when(() => settingsCubit.stream).thenAnswer((_) => const Stream.empty());

    router = GoRouter(
      initialLocation: '/document',
      routes: [
        GoRoute(
          path: '/document',
          builder: (context, state) => Scaffold(
            body: Column(
              children: [
                const Text('Document'),
                TextButton(
                  onPressed: () => openSettings(context),
                  child: const Text('Open settings'),
                ),
              ],
            ),
          ),
        ),
        GoRoute(
          path: '/settings/:page',
          builder: (context, state) =>
              const Scaffold(body: Text('Standalone settings page')),
        ),
      ],
    );
  });

  tearDown(() => router.dispose());

  testWidgets('dialog settings pages do not replace the document route', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      BlocProvider<SettingsCubit>.value(
        value: settingsCubit,
        child: MaterialApp.router(
          routerConfig: router,
          localizationsDelegates: const [
            ...AppLocalizations.localizationsDelegates,
            LeapLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    await tester.tap(find.text('Open settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('View'));
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, '/document');
    expect(find.byType(SettingsPage, skipOffstage: false), findsOneWidget);
    expect(find.text('Document', skipOffstage: false), findsOneWidget);

    await tester.binding.handlePopRoute();
    await tester.pumpAndSettle();

    expect(router.routeInformationProvider.value.uri.path, '/document');
    expect(find.byType(SettingsPage), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });
}
