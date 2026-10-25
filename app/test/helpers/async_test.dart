import 'dart:async';

import 'package:butterfly/helpers/async.dart';
import 'package:flutter_test/flutter_test.dart';

class _Resource {
  int disposals = 0;

  void dispose() => disposals++;
}

void main() {
  group('AsyncResource', () {
    test('releases replaced, stale and current values exactly once', () async {
      final initial = _Resource();
      final stale = _Resource();
      final current = _Resource();
      final holder = AsyncResource<_Resource>(
        disposeValue: (value) => value.dispose(),
        value: initial,
      );
      final loading = Completer<_Resource?>();
      final first = holder.load((_) => loading.future);
      await holder.load((_) async => current);
      expect(holder.value, same(current));
      expect(initial.disposals, 1);
      loading.complete(stale);
      await first;
      expect(stale.disposals, 1);
      await holder.load((_) async => current);
      expect(current.disposals, 0);
      holder.clear();
      holder.clear();
      holder.dispose();
      holder.dispose();
      expect(holder.value, isNull);
      expect(initial.disposals, 1);
      expect(stale.disposals, 1);
      expect(current.disposals, 1);
    });

    test('borrowed values survive replacement and disposal', () async {
      final borrowed = _Resource();
      final owned = _Resource();
      final holder = AsyncResource<_Resource>(
        disposeValue: (value) => value.dispose(),
        value: borrowed,
        ownsValue: false,
      );
      await holder.load((_) async => owned);
      expect(borrowed.disposals, 0);
      expect(holder.ownsValue, isTrue);
      holder.dispose();
      holder.dispose();
      expect(owned.disposals, 1);
      final preview = AsyncResource<_Resource>(
        disposeValue: (value) => value.dispose(),
        value: borrowed,
        ownsValue: false,
      );
      preview.dispose();
      expect(borrowed.disposals, 0);
    });

    test('repeated disposal releases a pending result only once', () async {
      final value = _Resource();
      final holder = AsyncResource<_Resource>(
        disposeValue: (value) => value.dispose(),
      );
      final loading = Completer<_Resource?>();
      final pending = holder.load((_) => loading.future);
      holder.dispose();
      holder.dispose();
      loading.complete(value);
      await pending;
      holder.dispose();
      expect(value.disposals, 1);
      expect(holder.value, isNull);
      await holder.load((_) => throw StateError('Load after disposal'));
    });

    test(
      'clearing allows reuse and failed loads preserve the current value',
      () async {
        final value = _Resource();
        final holder = AsyncResource<_Resource>(
          disposeValue: (value) => value.dispose(),
        );
        holder.clear();
        await holder.load((_) async => value);
        await holder.load((_) async => null);
        expect(holder.value, same(value));
        await expectLater(
          holder.load((_) => throw StateError('Failed load')),
          throwsStateError,
        );
        expect(holder.value, same(value));
        expect(value.disposals, 0);
        holder.dispose();
        expect(value.disposals, 1);
      },
    );
  });

  group('LatestAsyncRunner', () {
    test('an older completion cannot detach the current task', () async {
      final runner = LatestAsyncRunner();
      final first = Completer<int>();
      final second = Completer<int>();
      final discarded = <int>[];
      final firstRun = runner.run(
        (_) => first.future,
        onCompleted: (_) => fail('Old result accepted'),
        onDiscarded: discarded.add,
      );
      final secondRun = runner.run(
        (_) => second.future,
        onCompleted: (_) => fail('Cancelled result accepted'),
        onDiscarded: discarded.add,
      );
      first.complete(1);
      await firstRun;
      runner.cancel();
      second.complete(2);
      await secondRun;
      expect(discarded, [1, 2]);
      // Cancelling pending work still permits a subsequent task.
      var accepted = false;
      await runner.run((_) async => 3, onCompleted: (_) => accepted = true);
      expect(accepted, isTrue);
      runner.dispose();
    });

    test('awaits asynchronous disposal of discarded results', () async {
      final runner = LatestAsyncRunner();
      final result = Completer<int>();
      final cleanupStarted = Completer<void>();
      final cleanupDone = Completer<void>();
      var finished = false;
      final running = runner
          .run(
            (_) => result.future,
            onCompleted: (_) => fail('Cancelled result accepted'),
            onDiscarded: (_) {
              cleanupStarted.complete();
              return cleanupDone.future;
            },
          )
          .then((_) => finished = true);
      runner.cancel();
      result.complete(1);
      await cleanupStarted.future;
      expect(finished, isFalse);
      cleanupDone.complete();
      await running;
      expect(finished, isTrue);
      runner.dispose();
    });

    test('obsolete failures do not affect the current task', () async {
      final runner = LatestAsyncRunner();
      final first = Completer<int>();
      final second = Completer<int>();
      var accepted = 0;
      final firstRun = runner.run(
        (_) => first.future,
        onCompleted: (_) => fail('Old result accepted'),
        onError: (_, _) => fail('Old failure handled as current'),
      );
      final secondRun = runner.run(
        (_) => second.future,
        onCompleted: (value) => accepted = value,
      );
      first.completeError(StateError('Obsolete failure'));
      await firstRun;
      second.complete(2);
      await secondRun;
      expect(accepted, 2);
      runner.dispose();
    });

    test('reports active errors and preserves their stack trace', () async {
      final runner = LatestAsyncRunner();
      final error = StateError('Load failed');
      final stackTrace = StackTrace.current;
      Object? reported;
      StackTrace? reportedStack;
      await runner.run<int>(
        (_) => Future.error(error, stackTrace),
        onCompleted: (_) => fail('Failed task completed'),
        onError: (value, stack) {
          reported = value;
          reportedStack = stack;
        },
      );
      expect(reported, same(error));
      expect(reportedStack, same(stackTrace));
      await expectLater(
        runner.run<int>(
          (_) => throw error,
          onCompleted: (_) => fail('Failed task completed'),
        ),
        throwsA(same(error)),
      );
      runner.dispose();
    });
  });

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
