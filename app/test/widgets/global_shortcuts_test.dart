import 'package:butterfly/widgets/global_shortcuts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestIntent extends Intent {
  const _TestIntent();
}

class _TestAction extends Action<_TestIntent> {
  _TestAction(this.onInvoke);

  final VoidCallback onInvoke;
  bool enabled = true;

  @override
  bool isEnabled(_TestIntent intent) => enabled;

  @override
  Object? invoke(_TestIntent intent) {
    onInvoke();
    return null;
  }
}

void main() {
  Future<void> pressControlKey(
    WidgetTester tester,
    LogicalKeyboardKey key,
  ) async {
    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);
    await tester.sendKeyEvent(key);
    await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);
    await tester.pump();
  }

  testWidgets('shortcuts respect controls, survive lost focus, and update', (
    tester,
  ) async {
    var calls = 0;
    var trigger = LogicalKeyboardKey.keyZ;
    final action = _TestAction(() => calls++);
    Widget buildApp() => MaterialApp(
      home: Row(
        children: [
          Actions(
            actions: {_TestIntent: action},
            child: GlobalShortcuts(
              shortcuts: {
                SingleActivator(trigger, control: true): const _TestIntent(),
              },
              child: const SizedBox(),
            ),
          ),
          // Focused controls keep priority over registered shortcuts.
          Shortcuts(
            shortcuts: const {
              SingleActivator(LogicalKeyboardKey.keyZ, control: true):
                  DoNothingIntent(),
            },
            child: const Focus(autofocus: true, child: SizedBox()),
          ),
        ],
      ),
    );
    await tester.pumpWidget(buildApp());
    await tester.pump();
    await pressControlKey(tester, LogicalKeyboardKey.keyZ);
    expect(calls, 0);

    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();
    await pressControlKey(tester, LogicalKeyboardKey.keyZ);
    expect(calls, 1);

    trigger = LogicalKeyboardKey.keyU;
    await tester.pumpWidget(buildApp());
    await pressControlKey(tester, LogicalKeyboardKey.keyZ);
    expect(calls, 1);
    await pressControlKey(tester, LogicalKeyboardKey.keyU);
    expect(calls, 2);

    // Removing the document must also remove its global handler.
    await tester.pumpWidget(const MaterialApp(home: SizedBox()));
    await pressControlKey(tester, LogicalKeyboardKey.keyU);
    expect(calls, 2);
    expect(tester.takeException(), isNull);
  });

  testWidgets('focused actions retain precedence and can disable a shortcut', (
    tester,
  ) async {
    var routeCalls = 0;
    var toolCalls = 0;
    final toolAction = _TestAction(() => toolCalls++);
    await tester.pumpWidget(
      MaterialApp(
        home: Actions(
          actions: {_TestIntent: _TestAction(() => routeCalls++)},
          child: GlobalShortcuts(
            shortcuts: const {
              SingleActivator(LogicalKeyboardKey.keyZ, control: true):
                  _TestIntent(),
            },
            child: Actions(
              actions: {_TestIntent: toolAction},
              child: const Focus(autofocus: true, child: SizedBox()),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await pressControlKey(tester, LogicalKeyboardKey.keyZ);
    expect(toolCalls, 1);
    expect(routeCalls, 0);

    toolAction.enabled = false;
    await pressControlKey(tester, LogicalKeyboardKey.keyZ);
    expect(toolCalls, 1);
    expect(routeCalls, 0);
    expect(tester.takeException(), isNull);
  });

  testWidgets('document bindings take priority over app focus and scrolling', (
    tester,
  ) async {
    var calls = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: Actions(
          actions: {_TestIntent: _TestAction(() => calls++)},
          child: GlobalShortcuts(
            shortcuts: const {
              SingleActivator(LogicalKeyboardKey.arrowRight): _TestIntent(),
              SingleActivator(LogicalKeyboardKey.pageDown): _TestIntent(),
            },
            child: const Focus(autofocus: true, child: SizedBox()),
          ),
        ),
      ),
    );
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.sendKeyEvent(LogicalKeyboardKey.pageDown);
    expect(calls, 2);

    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);
    await tester.sendKeyEvent(LogicalKeyboardKey.pageDown);
    expect(calls, 4);
    expect(tester.takeException(), isNull);
  });

  testWidgets('only the current route handles shared bindings', (tester) async {
    var firstCalls = 0;
    var secondCalls = 0;
    Widget shortcuts(VoidCallback onInvoke) => Actions(
      actions: {_TestIntent: _TestAction(onInvoke)},
      child: GlobalShortcuts(
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.keyZ, control: true):
              _TestIntent(),
        },
        child: const Scaffold(body: SizedBox()),
      ),
    );
    final navigatorKey = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: navigatorKey,
        home: shortcuts(() => firstCalls++),
      ),
    );
    await tester.pumpAndSettle();
    await pressControlKey(tester, LogicalKeyboardKey.keyZ);
    expect(firstCalls, 1);

    final route = navigatorKey.currentState!.push<void>(
      MaterialPageRoute(builder: (_) => shortcuts(() => secondCalls++)),
    );
    await tester.pumpAndSettle();
    await pressControlKey(tester, LogicalKeyboardKey.keyZ);
    expect(firstCalls, 1);
    expect(secondCalls, 1);

    navigatorKey.currentState!.pop();
    await route;
    await tester.pumpAndSettle();
    await pressControlKey(tester, LogicalKeyboardKey.keyZ);
    expect(firstCalls, 2);
    expect(secondCalls, 1);
    expect(tester.takeException(), isNull);
  });
}
