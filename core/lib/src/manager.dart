import 'package:butterfly_core/butterfly_core.dart';

class PadManager<T> {
  Handler _handler;
  Handler? _tempHandler;
  final List<Renderer<T>> _renderers = [], _tempRenderers = [];
  PadManager(Handler handler) : _handler = handler;
}
