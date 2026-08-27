import 'dart:async';

import 'package:butterfly/helpers/async.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('throttled runner is not postponed by continuous scheduling', (
    tester,
  ) async {
    final runner = CoalescedAsyncRunner(
      delay: const Duration(milliseconds: 16),
      restartDelay: false,
    );
    var runs = 0;

    unawaited(
      runner.schedule(() async {
        runs++;
      }),
    );
    await tester.pump(const Duration(milliseconds: 8));
    unawaited(
      runner.schedule(() async {
        runs++;
      }),
    );
    await tester.pump(const Duration(milliseconds: 8));

    expect(runs, 1);
    await runner.disposeAndWait();
  });

  testWidgets('slow throttled work does not add another delay', (tester) async {
    final runner = CoalescedAsyncRunner(
      delay: const Duration(milliseconds: 16),
      restartDelay: false,
    );
    final finishFirstRun = Completer<void>();
    var runs = 0;

    unawaited(
      runner.schedule(() async {
        runs++;
        await finishFirstRun.future;
      }),
    );
    await tester.pump(const Duration(milliseconds: 16));
    expect(runs, 1);

    unawaited(
      runner.schedule(() async {
        runs++;
      }),
    );
    await tester.pump(const Duration(milliseconds: 16));
    expect(runs, 1);

    finishFirstRun.complete();
    await tester.pump();
    expect(runs, 2);
    await runner.disposeAndWait();
  });

  testWidgets('default runner retains debounce behavior', (tester) async {
    final runner = CoalescedAsyncRunner(
      delay: const Duration(milliseconds: 16),
    );
    var runs = 0;

    unawaited(
      runner.schedule(() async {
        runs++;
      }),
    );
    await tester.pump(const Duration(milliseconds: 8));
    unawaited(
      runner.schedule(() async {
        runs++;
      }),
    );
    await tester.pump(const Duration(milliseconds: 8));

    expect(runs, 0);
    await tester.pump(const Duration(milliseconds: 8));
    expect(runs, 1);
    await runner.disposeAndWait();
  });
}
