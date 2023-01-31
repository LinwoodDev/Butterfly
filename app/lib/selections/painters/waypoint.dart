part of '../selection.dart';

class WaypointSelection extends PainterSelection<WaypointPainter> {
  WaypointSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    final state = context.read<DocumentBloc>().state;
    if (state is! DocumentLoadSuccess) return super.buildProperties(context);
    final waypoints = state.document.waypoints;

    return [
      ...super.buildProperties(context),
      const SizedBox(height: 8),
      const Divider(),
      const SizedBox(height: 8),
      ListView.builder(
        itemCount: waypoints.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final waypoint = waypoints[index];
          return ListTile(
            title: Text(waypoint.name),
            trailing: IconButton(
              icon: const Icon(PhosphorIcons.xLight),
              onPressed: () {},
            ),
            onTap: () {
              context.read<TransformCubit>().moveToWaypoint(waypoint);
              context.read<DocumentBloc>().bake();
            },
          );
        },
      )
    ];
  }
}
