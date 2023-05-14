part of '../selection.dart';

class WaypointSelection extends PainterSelection<WaypointPainter> {
  WaypointSelection(super.selected);

  @override
  List<Widget> buildProperties(BuildContext context) {
    return [
      ...super.buildProperties(context),
      BlocBuilder<DocumentBloc, DocumentState>(
        buildWhen: (previous, current) {
          if (current is! DocumentLoadSuccess ||
              previous is! DocumentLoadSuccess) {
            return true;
          }
          return previous.page.waypoints != current.page.waypoints;
        },
        builder: (context, state) {
          if (state is! DocumentLoadSuccess) return const SizedBox.shrink();
          final waypoints = state.page.waypoints;
          return ListView.builder(
            itemCount: waypoints.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final waypoint = waypoints[index];
              return ListTile(
                title: Text(waypoint.name),
                onTap: () {
                  context.read<TransformCubit>().moveToWaypoint(waypoint);
                  context.read<DocumentBloc>().bake();
                },
                trailing: IconButton(
                  icon: const PhosphorIcon(PhosphorIconsLight.x),
                  onPressed: () {
                    context.read<DocumentBloc>().add(
                          WaypointRemoved(index),
                        );
                  },
                ),
              );
            },
          );
        },
      ),
    ];
  }
}
