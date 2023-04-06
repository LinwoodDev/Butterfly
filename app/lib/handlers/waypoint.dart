part of 'handler.dart';

class WaypointHandler extends Handler<WaypointPainter> {
  static const radius = 20.0;

  WaypointHandler(super.data);

  @override
  List<Renderer> createForegrounds(
          CurrentIndexCubit currentIndexCubit, AppDocument document,
          [Area? currentArea]) =>
      document.waypoints
          .map((e) => WaypointForegroundRenderer(e, radius))
          .toList();

  @override
  void onTapUp(TapUpDetails details, EventContext context) async {
    final bloc = context.getDocumentBloc();
    final document = context.getDocument();
    if (document == null) return;
    final transform = context.getCameraTransform();
    final globalPosition =
        transform.localToGlobal(details.localPosition).toPoint();
    final scale = transform.size;

    final waypoints = document.waypoints;
    final clickedWaypoint = waypoints.asMap().entries.firstWhereOrNull(
        (waypoint) =>
            (waypoint.value.position - globalPosition).magnitude <
            radius / transform.size);

    if (clickedWaypoint == null) {
      await _showCreateDialog(context, globalPosition, scale);
    } else {
      await showContextMenu(
        context: context.buildContext,
        position: details.localPosition,
        builder: (context) => ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                clickedWaypoint.value.name,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            ListTile(
              title: Text(AppLocalizations.of(context).delete),
              leading: const PhosphorIcon(PhosphorIconsLight.trash),
              onTap: () {
                bloc.add(WaypointRemoved(clickedWaypoint.key));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
    context.refresh();
  }

  Future<void> _showCreateDialog(
      EventContext context, Point<double> position, double size) {
    var saveScale = true;
    var nameController = TextEditingController();
    return showDialog<void>(
        context: context.buildContext,
        builder: (ctx) => StatefulBuilder(builder: (ctx, setState) {
              return AlertDialog(
                title: Text(AppLocalizations.of(ctx).create),
                content: Column(mainAxisSize: MainAxisSize.min, children: [
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(
                        filled: true, labelText: AppLocalizations.of(ctx).name),
                  ),
                  const SizedBox(height: 10),
                  CheckboxListTile(
                      title: Text(AppLocalizations.of(ctx).scale),
                      value: saveScale,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) =>
                          setState(() => saveScale = value ?? saveScale))
                ]),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(ctx).pop(),
                      child: Text(
                          AppLocalizations.of(context.buildContext).cancel)),
                  ElevatedButton(
                      onPressed: () {
                        context.getDocumentBloc().add(WaypointCreated(Waypoint(
                            nameController.text,
                            position,
                            saveScale ? size : null)));
                        Navigator.of(ctx).pop();
                      },
                      child: Text(AppLocalizations.of(ctx).create)),
                ],
              );
            }));
  }
}
