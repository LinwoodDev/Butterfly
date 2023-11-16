part of 'dialog.dart';

class ViewCollaborationDialog extends StatelessWidget {
  final NetworkingService service;
  final NetworkingState state;

  const ViewCollaborationDialog({
    super.key,
    required this.service,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(AppLocalizations.of(context).collaboration),
      scrollable: true,
      content: StreamBuilder<Set<ConnectionId>>(
          stream: service.connections,
          builder: (context, snapshot) {
            final connections = snapshot.data ?? {};
            if (connections.isEmpty) {
              return Text(AppLocalizations.of(context).noConnections);
            }
            return Column(
              children: [
                for (final connection in connections)
                  ListTile(
                    title: Text(connection.toString()),
                  ),
              ],
            );
          }),
      actions: [
        OutlinedButton(
          child: Text(AppLocalizations.of(context).stop),
          onPressed: () {
            Navigator.of(context).pop();
            service.closeNetworking();
          },
        ),
        TextButton(
          child: Text(AppLocalizations.of(context).close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
