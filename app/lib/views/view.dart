import 'dart:async';

import 'package:butterfly/bloc/document_bloc.dart';
import 'package:butterfly/cubits/editor_controller.dart';
import 'package:butterfly/cubits/settings.dart';
import 'package:butterfly/cubits/transform.dart';
import 'package:butterfly/handlers/handler.dart';
import 'package:butterfly/services/pointer_shortcuts.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_painter.dart';

part 'view/canvas.dart';
part 'view/content.dart';
part 'view/input.dart';

class MainViewViewport extends StatefulWidget {
  const MainViewViewport({super.key});

  @override
  MainViewViewportState createState() => MainViewViewportState();
}

typedef _HandlerGetter = Handler Function();
typedef _EventContextGetter = EventContext Function();
typedef _PointerInputContext = ({
  BuildContext context,
  EditorController cubit,
  DocumentLoaded state,
  DocumentBloc bloc,
  _HandlerGetter getHandler,
  _EventContextGetter getEventContext,
  VoidCallback delayBake,
});

class MainViewViewportState extends State<MainViewViewport>
    with WidgetsBindingObserver {
  final GlobalKey<_ViewportCanvasState> _canvasKey = GlobalKey();
  late final _ViewportInputCoordinator _input;

  void openContextMenu() {
    final bloc = context.read<DocumentBloc>();
    final state = bloc.state;
    if (state is! DocumentLoaded) return;
    final cubit = context.read<EditorController>();
    final handler = _getViewportHandler(state, cubit);
    final renderBox = context.findRenderObject();
    if (renderBox is! RenderBox) return;
    final position =
        cubit.inputCubit.state.lastPosition ??
        renderBox.size.center(Offset.zero);
    handler.onContextMenu(
      position,
      EventContext(
        context,
        renderBox.size,
        HardwareKeyboard.instance.isShiftPressed,
        HardwareKeyboard.instance.isAltPressed,
        HardwareKeyboard.instance.isControlPressed,
      ),
    );
  }

  void _bake(Size viewportSize) => context.read<DocumentBloc>().bake(
    viewportSize: viewportSize,
    pixelRatio: MediaQuery.devicePixelRatioOf(context),
  );

  void _delayBake(Size viewportSize) =>
      context.read<DocumentBloc>().delayedBake(
        viewportSize: viewportSize,
        pixelRatio: MediaQuery.devicePixelRatioOf(context),
        testTransform: false,
      );

  @override
  void initState() {
    super.initState();
    _input = _ViewportInputCoordinator((transformCubit) {
      _canvasKey.currentState?.settleSlide(transformCubit);
    });
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _input.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final bloc = context.read<DocumentBloc>();
    if (bloc.state is! DocumentLoadSuccess ||
        state == AppLifecycleState.resumed) {
      return;
    }
    _input.reset();
    final controller = context.read<EditorController>();
    controller.toolCubit.resetInput(bloc, controller.inputCubit);
    unawaited(bloc.save());
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: RepaintBoundary(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final viewportSize = constraints.biggest;
            final bloc = context.read<DocumentBloc>();

            return BlocBuilder<DocumentBloc, DocumentState>(
              builder: (context, state) {
                if (state is! DocumentLoaded) {
                  return const Center(child: CircularProgressIndicator());
                }
                return _LoadedViewport(
                  bloc: bloc,
                  state: state,
                  viewportSize: viewportSize,
                  input: _input,
                  canvasKey: _canvasKey,
                  bake: () => _bake(viewportSize),
                  delayBake: () => _delayBake(viewportSize),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
