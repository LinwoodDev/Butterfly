import 'dart:async';

class CoalescedAsyncRunner {
  CoalescedAsyncRunner({required this.delay});

  final Duration delay;
  Timer? _timer;
  Future<void>? _running;
  Future<void> Function()? _pendingTask;
  Completer<void>? _pendingCompleter;
  bool _disposed = false;

  Future<void> schedule(Future<void> Function() task) {
    if (_disposed) return Future.value();
    _pendingTask = task;
    final completer = _pendingCompleter ??= Completer<void>();
    _timer?.cancel();
    if (_running == null) {
      _timer = Timer(delay, _runPending);
    }
    return completer.future;
  }

  void _runPending() {
    _timer = null;
    final task = _pendingTask;
    final completer = _pendingCompleter;
    _pendingTask = null;
    _pendingCompleter = null;
    if (_disposed || task == null) {
      if (completer?.isCompleted == false) completer?.complete();
      return;
    }
    _running = () async {
      try {
        await task();
        if (completer?.isCompleted == false) completer?.complete();
      } catch (error, stackTrace) {
        if (completer?.isCompleted == false) {
          completer?.completeError(error, stackTrace);
        }
      }
    }();
    unawaited(
      _running!.whenComplete(() {
        _running = null;
        if (_pendingTask != null && !_disposed) {
          _timer = Timer(delay, _runPending);
        }
      }),
    );
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
    _pendingTask = null;
    final completer = _pendingCompleter;
    _pendingCompleter = null;
    if (completer?.isCompleted == false) completer?.complete();
  }

  void dispose() {
    _disposed = true;
    cancel();
  }

  Future<void> disposeAndWait() async {
    dispose();
    await _running;
  }
}
