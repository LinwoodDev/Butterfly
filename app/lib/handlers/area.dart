part of 'handler.dart';

class AreaHandler extends Handler {
  Rect? currentArea;
  @override
  List<Renderer> createForegrounds(AppDocument document) => [
        if (currentArea != null)
          AreaRenderer(Area(
              width: currentArea!.width,
              height: currentArea!.height,
              position: currentArea!.topLeft)),
        ...document.areas.map((e) => AreaRenderer(e)).toList()
      ];
  @override
  void onPointerDown(
      Size viewportSize, BuildContext context, PointerDownEvent event) {
    final transform = context.read<TransformCubit>().state;
    final position = transform.localToGlobal(event.localPosition);
    currentArea = Rect.fromLTWH(position.dx, position.dy, 0, 0);
    context.read<DocumentBloc>().add(const IndexRefreshed());
  }

  @override
  void onPointerMove(
      Size viewportSize, BuildContext context, PointerMoveEvent event) {
    if (currentArea == null) return;
    final transform = context.read<TransformCubit>().state;
    final position = transform.localToGlobal(event.localPosition);
    currentArea = Rect.fromLTWH(currentArea!.left, currentArea!.top,
        position.dx - currentArea!.left, position.dy - currentArea!.top);
    context.read<DocumentBloc>().add(const IndexRefreshed());
  }

  Future<String?> _showAreaLabelDialog(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(AppLocalizations.of(context)!.enterName),
              content: TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.name,
                ),
                controller: controller,
              ),
              actions: [
                TextButton(
                  child: Text(AppLocalizations.of(context)!.cancel),
                  onPressed: () => Navigator.pop(context, null),
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.ok),
                  onPressed: () => Navigator.pop(context, controller.text),
                ),
              ],
            ));
  }

  @override
  Future<void> onPointerUp(
      Size viewportSize, BuildContext context, PointerUpEvent event) async {
    if (currentArea == null) return;
    final transform = context.read<TransformCubit>().state;
    final position = transform.localToGlobal(event.localPosition);
    currentArea = Rect.fromLTWH(currentArea!.left, currentArea!.top,
        position.dx - currentArea!.left, position.dy - currentArea!.top);
    final name = await _showAreaLabelDialog(context);
    if (name == null) {
      currentArea = null;
      context.read<DocumentBloc>().add(const IndexRefreshed());
      return;
    }

    context.read<DocumentBloc>()
      ..add(AreaCreated(Area(
          name: name,
          width: currentArea!.width,
          height: currentArea!.height,
          position: currentArea!.topLeft)))
      ..add(const IndexRefreshed());
    currentArea = null;
  }
}
