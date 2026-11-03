import 'dart:async';

import 'package:butterfly/api/close.dart';
import 'package:butterfly/api/close_io.dart';
import 'package:butterfly/src/generated/i18n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:window_manager/window_manager.dart';

class _Window extends Mock implements Window {}

class _EventRequest extends Mock implements EventRequest {}

void main() {
  late _Window window;
  late FutureOr<void> Function(WindowEvent) onEvent;
  late BuildContext context;

  setUpAll(() {
    registerFallbackValue((WindowEvent event) {});
  });

  setUp(() {
    window = _Window();
    when(() => window.addListener(any())).thenAnswer((invocation) {
      onEvent =
          invocation.positionalArguments.single
              as FutureOr<void> Function(WindowEvent);
      return 1;
    });
    when(() => window.removeListener(any())).thenReturn(true);
  });

  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (value) {
            context = value;
            return const SizedBox();
          },
        ),
      ),
    );
  }

  _EventRequest request() {
    final request = _EventRequest();
    when(request.cancel).thenReturn(true);
    return request;
  }

  Future<void> close(_EventRequest request) async {
    await onEvent(WindowCloseRequestedEvent(windowId: 1, request: request));
  }

  testWidgets('clean documents allow the original native close request', (
    tester,
  ) async {
    await pumpApp(tester);
    final subscription = IOCloseSubscription(
      context,
      () => null,
      window: window,
    );
    addTearDown(subscription.dispose);
    final eventRequest = request();

    await close(eventRequest);

    verifyNever(eventRequest.cancel);
    verifyNever(window.close);
  });

  testWidgets('Cancel vetoes closing and allows another close attempt', (
    tester,
  ) async {
    await pumpApp(tester);
    final subscription = IOCloseSubscription(
      context,
      () => const CloseRequest(message: 'Unsaved document'),
      window: window,
    );
    addTearDown(subscription.dispose);

    for (var attempt = 0; attempt < 2; attempt++) {
      final eventRequest = request();
      final closing = close(eventRequest);
      await tester.pumpAndSettle();
      expect(find.text('Unsaved document'), findsOneWidget);
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      await closing;
      verify(eventRequest.cancel).called(1);
    }
  });

  testWidgets('Discard allows closing without saving', (tester) async {
    await pumpApp(tester);
    var saveCalls = 0;
    final subscription = IOCloseSubscription(
      context,
      () => CloseRequest(
        message: 'Unsaved document',
        onSave: () {
          saveCalls++;
          return true;
        },
      ),
      window: window,
    );
    addTearDown(subscription.dispose);
    final eventRequest = request();
    final closing = close(eventRequest);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Discard'));
    await tester.pumpAndSettle();
    await closing;

    verifyNever(eventRequest.cancel);
    expect(saveCalls, 0);
  });

  testWidgets('native close waits for saving and vetoes duplicate requests', (
    tester,
  ) async {
    await pumpApp(tester);
    final saved = Completer<bool>();
    final subscription = IOCloseSubscription(
      context,
      () =>
          CloseRequest(message: 'Unsaved document', onSave: () => saved.future),
      window: window,
    );
    addTearDown(subscription.dispose);
    final eventRequest = request();
    var finished = false;
    final closing = close(eventRequest).then((_) => finished = true);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(finished, isFalse);
    final duplicateRequest = request();
    await close(duplicateRequest);
    verify(duplicateRequest.cancel).called(1);

    saved.complete(true);
    await closing;
    verifyNever(eventRequest.cancel);
  });

  for (final throws in [false, true]) {
    testWidgets('failed save vetoes closing (throws: $throws)', (tester) async {
      await pumpApp(tester);
      final subscription = IOCloseSubscription(
        context,
        () => CloseRequest(
          message: 'Unsaved document',
          onSave: () {
            if (throws) throw StateError('Save failed');
            return false;
          },
        ),
        window: window,
      );
      addTearDown(subscription.dispose);
      final eventRequest = request();
      final closing = close(eventRequest);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      await closing;

      verify(eventRequest.cancel).called(1);
    });
  }

  testWidgets('only the latest subscription handles closing', (tester) async {
    await pumpApp(tester);
    var earlierCalls = 0;
    final earlier = IOCloseSubscription(context, () {
      earlierCalls++;
      return null;
    }, window: window);
    addTearDown(earlier.dispose);
    final earlierListener = onEvent;
    final latest = IOCloseSubscription(context, () => null, window: window);
    final eventRequest = request();

    await earlierListener(
      WindowCloseRequestedEvent(windowId: 1, request: eventRequest),
    );
    expect(earlierCalls, 0);
    await close(eventRequest);
    verifyNever(eventRequest.cancel);

    latest.dispose();
    await earlierListener(
      WindowCloseRequestedEvent(windowId: 1, request: eventRequest),
    );
    expect(earlierCalls, 1);
  });

  testWidgets('disposing while checking unsaved changes cancels closing', (
    tester,
  ) async {
    await pumpApp(tester);
    final checked = Completer<CloseRequest?>();
    final subscription = IOCloseSubscription(
      context,
      () => checked.future,
      window: window,
    );
    final eventRequest = request();
    final closing = close(eventRequest);

    subscription.dispose();
    checked.complete(const CloseRequest(message: 'Unsaved document'));
    await closing;
    await tester.pumpAndSettle();

    verify(eventRequest.cancel).called(1);
    verify(() => window.removeListener(1)).called(1);
    verify(window.dispose).called(1);
    expect(find.byType(AlertDialog), findsNothing);
  });
}
