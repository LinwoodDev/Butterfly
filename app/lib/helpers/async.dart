import 'dart:async';

import 'package:async/async.dart';

/// Runs overlapping tasks, accepting only the latest result.
///
/// [cancel] invalidates pending work; [dispose] also prevents new work. Tasks
/// can check [CancelableOperation.isCanceled] between expensive steps. Work that
/// cannot be interrupted may still finish, so resource-producing callers must
/// provide `onDiscarded` to release results that are no longer needed.
class LatestAsyncRunner {
  CancelableCompleter<void>? _current;
  bool _disposed = false;

  Future<void> run<T>(
    Future<T> Function(CancelableOperation<void> operation) task, {
    required void Function(T value) onCompleted,
    FutureOr<void> Function(T value)? onDiscarded,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    if (_disposed) return;
    cancel();
    final pending = _current = CancelableCompleter<void>();
    final operation = pending.operation;
    try {
      late T value;
      try {
        value = await task(operation);
      } catch (error, stackTrace) {
        if (operation.isCanceled) return;
        if (onError == null) rethrow;
        onError(error, stackTrace);
        return;
      }
      if (operation.isCanceled) {
        await onDiscarded?.call(value);
      } else {
        onCompleted(value);
      }
    } finally {
      pending.complete();
      if (identical(_current, pending)) _current = null;
    }
  }

  void cancel() {
    final pending = _current;
    _current = null;
    if (pending != null) unawaited(pending.operation.cancel());
  }

  void dispose() {
    _disposed = true;
    cancel();
  }
}

/// Owns an asynchronously loaded resource and releases it when replaced/cleared.
///
/// Each successful loader transfers ownership of its result to this holder.
/// Borrowed initial values are never released. A null result leaves the current
/// value unchanged; factories must release any intermediate resources themselves.
class AsyncResource<T extends Object> {
  AsyncResource({
    required this._disposeValue,
    this._value,
    this._ownsValue = true,
  });

  final void Function(T value) _disposeValue;
  final _runner = LatestAsyncRunner();
  T? _value;
  bool _ownsValue;

  T? get value => _value;
  bool get ownsValue => _ownsValue;

  Future<void> load(
    Future<T?> Function(CancelableOperation<void> operation) loader, {
    void Function(Object error, StackTrace stackTrace)? onError,
  }) => _runner.run(
    loader,
    onCompleted: (loaded) {
      if (loaded == null) return;
      final previous = _value;
      final owned = _ownsValue;
      _value = loaded;
      _ownsValue = true;
      if (owned && previous != null && !identical(previous, loaded)) {
        _disposeValue(previous);
      }
    },
    onDiscarded: (loaded) {
      if (loaded != null && !identical(loaded, _value)) _disposeValue(loaded);
    },
    onError: onError,
  );

  /// Cancels pending work and releases the current value, allowing another load.
  void clear() {
    _runner.cancel();
    _release();
  }

  /// Permanently closes this holder. Repeated calls do not release values again.
  void dispose() {
    _runner.dispose();
    _release();
  }

  void _release() {
    final value = _value;
    final owned = _ownsValue;
    _value = null;
    _ownsValue = true;
    if (owned && value != null) _disposeValue(value);
  }
}

class CoalescedAsyncRunner {
  CoalescedAsyncRunner({required this.delay, this.restartDelay = true});

  final Duration delay;

  /// Whether a new task postpones a pending run by [delay].
  /// Set to false to coalesce calls at a fixed maximum frame rate.
  final bool restartDelay;
  Timer? _timer;
  Future<void>? _running;
  Future<void> Function()? _pendingTask;
  Completer<void>? _pendingCompleter;
  bool _disposed = false;

  Future<void> schedule(Future<void> Function() task) {
    if (_disposed) return Future.value();
    _pendingTask = task;
    final completer = _pendingCompleter ??= Completer<void>();
    if (_running == null && (restartDelay || _timer == null)) {
      _timer?.cancel();
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
    if (!restartDelay) {
      // Start the throttle interval with the work itself. If a slow task takes
      // longer than [delay], the latest pending update can run immediately
      // instead of adding another full delay after the task completes.
      _timer = Timer(delay, () {
        _timer = null;
        if (_running == null && _pendingTask != null && !_disposed) {
          _runPending();
        }
      });
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
          if (restartDelay) {
            _timer = Timer(delay, _runPending);
          } else if (_timer == null) {
            _runPending();
          }
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
