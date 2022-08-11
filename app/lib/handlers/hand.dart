part of 'handler.dart';

class HandSelectionRenderer extends Renderer<Rect> {
  final Color color;
  HandSelectionRenderer(super.element, this.color);

  @override
  void build(
      Canvas canvas, Size size, AppDocument document, CameraTransform transform,
      [bool foreground = false]) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..isAntiAlias = true
      ..filterQuality = FilterQuality.high
      ..colorFilter =
          ColorFilter.mode(Colors.grey.withOpacity(0.5), BlendMode.srcATop);
    canvas.drawRect(element, paint);
  }
}

class HandHandler extends Handler<HandProperty> {
  Renderer<PadElement>? movingElement;
  List<Renderer<PadElement>> selected = [];
  Offset? currentMovePosition;

  HandHandler(super.data);

  @override
  Future<bool> onRendererUpdated(
      AppDocument appDocument, Renderer old, Renderer updated) async {
    if (old.element == movingElement && updated is Renderer<PadElement>) {
      movingElement = updated;
    } else if (old is Renderer<PadElement> &&
        selected.contains(old) &&
        updated is Renderer<PadElement>) {
      selected[selected.indexOf(old)] = updated;
    } else {
      return false;
    }
    return true;
  }

  Rect? getSelectionRect() {
    Rect? rect;
    for (final element in selected) {
      final current = element.rect;
      if (current != null) {
        rect = rect?.expandToInclude(current) ?? current;
      }
    }
    return rect;
  }

  @override
  List<Renderer> createForegrounds(
      CurrentIndexCubit currentIndexCubit, AppDocument document,
      [Area? currentArea]) {
    final foregrounds = <Renderer>[];
    final color = ThemeManager.getThemeByName(
            currentIndexCubit.state.settingsCubit.state.design)
        .primaryColor;
    if (movingElement != null) {
      final currentElement = currentMovePosition == null
          ? movingElement!.element
          : movingElement!.move(currentMovePosition!);
      final renderer = Renderer.fromInstance(currentElement);
      foregrounds.add(renderer);
    }
    final selectionRect = getSelectionRect();
    if (selectionRect != null) {
      foregrounds.add(HandSelectionRenderer(selectionRect, color));
    }
    return foregrounds;
  }

  void move(BuildContext context, Renderer<PadElement> next,
      [bool duplicate = false]) {
    submitMove(context);
    movingElement = next;
    if (!duplicate) {
      final bloc = context.read<DocumentBloc>();
      bloc.add(ElementsRemoved([next.element]));
      bloc.refresh();
    }
  }

  void submitMove(BuildContext context, [PadElement? element]) {
    if (movingElement == null && element == null) return;
    final current = (element ?? movingElement?.element)!;
    movingElement = null;
    final bloc = context.read<DocumentBloc>();
    bloc.add(ElementsCreated([current]));
    bloc.refresh();
  }

  @override
  void onTapUp(TapUpDetails details, EventContext context) async {
    final transform = context.getCameraTransform();
    final settings = context.getSettings();
    final radius = settings.selectSensitivity / transform.size;
    final hits =
        await rayCast(context.buildContext, details.localPosition, radius);
    if (hits.isEmpty) {
      if (!context.isCtrlPressed) {
        selected.clear();
        context.refresh();
      }
      return;
    }
    final hit = hits.first;
    if (context.isCtrlPressed) {
      if (selected.contains(hit)) {
        selected.remove(hit);
      } else {
        selected.add(hit);
      }
    } else {
      selected.clear();
      selected.add(hit);
    }
    context.refresh();
  }

  @override
  void onSecondaryTapUp(TapUpDetails details, EventContext context) async {
    final providers = context.getProviders();
    final hits =
        await rayCast(context.buildContext, details.localPosition, 0.0);
    final hit = hits.firstOrNull;
    final rect = hit?.rect;
    if ((hit == null ||
            rect == null ||
            !(getSelectionRect()?.overlaps(rect) ?? false)) &&
        !context.isCtrlPressed) {
      selected.clear();
      if (hit != null) selected.add(hit);
    }
    context.refresh();
    if (selected.isEmpty) {
      await showContextMenu(
        context: context.buildContext,
        position: details.localPosition,
        builder: (ctx, close) => MultiBlocProvider(
          providers: providers,
          child: BackgroundContextMenu(
            close: close,
            position: details.localPosition,
          ),
        ),
      );
      return;
    }
    await showContextMenu(
        context: context.buildContext,
        position: details.localPosition,
        builder: (ctx, close) => MultiBlocProvider(
            providers: context.getProviders(),
            child: ElementsDialog(renderers: selected)));
    selected.clear();
    context.refresh();
  }

  @override
  void onScaleUpdate(ScaleUpdateDetails event, EventContext context) {
    context
        .getTransformCubit()
        .move(event.focalPointDelta / context.getCameraTransform().size);
  }
}
